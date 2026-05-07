const fs = require("fs");
const path = require("path");
const { execFileSync } = require("child_process");
const sharp = require("sharp");
const pptxgen = require("pptxgenjs");
const {
  AlignmentType,
  BorderStyle,
  Document,
  HeadingLevel,
  ImageRun,
  Packer,
  PageBreak,
  Paragraph,
  ShadingType,
  Table,
  TableCell,
  TableRow,
  TextRun,
  WidthType,
} = require("docx");

const root = path.resolve(__dirname, "..");
const outDir = path.join(root, "submission");
const assetDir = path.join(outDir, "assets");
fs.mkdirSync(assetDir, { recursive: true });

const navy = "17324D";
const teal = "2A9D8F";
const gold = "E9C46A";
const light = "F4F7FA";
const ink = "1D2630";

const functionsList = [
  ["Categories", "Add, edit, delete, and browse product categories."],
  ["Customers", "Maintain customer identity, contact, birthday, and signup data."],
  ["Departments", "Maintain the departments used for employees and managers."],
  ["Employees", "Track store assignment, department, manager, contact data, pay rate, hire date, and status."],
  ["Inventory", "Track product quantity and reorder levels by store location."],
  ["Products", "Maintain products with category, brand, supplier, sport type, SKU, price, cost, size, and color."],
  ["Reports", "Run read-only business queries for revenue, inventory, customers, employees, and sales."],
  ["Sale Items", "Maintain line items for each sale, including product, quantity, price, discount, and line total."],
  ["Sales", "Track point-of-sale transactions by store, cashier, customer, payment method, promotion, subtotal, tax, and total."],
  ["Stores", "Maintain store location, address, phone, square footage, and opening date."],
];

const reportQueries = [
  "Inventory below reorder level",
  "Top 10 products by revenue",
  "Sales totals by store",
  "Customers by lifetime spend",
  "Employees per department",
  "Products that have never sold",
  "Recent sales",
];

