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

app.get("/", async (req, res) => {
  try {
    const customerCount = await db.query("SELECT count(*) FROM customers");
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
      totalCustomers: Number(customerCount.rows[0].count),
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