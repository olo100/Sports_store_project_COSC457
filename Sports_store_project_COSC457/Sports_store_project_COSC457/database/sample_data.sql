-- Sample seed data for the Sports Store database
-- Generated automatically; safe to re-run after TRUNCATE.
USE sports_storedb;
SET FOREIGN_KEY_CHECKS = 0;

-- STORE_LOCATION
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-001', 'Sports Hub Towson', '200 York Rd', 'Towson', 'MD', '21204', '410-555-0101', 12000.0, '2010-05-01');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-002', 'Sports Hub Baltimore', '100 Pratt St', 'Baltimore', 'MD', '21202', '410-555-0102', 18500.0, '2012-03-15');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-003', 'Sports Hub Annapolis', '55 West St', 'Annapolis', 'MD', '21401', '410-555-0103', 9000.0, '2014-08-20');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-004', 'Sports Hub Bethesda', '7000 Wisconsin Ave', 'Bethesda', 'MD', '20814', '240-555-0104', 14000.0, '2016-06-01');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-005', 'Sports Hub Frederick', '20 Market St', 'Frederick', 'MD', '21701', '301-555-0105', 11000.0, '2018-02-10');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-006', 'Sports Hub Columbia', '10 Symphony Way', 'Columbia', 'MD', '21044', '443-555-0106', 13500.0, '2019-11-05');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-007', 'Sports Hub Rockville', '1500 Rockville Pk', 'Rockville', 'MD', '20852', '240-555-0107', 10500.0, '2020-07-12');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-008', 'Sports Hub Silver Spr', '8500 Colesville', 'Silver Spring', 'MD', '20910', '301-555-0108', 12500.0, '2021-09-01');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-009', 'Sports Hub Hagerstown', '44 N Potomac', 'Hagerstown', 'MD', '21740', '301-555-0109', 8800.0, '2022-04-22');
INSERT INTO STORE_LOCATION (store_id, store_name, address, city, state, zip_code, phone, square_footage, opening_date) VALUES ('store-010', 'Sports Hub Salisbury', '900 S Salisbury', 'Salisbury', 'MD', '21801', '410-555-0110', 9500.0, '2023-01-30');

-- DEPARTMENT
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-001', 'Footwear', 'Athletic shoes and cleats');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-002', 'Apparel', 'Athletic clothing and uniforms');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-003', 'Equipment', 'Sporting goods and equipment');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-004', 'Accessories', 'Sports accessories and gear');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-005', 'Outdoor', 'Camping and outdoor recreation');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-006', 'Fitness', 'Home gym and fitness equipment');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-007', 'Team Sports', 'Team sports equipment');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-008', 'Water Sports', 'Swimming and water gear');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-009', 'Winter Sports', 'Skiing and winter equipment');
INSERT INTO DEPARTMENT (department_id, name, description) VALUES ('dept-010', 'Customer Svc', 'Returns and customer service');

-- CATEGORY
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-001', 'Running Shoes', 'Performance running footwear');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-002', 'Basketball', 'Basketball equipment and gear');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-003', 'Soccer', 'Soccer balls, cleats and gear');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-004', 'Tennis', 'Tennis racquets and accessories');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-005', 'Golf', 'Golf clubs and accessories');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-006', 'Yoga', 'Yoga mats and props');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-007', 'Cycling', 'Bikes and cycling gear');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-008', 'Camping', 'Tents and camping gear');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-009', 'Swimming', 'Swim gear and accessories');
INSERT INTO CATEGORY (category_id, name, description) VALUES ('cat-010', 'Baseball', 'Bats, gloves and gear');

-- BRAND
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-001', 'Nike', 'USA');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-002', 'Adidas', 'Germany');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-003', 'Under Armour', 'USA');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-004', 'Puma', 'Germany');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-005', 'New Balance', 'USA');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-006', 'Wilson', 'USA');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-007', 'Spalding', 'USA');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-008', 'Yonex', 'Japan');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-009', 'Callaway', 'USA');
INSERT INTO BRAND (brand_id, name, country) VALUES ('brand-010', 'Lululemon', 'Canada');

-- SUPPLIER
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-001', 'Supplier 1 Co.', 'Contact 1', 'contact1@supplier1.com', '410-555-0201', '101 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-002', 'Supplier 2 Co.', 'Contact 2', 'contact2@supplier2.com', '410-555-0202', '102 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-003', 'Supplier 3 Co.', 'Contact 3', 'contact3@supplier3.com', '410-555-0203', '103 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-004', 'Supplier 4 Co.', 'Contact 4', 'contact4@supplier4.com', '410-555-0204', '104 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-005', 'Supplier 5 Co.', 'Contact 5', 'contact5@supplier5.com', '410-555-0205', '105 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-006', 'Supplier 6 Co.', 'Contact 6', 'contact6@supplier6.com', '410-555-0206', '106 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-007', 'Supplier 7 Co.', 'Contact 7', 'contact7@supplier7.com', '410-555-0207', '107 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-008', 'Supplier 8 Co.', 'Contact 8', 'contact8@supplier8.com', '410-555-0208', '108 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-009', 'Supplier 9 Co.', 'Contact 9', 'contact9@supplier9.com', '410-555-0209', '109 Industrial Way');
INSERT INTO SUPPLIER (supplier_id, name, contact_name, email, phone, address) VALUES ('sup-010', 'Supplier 10 Co.', 'Contact 10', 'contact10@supplier10.com', '410-555-0210', '110 Industrial Way');

-- SPORT_TYPE
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-001', 'Running', 'Track and road running', 'All Year');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-002', 'Basketball', 'Court basketball', 'Winter');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-003', 'Soccer', 'Outdoor and indoor soccer', 'Fall');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-004', 'Tennis', 'Court tennis', 'Summer');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-005', 'Golf', 'Golf course play', 'Spring');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-006', 'Yoga', 'Indoor practice', 'All Year');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-007', 'Cycling', 'Road and trail cycling', 'Summer');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-008', 'Hiking', 'Trail hiking', 'Fall');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-009', 'Swimming', 'Pool and open water', 'Summer');
INSERT INTO SPORT_TYPE (sport_id, name, description, season) VALUES ('sport-010', 'Baseball', 'Diamond baseball', 'Summer');

