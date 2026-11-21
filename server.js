import express from "express";
import pg from "pg";

const app = express();
const port = process.env.PORT || 3000;

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

app.get("/", (req, res) => {
  res.render("index.ejs");
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});