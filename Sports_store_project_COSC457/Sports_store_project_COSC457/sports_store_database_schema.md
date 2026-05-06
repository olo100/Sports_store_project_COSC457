# Sports Store Database Schema

## Complete Table Definitions

### 1. STORE_LOCATION
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| store_id | UUID | PRIMARY KEY | Unique store identifier |
| store_name | VARCHAR(100) | NOT NULL | Store name |
| address | VARCHAR(200) | NOT NULL | Street address |
| city | VARCHAR(100) | NOT NULL | City |
| state | VARCHAR(2) | NOT NULL | State code |
| zip_code | VARCHAR(10) | NOT NULL | Postal code |
| phone | VARCHAR(15) | NOT NULL | Contact phone |
| square_footage | DECIMAL(10,2) | | Store size |
| opening_date | DATE | | Store opening date |

### 2. EMPLOYEE
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| employee_id | UUID | PRIMARY KEY | Unique employee identifier |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Assigned store |
| department_id | UUID | FOREIGN KEY → DEPARTMENT | Department assignment |
| manager_id | UUID | FOREIGN KEY → MANAGER | Direct manager |
| first_name | VARCHAR(50) | NOT NULL | First name |
| last_name | VARCHAR(50) | NOT NULL | Last name |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Email address |
| phone | VARCHAR(15) | | Contact phone |
| hire_date | DATE | NOT NULL | Date hired |
| hourly_rate | DECIMAL(8,2) | NOT NULL | Pay rate |
| status | VARCHAR(20) | NOT NULL | Active/Inactive/Leave |

### 3. MANAGER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| manager_id | UUID | PRIMARY KEY | Unique manager identifier |
| employee_id | UUID | FOREIGN KEY → EMPLOYEE | Employee record |
| department_id | UUID | FOREIGN KEY → DEPARTMENT | Department managed |
| bonus_rate | DECIMAL(5,2) | | Bonus percentage |
| promotion_date | DATE | | Date promoted to manager |

### 4. DEPARTMENT
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| department_id | UUID | PRIMARY KEY | Unique department identifier |
| name | VARCHAR(100) | NOT NULL | Department name |
| description | TEXT | | Department description |

### 5. PRODUCT
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| product_id | UUID | PRIMARY KEY | Unique product identifier |
| category_id | UUID | FOREIGN KEY → CATEGORY | Product category |
| brand_id | UUID | FOREIGN KEY → BRAND | Brand |
| supplier_id | UUID | FOREIGN KEY → SUPPLIER | Primary supplier |
| sport_type_id | UUID | FOREIGN KEY → SPORT_TYPE | Sport classification |
| name | VARCHAR(200) | NOT NULL | Product name |
| sku | VARCHAR(50) | UNIQUE, NOT NULL | Stock keeping unit |
| description | TEXT | | Product description |
| price | DECIMAL(10,2) | NOT NULL | Retail price |
| cost | DECIMAL(10,2) | NOT NULL | Wholesale cost |
| size | VARCHAR(20) | | Size (S/M/L or numeric) |
| color | VARCHAR(50) | | Color |

### 6. CATEGORY
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| category_id | UUID | PRIMARY KEY | Unique category identifier |
| name | VARCHAR(100) | NOT NULL | Category name |
| description | TEXT | | Category description |

### 7. BRAND
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| brand_id | UUID | PRIMARY KEY | Unique brand identifier |
| name | VARCHAR(100) | NOT NULL | Brand name |
| country | VARCHAR(100) | | Country of origin |

### 8. SUPPLIER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| supplier_id | UUID | PRIMARY KEY | Unique supplier identifier |
| name | VARCHAR(100) | NOT NULL | Supplier company name |
| contact_name | VARCHAR(100) | | Contact person |
| email | VARCHAR(100) | | Contact email |
| phone | VARCHAR(15) | | Contact phone |
| address | VARCHAR(200) | | Supplier address |