-- PRODUCT
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-001', 'cat-001', 'brand-001', 'sup-001', 'sport-001', 'Air Zoom Pegasus', 'SKU-1001', 'running shoe', 63.5, 32.0, '10', 'Black');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-002', 'cat-002', 'brand-002', 'sup-002', 'sport-002', 'Pro Court', 'SKU-1002', 'basketball shoe', 77.0, 39.0, 'S', 'Red');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-003', 'cat-003', 'brand-003', 'sup-003', 'sport-003', 'Match Soccer Ball', 'SKU-1003', 'official soccer ball', 90.5, 46.0, 'M', 'White');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-004', 'cat-004', 'brand-004', 'sup-004', 'sport-004', 'Pro Staff Racquet', 'SKU-1004', 'tennis racquet', 104.0, 53.0, 'M', 'Black');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-005', 'cat-005', 'brand-005', 'sup-005', 'sport-005', 'Tour Driver', 'SKU-1005', 'golf driver', 117.5, 60.0, '10', 'Green');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-006', 'cat-006', 'brand-006', 'sup-006', 'sport-006', 'Studio Yoga Mat', 'SKU-1006', '6mm yoga mat', 131.0, 67.0, 'S', 'Green');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-007', 'cat-007', 'brand-007', 'sup-007', 'sport-007', 'Trail Bike 27', 'SKU-1007', 'mountain bike', 144.5, 74.0, 'XL', 'Black');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-008', 'cat-008', 'brand-008', 'sup-008', 'sport-008', '4-Person Tent', 'SKU-1008', 'camping tent', 158.0, 81.0, 'S', 'Black');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-009', 'cat-009', 'brand-009', 'sup-009', 'sport-009', 'Speed Goggles', 'SKU-1009', 'racing goggles', 171.5, 88.0, 'M', 'White');
INSERT INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES ('prod-010', 'cat-010', 'brand-010', 'sup-010', 'sport-010', 'Pro Bat 33', 'SKU-1010', 'baseball bat', 185.0, 95.0, '9', 'Green');

-- CUSTOMER
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-001', 'Alex', 'Smith', 'alex.smith@example.com', '410-555-0301', '1986-02-02', '2024-02-02');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-002', 'Jordan', 'Johnson', 'jordan.johnson@example.com', '410-555-0302', '1987-03-03', '2024-03-03');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-003', 'Sam', 'Williams', 'sam.williams@example.com', '410-555-0303', '1988-04-04', '2024-04-04');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-004', 'Taylor', 'Brown', 'taylor.brown@example.com', '410-555-0304', '1989-05-05', '2024-05-05');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-005', 'Chris', 'Jones', 'chris.jones@example.com', '410-555-0305', '1990-06-06', '2024-06-06');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-006', 'Morgan', 'Garcia', 'morgan.garcia@example.com', '410-555-0306', '1991-07-07', '2024-07-07');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-007', 'Casey', 'Miller', 'casey.miller@example.com', '410-555-0307', '1992-08-08', '2024-08-08');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-008', 'Jamie', 'Davis', 'jamie.davis@example.com', '410-555-0308', '1993-09-09', '2024-09-09');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-009', 'Pat', 'Rodriguez', 'pat.rodriguez@example.com', '410-555-0309', '1994-10-10', '2024-10-10');
INSERT INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES ('cust-010', 'Riley', 'Martinez', 'riley.martinez@example.com', '410-555-0310', '1995-11-11', '2024-11-11');

-- PAYMENT_METHOD
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-001', 'Cash', 'Cash payment');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-002', 'Credit Card', 'Visa/MC/Amex');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-003', 'Debit Card', 'Bank debit card');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-004', 'Apple Pay', 'Mobile NFC');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-005', 'Google Pay', 'Mobile NFC');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-006', 'Gift Card', 'Store gift card');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-007', 'PayPal', 'Online payment');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-008', 'Check', 'Personal check');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-009', 'Store Credit', 'Account credit');
INSERT INTO PAYMENT_METHOD (payment_id, method_name, description) VALUES ('pay-010', 'Layaway', 'Layaway plan');

-- LOYALTY_PROGRAM
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-001', 'Sports Hub Rewards', 217, 'Silver', '2024-02-02');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-002', 'Sports Hub Rewards', 4464, 'Platinum', '2024-03-03');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-003', 'Sports Hub Rewards', 1805, 'Platinum', '2024-04-04');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-004', 'Sports Hub Rewards', 4827, 'Gold', '2024-05-05');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-005', 'Sports Hub Rewards', 53, 'Silver', '2024-06-06');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-006', 'Sports Hub Rewards', 3462, 'Gold', '2024-07-07');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-007', 'Sports Hub Rewards', 2276, 'Silver', '2024-08-08');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-008', 'Sports Hub Rewards', 1763, 'Gold', '2024-09-09');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-009', 'Sports Hub Rewards', 837, 'Bronze', '2024-10-10');
INSERT INTO LOYALTY_PROGRAM (loyalty_id, program_name, points, tier, enrolled) VALUES ('loy-010', 'Sports Hub Rewards', 3112, 'Bronze', '2024-11-11');

