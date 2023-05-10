const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (val) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return val.match(re);
            },
            message: 'Please enter a valid email address!'
        },
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (val) => {
                return val.length >= 8;
            },
            message: 'Please enter a long password!'
        },
    },
    address: {
        type: String,
        default: ''
    },
    type: {
        type: String,
        default: 'user',
    },
});

const User = mongoose.model('User', userSchema);
module.exports = User;