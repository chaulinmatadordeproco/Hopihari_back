const express = require("express");
const router = express.Router();
const login = require("../middleware/usuarios.middleware")

router.post("/", login.required, () => {console.log("Rota de fila")});

module.exports = router;