-- Attach loyalty programs to customers
UPDATE CUSTOMER SET loyalty_id = 'loy-001' WHERE customer_id = 'cust-001';
UPDATE CUSTOMER SET loyalty_id = 'loy-002' WHERE customer_id = 'cust-002';
UPDATE CUSTOMER SET loyalty_id = 'loy-003' WHERE customer_id = 'cust-003';
UPDATE CUSTOMER SET loyalty_id = 'loy-004' WHERE customer_id = 'cust-004';
UPDATE CUSTOMER SET loyalty_id = 'loy-005' WHERE customer_id = 'cust-005';
UPDATE CUSTOMER SET loyalty_id = 'loy-006' WHERE customer_id = 'cust-006';
UPDATE CUSTOMER SET loyalty_id = 'loy-007' WHERE customer_id = 'cust-007';
UPDATE CUSTOMER SET loyalty_id = 'loy-008' WHERE customer_id = 'cust-008';
UPDATE CUSTOMER SET loyalty_id = 'loy-009' WHERE customer_id = 'cust-009';
UPDATE CUSTOMER SET loyalty_id = 'loy-010' WHERE customer_id = 'cust-010';

-- EMPLOYEE
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-001', 'store-001', 'dept-001', NULL, 'Alex', 'Martinez', 'emp1@sportshub.com', '410-555-0401', '2020-02-02', 16.25, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-002', 'store-002', 'dept-002', NULL, 'Jordan', 'Rodriguez', 'emp2@sportshub.com', '410-555-0402', '2020-03-03', 17.5, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-003', 'store-003', 'dept-003', NULL, 'Sam', 'Davis', 'emp3@sportshub.com', '410-555-0403', '2020-04-04', 18.75, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-004', 'store-004', 'dept-004', NULL, 'Taylor', 'Miller', 'emp4@sportshub.com', '410-555-0404', '2020-05-05', 20.0, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-005', 'store-005', 'dept-005', NULL, 'Chris', 'Garcia', 'emp5@sportshub.com', '410-555-0405', '2020-06-06', 21.25, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-006', 'store-006', 'dept-006', NULL, 'Morgan', 'Jones', 'emp6@sportshub.com', '410-555-0406', '2020-07-07', 22.5, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-007', 'store-007', 'dept-007', NULL, 'Casey', 'Brown', 'emp7@sportshub.com', '410-555-0407', '2020-08-08', 23.75, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-008', 'store-008', 'dept-008', NULL, 'Jamie', 'Williams', 'emp8@sportshub.com', '410-555-0408', '2020-09-09', 25.0, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-009', 'store-009', 'dept-009', NULL, 'Pat', 'Johnson', 'emp9@sportshub.com', '410-555-0409', '2020-10-10', 26.25, 'Active');
INSERT INTO EMPLOYEE (employee_id, store_id, department_id, manager_id, first_name, last_name, email, phone, hire_date, hourly_rate, status) VALUES ('emp-010', 'store-010', 'dept-010', NULL, 'Riley', 'Smith', 'emp10@sportshub.com', '410-555-0410', '2020-11-11', 27.5, 'Active');

-- MANAGER
INSERT INTO MANAGER (manager_id, employee_id, department_id, bonus_rate, promotion_date) VALUES ('mgr-001', 'emp-001', 'dept-001', 0.060000000000000005, '2022-01-01');
INSERT INTO MANAGER (manager_id, employee_id, department_id, bonus_rate, promotion_date) VALUES ('mgr-002', 'emp-002', 'dept-002', 0.07, '2022-02-01');
INSERT INTO MANAGER (manager_id, employee_id, department_id, bonus_rate, promotion_date) VALUES ('mgr-003', 'emp-003', 'dept-003', 0.08, '2022-03-01');
INSERT INTO MANAGER (manager_id, employee_id, department_id, bonus_rate, promotion_date) VALUES ('mgr-004', 'emp-004', 'dept-004', 0.09, '2022-04-01');
INSERT INTO MANAGER (manager_id, employee_id, department_id, bonus_rate, promotion_date) VALUES ('mgr-005', 'emp-005', 'dept-005', 0.1, '2022-05-01');

-- Wire managers up to employees
UPDATE EMPLOYEE SET manager_id = 'mgr-001' WHERE employee_id = 'emp-006';
UPDATE EMPLOYEE SET manager_id = 'mgr-002' WHERE employee_id = 'emp-007';
UPDATE EMPLOYEE SET manager_id = 'mgr-003' WHERE employee_id = 'emp-008';
UPDATE EMPLOYEE SET manager_id = 'mgr-004' WHERE employee_id = 'emp-009';
UPDATE EMPLOYEE SET manager_id = 'mgr-005' WHERE employee_id = 'emp-010';

-- PROMOTION
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-001', 'SUMMER25', 'Summer Sale 25%', 25.0, NULL, '2025-06-01', '2025-08-31', 'Seasonal');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-002', 'FALL10', 'Fall 10% Off', 10.0, NULL, '2025-09-01', '2025-11-30', 'Seasonal');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-003', 'BLACKFRI', 'Black Friday', NULL, 50.0, '2025-11-28', '2025-11-29', 'Holiday');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-004', 'NEWCUST', 'New Customer 15%', 15.0, NULL, '2025-01-01', '2025-12-31', 'Acquisition');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-005', 'BACK2SCHOOL', 'Back to School', 20.0, NULL, '2025-08-01', '2025-09-15', 'Seasonal');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-006', 'CLEARANCE', 'Clearance', NULL, 25.0, '2025-01-01', '2025-12-31', 'Clearance');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-007', 'LOYALTY5', 'Loyalty 5%', 5.0, NULL, '2025-01-01', '2025-12-31', 'Loyalty');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-008', 'SPRING', 'Spring Refresh', 15.0, NULL, '2025-03-01', '2025-05-31', 'Seasonal');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-009', 'BIRTHDAY', 'Birthday 20%', 20.0, NULL, '2025-01-01', '2025-12-31', 'Loyalty');
INSERT INTO PROMOTION (promotion_id, code, name, discount_pct, discount_amt, start_date, end_date, type) VALUES ('prom-010', 'FREESHIP', 'Free Shipping', NULL, 10.0, '2025-01-01', '2025-12-31', 'Shipping');

