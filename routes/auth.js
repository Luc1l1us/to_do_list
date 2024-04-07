const express = require('express');
const { register, update, login } = require('../userservices/auth');

const router = express.Router();

router.post('/register', register);
router.post('/update', update);
router.post('/login', login);

module.exports = router;