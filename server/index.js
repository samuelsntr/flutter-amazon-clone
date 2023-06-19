// IMPORT FORM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

// IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// INIT
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://samuel:samuel123@cluster0.u9rbuwr.mongodb.net/?retryWrites=true&w=majority";

// MIDDLEWARE
app.use(express.json());
app.use(
  cors({
    origin: "http://localhost:64689", // Replace with your Flutter project's URL
    methods: ["GET", "POST", "PUT", "DELETE"], // Specify the allowed HTTP methods
    allowedHeaders: ["Content-Type", "Authorization"], // Specify the allowed headers
  })
);

app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// CONNECTIONS
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successfull");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