### 9. INVENTORY
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| inventory_id | UUID | PRIMARY KEY | Unique inventory identifier |
| product_id | UUID | FOREIGN KEY → PRODUCT | Product being tracked |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Store location |
| quantity | INTEGER | NOT NULL, DEFAULT 0 | Current stock level |
| reorder_level | INTEGER | NOT NULL | Reorder threshold |
| last_restock | DATE | | Last restocking date |

### 10. SALE
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| sale_id | UUID | PRIMARY KEY | Unique sale identifier |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Store location |
| employee_id | UUID | FOREIGN KEY → EMPLOYEE | Sales associate |
| customer_id | UUID | FOREIGN KEY → CUSTOMER | Customer |
| payment_id | UUID | FOREIGN KEY → PAYMENT_METHOD | Payment method |
| promotion_id | UUID | FOREIGN KEY → PROMOTION | Applied promotion |
| sale_date | TIMESTAMP | NOT NULL | Date and time of sale |
| subtotal | DECIMAL(10,2) | NOT NULL | Pre-tax amount |
| tax | DECIMAL(10,2) | NOT NULL | Tax amount |
| total | DECIMAL(10,2) | NOT NULL | Final amount |

### 11. SALE_ITEM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| item_id | UUID | PRIMARY KEY | Unique sale item identifier |
| sale_id | UUID | FOREIGN KEY → SALE | Parent sale |
| product_id | UUID | FOREIGN KEY → PRODUCT | Product sold |
| quantity | INTEGER | NOT NULL | Quantity sold |
| price | DECIMAL(10,2) | NOT NULL | Unit price at time of sale |
| discount | DECIMAL(10,2) | DEFAULT 0 | Discount applied |
| total | DECIMAL(10,2) | NOT NULL | Line total |

### 12. CUSTOMER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| customer_id | UUID | PRIMARY KEY | Unique customer identifier |
| loyalty_id | UUID | FOREIGN KEY → LOYALTY_PROGRAM | Loyalty membership |
| first_name | VARCHAR(50) | NOT NULL | First name |
| last_name | VARCHAR(50) | NOT NULL | Last name |
| email | VARCHAR(100) | UNIQUE | Email address |
| phone | VARCHAR(15) | | Contact phone |
| birthday | DATE | | Date of birth |
| signup_date | DATE | NOT NULL | Registration date |

### 13. LOYALTY_PROGRAM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| loyalty_id | UUID | PRIMARY KEY | Unique loyalty identifier |
| program_name | VARCHAR(100) | NOT NULL | Program name |
| points | INTEGER | DEFAULT 0 | Current points balance |
| tier | VARCHAR(50) | | Membership tier |
| enrolled | DATE | NOT NULL | Enrollment date |

### 14. PAYMENT_METHOD
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| payment_id | UUID | PRIMARY KEY | Unique payment method identifier |
| method_name | VARCHAR(50) | NOT NULL | Payment type name |
| description | TEXT | | Method description |

### 15. PURCHASE_ORDER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| order_id | UUID | PRIMARY KEY | Unique order identifier |
| supplier_id | UUID | FOREIGN KEY → SUPPLIER | Supplier |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Ordering store |
| order_date | DATE | NOT NULL | Order placed date |
| delivery_date | DATE | | Expected delivery |
| total | DECIMAL(10,2) | NOT NULL | Order total |
| status | VARCHAR(20) | NOT NULL | Order status |

### 16. PURCHASE_ORDER_ITEM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| item_id | UUID | PRIMARY KEY | Unique order item identifier |
| order_id | UUID | FOREIGN KEY → PURCHASE_ORDER | Parent order |
| product_id | UUID | FOREIGN KEY → PRODUCT | Product ordered |
| quantity | INTEGER | NOT NULL | Quantity ordered |
| cost | DECIMAL(10,2) | NOT NULL | Unit cost |
| total | DECIMAL(10,2) | NOT NULL | Line total |

### 17. PROMOTION
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| promotion_id | UUID | PRIMARY KEY | Unique promotion identifier |
| code | VARCHAR(50) | UNIQUE | Promo code |
| name | VARCHAR(100) | NOT NULL | Promotion name |
| discount_pct | DECIMAL(5,2) | | Percentage discount |
| discount_amt | DECIMAL(10,2) | | Fixed amount discount |
| start_date | DATE | NOT NULL | Start date |
| end_date | DATE | NOT NULL | End date |
| type | VARCHAR(50) | NOT NULL | Promotion type |

