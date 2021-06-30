--1.seleccionar los campos idpersonas, primer_nombre, primer_apellido y email  de la tabla personas

SELECT idpersonas, primer_nombre, primer_apellido, email FROM personas

--2.seleccionar los campos  de idmantenimientos, descripcion y fecha de la tabla mantenimientos donde la descripcion se "descripcion 1 "

SELECT idmantenimientos, descripcion, fecha FROM `mantenimientos` WHERE descripcion="descripcion 1"

--3. seleccionar los campos dmantenimientos, descripcion y fecha de la tabla mantenimientos donde descripcion sea igual a "descripocion 1" y "descripcion 3"

SELECT idmantenimientos, descripcion, fecha FROM `mantenimientos` WHERE descripcion="descripcion 1" OR descripcion="descripcion 2"

--4.seleccione todos los campos de la tabla idiomas donde idioma sea igual a "aleman" y personas_idpersonas sea igual a 7

SELECT * FROM `idiomas` WHERE idioma="aleman" and personas_idpersonas=7

--5.selecionar todos los campos de la tabla casos_contables donde la fecha fin sea mayor a 2022-02-25

SELECT * FROM `casos_contables` WHERE fecha_fin>"2022-02-25"

--6. seleccione todos los campos de la tabla casos_contables donde la fecha este entre 2020-06-20 y 2021-04-30

SELECT * FROM `casos_contables` WHERE fecha_inicio BETWEEN "2020-06-20" and "2021-04-30"

--7. seleccione todos los campos de la tabla insumos  donde el campo nombre_insumo y que se ordene por ascendente

SELECT * FROM `insumos` ORDER BY nombre_insumo ASC

--8.seleccione todos los campos de la tabla insumos  donde el campo nombre_insumo se ordene por descendente

SELECT * FROM `insumos` ORDER BY nombre_insumo DESC

--9 seleccione todos los campos de la tabla mantenimientos donde el campo fecha se ordene en forma asecendente

SELECT * FROM `mantenimientos` ORDER BY fecha ASC

--10 selecione todos los campos de la tabla mantenimientos donde se ordene por descripcion y luego por fecha

SELECT * FROM `mantenimientos` ORDER BY descripcion, fecha 

--11. seleccione el usuario y cuente los usuarios de la tabla usuarios los agrupe por el rol y ordene descendentemente por la cantidad de clientes

SELECT usuario, COUNT(idusuarios) AS cantidad FROM `usuarios` GROUP BY usuario ORDER BY `cantidad` DESC

--12. seleccione la fecha mas alta de la tabla de mantenimientos donde la descripcion sea igual a descripcoion2 

SELECT MAX(fecha) FROM mantenimientos WHERE descripcion ="descripcion 2"

--13. seleccione la descripcion  la fecha y el idmantenimiento de la tabla mantenimientos cree un campo calculado de la diferencia de dias entre la fecha y la fecha actual y agrupelo por la descripcion

SELECT idmantenimientos, descripcion , fecha, DATE_FORMAT(NOW(),'%Y-%m-%d') AS fecha_actual, DATEDIFF(NOW(),fecha) AS diferencia FROM `mantenimientos` WHERE descripcion="descripcion 1"

--14 inserte un usuario

INSERT INTO `usuarios` (`idusuarios`, `contraseña`, `usuario`, `rol`, `personas_idpersonas`) VALUES ('102', 'contraseñainsertado', 'aleja-080911@gmail.com', 'contador', '96')

--15 mostrar como se creo la tabla mantenimientos

SHOW CREATE TABLE `mantenimientos`

--16.selecione todos los campos de la tabla personas que sepan el idioma aleman

SELECT * FROM personas INNER JOIN idiomas where idpersonas=personas_idpersonas and idioma="aleman"

--17. seleccione todos los campos de las personas que hayan tenido mantenimientos en fechas mayores a 2021 12 20

SELECT * FROM personas INNER JOIN mantenimientos ON idpersonas=personas_idpersonas WHERE fecha>2021-12-20

--18. seleccionar la informacion de la tabla personas y la informacion comun con la tabla de insumos

SELECT * FROM personas LEFT JOIN insumos ON idpersonas=personas_idpersonas

--19. seleccionar la informacion de la tabla insumos y la infromacion comun con la tabla de personas donde nombre del insumo sea "a,"

SELECT * FROM insumos RIGHT JOIN personas ON personas_idpersonas=idpersonas WHERE nombre_insumo="a,"

--20. seleccionar la infromacion de casos contables donde el rol del usuario sea igual a "administrador"

SELECT * FROM casos_contables INNER JOIN personas ON casos_contables.personas_idpersonas=personas.idpersonas INNER JOIN usuarios ON personas.idpersonas=usuarios.personas_idpersonas WHERE rol="administrador"
