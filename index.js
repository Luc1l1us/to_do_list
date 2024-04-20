require('dotenv').config();
const app = require('./app');
const PORT = process.env.PORT;
const authroutes = require('./routes/auth');
const userroutes = require('./routes/user');
const client = require('./db');
const jwt = require('jsonwebtoken');
const { JsonWebTokenError } = require('jsonwebtoken');
const database = client.db('to-do-list');
const collection = database.collection('user');

app.get('/', (req, res) => {
    res.send('Hello, Express!')
});

/*app.get('/api/books', (req, res) => {
    res.json(books)
})*/

//backend should be the one to fetch data from the user's email, 
//and send it as json to flutter
app.get('/api/fetchusers', async (req, res) => {
    try {
        const token = req.headers.authorization?.split(' ')[1];
        const decodedtoken = jwt.verify(token, process.env.SECRET_KEY);
        const useremail = decodedtoken.email;
        // connect to mongoDB
        await client.connect();
        let collection = await database.collection('user');
        let results = await collection.findOne({email: useremail});
        if (results) {
            res.json(results);
            console.log(results);
        } else {
            res.status(404).send('User not found!');
        }
    } catch (error) {
        console.error('Error fetching data', error);
        res.status(500).send('Internal Server Error!');
    }
}) 

app.use((req, res, next) => {
    console.log(`Endpoint: ${req.originalUrl}, Status: ${res.statusCode}`)
    next();
});

app.use('/auth', authroutes);

app.use('/user', userroutes);

/*
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
});*/

/*
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
});*/

app.listen(PORT, '0.0.0.0', async () => {
    console.log(`Server is listening on Port http://${process.env.DB_URL}`);
});
