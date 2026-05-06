# Sports Store Management System — COSC 457

Java + Swing front-end for the Sports Store MySQL database.

---

## Beginner Setup Guide (Start Here)

Follow these steps in order. This guide assumes no terminal experience.

---

### Step 1 — Install Java (JDK 17+)

1. Go to: https://www.oracle.com/java/technologies/downloads/
2. Download **JDK 17** (or newer) for your operating system (Windows, Mac, or Linux).
3. Run the installer and follow the prompts.
4. Verify it worked:
   - **Windows**: Open **Command Prompt** (search "cmd" in Start), type `javac -version`, press Enter. You should see something like `javac 17.0.x`.
   - **Mac**: Open **Terminal** (search in Spotlight), type `javac -version`, press Enter.

> If you see `'javac' is not recognized` on Windows, restart your computer and try again.

---

### Step 2 — Install MySQL + MySQL Workbench

You need MySQL (the database engine) and MySQL Workbench (a visual GUI so you don't need to use the terminal for SQL).

1. Go to: https://dev.mysql.com/downloads/installer/
2. Download **MySQL Installer** (Windows) or **MySQL Community Server** (Mac/Linux).
3. During installation, choose **"Developer Default"** — this installs both MySQL Server and MySQL Workbench.
4. When asked to set a root password, **write it down** — you will need it later.

> Mac users: After installing MySQL Server, also download MySQL Workbench separately from https://dev.mysql.com/downloads/workbench/

---

### Step 3 — Download / Clone the Project

If you have Git installed:
1. Open Terminal (Mac) or Command Prompt (Windows).
2. Run:
   ```
   git clone <your-repo-url-here>
   ```
3. Navigate into the folder:
   ```
   cd Sports_store_project_COSC457
   ```

If you **don't** have Git:
1. Go to the GitHub repo page.
2. Click the green **Code** button → **Download ZIP**.
3. Unzip the folder somewhere easy to find (like your Desktop).

---

### Step 4 — Set Up the Database (Using MySQL Workbench)

This loads the tables and sample data into MySQL. No terminal required.

1. Open **MySQL Workbench**.
2. Click on your local MySQL connection (usually called **Local instance MySQL**). Enter your root password if prompted.
3. Create the database:
   - In the top menu, click **Server → Data Import** — OR — click the SQL editor icon (looks like a lightning bolt).
   - In the query box, type the following and click the lightning bolt button to run it:
     ```sql
     CREATE DATABASE IF NOT EXISTS sports_storedb;
     ```
4. Load the schema (tables):
   - Click **File → Open SQL Script**.
   - Navigate to the project folder → `database` → open `sports_store_main.sql`.
   - At the top of the editor, make sure `sports_storedb` is selected in the schema dropdown.
   - Click the lightning bolt (Run) button.
5. Load the sample data:
   - Click **File → Open SQL Script** again.
   - Open `database/sample_data.sql` and click Run.
6. Load extra demo data:
   - Open `database/extra_demo_data.sql` and click Run.

You should now see tables populated in the left panel under `sports_storedb`.

---

### Step 5 — Configure the Database Connection

The app needs to know your MySQL username and password.

1. In the project folder, find the file `db.properties.example`.
2. Make a **copy** of it and rename the copy to `db.properties` (remove `.example`).
3. Open `db.properties` in any text editor (Notepad, TextEdit, VS Code, etc.).
4. Edit these lines to match your MySQL setup:
   ```
   db.host=localhost
   db.port=3306
   db.name=sports_storedb
   db.user=root
   db.password=YOUR_MYSQL_PASSWORD_HERE
   ```
5. Save the file.

---

### Step 6 — Build the App

#### On Mac or Linux:
1. Open Terminal and navigate to the project folder:
   ```
   cd path/to/Sports_store_project_COSC457
   ```
2. Run:
   ```
   ./build.sh
   ```

#### On Windows:
1. Make sure **Maven** is installed. Download from: https://maven.apache.org/download.cgi
   - Unzip it, then add the `bin` folder to your system PATH (Google "add Maven to PATH Windows" for a guide).
2. Open Command Prompt, navigate to the project folder:
   ```
   cd path\to\Sports_store_project_COSC457
   ```
3. Run:
   ```
   mvn clean package
   ```

Either method produces the file `target/sports-store-app.jar`.

---

### Step 7 — Run the Application

#### Mac / Linux (Terminal):
```
java -jar target/sports-store-app.jar
```

#### Windows (Command Prompt):
```
java -jar target\sports-store-app.jar
```

A window will open. Use the demo accounts to log in:

| Username | Password | Role |
|----------|----------|------|
| manager | manager123 | Manager |
| employee | employee123 | Employee |

> If you see a connection error dialog, double-check the password and username in `db.properties` and make sure MySQL is running.

---

### Common Problems

| Error | Fix |
|-------|-----|
| `'javac' is not recognized` | JDK not installed or not on PATH. Restart and try again. |
| `Communications link failure` | MySQL isn't running. Open MySQL Workbench and start the server. |
| `Access denied for user` | Wrong password in `db.properties`. |
| `Unknown database 'sports_storedb'` | You skipped Step 4. Go back and create the database. |
| `Cannot find or load main class` | You're running the jar from the wrong folder. Make sure you're inside the project folder. |

---

## Project Layout (For Reference)

```
Sports_store_project_COSC457/
├── build.sh                         Plain javac/jar build (Mac/Linux)
├── lib/
│   └── mysql-connector-j-8.3.0.jar   MySQL JDBC driver bundled into the jar
├── pom.xml                         Maven build (Windows)
├── db.properties.example           Template for local DB credentials
├── database/
│   ├── sports_store_main.sql       38-table schema (CREATE TABLE + FKs)
│   ├── sample_data.sql             ~10 rows per table of seed data
│   └── extra_demo_data.sql         Richer demo rows for charts and reports
├── sports_store_database_schema.md Human-readable schema doc
└── src/main/java/com/sportsstore/
    ├── App.java                    main() entry point
    ├── db/Database.java            JDBC connection helper
    ├── dao/GenericDao.java         Thin JDBC wrapper used by every panel
    └── ui/
        ├── MainFrame.java          Tabbed window
        ├── LoginDialog.java        Demo login/logout dialog
        ├── AuditLogPanel.java      Manager-only audit trail view
        ├── DashboardPanel.java     Summary metrics + top/low-stock tables
        ├── EntitySchema.java       Declarative description of a table
        ├── SchemaCatalog.java      The 8 entity schemas the app exposes
        ├── EntityCrudPanel.java    Generic CRUD UI (table + add/edit/delete)
        └── ReportsPanel.java       Read-only canned queries
```

## How the UI is Organised

The main window opens on a Dashboard tab, then has one tab per entity plus a Reports tab:

| Tab          | Backing table     | Add / Edit / Delete |
|--------------|-------------------|---------------------|
| Dashboard    | (multi-table SQL) | read-only |
| Stores       | STORE_LOCATION    | yes |
| Departments  | DEPARTMENT        | yes |
| Employees    | EMPLOYEE          | yes |
| Categories   | CATEGORY          | yes |
| Products     | PRODUCT           | yes |
| Customers    | CUSTOMER          | yes |
| Inventory    | INVENTORY         | yes |
| Sales        | SALE              | yes |
| Sale Items   | SALE_ITEM         | yes |
| Reports      | (multi-table SQL) | read-only |
| Audit Log    | APP_AUDIT_LOG     | manager-only |

Foreign-key columns (e.g. `Product → Category`) render as dropdowns populated from the referenced table, so you never type a UUID by hand.

Each CRUD tab also has a search box that filters the visible rows as you type. The Inventory tab highlights rows where `quantity` is below `reorder_level`, which makes low-stock products easy to spot during a demo.

## Troubleshooting (Advanced)

**`Communications link failure`** — MySQL isn't running, or `db.host` is wrong.

**`Access denied for user`** — credentials in `db.properties` don't match.

**`Unknown database 'sports_storedb'`** — you skipped the `CREATE DATABASE` step.

**`Cannot delete or update a parent row: a foreign key constraint fails`** — delete child records first before deleting the parent (e.g. remove employees before deleting their store).
