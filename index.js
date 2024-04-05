require('dotenv').config();
const app = require('./app');
const PORT = process.env.PORT;
const db = require('./config/db')


app.get('/', (req, res) => {
    res.send('Hello, Express!')
});

const books = [
    {id: 1, title: 'Alice in Wonderland', author: 'Lewis Carrol'},
    {id: 2, title: 'Around the World in eighty days', author: 'Jules Verne'},
    {id: 3, title: 'Utopia', author: 'Sir Thomas Moor'},
]

app.get('/api/books', (req, res) => {
    res.json(books)
})


app.post('/api/yikes', (req, res) => {
    res.json(books)
    try {
        const value = req.body.value;

        console.log('Received value from Flutter app: ', value);
        res.status(200).send('Data received successfully');
    } catch (error) {
        console.error('Error processing data:', error);
        res.status(500).send('Internal Server Error!');
    }
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is listening on Port http://192.168.68.106:${PORT}`);
});