function dotErd() {
  const dot = `digraph G {
    graph [rankdir=LR, bgcolor="white", pad="0.25", nodesep="0.45", ranksep="0.7"];
    node [shape=record, style="rounded,filled", fillcolor="#F4F7FA", color="#17324D", fontname="Helvetica", fontsize=10];
    edge [color="#2A9D8F", arrowsize=0.7, penwidth=1.4];

    STORE_LOCATION [label="{STORE_LOCATION|PK store_id\\lstore_name\\laddress\\lcity/state/zip\\l}"];
    DEPARTMENT [label="{DEPARTMENT|PK department_id\\lname\\ldescription\\l}"];
    EMPLOYEE [label="{EMPLOYEE|PK employee_id\\lFK store_id\\lFK department_id\\lFK manager_id\\lname/email\\lhire_date/rate/status\\l}"];
    MANAGER [label="{MANAGER|PK manager_id\\lFK employee_id\\lFK department_id\\lbonus_rate\\l}"];
    CATEGORY [label="{CATEGORY|PK category_id\\lname\\ldescription\\l}"];
    BRAND [label="{BRAND|PK brand_id\\lname\\lcountry\\l}"];
    SUPPLIER [label="{SUPPLIER|PK supplier_id\\lname/contact\\l}"];
    SPORT_TYPE [label="{SPORT_TYPE|PK sport_id\\lname\\lseason\\l}"];
    PRODUCT [label="{PRODUCT|PK product_id\\lFK category_id\\lFK brand_id\\lFK supplier_id\\lFK sport_type_id\\lsku/price/cost\\l}"];
    CUSTOMER [label="{CUSTOMER|PK customer_id\\lFK loyalty_id\\lname/email/phone\\lsignup_date\\l}"];
    LOYALTY_PROGRAM [label="{LOYALTY_PROGRAM|PK loyalty_id\\lpoints/tier/enrolled\\l}"];
    PAYMENT_METHOD [label="{PAYMENT_METHOD|PK payment_id\\lmethod_name\\l}"];
    PROMOTION [label="{PROMOTION|PK promotion_id\\lcode/discount\\ldates/type\\l}"];
    SALE [label="{SALE|PK sale_id\\lFK store_id\\lFK employee_id\\lFK customer_id\\lFK payment_id\\lFK promotion_id\\ltotal\\l}"];
    SALE_ITEM [label="{SALE_ITEM|PK item_id\\lFK sale_id\\lFK product_id\\lquantity/price/total\\l}"];
    INVENTORY [label="{INVENTORY|PK inventory_id\\lFK product_id\\lFK store_id\\lquantity/reorder_level\\l}"];
    PURCHASE_ORDER [label="{PURCHASE_ORDER|PK order_id\\lFK supplier_id\\lFK store_id\\lstatus/total\\l}"];
    PURCHASE_ORDER_ITEM [label="{PURCHASE_ORDER_ITEM|PK item_id\\lFK order_id\\lFK product_id\\lquantity/cost/total\\l}"];
    ONLINE_ORDER [label="{ONLINE_ORDER|PK order_id\\lFK customer_id\\lFK shipment_id\\ltotal/status\\l}"];
    SHIPMENT [label="{SHIPMENT|PK shipment_id\\lFK carrier_id\\ltracking/status\\l}"];

    STORE_LOCATION -> EMPLOYEE;
    STORE_LOCATION -> SALE;
    STORE_LOCATION -> INVENTORY;
    STORE_LOCATION -> PURCHASE_ORDER;
    DEPARTMENT -> EMPLOYEE;
    DEPARTMENT -> MANAGER;
    EMPLOYEE -> MANAGER;
    MANAGER -> EMPLOYEE;
    CATEGORY -> PRODUCT;
    BRAND -> PRODUCT;
    SUPPLIER -> PRODUCT;
    SUPPLIER -> PURCHASE_ORDER;
    SPORT_TYPE -> PRODUCT;
    PRODUCT -> SALE_ITEM;
    PRODUCT -> INVENTORY;
    PRODUCT -> PURCHASE_ORDER_ITEM;
    CUSTOMER -> SALE;
    CUSTOMER -> ONLINE_ORDER;
    LOYALTY_PROGRAM -> CUSTOMER;
    PAYMENT_METHOD -> SALE;
    PROMOTION -> SALE;
    SALE -> SALE_ITEM;
    PURCHASE_ORDER -> PURCHASE_ORDER_ITEM;
    SHIPMENT -> ONLINE_ORDER;
  }`;
  const dotPath = path.join(assetDir, "sports_store_erd.dot");
  const pngPath = path.join(assetDir, "sports_store_erd.png");
  fs.writeFileSync(dotPath, dot);
  execFileSync("/opt/homebrew/bin/dot", ["-Tpng", dotPath, "-o", pngPath]);
  return pngPath;
}

async function pngFromSvg(name, svg) {
  const out = path.join(assetDir, name);
  await sharp(Buffer.from(svg)).png().toFile(out);
  return out;
}

function mockScreen(title, active, rows) {
  const tabs = ["Stores", "Employees", "Products", "Customers", "Inventory", "Sales", "Reports"];
  const tabSvg = tabs.map((t, i) => {
    const x = 36 + i * 118;
    const fill = t === active ? "#2A9D8F" : "#E8EEF4";
    const color = t === active ? "#FFFFFF" : "#17324D";
    return `<rect x="${x}" y="88" width="104" height="34" rx="5" fill="${fill}"/><text x="${x + 52}" y="110" text-anchor="middle" font-size="13" fill="${color}">${t}</text>`;
  }).join("");
  const rowSvg = rows.map((r, i) => {
    const y = 176 + i * 44;
    return `<rect x="50" y="${y}" width="900" height="34" fill="${i % 2 ? "#FFFFFF" : "#F7FAFC"}" stroke="#D6E0EA"/><text x="72" y="${y + 22}" font-size="14" fill="#1D2630">${r}</text>`;
  }).join("");
  return `<svg width="1000" height="560" xmlns="http://www.w3.org/2000/svg">
    <rect width="1000" height="560" fill="#FFFFFF"/>
    <rect x="28" y="30" width="944" height="500" rx="10" fill="#FFFFFF" stroke="#B9C8D6" stroke-width="2"/>
    <rect x="28" y="30" width="944" height="44" rx="10" fill="#17324D"/>
    <text x="52" y="58" font-family="Arial" font-size="18" font-weight="700" fill="#FFFFFF">${title}</text>
    ${tabSvg}
    <rect x="50" y="142" width="900" height="34" fill="#17324D"/>
    <text x="72" y="164" font-family="Arial" font-size="13" font-weight="700" fill="#FFFFFF">Name / Description / Key Fields</text>
    ${rowSvg}
    <rect x="50" y="468" width="86" height="34" rx="5" fill="#2A9D8F"/><text x="93" y="490" text-anchor="middle" font-size="13" fill="#FFFFFF">Add</text>
    <rect x="146" y="468" width="86" height="34" rx="5" fill="#E9C46A"/><text x="189" y="490" text-anchor="middle" font-size="13" fill="#17324D">Edit</text>
    <rect x="242" y="468" width="86" height="34" rx="5" fill="#E76F51"/><text x="285" y="490" text-anchor="middle" font-size="13" fill="#FFFFFF">Delete</text>
    <text x="830" y="490" font-size="13" fill="#5D6D7E">10 row(s)</text>
  </svg>`;
}

