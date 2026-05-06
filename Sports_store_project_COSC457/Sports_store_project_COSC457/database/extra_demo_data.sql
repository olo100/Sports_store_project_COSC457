-- Extra demo data for a richer classroom presentation.
-- Run this after database/sample_data.sql has already been loaded.
USE sports_storedb;
SET FOREIGN_KEY_CHECKS = 0;

-- More products for search, reports, dashboard charts, and inventory warnings
INSERT IGNORE INTO PRODUCT (product_id, category_id, brand_id, supplier_id, sport_type_id, name, sku, description, price, cost, size, color) VALUES
('prod-011', 'cat-001', 'brand-005', 'sup-001', 'sport-001', 'Fresh Foam Runner', 'SKU-1011', 'daily trainer running shoe', 129.99, 72.00, '11', 'Blue'),
('prod-012', 'cat-002', 'brand-007', 'sup-002', 'sport-002', 'Elite Indoor Basketball', 'SKU-1012', 'composite leather basketball', 59.99, 28.00, 'Official', 'Orange'),
('prod-013', 'cat-003', 'brand-002', 'sup-003', 'sport-003', 'Predator Soccer Cleats', 'SKU-1013', 'firm ground soccer cleats', 139.99, 80.00, '10', 'Black'),
('prod-014', 'cat-004', 'brand-008', 'sup-004', 'sport-004', 'Aero Tennis Racquet', 'SKU-1014', 'lightweight control racquet', 189.99, 105.00, 'Grip 3', 'White'),
('prod-015', 'cat-005', 'brand-009', 'sup-005', 'sport-005', 'Chrome Soft Golf Balls', 'SKU-1015', 'tour golf balls dozen', 49.99, 24.00, 'Dozen', 'White'),
('prod-016', 'cat-006', 'brand-010', 'sup-006', 'sport-006', 'Align Training Shorts', 'SKU-1016', 'stretch training shorts', 68.00, 31.00, 'M', 'Navy'),
('prod-017', 'cat-007', 'brand-003', 'sup-007', 'sport-007', 'Carbon Road Helmet', 'SKU-1017', 'ventilated cycling helmet', 94.99, 45.00, 'M', 'Red'),
('prod-018', 'cat-008', 'brand-004', 'sup-008', 'sport-008', 'Trail Hiking Pack', 'SKU-1018', '35L hiking backpack', 119.99, 58.00, '35L', 'Green'),
('prod-019', 'cat-009', 'brand-006', 'sup-009', 'sport-009', 'Competition Swim Cap', 'SKU-1019', 'silicone swim cap', 14.99, 5.00, 'One Size', 'Black'),
('prod-020', 'cat-010', 'brand-001', 'sup-010', 'sport-010', 'Youth Baseball Glove', 'SKU-1020', 'leather youth glove', 74.99, 36.00, '11 in', 'Brown');

-- More customers for customer search and lifetime-spend reports
INSERT IGNORE INTO CUSTOMER (customer_id, first_name, last_name, email, phone, birthday, signup_date) VALUES
('cust-011', 'Maya', 'Patel', 'maya.patel@example.com', '410-555-0311', '1991-01-14', '2025-01-14'),
('cust-012', 'Noah', 'Lee', 'noah.lee@example.com', '410-555-0312', '1988-02-18', '2025-02-18'),
('cust-013', 'Ava', 'Clark', 'ava.clark@example.com', '410-555-0313', '1996-03-22', '2025-03-22'),
('cust-014', 'Ethan', 'Turner', 'ethan.turner@example.com', '410-555-0314', '1985-04-26', '2025-04-26'),
('cust-015', 'Sophia', 'Nguyen', 'sophia.nguyen@example.com', '410-555-0315', '1993-05-30', '2025-05-30'),
('cust-016', 'Liam', 'Wilson', 'liam.wilson@example.com', '410-555-0316', '1990-06-12', '2025-06-12'),
('cust-017', 'Isabella', 'Moore', 'isabella.moore@example.com', '410-555-0317', '1997-07-16', '2025-07-16'),
('cust-018', 'Mason', 'Taylor', 'mason.taylor@example.com', '410-555-0318', '1989-08-20', '2025-08-20'),
('cust-019', 'Olivia', 'Anderson', 'olivia.anderson@example.com', '410-555-0319', '1994-09-24', '2025-09-24'),
('cust-020', 'Lucas', 'Thomas', 'lucas.thomas@example.com', '410-555-0320', '1992-10-28', '2025-10-28');

-- Store/product inventory, including several low-stock rows for visual highlighting
INSERT IGNORE INTO INVENTORY (inventory_id, product_id, store_id, quantity, reorder_level, last_restock) VALUES
('inv-011', 'prod-011', 'store-001', 42, 18, '2025-11-01'),
('inv-012', 'prod-012', 'store-002', 8, 20, '2025-11-02'),
('inv-013', 'prod-013', 'store-003', 5, 16, '2025-11-03'),
('inv-014', 'prod-014', 'store-004', 27, 10, '2025-11-04'),
('inv-015', 'prod-015', 'store-005', 4, 25, '2025-11-05'),
('inv-016', 'prod-016', 'store-006', 65, 22, '2025-11-06'),
('inv-017', 'prod-017', 'store-007', 7, 18, '2025-11-07'),
('inv-018', 'prod-018', 'store-008', 33, 14, '2025-11-08'),
('inv-019', 'prod-019', 'store-009', 3, 30, '2025-11-09'),
('inv-020', 'prod-020', 'store-010', 51, 15, '2025-11-10'),
('inv-021', 'prod-011', 'store-006', 12, 18, '2025-11-11'),
('inv-022', 'prod-012', 'store-001', 44, 20, '2025-11-12'),
('inv-023', 'prod-013', 'store-002', 31, 16, '2025-11-13'),
('inv-024', 'prod-014', 'store-003', 9, 12, '2025-11-14'),
('inv-025', 'prod-015', 'store-004', 72, 25, '2025-11-15');

