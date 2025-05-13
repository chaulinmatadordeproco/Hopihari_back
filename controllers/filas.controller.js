const mysql = require('../mysql');

exports.verificarBrinquedos = async (req, res, next) =>{
    try{
        const resultados = await mysql.execute(`
            SELECT * FROM rides WHERE id = ?`, [req.params.idRide]);

        if (resultados.length == 0){
            return res.status(404).send({"Mensagem": "Brinquedo não encontrado"})
        }
    }catch (error){
        return res.status(500).send({"Mensagem": error})
    }
}

exports.entrarFila = async (req, res) => {
    try{
        const resultados = await mysql.execute(`
            INSERT INTO hopi_hari_db.lines (id_user, id_rides) VALUES(?,?)
            `, [res.locals.idUsuario, Number(req.params.idRide)]);
            return res.status(201).send({"Mensagens":resultados});
    }catch (error){
        return res.status(500).send(error);
    }
}