require('dotenv').config();
const uri = process.env.MONGO_DB;
const { MongoClient, ServerApiVersion } = require('mongodb')
const PORT = process.env.PORT2;

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
            task:'lmao'
        };

        const result = await collection.insertOne(document);
        console.log(`Document inserted with _id: ${result.insertedId}`);
    } finally {
        await client.close();
    }
}
run().catch(console.dir);
