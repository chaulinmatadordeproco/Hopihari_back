const mysql = require('../mysql');

exports.getNotificacoes = async (req, res) => {
    try {
        const resultado = await mysql.execute(`
            SELECT * FROM notifications WHERE id_user = ? and status = TRUE;`,
            [res.locals.idUsuario]);
        return res.status(201).send({
            "Mensagem": "Você esta cadastrado em",
            "Resultado": resultado
        })

    } catch {
        return res.status(500).send({ "Mensagem": error })
    }
}

exports.updateNotification = async (req, res) => {
    try {
        const resultado = await mysql.execute(`
        UPDATE notifications SET status = 0 WHERE id_user = ?;`,
            [res.params.idNot])
            res.status(201).send({
                "Resultado": resultado
            })

    } catch {
        return res.status(500).send({ "Mensagem": error })
    }
}