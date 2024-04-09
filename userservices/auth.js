require('dotenv').config();
const jwt = require('jsonwebtoken');
const { MongoClient, ServerApiVersion } = require('mongodb')
const bcrypt = require('bcrypt');
const app = require('../app');
const client = require('../db');
const database = client.db('to-do-list');
const collection = database.collection('user');
const User = require('../lib/model/usermodel');

const register = async (req, res) => {
    const { username, password, email, value } = req.body;
    try {
        const hashedpass = await bcrypt.hash(password, 10);
        const user = new User({username, email, password})
        const document = {
            'username': username,
            'password': hashedpass,
            'email': email,
            'tasks': value,
        }

        // to MongoDB, idk if this can be refactored
        await client.connect();
        const result = await collection.insertOne(document);
        console.log(`Document inserted with _id: ${result.insertedId}`);
        res.status(201).send('Registration Successful!');


    } catch (err) {
        console.error('Error processing data:', err);
        res.status(500).send('Internal Server Error!');
    } finally {
        await client.close();
    }
};

const update = async (req, res) => {
    const { value } = req.body;
    try {
        console.log('Received value from Flutter app: ', value);
        // use logic here to get the same username
        const filteruser = await collection.findOne({email});
        filter = { username: username} //hardcodeeedd
        const updatedocument = { $push: { 'tasks': value } }

        //to MongoDB again
        await client.connect;
        const result = await collection.updateOne(filter, updatedocument);
        console.log(`added ${value} to ${result} document!`);

        } catch (err) {
            console.error('Error processing data:', err);
            res.status(500).send('Internal Server Error!');
        } finally {
            await client.close();
        }
};

const login = async (req, res) => {
    const comparePass = async (pass, hashpass) => {
        try {
            const match = await bcrypt.compare(pass, hashpass);
            return match;
        } catch (err) {
            console.err('Error comparing passwords', err);
            return false;
        }
    };
    const { email, password } = req.body;
    try {
        //connect to MongoDB to retrieve password
        await client.connect();
        const filteruser = await collection.findOne({email});

        //logic to find whether the user is registered or not
        if (!filteruser) {
            return res.status(400).send('User not registered!')
        }

        // logic to compare passwords
        const passmatch = await comparePass(password, filteruser.password);
        if (!passmatch) {
            return res.status(401).send('Authentication unsuccessful!');
        }
        const token = jwt.sign({userID: user._id}, process.env.SECRET_KEY, {expiresIn: '1 hour'});
        res.json({token});
        
    } catch (err) {
        console.error('Error processing data:', err);
        res.status(500).send('Internal Server Error!');
    } finally {
        await client.close()
    }
};

module.exports = { register, update, login };