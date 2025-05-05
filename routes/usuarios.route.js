const express = require("express");
const router = express.Router();
const usuariosController = require("../controllers/usuarios.controller");

router.put('/:id', usuariosController.atualizarUsuario);
router.post('/login', ()=>{console.log("Rota de Login")});
router.post('/', ()=>{console.log("Rota de Cadastro")});

module.exports = router;