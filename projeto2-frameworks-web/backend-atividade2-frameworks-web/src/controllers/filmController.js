const Film = require('../models/Film');

module.exports = {
    async create(req, res) {
        try {
            const { title, actor, ageRating, genre } = req.body;
            const film = await Film.create({ title, actor, ageRating, genre });
            return res.status(201).json(film);
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    },
    async list(req, res) {
        try {
            const films = await Film.find();
            return res.status(200).json(films);
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    },
    async update(req, res) {
        try {
            const { id } = req.params;
            const { title, actor, ageRating, genre } = req.body;
            const film = await Film.findByIdAndUpdate(id, { title, actor, ageRating, genre }, { new: true });
            return res.status(200).json(film);
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    },
    async delete(req, res) {
        try {
            const { id } = req.params;
            await Film.findByIdAndDelete(id);
            return res.status(204).send();
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    }
};