async function makeMockups() {
  return {
    main: await pngFromSvg("main_screen_mock.png", mockScreen("Sports Store Management System", "Products", [
      "Air Zoom Pegasus    SKU-1001    Running Shoes    $63.50",
      "Pro Court           SKU-1002    Basketball       $77.00",
      "Match Soccer Ball   SKU-1003    Soccer           $90.50",
      "Studio Yoga Mat     SKU-1006    Yoga             $131.00",
      "Trail Bike 27       SKU-1007    Cycling          $144.50",
    ])),
    reports: await pngFromSvg("reports_mock.png", mockScreen("Reports tab: Top 10 products by revenue", "Reports", [
      "Trail Bike 27        units sold: 4       revenue: $234.00",
      "Pro Bat 33           units sold: 3       revenue: $225.00",
      "Studio Yoga Mat      units sold: 3       revenue: $159.00",
      "Match Soccer Ball    units sold: 4       revenue: $146.00",
      "Speed Goggles        units sold: 2       revenue: $139.00",
    ])),
    form: await pngFromSvg("add_product_mock.png", `<svg width="760" height="560" xmlns="http://www.w3.org/2000/svg">
      <rect width="760" height="560" fill="#FFFFFF"/>
      <rect x="120" y="44" width="520" height="470" rx="8" fill="#FFFFFF" stroke="#B9C8D6" stroke-width="2"/>
      <rect x="120" y="44" width="520" height="48" rx="8" fill="#17324D"/>
      <text x="146" y="74" font-family="Arial" font-size="18" font-weight="700" fill="#FFFFFF">Add Products</text>
      ${["Product ID", "Category", "Brand", "Supplier", "Sport", "Name *", "SKU *", "Price *", "Cost *"].map((label, i) => {
        const y = 124 + i * 38;
        return `<text x="154" y="${y + 20}" font-size="13" fill="#17324D">${label}</text><rect x="278" y="${y}" width="300" height="27" rx="4" fill="#F7FAFC" stroke="#C8D5E1"/>`;
      }).join("")}
      <rect x="392" y="464" width="86" height="32" rx="5" fill="#2A9D8F"/><text x="435" y="485" text-anchor="middle" font-size="13" fill="#FFFFFF">OK</text>
      <rect x="492" y="464" width="86" height="32" rx="5" fill="#E8EEF4"/><text x="535" y="485" text-anchor="middle" font-size="13" fill="#17324D">Cancel</text>
    </svg>`),
  };
}

function p(text, opts = {}) {
  return new Paragraph({
    text,
    heading: opts.heading,
    alignment: opts.align,
    spacing: { after: opts.after ?? 160, before: opts.before ?? 0 },
    bullet: opts.bullet ? { level: 0 } : undefined,
  });
}

function run(text, options = {}) {
  return new TextRun({ text, ...options });
}

function cell(text, fill = undefined, bold = false) {
  return new TableCell({
    shading: fill ? { type: ShadingType.CLEAR, color: "auto", fill } : undefined,
    margins: { top: 120, bottom: 120, left: 120, right: 120 },
    children: [new Paragraph({ children: [run(text, { bold, color: bold ? "FFFFFF" : ink })] })],
  });
}

function table(headers, rows) {
  return new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ children: headers.map(h => cell(h, navy, true)) }),
      ...rows.map(r => new TableRow({ children: r.map(v => cell(String(v))) })),
    ],
  });
}

