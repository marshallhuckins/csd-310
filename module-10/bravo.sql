DROP USER IF EXISTS 'db_user'@'localhost';

CREATE USER 'db_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'popcorn';

GRANT ALL PRIVILEGES ON team_bravo.* TO 'db_user'@localhost;


DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS assets;
DROP TABLE IF EXISTS transactions;

CREATE TABLE client (
    client_id       INT             NOT NULL        AUTO_INCREMENT,
    client_name     VARCHAR(255)    NOT NULL,
    client_address  VARCHAR(255)    NOT NULL,
    client_phone    VARCHAR(255)     NOT NULL,
    client_email    VARCHAR(255)    NOT NULL,
    client_startdate    Date        NOT NULL,

    PRIMARY KEY(client_id)    
);

CREATE TABLE assets (
    asset_id        INT             NOT NULL,
    asset_type      VARCHAR(255)    NOT NULL,
    asset_value     INT,
    client_id       INT,

    PRIMARY KEY(asset_id),

    CONSTRAINT fk_client
    FOREIGN KEY(client_id)
        REFERENCES client(client_id)
);

CREATE TABLE transactions (
    transaction_id      INT         NOT NULL        AUTO_INCREMENT,
    transaction_date    DATE,
    invoice_number      VARCHAR(255),
    client_id       INT,
    asset_id        INT,

    PRIMARY KEY(transaction_id),

    FOREIGN KEY(client_id)
        REFERENCES client(client_id),

    CONSTRAINT fk_assets
    FOREIGN KEY(asset_id)
        REFERENCES assets(asset_id)

);

INSERT INTO client (client_name, client_address, client_phone, client_email, client_startdate)    
    VALUES('Gus Garcia', '123 Wag Dr, Houston, TX', '7137840000', 'Gusser@gmail.com', ' 2020-11-26'),
          ('Charlie Smith', '789 Dig St, Houston, TX', '7130471000', 'Charles20@gmail.com', '2022-05-06'),
          ('John Lewis', '1410 Main St, Houston, TX', '7132259985', 'Lewis89@gmail.com', '2023-02-07'),
          ('Chris Stewart', '1289 Iowa St, Houston, TX', '7138899952', 'Chris@stewartinc.com', '2021-08-09'),
          ('Jim Carey', '525 Hollywood Blvd, Chicago, IL', '3122346543', 'Carey@gmail.com', '2021-02-14'),
          ('John Smith', '124 Lackluster Way, Chicago, IL', '3129942020', 'Smith@gmail.com', '2022-04-15'),
          ('Laney Stewart', '843 Blockbuster Dr, Nashville, TN', '8285551993', 'Stewart22@yahoo.com', '2024-01-18'),
          ('Ted Danson', '123 Cheers Way, Santa Rosa, NM', '4466980212', 'tdanson@cheers.com', '2023-05-18');

INSERT INTO assets (asset_id, asset_type, asset_value, client_id)
    VALUES('0001', 'Money', '100000', (SELECT client_id FROM client WHERE client_id = '1') ),
          ('0002','Land', '800000', (SELECT client_id FROM client WHERE client_id = '1' ) ),
          ('0003','Livestock', '50000', (SELECT client_id FROM client WHERE client_id = '2') ),
          ('0004', 'Land', '427000', (SELECT client_id FROM client WHERE client_id = '3') ),
          ('0005', 'Equipment', '740000', (SELECT client_id FROM client WHERE client_id = '3') ),
          ('0006', 'Vehicles', '80000', (SELECT client_id FROM client WHERE client_id = '4') ),
          ('0007', 'Property', '500000', (SELECT client_id FROM client WHERE client_id = '5') ),
          ('0008', 'Vehicles', '50000', (SELECT client_id FROM client WHERE client_id = '5') ),
          ('0009', 'Money', '75000', (SELECT client_id FROM client WHERE client_id = '6') ),
          ('0010', 'Equipment', '25000', (SELECT client_id FROM client WHERE client_id = '7') ),
          ('0011', 'Land', '650000', (SELECT client_id FROM client WHERE client_id = '8') );

INSERT INTO transactions (transaction_date, invoice_number, client_id, asset_id)
    VALUES('2020-11-26', 'INV0001', (SELECT client_id FROM client WHERE client_id = '1'), (SELECT asset_id FROM assets WHERE asset_id = '0001') ),
          ('2020-11-29', 'INV0002', (SELECT client_id FROM client WHERE client_id = '1'), (SELECT asset_id FROM assets WHERE asset_id = '0001') ),
          ('2022-05-06', 'INV0003', (SELECT client_id FROM client WHERE client_id = '2'), (SELECT asset_id FROM assets WHERE asset_id = '0003') ),
          ('2023-02-15', 'INV0004', (SELECT client_id FROM client WHERE client_id = '3'), (SELECT asset_id FROM assets WHERE asset_id = '0004') ),
          ('2021-08-15', 'INV0005', (SELECT client_id FROM client WHERE client_id = '4'), (SELECT asset_id FROM assets WHERE asset_id = '0003') ),
          ('2022-01-25', 'INV0006', (SELECT client_id FROM client WHERE client_id = '4'), (SELECT asset_id FROM assets WHERE asset_id = '0006') ),
          ('2021-03-01', 'INV0007', (SELECT client_id FROM client WHERE client_id = '5'), (SELECT asset_id FROM assets WHERE asset_id = '0007') ),
          ('2021-06-02', 'INV0008', (SELECT client_id FROM client WHERE client_id = '5'), (SELECT asset_id FROM assets WHERE asset_id = '0006') ),
          ('2022-05-01', 'INV0009', (SELECT client_id FROM client WHERE client_id = '6'), (SELECT asset_id FROM assets WHERE asset_id = '0001') ),
          ('2024-01-18', 'INV0010', (SELECT client_id FROM client WHERE client_id = '7'), (SELECT asset_id FROM assets WHERE asset_id = '0010') ),
          ('2024-01-02', 'INV0011', (SELECT client_id FROM client WHERE client_id = '7'), (SELECT asset_id FROM assets WHERE asset_id = '0010') ),
          ('2023-05-18', 'INV0012', (SELECT client_id FROM client WHERE client_id = '8'), (SELECT asset_id FROM assets WHERE asset_id = '0011') );