-- More sales spread across stores so dashboard charts look fuller
INSERT IGNORE INTO SALE (sale_id, store_id, employee_id, customer_id, payment_id, promotion_id, sale_date, subtotal, tax, total) VALUES
('sale-011', 'store-001', 'emp-001', 'cust-011', 'pay-002', 'prom-004', '2025-11-01 10:15:00', 259.98, 15.60, 275.58),
('sale-012', 'store-002', 'emp-002', 'cust-012', 'pay-003', 'prom-007', '2025-11-01 11:20:00', 179.97, 10.80, 190.77),
('sale-013', 'store-003', 'emp-003', 'cust-013', 'pay-004', 'prom-002', '2025-11-02 12:10:00', 419.97, 25.20, 445.17),
('sale-014', 'store-004', 'emp-004', 'cust-014', 'pay-002', 'prom-008', '2025-11-02 13:35:00', 379.98, 22.80, 402.78),
('sale-015', 'store-005', 'emp-005', 'cust-015', 'pay-001', 'prom-006', '2025-11-03 14:05:00', 149.97, 9.00, 158.97),
('sale-016', 'store-006', 'emp-006', 'cust-016', 'pay-005', 'prom-004', '2025-11-03 15:40:00', 204.00, 12.24, 216.24),
('sale-017', 'store-007', 'emp-007', 'cust-017', 'pay-002', 'prom-007', '2025-11-04 16:25:00', 284.97, 17.10, 302.07),
('sale-018', 'store-008', 'emp-008', 'cust-018', 'pay-003', 'prom-005', '2025-11-04 17:30:00', 239.98, 14.40, 254.38),
('sale-019', 'store-009', 'emp-009', 'cust-019', 'pay-004', 'prom-009', '2025-11-05 18:10:00', 44.97, 2.70, 47.67),
('sale-020', 'store-010', 'emp-010', 'cust-020', 'pay-002', 'prom-004', '2025-11-05 19:45:00', 224.97, 13.50, 238.47),
('sale-021', 'store-001', 'emp-001', 'cust-012', 'pay-006', 'prom-010', '2025-11-06 09:35:00', 389.97, 23.40, 413.37),
('sale-022', 'store-002', 'emp-002', 'cust-013', 'pay-002', 'prom-003', '2025-11-06 10:50:00', 199.98, 12.00, 211.98),
('sale-023', 'store-003', 'emp-003', 'cust-014', 'pay-003', 'prom-008', '2025-11-07 12:45:00', 569.97, 34.20, 604.17),
('sale-024', 'store-004', 'emp-004', 'cust-015', 'pay-004', 'prom-007', '2025-11-07 13:55:00', 259.98, 15.60, 275.58),
('sale-025', 'store-005', 'emp-005', 'cust-016', 'pay-002', 'prom-004', '2025-11-08 14:25:00', 419.97, 25.20, 445.17);

-- Sale line items for richer top-products and lifetime-spend reports
INSERT IGNORE INTO SALE_ITEM (item_id, sale_id, product_id, quantity, price, discount, total) VALUES
('si-011', 'sale-011', 'prod-011', 2, 129.99, 0.00, 259.98),
('si-012', 'sale-012', 'prod-012', 3, 59.99, 0.00, 179.97),
('si-013', 'sale-013', 'prod-013', 3, 139.99, 0.00, 419.97),
('si-014', 'sale-014', 'prod-014', 2, 189.99, 0.00, 379.98),
('si-015', 'sale-015', 'prod-015', 3, 49.99, 0.00, 149.97),
('si-016', 'sale-016', 'prod-016', 3, 68.00, 0.00, 204.00),
('si-017', 'sale-017', 'prod-017', 3, 94.99, 0.00, 284.97),
('si-018', 'sale-018', 'prod-018', 2, 119.99, 0.00, 239.98),
('si-019', 'sale-019', 'prod-019', 3, 14.99, 0.00, 44.97),
('si-020', 'sale-020', 'prod-020', 3, 74.99, 0.00, 224.97),
('si-021', 'sale-021', 'prod-011', 3, 129.99, 0.00, 389.97),
('si-022', 'sale-022', 'prod-015', 4, 49.99, 0.00, 199.96),
('si-023', 'sale-023', 'prod-014', 3, 189.99, 0.00, 569.97),
('si-024', 'sale-024', 'prod-011', 2, 129.99, 0.00, 259.98),
('si-025', 'sale-025', 'prod-013', 3, 139.99, 0.00, 419.97);

-- A few sample audit events so the manager-only Audit Log tab is not empty before live edits
INSERT IGNORE INTO APP_AUDIT_LOG (audit_id, username, role_name, action_name, table_name, record_id, created_at) VALUES
(1, 'manager', 'Manager', 'INSERT', 'PRODUCT', 'prod-011', '2025-11-01 09:00:00'),
(2, 'manager', 'Manager', 'INSERT', 'CUSTOMER', 'cust-011', '2025-11-01 09:05:00'),
(3, 'employee', 'Employee', 'INSERT', 'SALE', 'sale-011', '2025-11-01 10:16:00'),
(4, 'employee', 'Employee', 'INSERT', 'SALE_ITEM', 'si-011', '2025-11-01 10:17:00'),
(5, 'manager', 'Manager', 'UPDATE', 'INVENTORY', 'inv-012', '2025-11-02 08:30:00');

SET FOREIGN_KEY_CHECKS = 1;
