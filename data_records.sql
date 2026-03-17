create database sec01gr12db;
use sec01gr12db;






-- DDL ***********************

-- Customer Table
CREATE TABLE Customer (
    customer_ID INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    city VARCHAR(20),
    pin_code INT,
    street VARCHAR(20)
);


-- Account Table
CREATE TABLE Account (
    account_ID VARCHAR(20) PRIMARY KEY,
    acc_name VARCHAR(20),
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    bdate DATE,
    password VARCHAR(20)
);

-- Account identifier Table
CREATE TABLE Account_identifier (
	account_ID VARCHAR(20),
    phone_num CHAR(10),
    email VARCHAR(30),
    google_acc VARCHAR(20),
    facebook_acc VARCHAR(20),
    the_1_card_member VARCHAR(20),
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID)
);


-- Creation Table
CREATE TABLE Creation (
    account_ID VARCHAR(20),
    customer_ID INT,
    PRIMARY KEY (account_ID, customer_ID),
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

-- Customer Phone Number Table
CREATE TABLE CustomerPhoneNumber (
    customer_ID INT,
    customer_phone CHAR(10),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

-- Member Table
CREATE TABLE Member (
    member_ID INT PRIMARY KEY,
    member_coup VARCHAR(10),
    mem_privilege CHAR(1) CHECK (mem_privilege IN ('Y', 'N')),
    customer_ID INT,
    account_ID VARCHAR(20),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID),
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID)
);

-- The One Member Table
CREATE TABLE TheOneMember (
    member_ID INT,
    promotion_privil CHAR(1) CHECK (promotion_privil IN ('Y', 'N')),
    partner_privil CHAR(1) CHECK (partner_privil IN ('Y', 'N')),
    phone_num CHAR(10),
    salary DECIMAL(12, 2),
    name VARCHAR(20),
    FOREIGN KEY (member_ID) REFERENCES Member(member_ID)
);

-- Tops Prime Membership Table
CREATE TABLE TopsPrimeMembership (
    member_ID INT,
    coupon VARCHAR(10),
    fast_delivery CHAR(1) CHECK (fast_delivery IN ('Y', 'N')),
    subscription_date DATE,
    unlimit_free_delivery CHAR(1) CHECK (unlimit_free_delivery IN ('Y', 'N')),
    extra_point INT,
    FOREIGN KEY (member_ID) REFERENCES Member(member_ID)
);

