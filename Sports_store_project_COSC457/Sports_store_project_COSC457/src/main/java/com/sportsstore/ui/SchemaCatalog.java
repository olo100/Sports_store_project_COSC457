package com.sportsstore.ui;                                                                                                                                                                                        
                                                                                                                                                                                                                     
  public final class SchemaCatalog {

      private SchemaCatalog() {}                                                                                                                                                                                     
   
      public static EntitySchema store() {                                                                                                                                                                           
          EntitySchema s = new EntitySchema("STORE_LOCATION", "Stores").orderBy("store_name");
          s.primaryKey("store_id", "Store ID");                                                                                                                                                                      
          s.text("store_name", "Name").required();                                                                                                                                                                   
          s.text("address", "Address").required();                                                                                                                                                                   
          s.text("city", "City").required();                                                                                                                                                                         
          s.text("state", "State").required();
          s.text("zip_code", "ZIP").required();                                                                                                                                                                      
          s.text("phone", "Phone").required();
          s.decimal("square_footage", "Sq Ft");                                                                                                                                                                      
          s.date("opening_date", "Opened");
          return s;                                                                                                                                                                                                  
      }           
                                                                                                                                                                                                                     
      public static EntitySchema department() {
          EntitySchema s = new EntitySchema("DEPARTMENT", "Departments").orderBy("name");
          s.primaryKey("department_id", "Dept ID");                                                                                                                                                                  
          s.text("name", "Name").required();
          s.text("description", "Description");                                                                                                                                                                      
          return s;
      }                                                                                                                                                                                                              
                  
      public static EntitySchema employee() {
          EntitySchema s = new EntitySchema("EMPLOYEE", "Employees").orderBy("last_name, first_name");
          s.primaryKey("employee_id", "Emp ID");                                                                                                                                                                     
          s.foreignKey("store_id", "Store",
                  "SELECT store_id, store_name FROM STORE_LOCATION ORDER BY store_name");                                                                                                                            
          s.foreignKey("department_id", "Department",
                  "SELECT department_id, name FROM DEPARTMENT ORDER BY name");                                                                                                                                       
          s.foreignKey("manager_id", "Manager",
                  "SELECT manager_id, manager_id FROM MANAGER");                                                                                                                                                     
          s.text("first_name", "First Name").required();                                                                                                                                                             
          s.text("last_name", "Last Name").required();
          s.text("email", "Email").required();                                                                                                                                                                       
          s.text("phone", "Phone");
          s.date("hire_date", "Hire Date").required();                                                                                                                                                               
          s.decimal("hourly_rate", "Hourly Rate").required();                                                                                                                                                        
          s.dropdown("status", "Status", "Active", "Inactive", "Leave").required();
          return s;                                                                                                                                                                                                  
      }           
                                                                                                                                                                                                                     
      public static EntitySchema category() {
          EntitySchema s = new EntitySchema("CATEGORY", "Categories").orderBy("name");
          s.primaryKey("category_id", "Cat ID");                                                                                                                                                                     
          s.text("name", "Name").required();
          s.text("description", "Description");                                                                                                                                                                      
          return s;                                                                                                                                                                                                  
      }
                                                                                                                                                                                                                     
      public static EntitySchema product() {
          EntitySchema s = new EntitySchema("PRODUCT", "Products").orderBy("name");
          s.primaryKey("product_id", "Product ID");
          s.foreignKey("category_id", "Category",                                                                                                                                                                    
                  "SELECT category_id, name FROM CATEGORY ORDER BY name");
          s.foreignKey("brand_id", "Brand",                                                                                                                                                                          
                  "SELECT brand_id, name FROM BRAND ORDER BY name");                                                                                                                                                 
          s.foreignKey("supplier_id", "Supplier",
                  "SELECT supplier_id, name FROM SUPPLIER ORDER BY name");                                                                                                                                           
          s.foreignKey("sport_type_id", "Sport",                                                                                                                                                                     
                  "SELECT sport_id, name FROM SPORT_TYPE ORDER BY name");
          s.text("name", "Name").required();                                                                                                                                                                         
          s.text("sku", "SKU").required();                                                                                                                                                                           
          s.text("description", "Description");
          s.decimal("price", "Price").required();                                                                                                                                                                    
          s.decimal("cost", "Cost").required();
          s.text("size", "Size");                                                                                                                                                                                    
          s.text("color", "Color");
          return s;                                                                                                                                                                                                  
      }           

      public static EntitySchema customer() {                                                                                                                                                                        
          EntitySchema s = new EntitySchema("CUSTOMER", "Customers").orderBy("last_name, first_name");
          s.primaryKey("customer_id", "Cust ID");                                                                                                                                                                    
          s.text("first_name", "First Name").required();
          s.text("last_name", "Last Name").required();                                                                                                                                                               
          s.text("email", "Email");
          s.text("phone", "Phone");                                                                                                                                                                                  
          s.date("birthday", "Birthday");                                                                                                                                                                            
          s.date("signup_date", "Signed Up").required();
          return s;                                                                                                                                                                                                  
      }           

      public static EntitySchema inventory() {                                                                                                                                                                       
          EntitySchema s = new EntitySchema("INVENTORY", "Inventory").orderBy("inventory_id");
          s.primaryKey("inventory_id", "Inv ID");                                                                                                                                                                    
          s.foreignKey("product_id", "Product",                                                                                                                                                                      
                  "SELECT product_id, CONCAT(name, ' (', sku, ')') FROM PRODUCT ORDER BY name");
          s.foreignKey("store_id", "Store",                                                                                                                                                                          
                  "SELECT store_id, store_name FROM STORE_LOCATION ORDER BY store_name");
          s.integer("quantity", "Qty").required();                                                                                                                                                                   
          s.integer("reorder_level", "Reorder At").required();                                                                                                                                                       
          s.date("last_restock", "Last Restock");
          return s;                                                                                                                                                                                                  
      }           

      public static EntitySchema sale() {
          EntitySchema s = new EntitySchema("SALE", "Sales").orderBy("sale_date DESC");
          s.primaryKey("sale_id", "Sale ID");                                                                                                                                                                        
          s.foreignKey("store_id", "Store",
                  "SELECT store_id, store_name FROM STORE_LOCATION ORDER BY store_name");                                                                                                                            
          s.foreignKey("employee_id", "Cashier",
                  "SELECT employee_id, CONCAT(first_name,' ',last_name) FROM EMPLOYEE ORDER BY last_name");                                                                                                          
          s.foreignKey("customer_id", "Customer",                                                                                                                                                                    
                  "SELECT customer_id, CONCAT(first_name,' ',last_name) FROM CUSTOMER ORDER BY last_name");
          s.foreignKey("payment_id", "Payment",                                                                                                                                                                      
                  "SELECT payment_id, method_name FROM PAYMENT_METHOD ORDER BY method_name");
          s.foreignKey("promotion_id", "Promotion",                                                                                                                                                                  
                  "SELECT promotion_id, name FROM PROMOTION ORDER BY name");
          s.timestamp("sale_date", "Date").required();                                                                                                                                                               
          s.decimal("subtotal", "Subtotal").required();
          s.decimal("tax", "Tax").required();                                                                                                                                                                        
          s.decimal("total", "Total").required();
          return s;                                                                                                                                                                                                  
      }
                                                                                                                                                                                                                     
      public static EntitySchema saleItem() {
          EntitySchema s = new EntitySchema("SALE_ITEM", "Sale Items").orderBy("item_id");
          s.primaryKey("item_id", "Item ID");                                                                                                                                                                        
          s.foreignKey("sale_id", "Sale",
                  "SELECT sale_id, sale_id FROM SALE ORDER BY sale_date DESC");                                                                                                                                      
          s.foreignKey("product_id", "Product",                                                                                                                                                                      
                  "SELECT product_id, CONCAT(name, ' (', sku, ')') FROM PRODUCT ORDER BY name");
          s.integer("quantity", "Qty").required();                                                                                                                                                                   
          s.decimal("price", "Unit Price").required();
          s.decimal("discount", "Discount");                                                                                                                                                                         
          s.decimal("total", "Line Total").required();                                                                                                                                                               
          return s;
      }                                                                                                                                                                                                              
                  
      public static EntitySchema vendorContract() {
          EntitySchema s = new EntitySchema("VENDOR_CONTRACT", "Vendor Contracts").orderBy("contract_number");
          s.primaryKey("contract_id", "Contract ID");                                                                                                                                                                
          s.foreignKey("supplier_id", "Supplier",
                  "SELECT supplier_id, name FROM SUPPLIER ORDER BY name");                                                                                                                                           
          s.text("contract_number", "Contract #").required();
          s.date("start_date", "Start Date").required();                                                                                                                                                             
          s.date("end_date", "End Date").required();                                                                                                                                                                 
          s.decimal("contract_value", "Value").required();
          s.text("payment_terms", "Payment Terms");                                                                                                                                                                  
          s.dropdown("status", "Status", "Active", "Expired", "Pending", "Cancelled").required();
          s.text("notes", "Notes");                                                                                                                                                                                  
          return s;
      }                                                                                                                                                                                                              
  }