function image(pathName, width, height) {
  return new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { before: 120, after: 180 },
    children: [new ImageRun({
      data: fs.readFileSync(pathName),
      type: "png",
      transformation: { width, height },
    })],
  });
}

async function saveDoc(name, children) {
  const doc = new Document({
    styles: {
      default: { document: { run: { font: "Aptos", size: 22, color: ink } } },
      paragraphStyles: [
        { id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal", quickFormat: true, run: { size: 32, bold: true, color: navy }, paragraph: { spacing: { before: 220, after: 120 } } },
        { id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal", quickFormat: true, run: { size: 26, bold: true, color: teal }, paragraph: { spacing: { before: 180, after: 100 } } },
      ],
    },
    sections: [{ properties: {}, children }],
  });
  const buffer = await Packer.toBuffer(doc);
  const out = path.join(outDir, name);
  fs.writeFileSync(out, buffer);
  return out;
}

async function designReport(erdPath) {
  const children = [
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 300 }, children: [run("Sports Store Management System", { bold: true, size: 38, color: navy })] }),
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 120 }, children: [run("Database Design Report", { bold: true, size: 30, color: teal })] }),
    p("COSC 457 - Database Management Systems", { align: AlignmentType.CENTER }),
    p("Prepared for class submission", { align: AlignmentType.CENTER }),
    p("Team member(s): ______________________________", { align: AlignmentType.CENTER }),
    p("Signature(s): _________________________________", { align: AlignmentType.CENTER }),
    new Paragraph({ children: [new PageBreak()] }),
    p("Introduction", { heading: HeadingLevel.HEADING_1 }),
    p("The Sports Store Management System is a database application for a fictional regional sporting goods business called Sports Hub. The system organizes store locations, employees, products, inventory, customers, sales, sale line items, suppliers, promotions, loyalty programs, purchase orders, and related business records. The front end is written in Java Swing and connects to a MySQL database with JDBC."),
    p("The purpose of the project is to replace spreadsheet-style tracking with a normalized relational database and a simple desktop application. Store staff can browse and maintain core records, while managers can run reports for sales, inventory, customer spending, and product performance."),
    p("Target Business", { heading: HeadingLevel.HEADING_1 }),
    p("Sports Hub is a Maryland-based sporting goods retailer with ten sample branch locations. The business sells shoes, apparel, equipment, outdoor products, team sports items, water sports products, winter gear, and fitness accessories. The target area is retail customers, local teams, and recreational athletes who need in-store sales support and accurate product availability."),
    p("Business Process", { heading: HeadingLevel.HEADING_1 }),
    ...[
      "A customer visits or contacts a store and may register as a customer or loyalty member.",
      "The employee searches product and inventory records to confirm price and availability.",
      "A sale is created with store, employee, customer, payment method, and optional promotion.",
      "Sale item records are added for each product purchased.",
      "Inventory is reviewed against reorder levels; purchase orders can be placed with suppliers.",
      "Managers review reports for revenue, low inventory, customer lifetime spend, and unsold products.",
    ].map(x => p(x, { bullet: true })),
    p("User Requirements", { heading: HeadingLevel.HEADING_1 }),
    table(["Requirement", "Database Support", "Application Support"], [
      ["Maintain stores", "STORE_LOCATION", "Stores CRUD tab"],
      ["Maintain employees and departments", "EMPLOYEE, DEPARTMENT, MANAGER", "Employees and Departments tabs"],
      ["Maintain products", "PRODUCT, CATEGORY, BRAND, SUPPLIER, SPORT_TYPE", "Products and Categories tabs"],
      ["Track customers", "CUSTOMER, LOYALTY_PROGRAM", "Customers tab"],
      ["Track inventory", "INVENTORY", "Inventory tab"],
      ["Record sales", "SALE, SALE_ITEM, PAYMENT_METHOD, PROMOTION", "Sales and Sale Items tabs"],
      ["Report business activity", "Multi-table SQL joins and aggregates", "Reports tab"],
    ]),
    p("Expected Database Queries", { heading: HeadingLevel.HEADING_1 }),
    ...reportQueries.map(q => p(q, { bullet: true })),
    p("Conceptual ERD", { heading: HeadingLevel.HEADING_1 }),
    p("The ERD below shows the main operational relationships. The physical SQL script includes additional supporting tables for returns, online orders, warranties, events, schedules, training, gift cards, and memberships."),
    image(erdPath, 620, 390),
    p("Logical Schema", { heading: HeadingLevel.HEADING_1 }),
    p("The logical schema is implemented as normalized relations with primary keys on every table. Foreign keys connect sales to stores, employees, customers, payments, promotions, and sale items; products connect to categories, brands, suppliers, sport types, inventory, purchase orders, and sale items."),
    p("Physical Design", { heading: HeadingLevel.HEADING_1 }),
    p("The physical design is stored in database/sports_store_main.sql. It defines the MySQL tables, primary keys, foreign keys, uniqueness constraints, not-null fields, numeric fields for totals and prices, dates/timestamps, and a rating check constraint. database/sample_data.sql provides seed data for testing and grading."),
    p("Assumptions", { heading: HeadingLevel.HEADING_1 }),
    ...[
      "The project is scoped for a class demonstration, so the Swing app exposes the most important operational tables rather than every supporting table.",
      "UUID-style string IDs are used to keep inserts simple from the desktop application.",
      "Financial totals are entered directly in the demo app; a production version would calculate and lock totals through service logic.",
      "The sample company, addresses, customers, and sales are fictional.",
    ].map(x => p(x, { bullet: true })),
    p("Gantt Chart / Project Plan", { heading: HeadingLevel.HEADING_1 }),
    table(["Phase", "Work", "Planned Time"], [
      ["1", "Requirements, target business, and business process", "Week 1"],
      ["2", "ERD and logical schema", "Week 2"],
      ["3", "Physical MySQL schema and sample data", "Week 3"],
      ["4", "Java Swing/JDBC application implementation", "Week 4"],
      ["5", "Testing, manuals, flyer, and presentation", "Week 5"],
    ]),
  ];
  return saveDoc("Sports_Store_Database_Design_Report.docx", children);
}