-- SALE
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-001', 'store-001', 'emp-001', 'cust-001', 'pay-001', 'prom-001', '2025-01-01 11:30:00', 65.5, 3.93, 69.43);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-002', 'store-002', 'emp-002', 'cust-002', 'pay-002', 'prom-002', '2025-02-02 12:30:00', 81.0, 4.86, 85.86);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-003', 'store-003', 'emp-003', 'cust-003', 'pay-003', 'prom-003', '2025-03-03 13:30:00', 96.5, 5.79, 102.29);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-004', 'store-004', 'emp-004', 'cust-004', 'pay-004', 'prom-004', '2025-04-04 14:30:00', 112.0, 6.72, 118.72);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-005', 'store-005', 'emp-005', 'cust-005', 'pay-005', 'prom-005', '2025-05-05 15:30:00', 127.5, 7.65, 135.15);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-006', 'store-006', 'emp-006', 'cust-006', 'pay-006', 'prom-006', '2025-06-06 16:30:00', 143.0, 8.58, 151.58);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-007', 'store-007', 'emp-007', 'cust-007', 'pay-007', 'prom-007', '2025-07-07 17:30:00', 158.5, 9.51, 168.01);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-008', 'store-008', 'emp-008', 'cust-008', 'pay-008', 'prom-008', '2025-08-08 18:30:00', 174.0, 10.44, 184.44);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-009', 'store-009', 'emp-009', 'cust-009', 'pay-009', 'prom-009', '2025-09-09 19:30:00', 189.5, 11.37, 200.87);
INSERT INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES ('sale-010', 'store-010', 'emp-010', 'cust-010', 'pay-010', 'prom-010', '2025-10-10 20:30:00', 205.0, 12.3, 217.3);

-- SALE_ITEM
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-001', 'sale-001', 'prod-001', 2, 25.5, 0, 51.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-002', 'sale-002', 'prod-002', 3, 31.0, 0, 93.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-003', 'sale-003', 'prod-003', 4, 36.5, 0, 146.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-004', 'sale-004', 'prod-004', 1, 42.0, 0, 42.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-005', 'sale-005', 'prod-005', 2, 47.5, 0, 95.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-006', 'sale-006', 'prod-006', 3, 53.0, 0, 159.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-007', 'sale-007', 'prod-007', 4, 58.5, 0, 234.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-008', 'sale-008', 'prod-008', 1, 64.0, 0, 64.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-009', 'sale-009', 'prod-009', 2, 69.5, 0, 139.0);
INSERT INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES ('si-010', 'sale-010', 'prod-010', 3, 75.0, 0, 225.0);

-- INVENTORY
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-001', 'prod-001', 'store-001', 96, 21, '2025-01-01');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-002', 'prod-002', 'store-002', 159, 18, '2025-02-02');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-003', 'prod-003', 'store-003', 16, 24, '2025-03-03');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-004', 'prod-004', 'store-004', 142, 13, '2025-04-04');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-005', 'prod-005', 'store-005', 101, 12, '2025-05-05');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-006', 'prod-006', 'store-006', 146, 19, '2025-06-06');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-007', 'prod-007', 'store-007', 165, 29, '2025-07-07');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-008', 'prod-008', 'store-008', 97, 28, '2025-08-08');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-009', 'prod-009', 'store-009', 54, 12, '2025-09-09');
INSERT INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES ('inv-010', 'prod-010', 'store-010', 16, 17, '2025-10-10');

-- PURCHASE_ORDER
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-001', 'sup-001', 'store-001', '2025-01-01', '2025-01-15', 620.0, 'Shipped');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-002', 'sup-002', 'store-002', '2025-02-01', '2025-02-15', 740.0, 'Pending');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-003', 'sup-003', 'store-003', '2025-03-01', '2025-03-15', 860.0, 'Pending');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-004', 'sup-004', 'store-004', '2025-04-01', '2025-04-15', 980.0, 'Pending');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-005', 'sup-005', 'store-005', '2025-05-01', '2025-05-15', 1100.0, 'Shipped');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-006', 'sup-006', 'store-006', '2025-06-01', '2025-06-15', 1220.0, 'Shipped');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-007', 'sup-007', 'store-007', '2025-07-01', '2025-07-15', 1340.0, 'Shipped');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-008', 'sup-008', 'store-008', '2025-08-01', '2025-08-15', 1460.0, 'Received');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-009', 'sup-009', 'store-009', '2025-09-01', '2025-09-15', 1580.0, 'Shipped');
INSERT INTO PURCHASE_ORDER (order_id, supplier_id, store_id, order_date, delivery_date, total, status) VALUES ('po-010', 'sup-010', 'store-010', '2025-10-01', '2025-10-15', 1700.0, 'Pending');

-- PURCHASE_ORDER_ITEM
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-001', 'po-001', 'prod-001', 7, 14.5, 101.5);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-002', 'po-002', 'prod-002', 9, 19.0, 171.0);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-003', 'po-003', 'prod-003', 11, 23.5, 258.5);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-004', 'po-004', 'prod-004', 13, 28.0, 364.0);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-005', 'po-005', 'prod-005', 15, 32.5, 487.5);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-006', 'po-006', 'prod-006', 17, 37.0, 629.0);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-007', 'po-007', 'prod-007', 19, 41.5, 788.5);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-008', 'po-008', 'prod-008', 21, 46.0, 966.0);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-009', 'po-009', 'prod-009', 23, 50.5, 1161.5);
INSERT INTO PURCHASE_ORDER_ITEM (item_id, order_id, product_id, quantity, cost, total) VALUES ('poi-010', 'po-010', 'prod-010', 25, 55.0, 1375.0);