### 18. PRODUCT_REVIEW
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| review_id | UUID | PRIMARY KEY | Unique review identifier |
| product_id | UUID | FOREIGN KEY → PRODUCT | Product reviewed |
| customer_id | UUID | FOREIGN KEY → CUSTOMER | Reviewer |
| rating | INTEGER | NOT NULL, CHECK (1-5) | Star rating |
| comment | TEXT | | Review text |
| created | TIMESTAMP | NOT NULL | Review date/time |
| verified | BOOLEAN | DEFAULT FALSE | Verified purchase |

### 19. WISHLIST
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| wishlist_id | UUID | PRIMARY KEY | Unique wishlist identifier |
| customer_id | UUID | FOREIGN KEY → CUSTOMER | Wishlist owner |
| name | VARCHAR(100) | NOT NULL | Wishlist name |
| created | DATE | NOT NULL | Creation date |
| is_public | BOOLEAN | DEFAULT FALSE | Public visibility |

### 20. WISHLIST_ITEM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| item_id | UUID | PRIMARY KEY | Unique wishlist item identifier |
| wishlist_id | UUID | FOREIGN KEY → WISHLIST | Parent wishlist |
| product_id | UUID | FOREIGN KEY → PRODUCT | Desired product |
| added | DATE | NOT NULL | Date added |
| priority | INTEGER | | Priority ranking |

### 21. ONLINE_ORDER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| order_id | UUID | PRIMARY KEY | Unique order identifier |
| customer_id | UUID | FOREIGN KEY → CUSTOMER | Customer |
| shipment_id | UUID | FOREIGN KEY → SHIPMENT | Shipment details |
| order_date | TIMESTAMP | NOT NULL | Order date/time |
| subtotal | DECIMAL(10,2) | NOT NULL | Pre-tax/shipping amount |
| shipping | DECIMAL(10,2) | NOT NULL | Shipping cost |
| tax | DECIMAL(10,2) | NOT NULL | Tax amount |
| total | DECIMAL(10,2) | NOT NULL | Order total |
| status | VARCHAR(20) | NOT NULL | Order status |

### 22. ONLINE_ORDER_ITEM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| item_id | UUID | PRIMARY KEY | Unique order item identifier |
| order_id | UUID | FOREIGN KEY → ONLINE_ORDER | Parent order |
| product_id | UUID | FOREIGN KEY → PRODUCT | Product ordered |
| quantity | INTEGER | NOT NULL | Quantity ordered |
| price | DECIMAL(10,2) | NOT NULL | Unit price |
| total | DECIMAL(10,2) | NOT NULL | Line total |

### 23. SHIPMENT
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| shipment_id | UUID | PRIMARY KEY | Unique shipment identifier |
| carrier_id | UUID | FOREIGN KEY → SHIPPING_CARRIER | Shipping carrier |
| tracking_number | VARCHAR(100) | UNIQUE | Tracking number |
| ship_date | DATE | | Ship date |
| delivery_date | DATE | | Actual delivery date |
| status | VARCHAR(20) | NOT NULL | Shipment status |

### 24. SHIPPING_CARRIER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| carrier_id | UUID | PRIMARY KEY | Unique carrier identifier |
| name | VARCHAR(100) | NOT NULL | Carrier name |
| phone | VARCHAR(15) | | Contact phone |
| base_rate | DECIMAL(10,2) | | Base shipping rate |

### 25. RETURN_TRANSACTION
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| return_id | UUID | PRIMARY KEY | Unique return identifier |
| sale_id | UUID | FOREIGN KEY → SALE | Original sale |
| return_date | DATE | NOT NULL | Return date |
| refund_amount | DECIMAL(10,2) | NOT NULL | Refund amount |
| reason | VARCHAR(200) | | Return reason |
| status | VARCHAR(20) | NOT NULL | Return status |

