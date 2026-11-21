import express from "express";
import pg from "pg";

const app = express();
const port = 3000;

const db = new pg.Client({
  user: "postgres",
  password: "123456",
  host: "localhost",  
  port: 5432,
  database: "mystore",  
});

await db.connect();

app.use(express.static("public"));
app.set("view engine", "ejs");
app.set("views", "views");

const money = (n) =>
  "$" + Number(n).toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 });

const limit = 10; // customers per page

// DATE columns come back as JS Dates; format as MM/DD/YYYY
const formatDate = (d) => {
  const dt = new Date(d);
  const mm = String(dt.getMonth() + 1).padStart(2, "0");
  const dd = String(dt.getDate()).padStart(2, "0");
  return `${mm}/${dd}/${dt.getFullYear()}`;
};

// Page numbers to display: 1 ... (current-2 .. current+2) ... last
const buildPages = (current, total) => {
  const pages = [];
  for (let i = 1; i <= total; i++) {
    if (i === 1 || i === total || Math.abs(i - current) <= 2) {
      pages.push(i);
    } else if (pages[pages.length - 1] !== "...") {
      pages.push("...");
    }
  }
  return pages;
};

app.get("/", async (req, res) => {
  try {
    const page = Math.max(Number(req.query.page) || 1, 1);
    const offset = (page - 1) * limit;

    const customerCount = await db.query("SELECT count(*) FROM customers");
    const totalCustomers = Number(customerCount.rows[0].count);
    const totalPages = Math.max(Math.ceil(totalCustomers / limit), 1);

    const customers = await db.query(
      "SELECT * FROM customers ORDER BY id LIMIT $1 OFFSET $2",
      [limit, offset]
    );
    const revenue = await db.query("SELECT sum(saleamount) FROM sales");
    const orders = await db.query("SELECT count(quantity) FROM orders");
    const issuesCount = await db.query("SELECT count(id) FROM alerts WHERE type = 'issues'");
    const sales = await db.query(`SELECT products.name, sales.quantity, sales.saleamount FROM sales
       LEFT JOIN products ON sales.productid = products.id ORDER BY sales.id ASC`
    );
    const issues = await db.query("SELECT * FROM alerts WHERE type = 'issues'");
    const notificationsCount = await db.query("SELECT count(id) FROM alerts WHERE type = 'notifications'");
    const notifications = await db.query("SELECT * FROM alerts WHERE type = 'notifications'");
    const tasks = await db.query("SELECT * FROM alerts WHERE type = 'tasks'");

    res.render("index.ejs", {
      money,
      revenue: revenue.rows[0].sum || 0,
      formatDate,
      totalCustomers,
      customers: customers.rows,
      currentPage: page,
      totalPages,
      pages: buildPages(page, totalPages),
      totalOrders: Number(orders.rows[0].count),
      issuesCount: Number(issuesCount.rows[0].count),
      sales: sales.rows,
      issues: issues.rows,
      notificationsCount: Number(notificationsCount.rows[0].count),
      notifications: notifications.rows,
      tasks: tasks.rows,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error", message: err.message });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});