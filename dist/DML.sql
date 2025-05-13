{
  "first_name": "Ana",
  "last_name": "Silva",
  "email": "ana.silva@example.com",
  "password": "senha123",
  "birth_date": "1990-05-10",
  "phone": "11999990001"
};

{
  "first_name": "Bruno",
  "last_name": "Santos",
  "email": "bruno.santos@example.com",
  "password": "senha123",
  "birth_date": "1988-09-23",
  "phone": "11999990002"
}
;

{
  "first_name": "Carla",
  "last_name": "Oliveira",
  "email": "carla.oliveira@example.com",
  "password": "senha123",
  "birth_date": "1995-12-01",
  "phone": "11999990003"
}
;

{
  "first_name": "Diego",
  "last_name": "Lima",
  "email": "diego.lima@example.com",
  "password": "senha123",
  "birth_date": "1992-03-17",
  "phone": "11999990004"
};

{
  "first_name": "Elisa",
  "last_name": "Costa",
  "email": "elisa.costa@example.com",
  "password": "senha123",
  "birth_date": "1998-07-05",
  "phone": "11999990005"
};

{
  "first_name": "Fernando",
  "last_name": "Martins",
  "email": "fernando.martins@example.com",
  "password": "senha123",
  "birth_date": "1985-11-30",
  "phone": "11999990006"
};

USE hopi_hari_db;
desc rides;
desc rides;

INSERT INTO rides (name, waiting_time, status, area) VALUES
('Montezum', 45, 'operando', 'area 1'),
('Rio Bravo', 35, 'operando', 'area 3'),
('Vurang', 25, 'operando', 'area 1');

select * FROM users;
select * from rides;  #8,9,10
select * from `lines`;

INSERT INTO `lines` (users_id, rides_id)
VALUES (4, 5);

DELETE FROM `lines`
WHERE users_id = 4 AND rides_id = 5;

INSERT INTO `lines` (users_id, rides_id)
VALUES (4,8),
(5, 8),
(6,9),
(10,9),
(8,10),
(9,10);

SELECT 
  users.first_name,
  users.last_name,
  users_id,
  rides_id,
  rides.name AS ride_name,
  `lines`.created_at
FROM 
  `lines`
INNER JOIN users ON `lines`.users_id = users.id
INNER JOIN rides ON `lines`.rides_id = rides.id;

