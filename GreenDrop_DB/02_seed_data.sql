-- 1. Insert Users
INSERT INTO users (name, birthdate, green_drops, email, password) VALUES
('Max Mustermann', '1990-05-14', 15, 'max.mustermann@example.com', 'password123'),
('Lisa Müller', '1985-07-22', 10, 'lisa.mueller@example.com', 'password123'),
('John Doe', '1992-11-30', 25, 'john.doe@example.com', 'password123'),
('Sara Schmidt', '1996-02-10', 30, 'sara.schmidt@example.com', 'password123'),
('Tom Becker', '1988-09-05', 20, 'tom.becker@example.com', 'password123');

-- 2. Insert Vendors
INSERT INTO vendors (user_id, iban) VALUES
(2 , 'DE89370400440532013000'),
(1, 'DE44500105175407324959'),
(3, 'DE75512108000019843475');

-- 3. Insert Addresses for Users (up to 3 random addresses per user)

-- Max Mustermann has 2 addresses
INSERT INTO addresses (user_id, street, street_number, zip_code, city, is_primary) VALUES
(1, 'Schwabenstraße', '25', '68163', 'Mannheim', TRUE),
(1, 'Ludwigstraße', '18', '68169', 'Mannheim', FALSE);

-- Lisa Müller has 3 addresses
INSERT INTO addresses (user_id, street, street_number, zip_code, city, is_primary) VALUES
(2, 'Seckenheimer Str.', '58', '68163', 'Mannheim', TRUE),
(2, 'Käfertaler Str.', '135', '68167', 'Mannheim', FALSE),
(2, 'Breidenbacherstraße', '12', '68163', 'Mannheim', FALSE);

-- John Doe has 1 address
INSERT INTO addresses (user_id, street, street_number, zip_code, city, is_primary) VALUES
(3, 'Schwabenstraße', '25', '68163', 'Mannheim', TRUE);

-- Sara Schmidt has 2 addresses
INSERT INTO addresses (user_id, street, street_number, zip_code, city, is_primary) VALUES
(4, 'Hauptstraße', '45', '68159', 'Mannheim', TRUE),
(4, 'Neckarstraße', '13', '68199', 'Mannheim', FALSE);

-- Tom Becker has 3 addresses
INSERT INTO addresses (user_id, street, street_number, zip_code, city, is_primary) VALUES
(5, 'Rheinpromenade', '2', '68165', 'Mannheim', TRUE),
(5, 'Breidenbacherstraße', '12', '68163', 'Mannheim', FALSE),
(5, 'Käfertaler Str.', '88', '68167', 'Mannheim', FALSE);

-- 4. Insert Shops (weed-themed)
INSERT INTO shops (name, street, street_number, zip_code, city, minimum_order, delivery_costs, max_delivery_radius, vendor_id) VALUES
('The Green Leaf', 'Hauptstraße', '45', '68159', 'Mannheim', 15.00, 5.00, 10, 1),
('Cannabis Corner', 'Neckarstraße', '13', '68199', 'Mannheim', 20.00, 7.50, 15, 2),
('High Society', 'Rheinpromenade', '2', '68165', 'Mannheim', 18.00, 6.00, 12, 3);

-- 5. (Optional) Confirm foreign key relations work
SELECT * FROM users;
SELECT * FROM addresses;
SELECT * FROM vendors;
SELECT * FROM shops;