async function referenceManual(mockups) {
  const children = [
    p("Sports Store Management System Reference Manual", { heading: HeadingLevel.HEADING_1 }),
    p("This manual explains every implemented application function in alphabetical order. Screenshots are represented with generated mock screens that match the Java Swing tabs and dialogs."),
    image(mockups.main, 560, 314),
    p("Functions", { heading: HeadingLevel.HEADING_1 }),
    ...functionsList.flatMap(([name, desc]) => [
      p(name, { heading: HeadingLevel.HEADING_2 }),
      p(desc),
      p("Common controls: Add opens a form, Edit updates the selected row, Delete removes the selected row when it is not referenced by another table, and Refresh reloads the current database records."),
    ]),
    p("Reports", { heading: HeadingLevel.HEADING_2 }),
    p("The Reports tab contains canned read-only SQL queries. Choose a report from the dropdown and click Run to display the latest query result."),
    image(mockups.reports, 560, 314),
    p("Database Connection", { heading: HeadingLevel.HEADING_1 }),
    p("The application reads db.properties from the same folder as the jar. The file stores db.host, db.port, db.name, db.user, db.password, and optional JDBC parameters."),
  ];
  return saveDoc("Sports_Store_Reference_Manual.docx", children);
}

async function tutorialManual(mockups) {
  const children = [
    p("Sports Store Management System Tutorial Manual", { heading: HeadingLevel.HEADING_1 }),
    p("This tutorial walks through normal work scenarios for the Sports Hub store database application."),
    p("Scenario 1: Start the Application", { heading: HeadingLevel.HEADING_1 }),
    ...[
      "Create the database with database/sports_store_main.sql.",
      "Load database/sample_data.sql.",
      "Copy db.properties.example to db.properties and enter the MySQL credentials.",
      "Run java -jar target/sports-store-app.jar.",
      "Confirm the main tabbed window opens.",
    ].map(x => p(x, { bullet: true })),
    image(mockups.main, 560, 314),
    p("Scenario 2: Add a Product", { heading: HeadingLevel.HEADING_1 }),
    ...[
      "Open the Products tab.",
      "Click Add.",
      "Choose category, brand, supplier, and sport type from the dropdowns.",
      "Enter product name, SKU, price, cost, size, and color.",
      "Click OK and confirm the row appears in the table.",
    ].map(x => p(x, { bullet: true })),
    image(mockups.form, 430, 316),
    p("Scenario 3: Review Low Inventory", { heading: HeadingLevel.HEADING_1 }),
    ...[
      "Open the Reports tab.",
      "Select Inventory below reorder level.",
      "Click Run.",
      "Use the result to decide which products need a purchase order or restock.",
    ].map(x => p(x, { bullet: true })),
    image(mockups.reports, 560, 314),
    p("Scenario 4: Record a Sale", { heading: HeadingLevel.HEADING_1 }),
    ...[
      "Open the Sales tab and create the sale header with store, cashier, customer, payment method, optional promotion, subtotal, tax, and total.",
      "Open the Sale Items tab and add one row for each product purchased.",
      "Return to Reports to verify recent sales or top products by revenue.",
    ].map(x => p(x, { bullet: true })),
  ];
  return saveDoc("Sports_Store_Tutorial_Manual.docx", children);
}

