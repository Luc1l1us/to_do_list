require('dotenv').config();
const uri = process.env.MONGO_DB;
const express = require('express')
const app = express();
const cors = require('cors');

app.use(express.json());
app.use(cors());
module.exports = app;