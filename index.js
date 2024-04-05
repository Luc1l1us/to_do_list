require('dotenv').config();
const { MongoClient, ServerApiVersion } = require('mongodb')
const app = require('./app');
const PORT = process.env.PORT;
const uri = process.env.MONGO_DB;

const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
})

const database = client.db('to-do-list');
const collection = database.collection('user');

app.get('/', (req, res) => {
    res.send('Hello, Express!')
});

const books = [
    {id: 1, title: 'Alice in Wonderland', author: 'Lewis Carrol'},
    {id: 2, title: 'Around the World in eighty days', author: 'Jules Verne'},
    {id: 3, title: 'Utopia', author: 'Sir Thomas Moor'},
]

/*app.get('/api/books', (req, res) => {
    res.json(books)
})*/

app.get('/api/users', async (req, res) => {
    try {
    let collection = await database.collection('user');
    let results = await collection.find({}).toArray();
    res.json(results);
    } catch (error) {
        console.error('Error fetching data', error);
        res.status(500).send('Internal Server Error!');
    }
}) 

app.post('/api/sendvalue', async (req, res) => {
    try {
        const { value } = req.body;
        console.log('Received value from Flutter app: ', value);
        res.status(201).send('Data received successfully');
        
        await client.connect();
        const document = {
            'task': value,
        }

        const result = await collection.insertOne(document);
        console.log(`Document inserted with _id: ${result.insertedId}`);
        //await collection.deleteMany(document);
        //console.log(`Documents deleted!`);
    } catch (error) {
        console.error('Error processing data:', error);
        res.status(500).send('Internal Server Error!');
    } finally {
        await client.close();
    }
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is listening on Port http://192.168.68.106:${PORT}`);
});
