require('dotenv').config();
const uri = process.env.MONGO_DB;
const express = require('express')
const app = express();

module.exports = app;