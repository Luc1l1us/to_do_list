require('dotenv').config();
const uri = process.env.MONGO_DB;
const express = require('express')
const req = require('express/lib/request')
const port = 3000
var app = express()
const { MongoClient, ServerApiVersion } = require('mongodb')

app.use(express.json());

const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
})
/*
async function run() {
    try {
        await client.connect();
        const database = client.db('to-do-list');
        const collection = database.collection('user');
        await client.db('admin').command({ping:1});

        const document = {
            task: value
        };

        const result = await collection.insertOne(document);
        console.log(`Document inserted with _id: ${result.insertedId}`);
    } finally {
        await client.close();
    }
}
run().catch(console.dir);
*/
app.get('/', (req, res) => {
    res.send('Hello, Express!');
});
  

app.post('/', async (req, res) => {
    try {
        await client.connect();
        const database = client.db('to-do-list');
        const collection = database.collection('user');
        const value = req.body.value;
        await collection.insertOne({value:value});
        res.setStatus(200);
        res.send(value);
        console.log('Data sent successfully!')
    } catch (error) {
        res.status(500).send('Internal Server Error');
    }
});

//const PORT = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});