const express = require("express");
const auth = require("../middlewares/auth");
const productRouter = express.Router();
const { Product } = require("../models/product");

// GET ALL THE PRODUCTS BASED ON CATEGORY
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const { category } = req.query;
    const products = await Product.find({ category: category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// SEARHING PRODUCTS BY NAME
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// RATING PRODUCTS
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((p1, p2) => {
      let p1Sum = 0;
      let p2Sum = 0;

      for (let i = 0; i < p1.ratings.length; i++) {
        p1Sum += p1.ratings[i].rating;
      }

      for (let i = 0; i < p2.ratings.length; i++) {
        p2Sum += p2.ratings[i].rating;
      }
      return p1Sum < p2Sum ? 1 : -1;
    });

    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
