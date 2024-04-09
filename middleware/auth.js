require('dotenv').config();
const jwt = require('jsonwebtoken');
const User = require('../lib/model/usermodel');
const client = require('../db')
const database = client.db('to-do-list');
const collection = database.collection('user');

const authenticate = async (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) {
        return res.status(401).json({message: 'Authentication required'});
    }

    try {
        const decodedtoken = jwt.verify(token, process.env.SECRET_KEY);
        console.log(decodedtoken);
        const filteruser = await collection.findOne({decodedtoken});
        if (!filteruser) {
            return res.status(404).json({message: 'User not found!'});
        }

        req.user = filteruser;
        next();

    } catch (err) {
        res.status(401).json({message: 'Invalid token'});
    }
}

module.exports = { authenticate };