async function flyer(mockups) {
  const children = [
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 120 }, children: [run("Sports Hub", { bold: true, size: 44, color: navy })] }),
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 240 }, children: [run("Sports Store Management System", { bold: true, size: 30, color: teal })] }),
    image(mockups.main, 520, 291),
    p("A simple Java Swing and MySQL desktop system for store, product, customer, inventory, and sales management.", { align: AlignmentType.CENTER }),
    table(["Implemented Functions", "Advantages", "Limitations"], [
      ["Stores, departments, employees, categories, products, customers, inventory, sales, sale items, reports", "Normalized database, foreign-key dropdowns, executable jar target, seed data, canned business reports", "Demo app focuses on core tables; production version would add authentication, automated totals, and richer validation"],
    ]),
    p("Target Business: A regional sporting goods chain with multiple branches, retail sales, inventory tracking, promotions, and customer records.", { before: 180 }),
  ];
  return saveDoc("Sports_Store_Flyer.docx", children);
}

async function presentation(erdPath, mockups) {
  const pptx = new pptxgen();
  pptx.layout = "LAYOUT_WIDE";
  pptx.author = "COSC 457";
  pptx.subject = "Sports Store Management System";
  pptx.title = "Sports Store Management System";
  pptx.company = "Sports Hub";
  pptx.theme = {
    headFontFace: "Aptos Display",
    bodyFontFace: "Aptos",
    lang: "en-US",
  };

  function title(slide, titleText, subtitle) {
    slide.addText(titleText, { x: 0.6, y: 0.42, w: 8.4, h: 0.55, fontFace: "Aptos Display", fontSize: 28, bold: true, color: navy, margin: 0 });
    if (subtitle) slide.addText(subtitle, { x: 0.62, y: 1.02, w: 8.9, h: 0.3, fontSize: 11, color: "5D6D7E", margin: 0 });
    slide.addShape(pptx.ShapeType.line, { x: 0.6, y: 1.38, w: 11.1, h: 0, line: { color: teal, width: 1.6 } });
  }

  let s = pptx.addSlide();
  s.background = { color: navy };
  s.addText("Sports Hub", { x: 0.7, y: 0.65, w: 6.4, h: 0.8, fontSize: 38, bold: true, color: "FFFFFF", margin: 0 });
  s.addText("Sports Store Management System", { x: 0.72, y: 1.5, w: 8.8, h: 0.55, fontSize: 22, color: gold, margin: 0 });
  s.addText("COSC 457 Database Management Systems", { x: 0.75, y: 6.2, w: 5.2, h: 0.3, fontSize: 13, color: "FFFFFF", margin: 0 });
  s.addImage({ path: mockups.main, x: 6.35, y: 1.0, w: 5.9, h: 3.3 });

  s = pptx.addSlide();
  title(s, "Project Goal", "Replace spreadsheet-style tracking with a normalized database and simple desktop app.");
  s.addText([
    { text: "Target business: ", options: { bold: true } },
    { text: "a regional sporting goods retailer with multiple branches." },
    { text: "\nCore need: ", options: { bold: true } },
    { text: "track products, customers, inventory, employees, and sales in one system." },
    { text: "\nTechnology: ", options: { bold: true } },
    { text: "Java Swing + MySQL + JDBC." },
  ], { x: 0.85, y: 1.85, w: 5.3, h: 2.1, fontSize: 20, color: ink, breakLine: false, fit: "shrink" });
  s.addImage({ path: mockups.main, x: 6.8, y: 1.75, w: 4.9, h: 2.75 });

  s = pptx.addSlide();
  title(s, "Database Design", "The design covers operational sales, inventory, customer, employee, supplier, and product data.");
  s.addImage({ path: erdPath, x: 0.75, y: 1.62, w: 11.8, h: 4.55 });
  s.addText("Physical design: 38 MySQL tables with primary keys, foreign keys, uniqueness constraints, and seed data.", { x: 0.8, y: 6.35, w: 10.8, h: 0.35, fontSize: 13, color: "5D6D7E" });

  s = pptx.addSlide();
  title(s, "Implemented Screens", "The Swing UI exposes the core records needed for the class demo.");
  const screens = ["Stores", "Departments", "Employees", "Categories", "Products", "Customers", "Inventory", "Sales", "Sale Items", "Reports"];
  screens.forEach((txt, i) => {
    const x = 0.85 + (i % 5) * 2.3;
    const y = 1.85 + Math.floor(i / 5) * 1.1;
    s.addShape(pptx.ShapeType.roundRect, { x, y, w: 1.95, h: 0.55, rectRadius: 0.06, fill: { color: i === 9 ? teal : light }, line: { color: i === 9 ? teal : "D6E0EA" } });
    s.addText(txt, { x, y: y + 0.15, w: 1.95, h: 0.22, fontSize: 12, bold: true, color: i === 9 ? "FFFFFF" : navy, align: "center", margin: 0 });
  });
  s.addImage({ path: mockups.form, x: 3.8, y: 4.1, w: 3.0, h: 2.2 });

  s = pptx.addSlide();
  title(s, "Reports", "Read-only SQL reports demonstrate joins, aggregates, filters, grouping, and sorting.");
  s.addImage({ path: mockups.reports, x: 0.85, y: 1.75, w: 6.0, h: 3.35 });
  s.addText(reportQueries.map(q => `- ${q}`).join("\n"), { x: 7.3, y: 1.78, w: 4.8, h: 3.45, fontSize: 16, color: ink, fit: "shrink" });

  s = pptx.addSlide();
  title(s, "Submission Package", "Files prepared for the project hand-in.");
  s.addText([
    "Java source code in src/main/java",
    "MySQL creation script: database/sports_store_main.sql",
    "Seed data: database/sample_data.sql",
    "Database design report",
    "Reference manual and tutorial manual",
    "Application flyer",
    "Presentation deck",
  ].map(x => `- ${x}`).join("\n"), { x: 1.0, y: 1.8, w: 7.5, h: 3.6, fontSize: 19, color: ink, fit: "shrink" });
  s.addText("Build jar locally with: mvn clean package", { x: 1.0, y: 5.75, w: 6.6, h: 0.4, fontSize: 18, bold: true, color: teal });

  const out = path.join(outDir, "Sports_Store_Presentation.pptx");
  await pptx.writeFile({ fileName: out });
  return out;
}

