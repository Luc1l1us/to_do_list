require('dotenv').config();
const { MongoClient, ServerApiVersion } = require('mongodb')
const bcrypt = require('bcrypt');
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

/*app.get('/api/books', (req, res) => {
    res.json(books)
})*/

app.get('/api/fetchusers', async (req, res) => {
    try {
    let collection = await database.collection('user');
    let results = await collection.find({}).toArray();
    res.json(results);
    } catch (error) {
        console.error('Error fetching data', error);
        res.status(500).send('Internal Server Error!');
    }
}) 

app.post('/api/registeruser', async (req, res) => {
    try {
        const { username, password, email, value } = req.body;
        const hashedpass = await bcrypt.hash(password, 10);
        const user = new user({username, email, password})
        console.log('Received value from Flutter app: ', username, hashedpass, email, value);
        res.status(201).send('Data received successfully');
        
        await client.connect();
        const document = {
            'username': username,
            'password': hashedpass,
            'email': email,
            'tasks': value,
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

app.post('/api/update', async (req, res) => {
    try {
        const { value } = req.body;
        console.log('Received value from Flutter app: ', value);
        res.status(201).send('Data received successfully');
        
        await client.connect();
        const filter = {
            username: 'LMAO'
        }
        const updatedocument = {
            $push: { 'tasks': value }
        }

        const result = await collection.updateOne(filter, updatedocument);
        console.log(`added ${value} to ${result} document!`);
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
