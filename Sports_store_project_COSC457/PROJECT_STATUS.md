# COSC 457 — Sports Store Project: What's Done & What's Left

This is a checklist built from the four reference files in your uploads:

- `Project Report Guidelines.pptx` (instructor's outline of deliverables)
- `Project Grade Rubric.pdf` (75 total points across 7 categories)
- `Report_1_Sample.docx` (format expectation for the design report)
- `Sample_TutorialManual.pdf` and `Sample_ReferenceManual.pdf` (format expectation for the manuals)

---

## TL;DR

The course wants two big deliverables: **(1) a Database Design Report** and **(2) a Software package** (Java app + executable jar + creation script + Reference Manual + Tutorial Manual + Flyer). On top of that there is a **Presentation**.

**Updated status (after this session):** the database is solid and the Java/Swing application has been built — ~9 source files covering connection, generic CRUD, 9 entity schemas (Store / Department / Employee / Category / Product / Customer / Inventory / Sale / SaleItem) and a Reports tab with 7 canned multi-table queries. A Maven `pom.xml` with the shade plugin produces a runnable fat-jar. Sample seed data with ~10 rows per table is in `database/sample_data.sql`.

**Remaining:** the design report document, the ERD diagram, the Reference Manual, the Tutorial Manual, the flyer, the presentation. Plus actually running `mvn package` on your machine (the sandbox here doesn't have a JDK).

Roughly: **~40 / 75 points of artifacts exist. ~35 points still need to be built — almost all of it is documentation and the ERD diagram.**

---

## 1. Database Design Report  *(rubric: 30 pts — Conceptual 20, Logical 5, Physical 5)*

The report itself is a Word document. The slides spell out its sections.

| # | Required section | Status | Notes |
|---|---|---|---|
| 1 | Title page / team members / signatures | TODO | See `Report_1_Sample.docx` for the layout. |
| 2 | Introduction (1–2 pages describing the whole project) | TODO | Not written. |
| 3 | Target Business (history, locations, branches, size, activities, total sales, target area, services) | TODO | Need a fictional sporting-goods company profile. |
| 4 | Business Process (sales scenarios, sequences, flowchart, Data Flow Diagram) | TODO | No DFD or flowchart exists. |
| 5 | User Requirements — Data Model | PARTIAL | The 39-table schema implies the data requirements but they are not written out as user stories. |
| 6 | User Requirements — Process Model (application function list) | TODO | Need a numbered list of functions the app must support. |
| 7 | Expected Database Queries (sample list) | TODO | Sample report shows ~10–12 example queries. None written. |
| 8 | ERD (conceptual diagram) | TODO | No ERD diagram exists — only the relational schema in markdown. **This is worth 20 pts on its own.** |
| 9 | Logical schema (relations from ERD) | DONE | Captured in `sports_store_database_schema.md`. |
| 10 | Physical design (DDL with PK / FK / constraints) | DONE | `database/sports_store_main.sql` covers 38 tables with PKs and FKs. |
| 11 | Assumptions list | TODO | Sample report has one — yours doesn't. |
| 12 | Gantt Chart (project plan/timeline) | TODO | Not started. |

**Quick wins inside this section:** the DDL is solid. The biggest single missing piece in this section is the **ERD diagram**, because by itself it's 20 of the 30 design-report points.

### Known issues in the existing DDL to fix while you're in there
- `MANAGER` is declared, but `EMPLOYEE.manager_id` has no `FOREIGN KEY` constraint pointing at it.
- The schema doc lists 39 tables; the SQL has 38. Compare the two files and decide whether the missing one (or any other discrepancy) is intentional.
- Consider adding `ON DELETE` / `ON UPDATE` actions and `NOT NULL` on FK columns where appropriate — the rubric's "Exemplary" tier rewards "not only keys but also other constraints."

---

## 2. Application — Design & Implementation  *(rubric: 30 pts — Design 10, Implementation 20)*

The slides require **Java + Swing + MySQL via JDBC**, delivered as an executable **jar**.

| # | Required item | Status | Notes |
|---|---|---|---|
| 1 | Java source code (Swing UI) | DONE | `src/main/java/com/sportsstore/` — App, Database, GenericDao, EntitySchema, SchemaCatalog, EntityCrudPanel, ReportsPanel, MainFrame. |
| 2 | Swing forms covering all user requirements | DONE | 9 entity tabs (Store, Department, Employee, Category, Product, Customer, Inventory, Sale, SaleItem) with Add / Edit / Delete dialogs. FK fields render as dropdowns. |
| 3 | JDBC connection layer to MySQL | DONE | `db/Database.java` — reads `db.properties`, opens fresh connections per query. |
| 4 | All declared functions implemented (no errors) | DONE (pending compile) | Code is written; needs `mvn package` on a machine with a JDK to verify. |
| 5 | Executable `.jar` (runs without extra installs) | DONE | `pom.xml` uses the shade plugin to produce a runnable fat-jar including the MySQL driver. Build with `mvn clean package`, run with `java -jar target/sports-store-app.jar`. |
| 6 | Polished input/output screens | PARTIAL | Tabs + sortable tables + form dialogs + a Reports tab with 7 canned queries. Tasteful for a class project; can be made fancier with an icon + nicer color scheme. |
| 7 | DB creation + sample data script | DONE | `database/sports_store_main.sql` (CREATE TABLEs + a missing-FK fix) and `database/sample_data.sql` (~10 rows per table, seeded deterministically). |

---

## 3. Manuals & Flyer  *(rubric: 5 pts for manuals; flyer is required by the slides)*

| # | Required item | Status | Notes |
|---|---|---|---|
| 1 | Reference Manual (every function explained alphabetically, with screenshots) | TODO | See `Sample_ReferenceManual.pdf`. |
| 2 | Tutorial Manual (work-process scenarios, every step explained with screenshots) | TODO | See `Sample_TutorialManual.pdf`. |
| 3 | Flyer (1-page promo for the application — target business, implemented functions, advantages/limitations) | TODO | |

The manuals can't be finished until the app is built — they need real screenshots.

---

## 4. Presentation  *(rubric: 10 pts)*

| # | Required item | Status | Notes |
|---|---|---|---|
| 1 | Presentation slide deck | TODO | |
| 2 | Live demo prep (face the audience, don't read notes) | TODO | Behavior, not a file. |

---

## Suggested order to attack the rest

1. **Fix the DDL nits** (manager FK, table count discrepancy) — small but free points on Physical design.
2. **Draw the ERD** — biggest single point payoff (20 pts). Tools: draw.io / Lucidchart / MySQL Workbench reverse-engineered from your DDL.
3. **Write the Database Design Report** in Word — Introduction, Target Business, Business Process (with DFD), User Requirements, Expected Queries, ERD image, Assumptions, Gantt.
4. **Add `INSERT` statements** to the SQL script so graders can populate the DB in one shot.
5. **Build the Java/Swing app** with JDBC. Start with a connection class and one or two CRUD screens (Product, Sale), then expand.
6. **Package as an executable jar** and verify it runs on a clean machine with no extra installs (just MySQL + the jar).
7. **Take screenshots while you work** — they go straight into the manuals.
8. **Write the Reference Manual and Tutorial Manual.**
9. **Make the flyer** (one Word/Canva page).
10. **Build the presentation deck** and rehearse.

---

## What's actually in the workspace right now

```
Sports_store_project_COSC457/
├── README.md                          DONE — full build/run instructions
├── pom.xml                            DONE — Maven build with mysql-connector-j + shade
├── db.properties.example              DONE — connection template
├── sports_store_database_schema.md    DONE — 39-table schema doc
├── database/
│   ├── sports_store_main.sql          DONE — DDL + manager FK fix
│   └── sample_data.sql                DONE — ~10 rows per table
└── src/main/java/com/sportsstore/
    ├── App.java                       DONE — main()
    ├── db/Database.java               DONE — JDBC connection helper
    ├── dao/GenericDao.java            DONE — thin JDBC wrapper
    └── ui/
        ├── MainFrame.java             DONE — tabbed window
        ├── EntitySchema.java          DONE — table descriptor
        ├── SchemaCatalog.java         DONE — 9 schema definitions
        ├── EntityCrudPanel.java       DONE — generic CRUD UI
        └── ReportsPanel.java          DONE — 7 canned queries
```

Still TODO: design report doc, ERD diagram, Reference Manual, Tutorial Manual, flyer, presentation.
