const mongoose = require('mongoose');

const filmSchema = new mongoose.Schema({
    title: { type: String, required: true },
    actor: { type: String, required: true },
    ageRating: { type: String, required: true },
    genre: { type: String, required: true }
});

module.exports = mongoose.model('Film', filmSchema);
