CREATE DATABASE IF NOT EXISTS sports_storedb;
USE sports_storedb;

CREATE TABLE STORE_LOCATION (
    store_id CHAR(36) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    square_footage DECIMAL(10,2),
    opening_date DATE
);

CREATE TABLE DEPARTMENT (
    department_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE EMPLOYEE (
    employee_id CHAR(36) PRIMARY KEY,
    store_id CHAR(36),
    department_id CHAR(36),
    manager_id CHAR(36),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    hire_date DATE NOT NULL,
    hourly_rate DECIMAL(8,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id),
    FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
    -- manager_id FK added after MANAGER table is created (see ALTER below)
);

CREATE TABLE MANAGER (
    manager_id CHAR(36) PRIMARY KEY,
    employee_id CHAR(36),
    department_id CHAR(36),
    bonus_rate DECIMAL(5,2),
    promotion_date DATE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

-- Now that MANAGER exists we can wire EMPLOYEE.manager_id back to it.
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT fk_employee_manager
    FOREIGN KEY (manager_id) REFERENCES MANAGER(manager_id);

CREATE TABLE CATEGORY (
    category_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE BRAND (
    brand_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE SUPPLIER (
    supplier_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(200)
);

CREATE TABLE SPORT_TYPE (
    sport_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    season VARCHAR(20)
);

CREATE TABLE PRODUCT (
    product_id CHAR(36) PRIMARY KEY,
    category_id CHAR(36),
    brand_id CHAR(36),
    supplier_id CHAR(36),
    sport_type_id CHAR(36),
    name VARCHAR(200) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    size VARCHAR(20),
    color VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES CATEGORY(category_id),
    FOREIGN KEY (brand_id) REFERENCES BRAND(brand_id),
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id),
    FOREIGN KEY (sport_type_id) REFERENCES SPORT_TYPE(sport_id)
);

CREATE TABLE CUSTOMER (
    customer_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    birthday DATE,
    signup_date DATE NOT NULL
);

CREATE TABLE PAYMENT_METHOD (
    payment_id CHAR(36) PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE PROMOTION (
    promotion_id CHAR(36) PRIMARY KEY,
    code VARCHAR(50) UNIQUE,
    name VARCHAR(100) NOT NULL,
    discount_pct DECIMAL(5,2),
    discount_amt DECIMAL(10,2),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE SALE (
    sale_id CHAR(36) PRIMARY KEY,
    store_id CHAR(36),
    employee_id CHAR(36),
    customer_id CHAR(36),
    payment_id CHAR(36),
    promotion_id CHAR(36),
    sale_date TIMESTAMP NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (payment_id) REFERENCES PAYMENT_METHOD(payment_id),
    FOREIGN KEY (promotion_id) REFERENCES PROMOTION(promotion_id)
);

CREATE TABLE SALE_ITEM (
    item_id CHAR(36) PRIMARY KEY,
    sale_id CHAR(36),
    product_id CHAR(36),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES SALE(sale_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

CREATE TABLE INVENTORY (
    inventory_id CHAR(36) PRIMARY KEY,
    product_id CHAR(36),
    store_id CHAR(36),
    quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL,
    last_restock DATE,
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id)
);

CREATE TABLE LOYALTY_PROGRAM (
    loyalty_id CHAR(36) PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    points INT DEFAULT 0,
    tier VARCHAR(50),
    enrolled DATE NOT NULL
);

ALTER TABLE CUSTOMER
ADD COLUMN loyalty_id CHAR(36),
ADD FOREIGN KEY (loyalty_id) REFERENCES LOYALTY_PROGRAM(loyalty_id);

CREATE TABLE PURCHASE_ORDER (
    order_id CHAR(36) PRIMARY KEY,
    supplier_id CHAR(36),
    store_id CHAR(36),
    order_date DATE NOT NULL,
    delivery_date DATE,
    total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id),
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id)
);

CREATE TABLE PURCHASE_ORDER_ITEM (
    item_id CHAR(36) PRIMARY KEY,
    order_id CHAR(36),
    product_id CHAR(36),
    quantity INT NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES PURCHASE_ORDER(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

CREATE TABLE PRODUCT_REVIEW (
    review_id CHAR(36) PRIMARY KEY,
    product_id CHAR(36),
    customer_id CHAR(36),
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created TIMESTAMP NOT NULL,
    verified BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);

CREATE TABLE WISHLIST (
    wishlist_id CHAR(36) PRIMARY KEY,
    customer_id CHAR(36),
    name VARCHAR(100) NOT NULL,
    created DATE NOT NULL,
    is_public BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);

CREATE TABLE WISHLIST_ITEM (
    item_id CHAR(36) PRIMARY KEY,
    wishlist_id CHAR(36),
    product_id CHAR(36),
    added DATE NOT NULL,
    priority INT,
    FOREIGN KEY (wishlist_id) REFERENCES WISHLIST(wishlist_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

CREATE TABLE SHIPPING_CARRIER (
    carrier_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    base_rate DECIMAL(10,2)
);

CREATE TABLE SHIPMENT (
    shipment_id CHAR(36) PRIMARY KEY,
    carrier_id CHAR(36),
    tracking_number VARCHAR(100) UNIQUE,
    ship_date DATE,
    delivery_date DATE,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (carrier_id) REFERENCES SHIPPING_CARRIER(carrier_id)
);

CREATE TABLE ONLINE_ORDER (
    order_id CHAR(36) PRIMARY KEY,
    customer_id CHAR(36),
    shipment_id CHAR(36),
    order_date TIMESTAMP NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    shipping DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (shipment_id) REFERENCES SHIPMENT(shipment_id)
);

CREATE TABLE ONLINE_ORDER_ITEM (
    item_id CHAR(36) PRIMARY KEY,
    order_id CHAR(36),
    product_id CHAR(36),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES ONLINE_ORDER(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);

CREATE TABLE RETURN_TRANSACTION (
    return_id CHAR(36) PRIMARY KEY,
    sale_id CHAR(36),
    return_date DATE NOT NULL,
    refund_amount DECIMAL(10,2) NOT NULL,
    reason VARCHAR(200),
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES SALE(sale_id)
);

CREATE TABLE RETURN_ITEM (
    item_id CHAR(36) PRIMARY KEY,
    return_id CHAR(36),
    sale_item_id CHAR(36),
    quantity INT NOT NULL,
    item_condition VARCHAR(50),
    FOREIGN KEY (return_id) REFERENCES RETURN_TRANSACTION(return_id),
    FOREIGN KEY (sale_item_id) REFERENCES SALE_ITEM(item_id)
);

CREATE TABLE EMPLOYEE_SCHEDULE (
    schedule_id CHAR(36) PRIMARY KEY,
    employee_id CHAR(36),
    store_id CHAR(36),
    shift_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    shift_type VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id)
);

CREATE TABLE TRAINING_RECORD (
    training_id CHAR(36) PRIMARY KEY,
    employee_id CHAR(36),
    sport_type_id CHAR(36),
    certification VARCHAR(100) NOT NULL,
    completed DATE NOT NULL,
    expires DATE,
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (sport_type_id) REFERENCES SPORT_TYPE(sport_id)
);

CREATE TABLE STORE_HOURS (
    hours_id CHAR(36) PRIMARY KEY,
    store_id CHAR(36),
    day_of_week VARCHAR(10) NOT NULL,
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    is_holiday BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id)
);

CREATE TABLE MEMBERSHIP_TIER (
    tier_id CHAR(36) PRIMARY KEY,
    tier_name VARCHAR(50) NOT NULL,
    min_points INT NOT NULL,
    discount_rate DECIMAL(5,2),
    free_shipping BOOLEAN DEFAULT FALSE,
    early_access BOOLEAN DEFAULT FALSE
);

CREATE TABLE EQUIPMENT_RENTAL (
    rental_id CHAR(36) PRIMARY KEY,
    product_id CHAR(36),
    customer_id CHAR(36),
    store_id CHAR(36),
    rental_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    daily_rate DECIMAL(10,2) NOT NULL,
    deposit DECIMAL(10,2),
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id)
);

CREATE TABLE WARRANTY (
    warranty_id CHAR(36) PRIMARY KEY,
    sale_item_id CHAR(36),
    warranty_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    cost DECIMAL(10,2),
    terms TEXT,
    FOREIGN KEY (sale_item_id) REFERENCES SALE_ITEM(item_id)
);

CREATE TABLE WARRANTY_CLAIM (
    claim_id CHAR(36) PRIMARY KEY,
    warranty_id CHAR(36),
    claim_date DATE NOT NULL,
    issue_description TEXT NOT NULL,
    resolution TEXT,
    resolution_date DATE,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (warranty_id) REFERENCES WARRANTY(warranty_id)
);

CREATE TABLE GIFT_CARD (
    card_id CHAR(36) PRIMARY KEY,
    card_number VARCHAR(50) UNIQUE NOT NULL,
    balance DECIMAL(10,2) NOT NULL,
    original_amount DECIMAL(10,2) NOT NULL,
    issue_date DATE NOT NULL,
    expiration_date DATE,
    purchaser_id CHAR(36),
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (purchaser_id) REFERENCES CUSTOMER(customer_id)
);

CREATE TABLE GIFT_CARD_TRANSACTION (
    transaction_id CHAR(36) PRIMARY KEY,
    card_id CHAR(36),
    sale_id CHAR(36),
    transaction_date TIMESTAMP NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    remaining_balance DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (card_id) REFERENCES GIFT_CARD(card_id),
    FOREIGN KEY (sale_id) REFERENCES SALE(sale_id)
);

CREATE TABLE EVENT (
    event_id CHAR(36) PRIMARY KEY,
    store_id CHAR(36),
    sport_type_id CHAR(36),
    event_name VARCHAR(200) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    max_participants INT,
    cost DECIMAL(10,2),
    FOREIGN KEY (store_id) REFERENCES STORE_LOCATION(store_id),
    FOREIGN KEY (sport_type_id) REFERENCES SPORT_TYPE(sport_id)
);

CREATE TABLE EVENT_REGISTRATION (
    registration_id CHAR(36) PRIMARY KEY,
    event_id CHAR(36),
    customer_id CHAR(36),
    registration_date TIMESTAMP NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    attendance_status VARCHAR(20),
    FOREIGN KEY (event_id) REFERENCES EVENT(event_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);

CREATE TABLE APP_AUDIT_LOG (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    action_name VARCHAR(30) NOT NULL,
    table_name VARCHAR(80) NOT NULL,
    record_id VARCHAR(80),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE VENDOR_CONTRACT (                                       
    contract_id CHAR(36) PRIMARY KEY,                              
    supplier_id CHAR(36) NOT NULL,                            
    contract_number VARCHAR(50) UNIQUE NOT NULL,              
    start_date DATE NOT NULL,                                 
    end_date DATE NOT NULL,                                   
    contract_value DECIMAL(12,2) NOT NULL,                    
    payment_terms VARCHAR(100),                               
    status VARCHAR(20) NOT NULL,                              
    notes TEXT,                                               
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id)
); 
