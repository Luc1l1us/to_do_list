require('dotenv').config();
const uri = process.env.MONGO_DB;
const PORT = process.env.PORT2;
const { MongoClient, ServerApiVersion } = require('mongodb')

const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
})

module.exports = client;