-- PRODUCT_REVIEW
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-001', 'prod-001', 'cust-001', 2, 'Review 1 comment.', '2025-01-01 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-002', 'prod-002', 'cust-002', 3, 'Review 2 comment.', '2025-02-02 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-003', 'prod-003', 'cust-003', 4, 'Review 3 comment.', '2025-03-03 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-004', 'prod-004', 'cust-004', 5, 'Review 4 comment.', '2025-04-04 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-005', 'prod-005', 'cust-005', 1, 'Review 5 comment.', '2025-05-05 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-006', 'prod-006', 'cust-006', 2, 'Review 6 comment.', '2025-06-06 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-007', 'prod-007', 'cust-007', 3, 'Review 7 comment.', '2025-07-07 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-008', 'prod-008', 'cust-008', 4, 'Review 8 comment.', '2025-08-08 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-009', 'prod-009', 'cust-009', 5, 'Review 9 comment.', '2025-09-09 12:00:00', TRUE);
INSERT INTO PRODUCT_REVIEW (review_id, product_id, customer_id, rating, comment, created, verified) VALUES ('rev-010', 'prod-010', 'cust-010', 1, 'Review 10 comment.', '2025-10-10 12:00:00', TRUE);

-- WISHLIST
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-001', 'cust-001', 'Alex''s wishlist', '2025-01-01', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-002', 'cust-002', 'Jordan''s wishlist', '2025-02-02', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-003', 'cust-003', 'Sam''s wishlist', '2025-03-03', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-004', 'cust-004', 'Taylor''s wishlist', '2025-04-04', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-005', 'cust-005', 'Chris''s wishlist', '2025-05-05', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-006', 'cust-006', 'Morgan''s wishlist', '2025-06-06', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-007', 'cust-007', 'Casey''s wishlist', '2025-07-07', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-008', 'cust-008', 'Jamie''s wishlist', '2025-08-08', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-009', 'cust-009', 'Pat''s wishlist', '2025-09-09', FALSE);
INSERT INTO WISHLIST (wishlist_id, customer_id, name, created, is_public) VALUES ('wl-010', 'cust-010', 'Riley''s wishlist', '2025-10-10', FALSE);

-- WISHLIST_ITEM
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-001', 'wl-001', 'prod-001', '2025-01-01', 2);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-002', 'wl-002', 'prod-002', '2025-02-02', 3);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-003', 'wl-003', 'prod-003', '2025-03-03', 1);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-004', 'wl-004', 'prod-004', '2025-04-04', 2);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-005', 'wl-005', 'prod-005', '2025-05-05', 3);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-006', 'wl-006', 'prod-006', '2025-06-06', 1);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-007', 'wl-007', 'prod-007', '2025-07-07', 2);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-008', 'wl-008', 'prod-008', '2025-08-08', 3);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-009', 'wl-009', 'prod-009', '2025-09-09', 1);
INSERT INTO WISHLIST_ITEM (item_id, wishlist_id, product_id, added, priority) VALUES ('wli-010', 'wl-010', 'prod-010', '2025-10-10', 2);

-- SHIPPING_CARRIER
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-001', 'UPS', '800-742-5877', 8.99);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-002', 'FedEx', '800-463-3339', 9.99);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-003', 'USPS', '800-275-8777', 6.99);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-004', 'DHL', '800-225-5345', 12.99);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-005', 'OnTrac', '800-334-5000', 7.99);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-006', 'LaserShip', '804-414-2590', 6.49);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-007', 'Amazon Logistics', '888-280-4331', 0.0);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-008', 'XPO', '855-976-3666', 14.99);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-009', 'Speedee', '920-432-2200', 8.49);
INSERT INTO SHIPPING_CARRIER (carrier_id, name, phone, base_rate) VALUES ('car-010', 'Pitney Bowes', '800-322-8000', 5.99);

-- SHIPMENT
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-001', 'car-001', 'TRK1000001', '2025-01-01', '2025-01-05', 'Delivered');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-002', 'car-002', 'TRK1000002', '2025-02-02', '2025-02-06', 'Delivered');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-003', 'car-003', 'TRK1000003', '2025-03-03', '2025-03-07', 'In Transit');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-004', 'car-004', 'TRK1000004', '2025-04-04', '2025-04-08', 'Pending');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-005', 'car-005', 'TRK1000005', '2025-05-05', '2025-05-09', 'Delivered');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-006', 'car-006', 'TRK1000006', '2025-06-06', '2025-06-10', 'Pending');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-007', 'car-007', 'TRK1000007', '2025-07-07', '2025-07-11', 'Pending');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-008', 'car-008', 'TRK1000008', '2025-08-08', '2025-08-12', 'Pending');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-009', 'car-009', 'TRK1000009', '2025-09-09', '2025-09-13', 'In Transit');
INSERT INTO SHIPMENT (shipment_id, carrier_id, tracking_number, ship_date, delivery_date, status) VALUES ('shp-010', 'car-010', 'TRK1000010', '2025-10-10', '2025-10-14', 'Pending');

-- ONLINE_ORDER
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-001', 'cust-001', 'shp-001', '2025-01-01 14:00:00', 52.5, 9.99, 3.15, 65.64, 'Shipped');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-002', 'cust-002', 'shp-002', '2025-02-02 14:00:00', 65.0, 9.99, 3.9, 78.89, 'Shipped');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-003', 'cust-003', 'shp-003', '2025-03-03 14:00:00', 77.5, 9.99, 4.65, 92.14, 'Shipped');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-004', 'cust-004', 'shp-004', '2025-04-04 14:00:00', 90.0, 9.99, 5.4, 105.39, 'Cancelled');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-005', 'cust-005', 'shp-005', '2025-05-05 14:00:00', 102.5, 9.99, 6.15, 118.64, 'Cancelled');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-006', 'cust-006', 'shp-006', '2025-06-06 14:00:00', 115.0, 9.99, 6.9, 131.89, 'Delivered');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-007', 'cust-007', 'shp-007', '2025-07-07 14:00:00', 127.5, 9.99, 7.65, 145.14, 'Shipped');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-008', 'cust-008', 'shp-008', '2025-08-08 14:00:00', 140.0, 9.99, 8.4, 158.39, 'Delivered');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-009', 'cust-009', 'shp-009', '2025-09-09 14:00:00', 152.5, 9.99, 9.15, 171.64, 'Placed');
INSERT INTO ONLINE_ORDER (order_id, customer_id, shipment_id, order_date, subtotal, shipping, tax, total, status) VALUES ('oo-010', 'cust-010', 'shp-010', '2025-10-10 14:00:00', 165.0, 9.99, 9.9, 184.89, 'Shipped');

