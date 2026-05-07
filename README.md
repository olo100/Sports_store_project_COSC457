# Sports Store Management System — COSC 457

A Java desktop app (Swing UI) connected to a MySQL database. You can manage stores, employees, products, inventory, and sales through a tabbed window.

---

## How It All Works

Before you start, here is a quick explanation of each tool you will be using so nothing feels like a mystery.

- **MySQL** — the database engine. It runs as a background service on your computer and stores all the data (tables, rows, relationships). Think of it as the filing cabinet the app reads and writes to.
- **MySQL Workbench** — an optional visual GUI for MySQL. Instead of typing SQL commands in a terminal, you can point and click. You only need this if you prefer the GUI approach.
- **Java (JDK)** — the programming language the app is written in. You need it installed to both compile and run the app.
- **Maven** — a build tool for Java (Windows users need this). It reads `pom.xml`, downloads any dependencies, compiles the source code, and packages everything into one runnable `.jar` file.
- **build.sh** — the Mac/Linux equivalent of Maven for this project. It is a shell script that compiles and packages the app without needing Maven installed.
- **db.properties** — a small config file you create locally. It tells the app your MySQL username, password, and which database to connect to. It is never committed to git so your credentials stay private.
- **.jar file** — the compiled app. Once built, `target/sports-store-app.jar` is the file you run with Java.

---

## Step 1 — Install the Requirements

### Java (JDK 17 or newer)

The app requires Java 17+. You need the **JDK** (not just the JRE) because it includes the compiler.

**All platforms:**
1. Go to https://www.oracle.com/java/technologies/downloads/
2. Download **JDK 17** (or newer) for your OS and run the installer.

**Verify it worked** — open a terminal or Command Prompt and run:
```
javac -version
```
You should see something like `javac 17.0.x`. If you see an error, restart your terminal and try again.

---

### MySQL

MySQL is the database server. Install it once and it runs in the background.

**Windows:**
1. Download **MySQL Installer** from https://dev.mysql.com/downloads/installer/
2. Run the installer and choose **Developer Default** — this installs both MySQL Server and MySQL Workbench in one step.
3. During setup you will be asked to create a root password. **Write it down** — you will need it later.
4. Finish the installer. MySQL should start automatically as a Windows service.

