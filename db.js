require('dotenv').config();
const uri = process.env.MONGO_DB;
const PORT = process.env.PORT2;
const { MongoClient, ServerApiVersion } = require('mongodb')

const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

client.connect()
    .then(() => {
        console.log('Connected to MongoDB!');
    })
    .catch(err => {
        console.error('Error: ', err);
        process.exit(1);
    })

module.exports = client;