-- ONLINE_ORDER_ITEM
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-001', 'oo-001', 'prod-001', 2, 19.0, 38.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-002', 'oo-002', 'prod-002', 3, 23.0, 69.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-003', 'oo-003', 'prod-003', 1, 27.0, 27.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-004', 'oo-004', 'prod-004', 2, 31.0, 62.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-005', 'oo-005', 'prod-005', 3, 35.0, 105.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-006', 'oo-006', 'prod-006', 1, 39.0, 39.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-007', 'oo-007', 'prod-007', 2, 43.0, 86.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-008', 'oo-008', 'prod-008', 3, 47.0, 141.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-009', 'oo-009', 'prod-009', 1, 51.0, 51.0);
INSERT INTO ONLINE_ORDER_ITEM (item_id, order_id, product_id, quantity, price, total) VALUES ('ooi-010', 'oo-010', 'prod-010', 2, 55.0, 110.0);

-- RETURN_TRANSACTION
INSERT INTO RETURN_TRANSACTION (return_id, sale_id, return_date, refund_amount, reason, status) VALUES ('rt-001', 'sale-001', '2025-01-05', 25.0, 'Defective product', 'Approved');
INSERT INTO RETURN_TRANSACTION (return_id, sale_id, return_date, refund_amount, reason, status) VALUES ('rt-002', 'sale-002', '2025-02-06', 30.0, 'Defective product', 'Approved');
INSERT INTO RETURN_TRANSACTION (return_id, sale_id, return_date, refund_amount, reason, status) VALUES ('rt-003', 'sale-003', '2025-03-07', 35.0, 'Defective product', 'Approved');
INSERT INTO RETURN_TRANSACTION (return_id, sale_id, return_date, refund_amount, reason, status) VALUES ('rt-004', 'sale-004', '2025-04-08', 40.0, 'Defective product', 'Approved');
INSERT INTO RETURN_TRANSACTION (return_id, sale_id, return_date, refund_amount, reason, status) VALUES ('rt-005', 'sale-005', '2025-05-09', 45.0, 'Defective product', 'Approved');

-- RETURN_ITEM
INSERT INTO RETURN_ITEM (item_id, return_id, sale_item_id, quantity, item_condition) VALUES ('ri-001', 'rt-001', 'si-001', 1, 'Damaged');
INSERT INTO RETURN_ITEM (item_id, return_id, sale_item_id, quantity, item_condition) VALUES ('ri-002', 'rt-002', 'si-002', 1, 'Damaged');
INSERT INTO RETURN_ITEM (item_id, return_id, sale_item_id, quantity, item_condition) VALUES ('ri-003', 'rt-003', 'si-003', 1, 'Damaged');
INSERT INTO RETURN_ITEM (item_id, return_id, sale_item_id, quantity, item_condition) VALUES ('ri-004', 'rt-004', 'si-004', 1, 'Damaged');
INSERT INTO RETURN_ITEM (item_id, return_id, sale_item_id, quantity, item_condition) VALUES ('ri-005', 'rt-005', 'si-005', 1, 'Damaged');

-- EMPLOYEE_SCHEDULE
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-001', 'emp-001', 'store-001', '2025-06-01', '09:00:00', '17:00:00', 'Morning');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-002', 'emp-002', 'store-002', '2025-06-02', '10:00:00', '18:00:00', 'Afternoon');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-003', 'emp-003', 'store-003', '2025-06-03', '11:00:00', '19:00:00', 'Afternoon');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-004', 'emp-004', 'store-004', '2025-06-04', '08:00:00', '16:00:00', 'Afternoon');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-005', 'emp-005', 'store-005', '2025-06-05', '09:00:00', '17:00:00', 'Morning');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-006', 'emp-006', 'store-006', '2025-06-06', '10:00:00', '18:00:00', 'Morning');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-007', 'emp-007', 'store-007', '2025-06-07', '11:00:00', '19:00:00', 'Night');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-008', 'emp-008', 'store-008', '2025-06-08', '08:00:00', '16:00:00', 'Night');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-009', 'emp-009', 'store-009', '2025-06-09', '09:00:00', '17:00:00', 'Afternoon');
INSERT INTO EMPLOYEE_SCHEDULE (schedule_id, employee_id, store_id, shift_date, start_time, end_time, shift_type) VALUES ('sch-010', 'emp-010', 'store-010', '2025-06-10', '10:00:00', '18:00:00', 'Morning');

-- TRAINING_RECORD
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-001', 'emp-001', 'sport-001', 'Cert L1', '2024-01-01', '2026-01-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-002', 'emp-002', 'sport-002', 'Cert L2', '2024-02-01', '2026-02-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-003', 'emp-003', 'sport-003', 'Cert L3', '2024-03-01', '2026-03-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-004', 'emp-004', 'sport-004', 'Cert L1', '2024-04-01', '2026-04-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-005', 'emp-005', 'sport-005', 'Cert L2', '2024-05-01', '2026-05-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-006', 'emp-006', 'sport-006', 'Cert L3', '2024-06-01', '2026-06-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-007', 'emp-007', 'sport-007', 'Cert L1', '2024-07-01', '2026-07-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-008', 'emp-008', 'sport-008', 'Cert L2', '2024-08-01', '2026-08-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-009', 'emp-009', 'sport-009', 'Cert L3', '2024-09-01', '2026-09-01');
INSERT INTO TRAINING_RECORD (training_id, employee_id, sport_type_id, certification, completed, expires) VALUES ('tr-010', 'emp-010', 'sport-010', 'Cert L1', '2024-10-01', '2026-10-01');

