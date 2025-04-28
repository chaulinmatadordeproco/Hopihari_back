const express = require("express");
const router = express.Router();

router.post('/login', ()=>{console.log("Rota de Login")});

module.exports = router;