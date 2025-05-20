const express = require('express');
const router =  express.Router();
const BrinquedoController = require("../controllers/brinquedos.controller");
const login  = require('../middleware/usuarios.middleware');

router.post('/', 
    login.required, 
    login.userRequired, 
    BrinquedoController.cadastrarBrinquedo);


module.exports = router;