-- STORE_HOURS
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-001', 'store-001', 'Monday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-002', 'store-001', 'Tuesday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-003', 'store-002', 'Monday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-004', 'store-002', 'Tuesday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-005', 'store-003', 'Monday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-006', 'store-003', 'Tuesday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-007', 'store-004', 'Monday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-008', 'store-004', 'Tuesday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-009', 'store-005', 'Monday', '09:00:00', '21:00:00', FALSE);
INSERT INTO STORE_HOURS (hours_id, store_id, day_of_week, open_time, close_time, is_holiday) VALUES ('sh-010', 'store-005', 'Tuesday', '09:00:00', '21:00:00', FALSE);

-- MEMBERSHIP_TIER
INSERT INTO MEMBERSHIP_TIER (tier_id, tier_name, min_points, discount_rate, free_shipping, early_access) VALUES ('mt-001', 'Bronze', 0, 0.0, FALSE, FALSE);
INSERT INTO MEMBERSHIP_TIER (tier_id, tier_name, min_points, discount_rate, free_shipping, early_access) VALUES ('mt-002', 'Silver', 1000, 0.05, FALSE, TRUE);
INSERT INTO MEMBERSHIP_TIER (tier_id, tier_name, min_points, discount_rate, free_shipping, early_access) VALUES ('mt-003', 'Gold', 5000, 0.1, TRUE, TRUE);
INSERT INTO MEMBERSHIP_TIER (tier_id, tier_name, min_points, discount_rate, free_shipping, early_access) VALUES ('mt-004', 'Platinum', 10000, 0.15, TRUE, TRUE);

-- EQUIPMENT_RENTAL
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-001', 'prod-001', 'cust-001', 'store-001', '2025-01-01', NULL, '2025-01-08', 11.5, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-002', 'prod-002', 'cust-002', 'store-002', '2025-02-01', NULL, '2025-02-08', 13.0, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-003', 'prod-003', 'cust-003', 'store-003', '2025-03-01', NULL, '2025-03-08', 14.5, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-004', 'prod-004', 'cust-004', 'store-004', '2025-04-01', NULL, '2025-04-08', 16.0, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-005', 'prod-005', 'cust-005', 'store-005', '2025-05-01', NULL, '2025-05-08', 17.5, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-006', 'prod-006', 'cust-006', 'store-006', '2025-06-01', NULL, '2025-06-08', 19.0, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-007', 'prod-007', 'cust-007', 'store-007', '2025-07-01', NULL, '2025-07-08', 20.5, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-008', 'prod-008', 'cust-008', 'store-008', '2025-08-01', NULL, '2025-08-08', 22.0, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-009', 'prod-009', 'cust-009', 'store-009', '2025-09-01', NULL, '2025-09-08', 23.5, 50.0, 'Active');
INSERT INTO EQUIPMENT_RENTAL (rental_id, product_id, customer_id, store_id, rental_date, return_date, due_date, daily_rate, deposit, status) VALUES ('er-010', 'prod-010', 'cust-010', 'store-010', '2025-10-01', NULL, '2025-10-08', 25.0, 50.0, 'Active');

-- WARRANTY
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-001', 'si-001', 'Manufacturer', '2025-01-01', '2026-01-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-002', 'si-002', 'Manufacturer', '2025-02-01', '2026-02-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-003', 'si-003', 'Manufacturer', '2025-03-01', '2026-03-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-004', 'si-004', 'Manufacturer', '2025-04-01', '2026-04-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-005', 'si-005', 'Manufacturer', '2025-05-01', '2026-05-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-006', 'si-006', 'Manufacturer', '2025-06-01', '2026-06-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-007', 'si-007', 'Manufacturer', '2025-07-01', '2026-07-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-008', 'si-008', 'Manufacturer', '2025-08-01', '2026-08-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-009', 'si-009', 'Manufacturer', '2025-09-01', '2026-09-01', 19.99, '1-year manufacturer warranty');
INSERT INTO WARRANTY (warranty_id, sale_item_id, warranty_type, start_date, end_date, cost, terms) VALUES ('war-010', 'si-010', 'Manufacturer', '2025-10-01', '2026-10-01', 19.99, '1-year manufacturer warranty');

-- WARRANTY_CLAIM
INSERT INTO WARRANTY_CLAIM (claim_id, warranty_id, claim_date, issue_description, resolution, resolution_date, status) VALUES ('wc-001', 'war-001', '2025-01-15', 'Issue 1 description', 'Replaced', '2025-01-22', 'Approved');
INSERT INTO WARRANTY_CLAIM (claim_id, warranty_id, claim_date, issue_description, resolution, resolution_date, status) VALUES ('wc-002', 'war-002', '2025-02-15', 'Issue 2 description', 'Replaced', '2025-02-22', 'Approved');
INSERT INTO WARRANTY_CLAIM (claim_id, warranty_id, claim_date, issue_description, resolution, resolution_date, status) VALUES ('wc-003', 'war-003', '2025-03-15', 'Issue 3 description', 'Replaced', '2025-03-22', 'Approved');
INSERT INTO WARRANTY_CLAIM (claim_id, warranty_id, claim_date, issue_description, resolution, resolution_date, status) VALUES ('wc-004', 'war-004', '2025-04-15', 'Issue 4 description', 'Replaced', '2025-04-22', 'Approved');
INSERT INTO WARRANTY_CLAIM (claim_id, warranty_id, claim_date, issue_description, resolution, resolution_date, status) VALUES ('wc-005', 'war-005', '2025-05-15', 'Issue 5 description', 'Replaced', '2025-05-22', 'Approved');

