const express = require('express');
const bcrypt = require('bcryptjs');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

const authRouter = express.Router();

// SIGN UP ROUTE
authRouter.post('/api/signup', async (req, res) => {
    // get data from client (flutter)
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if(existingUser) {
        return res.status(400).json({msg: 'User with same email already exist!'});
        }

        const hashedPass = await bcrypt.hash(password, 8);
        
        let user = new User({
            name,
            email,
            password: hashedPass,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message});
    }

    // post that data to server
    // return that data to user
});

// SIGN IN ROUTE
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({msg: 'User with this email does not exist!'});
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Incorrect password!' });
        }

        const token = jwt.sign({ id: user._id }, 'passwordKey');
        res.json({ token, ...user._doc });

    } catch (e) {
        res.status(500).json({ error: e.message });
}
});

// SIGN IN ROUTE
authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);
        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
}
});

// get the user data

authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
})

module.exports = authRouter;