function writeChecklist(paths) {
  const content = `# Sports Store Submission Checklist

Generated files:

- ${path.basename(paths.report)}
- ${path.basename(paths.reference)}
- ${path.basename(paths.tutorial)}
- ${path.basename(paths.flyer)}
- ${path.basename(paths.deck)}
- assets/${path.basename(paths.erd)}

Project files to submit with them:

- src/main/java/com/sportsstore/
- pom.xml
- db.properties.example
- database/sports_store_main.sql
- database/sample_data.sql
- sports_store_database_schema.md
- README.md

Final local build step:

\`\`\`bash
mvn clean package
java -jar target/sports-store-app.jar
\`\`\`

Note: Maven was not installed in this shell, so the jar still needs to be built on a machine with Maven.
`;
  fs.writeFileSync(path.join(outDir, "SUBMISSION_CHECKLIST.md"), content);
}

(async () => {
  const erd = dotErd();
  const mockups = await makeMockups();
  const paths = {
    erd,
    report: await designReport(erd),
    reference: await referenceManual(mockups),
    tutorial: await tutorialManual(mockups),
    flyer: await flyer(mockups),
  };
  paths.deck = await presentation(erd, mockups);
  writeChecklist(paths);
  console.log(JSON.stringify(paths, null, 2));
})();
