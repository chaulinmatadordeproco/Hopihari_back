const express = require("express");
const router = express.Router();
const usuariosController = require("../controllers/usuarios.controller");

router.put('/:id', usuariosController.atualizarUsuario);
router.post('/login', usuariosController.login);
router.post('/', usuariosController.cadastrarUsuario);

module.exports = router;