**Mac:**
1. Download **MySQL Community Server** from https://dev.mysql.com/downloads/
2. Run the `.dmg` installer. At the end it will show a **temporary root password** — copy it immediately.
3. After install, go to **System Preferences → MySQL → Start MySQL Server**.
4. Open a terminal and reset your root password:
   ```bash
   mysql -u root -p
   ```
   Enter the temporary password, then run:
   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED BY 'your_new_password';
   EXIT;
   ```
5. Optionally download **MySQL Workbench** separately from https://dev.mysql.com/downloads/workbench/ if you want the GUI.

**Linux (Ubuntu/Debian):**
```bash
sudo apt update && sudo apt install mysql-server
sudo systemctl start mysql
sudo mysql_secure_installation
```

**Verify MySQL is running** — open a terminal and run:
```
mysql -u root -p
```
If you see a `mysql>` prompt, it is working. Type `EXIT;` to leave.

---

### Maven (Windows only)

Mac and Linux users can skip this — `build.sh` handles everything without Maven.

Maven is a build tool that compiles the Java source code and packages it into a `.jar` file.

1. Download Maven from https://maven.apache.org/download.cgi — grab the **Binary zip archive**.
2. Unzip it somewhere easy, for example `C:\maven`.
3. Add Maven to your system PATH so you can run it from any folder:
   - Search **"Environment Variables"** in the Start Menu and open it.
   - Under **System Variables**, find **Path** and click **Edit**.
   - Click **New** and add: `C:\maven\bin`
   - Click OK on all windows and restart Command Prompt.

**Verify it worked:**
```
mvn -version
```
You should see the Maven version printed. If not, double-check the PATH step above.

---

## Step 2 — Set Up the Database

This step creates the database, loads the table structure, and inserts sample data. Pick whichever method you prefer — both produce the same result.

---

### Option A: Terminal

**1. Log into MySQL:**
```
mysql -u root -p
```
Enter your root password when prompted.

**2. Create the database:**
```sql
CREATE DATABASE IF NOT EXISTS sports_storedb;
EXIT;
```

**3. Load the SQL files** — open a terminal, navigate to the project folder, and run these one at a time:

**Mac / Linux:**
```bash
mysql -u root -p sports_storedb < database/sports_store_main.sql
mysql -u root -p sports_storedb < database/sample_data.sql
mysql -u root -p sports_storedb < database/extra_demo_data.sql
```

**Windows (Command Prompt):**
```cmd
mysql -u root -p sports_storedb < database\sports_store_main.sql
mysql -u root -p sports_storedb < database\sample_data.sql
mysql -u root -p sports_storedb < database\extra_demo_data.sql
```

You will be asked for your password each time.

> **Windows tip:** If `mysql` is not recognized, add `C:\Program Files\MySQL\MySQL Server 8.0\bin` to your system PATH using the same steps as Maven above, then restart Command Prompt.

**4. Verify the tables loaded:**
```
mysql -u root -p -e "USE sports_storedb; SHOW TABLES;"
```
You should see a list of table names. If the list is empty, re-run the SQL files.

---

### Option B: MySQL Workbench (GUI)

MySQL Workbench is a visual interface for MySQL — no terminal needed.

> Windows users already have it if you chose **Developer Default** during MySQL installation.
> Mac users: download it from https://dev.mysql.com/downloads/workbench/

**1. Open MySQL Workbench** and click your local connection (usually called **Local instance MySQL**). Enter your root password if prompted.

**2. Create the database:**
- In the top toolbar, click the **SQL editor** icon (looks like a document with a plus sign) to open a new query tab.
- Type the following and click the **lightning bolt** button to run it:
  ```sql
  CREATE DATABASE IF NOT EXISTS sports_storedb;
  ```

**3. Load the schema (tables):**
- Click **File → Open SQL Script**
- Navigate to the project folder and open `database/sports_store_main.sql`
- In the schema dropdown near the top of the editor, select `sports_storedb`
- Click the **lightning bolt** to run the script

**4. Load the sample data:**
- Click **File → Open SQL Script** again
- Open `database/sample_data.sql` and click the lightning bolt to run it

**5. Load the extra demo data:**
- Repeat the same process for `database/extra_demo_data.sql`

**6. Verify it worked:**
- In the left panel, expand **Schemas → sports_storedb → Tables**
- You should see a list of tables. If not, re-run the SQL scripts.

---

## Step 3 — Configure the Database Connection

The app reads your MySQL credentials from a file called `db.properties`. This file is not included in the project (to keep passwords out of git), but a template is provided.

1. In the project folder, find `db.properties.example`.
2. Make a copy of it and rename the copy to `db.properties` (remove `.example` from the name).
3. Open `db.properties` in any text editor (Notepad, TextEdit, VS Code, etc.) and fill in your details:

```
db.host=localhost
db.port=3306
db.name=sports_storedb
db.user=root
db.password=YOUR_MYSQL_PASSWORD_HERE
```

4. Save the file. Do not share this file or commit it to git — it contains your password.

---

## Step 4 — Build the App

This compiles all the Java source files and packages them into `target/sports-store-app.jar`.

**Mac / Linux:**
```bash
./build.sh
```

If you get a permissions error, run this first to make the script executable:
```bash
chmod +x build.sh
```

**Windows:**
```cmd
mvn clean package
```

When it finishes you should see a `BUILD SUCCESS` message and the file `target/sports-store-app.jar` will exist.

---

## Step 5 — Run the App

**Mac / Linux:**
```bash
java -jar target/sports-store-app.jar
```

**Windows:**
```cmd
java -jar target\sports-store-app.jar
```

A window will open. Use one of these demo accounts to log in:

| Username | Password | Role |
|----------|----------|------|
| manager | manager123 | Manager |
| employee | employee123 | Employee |

The **Manager** account has access to all tabs including the Audit Log. The **Employee** account has access to everything except the Audit Log.

---

## What's in the App

| Tab | What it does |
|-----|--------------|
| Dashboard | Overview of key metrics and low-stock alerts |
| Stores | Add, edit, delete store locations |
| Departments | Manage departments within stores |
| Employees | Manage employee records |
| Categories | Product categories |
| Products | Add and manage products |
| Customers | Customer records |
| Inventory | Stock levels — low stock rows are highlighted |
| Sales | Sales transactions |
| Sale Items | Line items within a sale |
| Reports | Read-only summary reports |
| Audit Log | Manager only — history of all changes |

Each tab has a **search box** that filters rows as you type. Foreign-key fields (like Product → Category) show a dropdown instead of asking you to type an ID manually.

---

## Common Errors

| Error | Fix |
|-------|-----|
| `javac` not recognized | JDK not installed or not on PATH. Reinstall JDK and restart your terminal. |
| `mysql` not recognized | Add the MySQL `bin` folder to your system PATH and restart your terminal. |
| `mvn` not recognized | Maven not on PATH. Re-do the Maven PATH setup and restart Command Prompt. |
| `Communications link failure` | MySQL is not running. Start the MySQL service and try again. |
| `Access denied for user` | Wrong password in `db.properties`. Double-check it and save the file. |
| `Unknown database 'sports_storedb'` | You skipped Step 2. Go back and create the database. |
| `Cannot find or load main class` | You are running the `java` command from the wrong folder. Make sure you are inside the project folder. |
| `Cannot delete or update a parent row` | A foreign key constraint blocked the delete. Remove the child records first (e.g. remove employees before deleting their store). |
| `./build.sh: Permission denied` | Run `chmod +x build.sh` first, then try again. |

---

## Project Structure

```
Sports_store_project_COSC457/
├── database/
│   ├── sports_store_main.sql       38-table schema (CREATE TABLE + foreign keys)
│   ├── sample_data.sql             seed data (~10 rows per table)
│   └── extra_demo_data.sql         extra demo rows for charts and reports
├── src/main/java/com/sportsstore/
│   ├── App.java                    main() entry point
│   ├── db/Database.java            JDBC connection helper
│   ├── dao/GenericDao.java         JDBC wrapper used by every panel
│   └── ui/
│       ├── MainFrame.java          tabbed main window
│       ├── LoginDialog.java        login/logout dialog
│       ├── DashboardPanel.java     summary metrics + low-stock table
│       ├── EntitySchema.java       declarative table description
│       ├── SchemaCatalog.java      the 8 entity schemas the app exposes
│       ├── EntityCrudPanel.java    generic add/edit/delete UI
│       ├── ReportsPanel.java       read-only canned queries
│       └── AuditLogPanel.java      manager-only audit trail
├── lib/
│   └── mysql-connector-j-8.3.0.jar  MySQL JDBC driver (bundled into the jar)
├── db.properties.example           template — copy this to db.properties
├── build.sh                        build script for Mac/Linux
└── pom.xml                         Maven build config for Windows
```
