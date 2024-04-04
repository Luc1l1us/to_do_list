require('dotenv').config();
const app = require('./app');
const PORT = process.env.PORT;
const db = require('./config/db')

app.get('/', (req, res) => {
    res.send('Hello, Express!')
});

app.listen(PORT, () => {
    console.log(`Server is listening on Port http://192.168.68.106:${PORT}`);
});
