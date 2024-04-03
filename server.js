require('dotenv').config();
const uri = process.env.MONGO_DB;
//const express = require('express')
//const req = require('express/lib/request')
//const port = 3000
//var app = express()
const { MongoClient, ServerApiVersion } = require('mongodb')

const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
})

async function run() {
    try {
        await client.connect();
        const database = client.db('to-do-list');
        const collection = database.collection('user');
        await client.db('admin').command({ping:1});

        const document = {
            username: "username",
            password: "password"
        };

        const result = await collection.insertOne(document);
        console.log(`Document inserted with _id: ${result.insertedId}`);
    } finally {
        await client.close();
    }
}
run().catch(console.dir);