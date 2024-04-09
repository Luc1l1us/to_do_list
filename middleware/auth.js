require('dotenv').config();
const jwt = require('jsonwebtoken');
const User = require('../lib/model/usermodel');

const authenticate = async (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) {
        return res.status(401).json({message: 'Authentication required'});
    }

    try {
        const decodedtoken = jwt.verify(token, process.env.SECRET_KEY);
        const filteruser = await collection.findOne({email});
    } catch (err) {
        res.status(401).json({message: 'Invalid token'});
    }
}

module.exports = { authenticate };