-- GIFT_CARD
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-001', 'GC00100001', 60.0, 60.0, '2025-01-01', '2027-01-01', 'cust-001', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-002', 'GC00100002', 70.0, 70.0, '2025-01-01', '2027-01-01', 'cust-002', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-003', 'GC00100003', 80.0, 80.0, '2025-01-01', '2027-01-01', 'cust-003', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-004', 'GC00100004', 90.0, 90.0, '2025-01-01', '2027-01-01', 'cust-004', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-005', 'GC00100005', 100.0, 100.0, '2025-01-01', '2027-01-01', 'cust-005', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-006', 'GC00100006', 110.0, 110.0, '2025-01-01', '2027-01-01', 'cust-006', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-007', 'GC00100007', 120.0, 120.0, '2025-01-01', '2027-01-01', 'cust-007', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-008', 'GC00100008', 130.0, 130.0, '2025-01-01', '2027-01-01', 'cust-008', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-009', 'GC00100009', 140.0, 140.0, '2025-01-01', '2027-01-01', 'cust-009', 'Active');
INSERT INTO GIFT_CARD (card_id, card_number, balance, original_amount, issue_date, expiration_date, purchaser_id, status) VALUES ('gc-010', 'GC00100010', 150.0, 150.0, '2025-01-01', '2027-01-01', 'cust-010', 'Active');

-- GIFT_CARD_TRANSACTION
INSERT INTO GIFT_CARD_TRANSACTION (transaction_id, card_id, sale_id, transaction_date, amount, remaining_balance) VALUES ('gct-001', 'gc-001', 'sale-001', '2025-01-10 11:00:00', 12.0, 48.0);
INSERT INTO GIFT_CARD_TRANSACTION (transaction_id, card_id, sale_id, transaction_date, amount, remaining_balance) VALUES ('gct-002', 'gc-002', 'sale-002', '2025-02-10 11:00:00', 14.0, 56.0);
INSERT INTO GIFT_CARD_TRANSACTION (transaction_id, card_id, sale_id, transaction_date, amount, remaining_balance) VALUES ('gct-003', 'gc-003', 'sale-003', '2025-03-10 11:00:00', 16.0, 64.0);
INSERT INTO GIFT_CARD_TRANSACTION (transaction_id, card_id, sale_id, transaction_date, amount, remaining_balance) VALUES ('gct-004', 'gc-004', 'sale-004', '2025-04-10 11:00:00', 18.0, 72.0);
INSERT INTO GIFT_CARD_TRANSACTION (transaction_id, card_id, sale_id, transaction_date, amount, remaining_balance) VALUES ('gct-005', 'gc-005', 'sale-005', '2025-05-10 11:00:00', 20.0, 80.0);

-- EVENT
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-001', 'store-001', 'sport-001', 'Event 1', 'Description for event 1', '2025-01-15', '10:00:00', '14:00:00', 50, 12.5);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-002', 'store-002', 'sport-002', 'Event 2', 'Description for event 2', '2025-02-15', '10:00:00', '14:00:00', 50, 15.0);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-003', 'store-003', 'sport-003', 'Event 3', 'Description for event 3', '2025-03-15', '10:00:00', '14:00:00', 50, 17.5);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-004', 'store-004', 'sport-004', 'Event 4', 'Description for event 4', '2025-04-15', '10:00:00', '14:00:00', 50, 20.0);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-005', 'store-005', 'sport-005', 'Event 5', 'Description for event 5', '2025-05-15', '10:00:00', '14:00:00', 50, 22.5);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-006', 'store-006', 'sport-006', 'Event 6', 'Description for event 6', '2025-06-15', '10:00:00', '14:00:00', 50, 25.0);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-007', 'store-007', 'sport-007', 'Event 7', 'Description for event 7', '2025-07-15', '10:00:00', '14:00:00', 50, 27.5);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-008', 'store-008', 'sport-008', 'Event 8', 'Description for event 8', '2025-08-15', '10:00:00', '14:00:00', 50, 30.0);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-009', 'store-009', 'sport-009', 'Event 9', 'Description for event 9', '2025-09-15', '10:00:00', '14:00:00', 50, 32.5);
INSERT INTO EVENT (event_id, store_id, sport_type_id, event_name, description, event_date, start_time, end_time, max_participants, cost) VALUES ('ev-010', 'store-010', 'sport-010', 'Event 10', 'Description for event 10', '2025-10-15', '10:00:00', '14:00:00', 50, 35.0);

-- EVENT_REGISTRATION
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-001', 'ev-001', 'cust-001', '2025-01-05 09:00:00', 'Pending', 'No-show');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-002', 'ev-002', 'cust-002', '2025-02-05 09:00:00', 'Pending', 'Attended');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-003', 'ev-003', 'cust-003', '2025-03-05 09:00:00', 'Pending', 'Attended');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-004', 'ev-004', 'cust-004', '2025-04-05 09:00:00', 'Paid', 'No-show');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-005', 'ev-005', 'cust-005', '2025-05-05 09:00:00', 'Pending', 'No-show');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-006', 'ev-006', 'cust-006', '2025-06-05 09:00:00', 'Pending', 'Attended');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-007', 'ev-007', 'cust-007', '2025-07-05 09:00:00', 'Paid', 'No-show');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-008', 'ev-008', 'cust-008', '2025-08-05 09:00:00', 'Paid', 'Attended');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-009', 'ev-009', 'cust-009', '2025-09-05 09:00:00', 'Paid', 'Attended');
INSERT INTO EVENT_REGISTRATION (registration_id, event_id, customer_id, registration_date, payment_status, attendance_status) VALUES ('evr-010', 'ev-010', 'cust-010', '2025-10-05 09:00:00', 'Paid', 'No-show');

SET FOREIGN_KEY_CHECKS = 1;