### 26. RETURN_ITEM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| item_id | UUID | PRIMARY KEY | Unique return item identifier |
| return_id | UUID | FOREIGN KEY → RETURN_TRANSACTION | Parent return |
| sale_item_id | UUID | FOREIGN KEY → SALE_ITEM | Original sale item |
| quantity | INTEGER | NOT NULL | Quantity returned |
| condition | VARCHAR(50) | | Item condition |

### 27. EMPLOYEE_SCHEDULE
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| schedule_id | UUID | PRIMARY KEY | Unique schedule identifier |
| employee_id | UUID | FOREIGN KEY → EMPLOYEE | Scheduled employee |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Store location |
| shift_date | DATE | NOT NULL | Shift date |
| start_time | TIME | NOT NULL | Shift start time |
| end_time | TIME | NOT NULL | Shift end time |
| shift_type | VARCHAR(20) | | Morning/Afternoon/Night |

### 28. TRAINING_RECORD
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| training_id | UUID | PRIMARY KEY | Unique training identifier |
| employee_id | UUID | FOREIGN KEY → EMPLOYEE | Trained employee |
| sport_type_id | UUID | FOREIGN KEY → SPORT_TYPE | Sport specialization |
| certification | VARCHAR(100) | NOT NULL | Certification name |
| completed | DATE | NOT NULL | Completion date |
| expires | DATE | | Expiration date |

### 29. SPORT_TYPE
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| sport_id | UUID | PRIMARY KEY | Unique sport identifier |
| name | VARCHAR(100) | NOT NULL | Sport name |
| description | TEXT | | Sport description |
| season | VARCHAR(20) | | Primary season |

### 30. STORE_HOURS
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| hours_id | UUID | PRIMARY KEY | Unique hours identifier |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Store location |
| day_of_week | VARCHAR(10) | NOT NULL | Day name |
| open_time | TIME | NOT NULL | Opening time |
| close_time | TIME | NOT NULL | Closing time |
| is_holiday | BOOLEAN | DEFAULT FALSE | Holiday flag |

### 31. MEMBERSHIP_TIER
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| tier_id | UUID | PRIMARY KEY | Unique tier identifier |
| tier_name | VARCHAR(50) | NOT NULL | Tier name (Bronze/Silver/Gold/Platinum) |
| min_points | INTEGER | NOT NULL | Minimum points required |
| discount_rate | DECIMAL(5,2) | | Discount percentage |
| free_shipping | BOOLEAN | DEFAULT FALSE | Free shipping benefit |
| early_access | BOOLEAN | DEFAULT FALSE | Early sale access |

### 32. EQUIPMENT_RENTAL
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| rental_id | UUID | PRIMARY KEY | Unique rental identifier |
| product_id | UUID | FOREIGN KEY → PRODUCT | Equipment being rented |
| customer_id | UUID | FOREIGN KEY → CUSTOMER | Renting customer |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Rental location |
| rental_date | DATE | NOT NULL | Start date |
| return_date | DATE | | Actual return date |
| due_date | DATE | NOT NULL | Expected return date |
| daily_rate | DECIMAL(10,2) | NOT NULL | Daily rental rate |
| deposit | DECIMAL(10,2) | | Security deposit |
| status | VARCHAR(20) | NOT NULL | Active/Returned/Overdue |

### 33. WARRANTY
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| warranty_id | UUID | PRIMARY KEY | Unique warranty identifier |
| sale_item_id | UUID | FOREIGN KEY → SALE_ITEM | Product sold |
| warranty_type | VARCHAR(50) | NOT NULL | Extended/Manufacturer |
| start_date | DATE | NOT NULL | Coverage start |
| end_date | DATE | NOT NULL | Coverage end |
| cost | DECIMAL(10,2) | | Warranty cost |
| terms | TEXT | | Warranty terms |