-- Contact Table
CREATE TABLE Contact (
    contact_num INT PRIMARY KEY,
    customer_ID INT,
    name VARCHAR(20),
    suggestion VARCHAR(100),
    subject VARCHAR(20),
    email VARCHAR(30),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

-- Product Table
CREATE TABLE Product (
    product_num INT PRIMARY KEY,
    price DECIMAL(12, 2),
    product_name VARCHAR(20),
    manufactured_date DATE,
    contact_num INT,
    customer_ID INT,
    FOREIGN KEY (contact_num) REFERENCES Contact(contact_num),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

-- Product Category Table
CREATE TABLE ProductCategory (
    product_num INT,
    prod_category VARCHAR(20),
    FOREIGN KEY (product_num) REFERENCES Product(product_num)
);

-- Order Table
CREATE TABLE Orders (
    order_num INT PRIMARY KEY,
    date DATE,
    time TIME,
    delivery_fee DECIMAL(12, 2),
    total_item INT,
    product_num INT,
    FOREIGN KEY (product_num) REFERENCES Product(product_num)
);


-- Company Table
CREATE TABLE Company (
    company_name VARCHAR(20) PRIMARY KEY,
    pincode CHAR(5),
    street VARCHAR(20),
    city VARCHAR(20)
);


-- TaxInvoice Table
CREATE TABLE TaxInvoice (
    tax_ID CHAR(13) PRIMARY KEY,
    name VARCHAR(20),
    province VARCHAR(20),
    postal_code CHAR(5),
    district VARCHAR(20),
    subdistrict VARCHAR(20),
    phone_num CHAR(10),
    company_name VARCHAR(20),
    customer_ID INT,
    order_num INT,
    FOREIGN KEY (company_name) REFERENCES Company(company_name),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID),
    FOREIGN KEY (order_num) REFERENCES Orders(order_num)
);



-- Company Phone Number Table
CREATE TABLE CompanyPhoneNumber (
    customer_phone CHAR(10),
    company_name VARCHAR(20),
    FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

-- Payment Option Table
CREATE TABLE PaymentOption (
    payment_num CHAR(16) PRIMARY KEY,
    total_price DECIMAL(12, 2),
    delivery_date DATE,
    coupon_code VARCHAR(20),
    note VARCHAR(100),
    order_num INT,
    FOREIGN KEY (order_num) REFERENCES Orders(order_num)
);


-- Credit Card Table
CREATE TABLE CreditCard (
    payment_num CHAR(16),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    card_type VARCHAR(20),
    card_number CHAR(16),
    FOREIGN KEY (payment_num) REFERENCES PaymentOption(payment_num)
);

-- Cash on Delivery Table
CREATE TABLE CashOnDelivery (
    payment_num CHAR(16),
    delivery_time TIME,
    delivery_date DATE,
    FOREIGN KEY (payment_num) REFERENCES PaymentOption(payment_num)
);

-- Bank Transfer Table
CREATE TABLE BankTransfer (
    payment_num CHAR(16),
    bank_name VARCHAR(20),
    bank_num CHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    payment_receipt CHAR(20),
    FOREIGN KEY (payment_num) REFERENCES PaymentOption(payment_num)
);




-- DML ***********************

-- Insert data into the Customer Table (Master)
INSERT INTO Customer (customer_ID, first_name, last_name, city, pin_code, street)
VALUES 
	(1, 'Alice', 'Smith', 'New York', 10001, 'Main St'),
	(2, 'Bob', 'Johnson', 'Los Angeles', 90001, 'Second St'),
	(3, 'Charlie', 'Brown', 'Chicago', 60601, 'Third St'),
	(4, 'Diana', 'White', 'Houston', 77001, 'Fourth St'),
	(5, 'Edward', 'Green', 'Phoenix', 85001, 'Fifth St'),
	(6, 'Fiona', 'Black', 'San Diego', 92101, 'Sixth St'),
	(7, 'George', 'Clark', 'Dallas', 75201, 'Seventh St'),
	(8, 'Helen', 'Davis', 'San Jose', 95101, 'Eighth St'),
	(9, 'Irene', 'Martinez', 'Austin', 73301, 'Ninth St'),
	(10, 'Jack', 'Miller', 'San Francisco', 94101, 'Tenth St');

-- Insert data into the Account Table (Master)
INSERT INTO Account (account_ID, acc_name, gender, bdate, password)
VALUES
	('A001', 'AliceAcc', 'F', '1985-05-15', 'Alice123'),
	('A002', 'BobAcc', 'M', '1990-08-22', 'Bob123'),
	('A003', 'CharlieAcc', 'M', '1992-11-30', 'Charlie123'),
	('A004', 'DianaAcc', 'F', '1987-03-10', 'Diana123'),
	('A005', 'EdwardAcc', 'M', '1988-07-25', 'Edward123'),
	('A006', 'FionaAcc', 'F', '1995-09-14', 'Fiona123'),
	('A007', 'GeorgeAcc', 'M', '1983-02-18', 'George123'),
	('A008', 'HelenAcc', 'F', '1991-12-20', 'Helen123'),
	('A009', 'IreneAcc', 'F', '1993-04-05', 'Irene123'),
	('A010', 'JackAcc', 'M', '1997-06-30', 'Jack123');
    

INSERT INTO Account_identifier (account_ID, phone_num, email, google_acc, facebook_acc, the_1_card_member)
VALUES ('A001', '1234567890', 'alice@gmail.com', 'alice.g', 'alice.fb', 'YES'),
	('A002', '2345678901', 'bob@gmail.com', 'bob.g', 'bob.fb', 'NO'),
	('A003', '3456789012', 'charlie@gmail.com', 'charlie.g', 'charlie.fb', 'YES'),
	('A004', '4567890123', 'diana@gmail.com', 'diana.g', 'diana.fb', 'NO'),
	('A005', '5678901234', 'edward@gmail.com', 'edward.g', 'edward.fb', 'YES'),
	('A006', '6789012345', 'fiona@gmail.com', 'fiona.g', 'fiona.fb', 'NO'),
	('A007', '7890123456', 'george@gmail.com', 'george.g', 'george.fb', 'YES'),
	('A008', '8901234567', 'helen@gmail.com', 'helen.g', 'helen.fb', 'NO'),
	('A009', '9012345678', 'irene@gmail.com', 'irene.g', 'irene.fb', 'YES'),
	('A010', '0123456789', 'jack@gmail.com', 'jack.g', 'jack.fb', 'NO');




-- Insert data into the Creation Table (Master)
INSERT INTO Creation (account_ID, customer_ID)
VALUES 
	('A001', 1),
	('A002', 2),
	('A003', 3),
	('A004', 4),
	('A005', 5),
	('A006', 6),
	('A007', 7),
	('A008', 8),
	('A009', 9),
	('A010', 10);


-- Insert data into the CustomerPhoneNumber Table (Master)
INSERT INTO CustomerPhoneNumber (customer_ID, customer_phone)
VALUES
    (1, '1234567890'),
    (2, '2345678901'),
    (3, '3456789012'),
    (4, '4567890123'),
    (5, '5678901234'),
    (6, '6789012345'),
    (7, '7890123456'),
    (8, '8901234567'),
    (9, '9012345678'),
    (10, '0123456789');

-- Insert data into the Member Table (Master)
INSERT INTO Member (member_ID, member_coup, mem_privilege, customer_ID, account_ID)
VALUES(1, 'M001', 'Y', 1, 'A001'),
	(2, 'M002', 'N', 2, 'A002'),
	(3, 'M003', 'Y', 3, 'A003'),
	(4, 'M004', 'N', 4, 'A004'),
	(5, 'M005', 'Y', 5, 'A005'),
	(6, 'M006', 'N', 6, 'A006'),
	(7, 'M007', 'Y', 7, 'A007'),
	(8, 'M008', 'N', 8, 'A008'),
	(9, 'M009', 'Y', 9, 'A009'),
	(10, 'M010', 'N', 10, 'A010');


INSERT INTO TheOneMember (member_ID, promotion_privil, partner_privil, phone_num, salary, name)
VALUES
    (1, 'Y', 'N', '1234567890', 50000.00, 'Alice Smith'),
    (2, 'N', 'Y', '2345678901', 45000.00, 'Bob Johnson'),
    (3, 'Y', 'Y', '3456789012', 55000.00, 'Charlie Brown'),
    (4, 'N', 'N', '4567890123', 40000.00, 'Diana White'),
    (5, 'Y', 'Y', '5678901234', 52000.00, 'Edward Green'),
    (6, 'N', 'N', '6789012345', 48000.00, 'Fiona Black'),
    (7, 'Y', 'N', '7890123456', 60000.00, 'George Clark'),
    (8, 'N', 'Y', '8901234567', 47000.00, 'Helen Davis'),
    (9, 'Y', 'N', '9012345678', 53000.00, 'Irene Martinez'),
    (10, 'N', 'N', '0123456789', 49000.00, 'Jack Miller');


INSERT INTO TopsPrimeMembership (member_ID, coupon, fast_delivery, subscription_date, unlimit_free_delivery, extra_point)
VALUES
    (1, 'TPM001', 'Y', '2023-01-15', 'Y', 120),
    (2, 'TPM002', 'N', '2023-02-10', 'N', 80),
    (3, 'TPM003', 'Y', '2023-03-05', 'Y', 140),
    (4, 'TPM004', 'N', '2023-04-20', 'N', 70),
    (5, 'TPM005', 'Y', '2023-05-15', 'Y', 150),
    (6, 'TPM006', 'N', '2023-06-10', 'N', 60),
    (7, 'TPM007', 'Y', '2023-07-25', 'Y', 130),
    (8, 'TPM008', 'N', '2023-08-20', 'N', 75),
    (9, 'TPM009', 'Y', '2023-09-15', 'Y', 100),
    (10, 'TPM010', 'N', '2023-10-10', 'N', 90);


-- Insert data into the Contact Table (Transaction)
INSERT INTO Contact (contact_num, customer_ID, name, suggestion, subject, email)
VALUES(1, 1, 'Alice', 'Great service', 'Product Quality', 'alice@example.com'),
	(2, 2, 'Bob', 'Fast delivery', 'Delivery Time', 'bob@example.com'),
	(3, 3, 'Charlie', 'Excellent customer support', 'Return Policy', 'charlie@example.com'),
	(4, 4, 'Diana', 'Website was easy to use', 'Website Design', 'diana@example.com'),
	(5, 5, 'Edward', 'Could improve packaging', 'Packaging', 'edward@example.com'),
	(6, 6, 'Fiona', 'Easy payment options', 'Payment Process', 'fiona@example.com'),
	(7, 7, 'George', 'Love the deals', 'Discounts', 'george@example.com'),
	(8, 8, 'Helen', 'Quick customer support response', 'Customer Support', 'helen@example.com'),
	(9, 9, 'Irene', 'Fast and easy ordering process', 'Order Process', 'irene@example.com'),
	(10, 10, 'Jack', 'Great variety of products', 'Product Variety', 'jack@example.com');

-- Insert data into Product Table (Transaction)
INSERT INTO Product (product_num, price, product_name, manufactured_date, contact_num, customer_ID)
VALUES
	(101, 120.50, 'Laptop', '2023-09-01', 1, 1),
	(102, 75.00, 'Headphones', '2023-09-02', 2, 2),
	(103, 200.00, 'Smartphone', '2023-09-03', 3, 3),
	(104, 350.00, 'Tablet', '2023-09-04', 4, 4),
	(105, 15.00, 'USB Cable', '2023-09-05', 5, 5),
	(106, 80.00, 'Monitor', '2023-09-06', 6, 6),
	(107, 60.00, 'Printer', '2023-09-07', 7, 7),
	(108, 10.00, 'Mouse', '2023-09-08', 8, 8),
	(109, 25.00, 'Router', '2023-09-09', 9, 9),
	(110, 500.00, 'Camera', '2023-09-10', 10, 10);

-- Insert data into the Orders Table (Transaction)
INSERT INTO Orders (order_num, date, time, delivery_fee, total_item, product_num)
VALUES
	(1, '2023-11-01', '10:00:00', 5.99, 3, 101),
	(2, '2023-11-01', '11:00:00', 7.99, 2, 102),
	(3, '2023-11-02', '12:00:00', 6.50, 1, 103),
	(4, '2023-11-02', '13:30:00', 8.00, 5, 104),
	(5, '2023-11-03', '14:00:00', 4.50, 4, 105),
	(6, '2023-11-03', '15:00:00', 7.00, 6, 106),
	(7, '2023-11-04', '16:00:00', 6.99, 3, 107),
	(8, '2023-11-04', '17:30:00', 8.99, 2, 108),
	(9, '2023-11-05', '18:00:00', 5.49, 3, 109),
	(10, '2023-11-05', '19:00:00', 7.49, 2, 110),
	(11, '2023-11-06', '20:00:00', 5.99, 1, 101),
	(12, '2023-11-06', '21:00:00', 6.50, 4, 102),
	(13, '2023-11-07', '22:00:00', 5.00, 2, 103),
	(14, '2023-11-07', '23:30:00', 4.50, 1, 104),
	(15, '2023-11-08', '00:00:00', 7.50, 5, 105),
	(16, '2023-11-08', '01:00:00', 6.00, 6, 106),
	(17, '2023-11-09', '02:30:00', 7.99, 3, 107),
	(18, '2023-11-09', '03:00:00', 5.49, 2, 108),
	(19, '2023-11-10', '04:00:00', 6.99, 1, 109),
	(20, '2023-11-10', '05:30:00', 4.99, 5, 110),
	(21, '2023-11-11', '06:00:00', 8.99, 4, 101),
	(22, '2023-11-11', '07:00:00', 5.49, 3, 102),
	(23, '2023-11-12', '08:00:00', 7.50, 2, 103),
	(24, '2023-11-12', '09:00:00', 4.50, 1, 104),
	(25, '2023-11-13', '10:30:00', 5.99, 5, 105),
	(26, '2023-11-13', '11:00:00', 6.50, 6, 106),
	(27, '2023-11-14', '12:30:00', 7.00, 3, 107),
	(28, '2023-11-14', '13:00:00', 8.99, 4, 108),
	(29, '2023-11-15', '14:00:00', 5.49, 1, 109),
	(30, '2023-11-15', '15:00:00', 6.99, 2, 110);



-- Insert data into the ProductCategory Table (Transaction)
INSERT INTO ProductCategory (product_num, prod_category)
VALUES
	(101, 'Electronics'),
	(102, 'Electronics'),
	(103, 'Electronics'),
	(104, 'Electronics'),
	(105, 'Accessories'),
	(106, 'Electronics'),
	(107, 'Accessories'),
	(108, 'Accessories'),
	(109, 'Accessories'),
	(110, 'Electronics');


-- Insert data into the Company Table (Master)
INSERT INTO Company (company_name, pincode, street, city)
VALUES
	('TechCorp', '10001', 'Tech St', 'New York'),
	('Gizmo Ltd', '90001', 'Gizmo Ave', 'Los Angeles'),
	('DeviceWorks', '60601', 'Device Blvd', 'Chicago'),
	('GadgetPro', '77001', 'Gadget Rd', 'Houston'),
	('SmartTech', '85001', 'Smart St', 'Phoenix'),
	('Innovative Elec', '92101', 'Innovation Ln', 'San Diego'),
	('TechMasters', '75201', 'Tech Way', 'Dallas'),
	('Gizmo World', '95101', 'Gizmo Blvd', 'San Jose'),
	('DeviceExperts', '73301', 'Device St', 'Austin'),
	('Smart Devices', '94101', 'Smart Blvd', 'San Francisco');

-- Insert data into the TaxInvoice Table (Transaction)
INSERT INTO TaxInvoice (tax_ID, name, province, postal_code, district, subdistrict, phone_num, company_name, customer_ID, order_num)
VALUES
	('TX001', 'Alice Smith', 'NY', '10001', 'Manhattan', 'Downtown', '1234567890', 'TechCorp', 1, 1),
	('TX002', 'Bob Johnson', 'CA', '90001', 'Los Angeles', 'Hollywood', '2345678901', 'Gizmo Ltd', 2, 2),
	('TX003', 'Charlie Brown', 'IL', '60601', 'Chicago', 'Loop', '3456789012', 'DeviceWorks', 3, 3),
	('TX004', 'Diana White', 'TX', '77001', 'Houston', 'Midtown', '4567890123', 'GadgetPro', 4, 4),
	('TX005', 'Edward Green', 'AZ', '85001', 'Phoenix', 'North Phoenix', '5678901234', 'SmartTech', 5, 5),
	('TX006', 'Fiona Black', 'CA', '92101', 'San Diego', 'Mission Valley', '6789012345', 'Innovative Elec', 6, 6),
	('TX007', 'George Clark', 'TX', '75201', 'Dallas', 'Uptown', '7890123456', 'TechMasters', 7, 7),
	('TX008', 'Helen Davis', 'CA', '95101', 'San Jose', 'Downtown', '8901234567', 'Gizmo World', 8, 8),
	('TX009', 'Irene Martinez', 'TX', '73301', 'Austin', 'West Austin', '9012345678', 'DeviceExperts', 9, 9),
	('TX010', 'Jack Miller', 'CA', '94101', 'San Francisco', 'Financial District', '0123456789', 'Smart Devices', 10, 10);

-- Insert data into the CompanyPhoneNumber Table (Transaction)
INSERT INTO CompanyPhoneNumber (customer_phone, company_name)
VALUES
	('1234567890', 'TechCorp'),
	('2345678901', 'Gizmo Ltd'),
	('3456789012', 'DeviceWorks'),
	('4567890123', 'GadgetPro'),
	('5678901234', 'SmartTech'),
	('6789012345', 'Innovative Elec'),
	('7890123456', 'TechMasters'),
	('8901234567', 'Gizmo World'),
	('9012345678', 'DeviceExperts'),
	('0123456789', 'Smart Devices');



-- Insert data into the PaymentOption Table (Transaction)
INSERT INTO PaymentOption (payment_num, total_price, delivery_date, coupon_code, note, order_num)
VALUES
	('P001', 120.50, '2023-11-02', 'DISCOUNT10', 'First time buyer discount', 1),
	('P002', 75.00, '2023-11-03', 'OFFER20', 'Bundle discount applied', 2),
	('P003', 200.00, '2023-11-04', 'SALE15', 'Seasonal sale discount', 3),
	('P004', 350.00, '2023-11-05', 'NEWYEAR5', 'New Year sale', 4),
	('P005', 15.00, '2023-11-06', NULL, 'Standard shipping', 5),
	('P006', 80.00, '2023-11-07', NULL, 'No coupon', 6),
	('P007', 60.00, '2023-11-08', 'PROMO25', 'Holiday promo', 7),
	('P008', 10.00, '2023-11-09', NULL, 'Free shipping', 8),
	('P009', 25.00, '2023-11-10', 'DISCOUNT10', 'Referral discount', 9),
	('P010', 500.00, '2023-11-11', NULL, 'High value product', 10),
	('P011', 100.00, '2023-11-12', 'SUMMER30', 'Summer special discount', 11),
	('P012', 120.00, '2023-11-13', 'BIRTHDAY5', 'Birthday offer', 12),
	('P013', 75.50, '2023-11-14', 'WINTER15', 'Winter sale discount', 13),
	('P014', 45.99, '2023-11-15', NULL, 'Normal shipping', 14),
	('P015', 220.00, '2023-11-16', 'CYBERMONDAY40', 'Cyber Monday discount', 15),
	('P016', 85.00, '2023-11-17', NULL, 'Gift card applied', 16),
	('P017', 50.00, '2023-11-18', 'FALL20', 'Fall season discount', 17),
	('P018', 150.00, '2023-11-19', NULL, 'Gift wrapped', 18),
	('P019', 20.00, '2023-11-20', 'BLACKFRIDAY30', 'Black Friday sale', 19),
	('P020', 30.00, '2023-11-21', NULL, 'Free shipping', 20),
	('P021', 80.00, '2023-11-22', 'XMAS10', 'Christmas sale', 21),
	('P022', 45.00, '2023-11-23', NULL, 'Normal delivery', 22),
	('P023', 150.00, '2023-11-24', 'WINTERSALE50', 'Winter sale clearance', 23),
	('P024', 200.00, '2023-11-25', NULL, 'Seasonal discount', 24),
	('P025', 300.00, '2023-11-26', 'VIP10', 'VIP member discount', 25),
	('P026', 400.00, '2023-11-27', NULL, 'No coupon', 26),
	('P027', 50.00, '2023-11-28', 'STUDENT10', 'Student discount', 27),
	('P028', 60.00, '2023-11-29', NULL, 'Free delivery', 28),
	('P029', 70.00, '2023-11-30', 'NEWCUSTOMER15', 'New customer offer', 29),
	('P030', 80.00, '2023-12-01', NULL, 'Discount applied', 30);

-- Insert data into CreditCard Table
INSERT INTO CreditCard (payment_num, first_name, last_name, card_type, card_number)
VALUES
    ('P001', 'Alice', 'Smith', 'Visa', '4111111111111111'),
    ('P002', 'Bob', 'Johnson', 'MasterCard', '5500000000000004'),
    ('P003', 'Charlie', 'Brown', 'American Express', '340000000000009'),
    ('P004', 'Diana', 'White', 'Discover', '6011000000000002'),
    ('P005', 'Edward', 'Green', 'Visa', '4111111111111123'),
    ('P006', 'Fiona', 'Black', 'MasterCard', '5500000000000055'),
    ('P007', 'George', 'Clark', 'American Express', '3400000000000100'),
    ('P008', 'Helen', 'Davis', 'Discover', '6011000000000005'),
    ('P009', 'Irene', 'Martinez', 'Visa', '4111111111111134'),
    ('P010', 'Jack', 'Miller', 'MasterCard', '5500000000000066'),
    ('P011', 'Laura', 'Wilson', 'American Express', '3400000000000111'),
    ('P012', 'Megan', 'Moore', 'Discover', '6011000000000008'),
    ('P013', 'Nathan', 'Taylor', 'Visa', '4111111111111145'),
    ('P014', 'Olivia', 'Harris', 'MasterCard', '5500000000000077'),
    ('P015', 'Paul', 'Martinez', 'American Express', '3400000000000122'),
    ('P016', 'Quinn', 'Gonzalez', 'Discover', '6011000000000010'),
    ('P017', 'Rachel', 'Lopez', 'Visa', '4111111111111156'),
    ('P018', 'Sam', 'Perez', 'MasterCard', '5500000000000088'),
    ('P019', 'Tina', 'Roberts', 'American Express', '3400000000000133'),
    ('P020', 'Uma', 'Jackson', 'Discover', '6011000000000012'),
    ('P021', 'Victor', 'Lee', 'Visa', '4111111111111167'),
    ('P022', 'Will', 'Allen', 'MasterCard', '5500000000000099'),
    ('P023', 'Xander', 'Scott', 'American Express', '3400000000000144'),
    ('P024', 'Yvonne', 'King', 'Discover', '6011000000000014'),
    ('P025', 'Zane', 'Young', 'Visa', '4111111111111178'),
    ('P026', 'Ava', 'Adams', 'MasterCard', '5500000000000100'),
    ('P027', 'Brayden', 'Evans', 'American Express', '3400000000000155'),
    ('P028', 'Carter', 'Hall', 'Discover', '6011000000000016'),
    ('P029', 'Daisy', 'Wright', 'Visa', '4111111111111189'),
    ('P030', 'Evan', 'Martinez', 'MasterCard', '5500000000000111');


-- Insert data into the CashOnDelivery Table (Transaction)
INSERT INTO CashOnDelivery (payment_num, delivery_time, delivery_date)
VALUES
	('P001', '15:00:00', '2023-11-02'),
	('P002', '16:00:00', '2023-11-03'),
	('P003', '17:00:00', '2023-11-04'),
	('P004', '18:00:00', '2023-11-05'),
	('P005', '19:00:00', '2023-11-06'),
	('P006', '20:00:00', '2023-11-07'),
	('P007', '21:00:00', '2023-11-08'),
	('P008', '22:00:00', '2023-11-09'),
	('P009', '23:00:00', '2023-11-10'),
	('P010', '12:00:00', '2023-11-11'),
	('P011', '13:00:00', '2023-11-12'),
	('P012', '14:00:00', '2023-11-13'),
	('P013', '15:00:00', '2023-11-14'),
	('P014', '16:00:00', '2023-11-15'),
	('P015', '17:00:00', '2023-11-16'),
	('P016', '18:00:00', '2023-11-17'),
	('P017', '19:00:00', '2023-11-18'),
	('P018', '20:00:00', '2023-11-19'),
	('P019', '21:00:00', '2023-11-20'),
	('P020', '22:00:00', '2023-11-21'),
	('P021', '23:00:00', '2023-11-22'),
	('P022', '12:00:00', '2023-11-23'),
	('P023', '13:00:00', '2023-11-24'),
	('P024', '14:00:00', '2023-11-25'),
	('P025', '15:00:00', '2023-11-26'),
	('P026', '16:00:00', '2023-11-27'),
	('P027', '17:00:00', '2023-11-28'),
	('P028', '18:00:00', '2023-11-29'),
	('P029', '19:00:00', '2023-11-30'),
	('P030', '20:00:00', '2023-12-01');

-- Insert data into the BankTransfer Table (Transaction)
INSERT INTO BankTransfer (payment_num, bank_name, bank_num, first_name, last_name, payment_receipt)
VALUES
	('P001', 'Bank of America', '1234567890', 'Alice', 'Smith', 'receipt001'),
	('P002', 'Chase Bank', '2345678901', 'Bob', 'Johnson', 'receipt002'),
	('P003', 'Wells Fargo', '3456789012', 'Charlie', 'Brown', 'receipt003'),
	('P004', 'Citibank', '4567890123', 'Diana', 'White', 'receipt004'),
	('P005', 'Bank of America', '5678901234', 'Edward', 'Green', 'receipt005'),
	('P006', 'Chase Bank', '6789012345', 'Fiona', 'Black', 'receipt006'),
	('P007', 'Wells Fargo', '7890123456', 'George', 'Clark', 'receipt007'),
	('P008', 'Citibank', '8901234567', 'Helen', 'Davis', 'receipt008'),
	('P009', 'Bank of America', '9012345678', 'Irene', 'Martinez', 'receipt009'),
	('P010', 'Chase Bank', '0123456789', 'Jack', 'Miller', 'receipt010'),
	('P011', 'Wells Fargo', '1234567890', 'Alice', 'Smith', 'receipt011'),
	('P012', 'Citibank', '2345678901', 'Bob', 'Johnson', 'receipt012'),
	('P013', 'Bank of America', '3456789012', 'Charlie', 'Brown', 'receipt013'),
	('P014', 'Chase Bank', '4567890123', 'Diana', 'White', 'receipt014'),
	('P015', 'Wells Fargo', '5678901234', 'Edward', 'Green', 'receipt015'),
	('P016', 'Citibank', '6789012345', 'Fiona', 'Black', 'receipt016'),
	('P017', 'Bank of America', '7890123456', 'George', 'Clark', 'receipt017'),
	('P018', 'Chase Bank', '8901234567', 'Helen', 'Davis', 'receipt018'),
	('P019', 'Wells Fargo', '9012345678', 'Irene', 'Martinez', 'receipt019'),
	('P020', 'Citibank', '0123456789', 'Jack', 'Miller', 'receipt020'),
	('P021', 'Bank of America', '1234567890', 'Alice', 'Smith', 'receipt021'),
	('P022', 'Chase Bank', '2345678901', 'Bob', 'Johnson', 'receipt022'),
	('P023', 'Wells Fargo', '3456789012', 'Charlie', 'Brown', 'receipt023'),
	('P024', 'Citibank', '4567890123', 'Diana', 'White', 'receipt024'),
	('P025', 'Bank of America', '5678901234', 'Edward', 'Green', 'receipt025'),
	('P026', 'Chase Bank', '6789012345', 'Fiona', 'Black', 'receipt026'),
	('P027', 'Wells Fargo', '7890123456', 'George', 'Clark', 'receipt027'),
	('P028', 'Citibank', '8901234567', 'Helen', 'Davis', 'receipt028'),
	('P029', 'Bank of America', '9012345678', 'Irene', 'Martinez', 'receipt029'),
	('P030', 'Chase Bank', '0123456789', 'Jack', 'Miller', 'receipt030');

