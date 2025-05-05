const mysql = require("../mysql");

exports.atualizarUsuario = async (req, res) => {
    try {
        const idUsuario = Number(req.params.id);
        const resultado = await mysql.execute(
            `UPDATE users
                SET name     = ?,
                    email    = ?,
                    password = ?
              WHERE id = ?;`,
              [
                req.body.name, 
                req.body.email,
                req.body.password,
                idUsuario
            ]
        );
        return res.status(201).send({
            "Mensagem": "Usuario atualizado com Sucesso",
            "Resultado": resultado
        });
    } catch (error) {
        return res.status(500).send({"Mensagem": error});
    }
}

exports.cadastrarUsuario = async (req, res) => {
    try {
        const resultado = await mysql.execute(`
            INSERT INTO users (
                first_name, 
                last_name, 
                email, 
                password, 
                birth_date, 
                phone
            )
            VALUES (?, ?, ?, ?, ?, ?);`, [
                req.body.first_name,
                req.body.last_name,
                req.body.email,
                req.body.password,
                req.body.birth_date,
                req.body.phone
            ]);
        return res.status(201).send({
            "Mensagem": "Usuario cadastrado com Sucesso",
            "Resultado": resultado
        });
    } catch (error) {
        return res.status(500).send({"Error": error})
    }
}