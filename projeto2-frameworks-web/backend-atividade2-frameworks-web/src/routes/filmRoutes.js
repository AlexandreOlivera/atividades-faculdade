const express = require('express');
const filmController = require('../controllers/filmController');
const router = express.Router();

router.post('/films', filmController.create);
router.get('/films', filmController.list);
router.put('/films/:id', filmController.update);
router.delete('/films/:id', filmController.delete);

module.exports = router;