### 34. WARRANTY_CLAIM
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| claim_id | UUID | PRIMARY KEY | Unique claim identifier |
| warranty_id | UUID | FOREIGN KEY → WARRANTY | Warranty policy |
| claim_date | DATE | NOT NULL | Claim filed date |
| issue_description | TEXT | NOT NULL | Problem description |
| resolution | TEXT | | Resolution details |
| resolution_date | DATE | | Date resolved |
| status | VARCHAR(20) | NOT NULL | Pending/Approved/Denied |

### 35. GIFT_CARD
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| card_id | UUID | PRIMARY KEY | Unique gift card identifier |
| card_number | VARCHAR(50) | UNIQUE, NOT NULL | Card number |
| balance | DECIMAL(10,2) | NOT NULL | Current balance |
| original_amount | DECIMAL(10,2) | NOT NULL | Initial value |
| issue_date | DATE | NOT NULL | Issue date |
| expiration_date | DATE | | Expiration date |
| purchaser_id | UUID | FOREIGN KEY → CUSTOMER | Purchaser |
| status | VARCHAR(20) | NOT NULL | Active/Used/Expired |

### 36. GIFT_CARD_TRANSACTION
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| transaction_id | UUID | PRIMARY KEY | Unique transaction identifier |
| card_id | UUID | FOREIGN KEY → GIFT_CARD | Gift card used |
| sale_id | UUID | FOREIGN KEY → SALE | Associated sale |
| transaction_date | TIMESTAMP | NOT NULL | Transaction date/time |
| amount | DECIMAL(10,2) | NOT NULL | Amount used |
| remaining_balance | DECIMAL(10,2) | NOT NULL | Balance after transaction |

### 37. EVENT
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| event_id | UUID | PRIMARY KEY | Unique event identifier |
| store_id | UUID | FOREIGN KEY → STORE_LOCATION | Event location |
| sport_type_id | UUID | FOREIGN KEY → SPORT_TYPE | Related sport |
| event_name | VARCHAR(200) | NOT NULL | Event name |
| description | TEXT | | Event description |
| event_date | DATE | NOT NULL | Event date |
| start_time | TIME | NOT NULL | Start time |
| end_time | TIME | NOT NULL | End time |
| max_participants | INTEGER | | Maximum attendees |
| cost | DECIMAL(10,2) | | Participation fee |

### 38. EVENT_REGISTRATION
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| registration_id | UUID | PRIMARY KEY | Unique registration identifier |
| event_id | UUID | FOREIGN KEY → EVENT | Event |
| customer_id | UUID | FOREIGN KEY → CUSTOMER | Participant |
| registration_date | TIMESTAMP | NOT NULL | Registration date/time |
| payment_status | VARCHAR(20) | NOT NULL | Paid/Pending/Refunded |
| attendance_status | VARCHAR(20) | | Attended/No-show/Cancelled |

### 39. VENDOR_CONTRACT
| Column Name | Data Type | Constraints | Description |
|-------------|-----------|-------------|-------------|
| contract_id | UUID | PRIMARY KEY | Unique contract identifier |
| supplier_id | UUID | FOREIGN KEY → SUPPLIER | Contracted supplier |
| start_date | DATE | NOT NULL | Contract start |
| end_date | DATE | NOT NULL | Contract end |
| payment_terms | VARCHAR(100) | | Payment terms |
| discount_rate | DECIMAL(5,2) | | Volume discount rate |
| minimum_order | DECIMAL(10,2) | | Minimum order value |
| status | VARCHAR(20) | NOT NULL | Active/Expired/Terminated |

---

## Summary Statistics

**Total Tables:** 39
**Total Relationships:** 60+
**Primary Keys:** 39
**Foreign Keys:** 70+

## Key Relationships Overview

1. **Store Operations:** Store locations employ staff, manage inventory, and process sales
2. **Employee Management:** Hierarchical structure with managers, departments, and schedules
3. **Product Catalog:** Products categorized by sport, brand, and supplier
4. **Sales Channels:** In-store sales and online orders with separate workflows
5. **Customer Engagement:** Loyalty programs, wishlists, reviews, and events
6. **Logistics:** Purchasing, inventory management, shipping, and returns
7. **Additional Services:** Equipment rentals, warranties, gift cards, and events
