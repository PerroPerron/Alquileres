/*                   CURSO SQL                     */
/*    PROYECTO: ALQUILER ONLINE DE INMUEBLES       */
-- Descripción: Base de datos para alquilar alojamientos de forma online
<<<<<<< HEAD
-- ------------------------------------------------------------------------
-- INDICE:
-- 1) CREACIÓN DE BASE DE DATOS
-- 2) CREACIÓN DE TABLAS
-- 3) INSERCIÓN DE DATOS
-- 4) CREACIÓN DE VISTAS
-- 5) FUNCIONES PERSONALIZADAS
-- 6) STORED PROCEDURES
-- 7) TRIGGERS
-- -------------------------------------------------------------------------
/*                      CREACIÓN DE BASE DE DATOS                        */
-- -------------------------------------------------------------------------
=======
-- ----------------------------------------------------
/*          CREACIÓN DE BASE DE DATOS              */
-- -----------------------------------------------------
>>>>>>> e48545250cefdd1469edb44e38821b37e1ebc28d
create schema if not exists alquileres;
use alquileres;
-- -------------------------------------------------------------------------------------------------------------------------
/*                                           CREACIÓN DE TABLAS                                                          */
-- -------------------------------------------------------------------------------------------------------------------------
-- TABLAS DIMENSIONALES:
	-- 1) Tabla Paises: Contiene información de paises, codigos de telefonos de pais.
	-- 2) Tabla Estados: Contiene información de estados o provincias, codigos de telefonos.
	-- 3) Tabla Localidades: Contiene información de localidades, sus códigos postales.
	-- 4) Tabla Tipos Alojamiento: Contiene información del tipo de alojamiento, si es comparido, para una persona, etc.
    -- 5) Tabla Tipos propiedad: Contiene información del tipo de propiedad, hotel, casa, departamento, cabaña, etc
	-- 6) Tabla Servicios: Contiene información de los servicios con que cuenta el alojamiento
	-- 7) Tabla Actividades: Contiene información de las actividades que se brindan con el alojamiento
	-- 8) Tabla Caracteristicas: Contiene información de caracteristicas del alojamiento, como vista al mar, etc
	-- 9) Tabla Idiomas: Contiene el idioma de hablan personas
-- TABLAS DE HECHO
	-- 10) Tabla Personas: Contiene información de las personas, contiene un marcador de anfitrion, otro marcador de propietario
	-- 11) Tabla Alojamientos: Es una tabla de hecho que contiene información de los alojamientos
	-- 12) Tabla Reservas: Contiene información de las reservas de los alojamientos, que persona alquila, que fechas, etc. 
	-- 13) Tabla Medios: Contiene información de los medios de pago y/o cobro. 
	-- 14) Tabla Transacciones: Contiene información de las transacciones monetarias, importes, si son debitos o creditos, fechas, etc    
-- SCRIPTS:
-- TABLAS DE DIMENSIONALES
create table paises(
id_pais int not null auto_increment primary key,
pais varchar(50),
phone_code int
);
create table estados(
id_estado int not null auto_increment primary key,
estado varchar (50)
);
create table localidades(
id_localidad int not null auto_increment primary key,
localidad varchar (50)
);
create table tipo_alojamiento(
id_tipoalojamiento int not null auto_increment primary key,
nombre varchar(50) not null
);
create table tipo_propiedad(
id_propiedad int not null auto_increment primary key,
propiedad varchar(50) not null
);
create table servicios(
id_servicio int not null auto_increment primary key,
servicio varchar(50)
);
create table actividades(
id_actividad int not null auto_increment primary key,
actividad varchar(50)
);
create table caracteristicas(
id_caracteristica int not null auto_increment primary key,
caracteristica varchar(50)
);
create table idiomas(
id_idioma int not null auto_increment primary key,
idioma varchar(30)
);
-- TABLAS DE HECHOS:
create table personas(
 id_persona int not null auto_increment primary key,
 apellido varchar(50) not null,
 nombre varchar(50) not null,
 telefono varchar(20) not null,
 dni numeric(8,0) not null,
 nacimiento date not null,
 email varchar(50) not null,
 pais int not null, -- Llave foranea que relaciona a la persona con el pais donde se encuentra
 estado int not null, -- Llave foranea que relaciona a la persona con el estado o provincia donde se encuentra
 localidad int not null, -- Llave foranea que relaciona a la persona con la localidad donde se encuentra
 idioma int not null,
 foreign key (pais) references paises (id_pais),
 foreign key (estado) references estados (id_estado),
 foreign key (localidad) references localidades (id_localidad),
 foreign key (idioma) references idiomas(id_idioma)
 -- anfitrion Esta marca define si una persona es anfitriona de algún alojamiento
 );
create table alojamientos(
id_alojamiento int not null auto_increment primary key,
nombre varchar(50),
dormitorios int not null,
baños int not null,
pais int not null, -- Llave foranea que relaciona al alojamiento con el pais donde se encuentra
estado int not null, -- Llave foranea que relaciona al alojamiento con el estado o provincia donde se encuentra
localidad int not null, -- Llave foranea que relaciona al alojamiento con la localidad donde se encuentra
tipo_alojamiento int not null,
tipo_propiedad int not null,
servicios int not null,
actividades int not null,
caracteristicas int not null,
foreign key (pais) references paises(id_pais),
foreign key (estado) references estados(id_estado),
foreign key (localidad) references localidades(id_localidad),
foreign key (tipo_alojamiento) references tipo_alojamiento(id_tipoalojamiento),
foreign key (tipo_propiedad) references tipo_propiedad(id_propiedad),
foreign key (servicios) references servicios(id_servicio),
foreign key (actividades) references actividades(id_actividad),
foreign key (caracteristicas) references caracteristicas(id_caracteristica)
);
create table reservas(
id_reserva int not null auto_increment primary key,
persona int not null, -- Llave foranea que relaciona la reserva con la persona
alojamiento int not null, -- Llave foranea que relaciona la reserva con el alojamiento
checkin date not null, -- Fecha de entrada de la persona al alojamiento
<<<<<<< HEAD
checkout date not null,
precio_dia numeric(6,2) not null, -- Fecha de salida de la persona del alojamiento
=======
checkout date not null, -- Fecha de salida de la persona del alojamiento
>>>>>>> e48545250cefdd1469edb44e38821b37e1ebc28d
foreign key (persona) references personas(id_persona),
foreign key (alojamiento) references alojamientos(id_alojamiento)
);
create table medios(
id_medio int not null auto_increment primary key,
persona int not null, -- Llave foranea que relaciona el medio con la persona titular del mismo
cbu int,
alias_cbu varchar(50),
cvu int,
alias_cvu varchar(50),
n_tarjeta int,
cvc int,
fec_exp date,
foreign key (persona) references personas(id_persona)
);
create table transacciones(
id_transaccion int not null auto_increment primary key,
medio int not null, -- Llave foranea que relaciona la transacción con el medio utilizado
importe int not null,
fec_trans datetime not null,
foreign key (medio) references medios(id_medio)
);
-- ------------------------------------------------------------------------------------------------------------------------------------
/*                                              INSERCIÓN DE DATOS                                                                  */
-- ------------------------------------------------------------------------------------------------------------------------------------
-- CON IMPORTACIÓN DE ARCHIVO CSV
	-- 1) Tabla Paises
-- CON SCRIPTS
-- 2) Tabla Estados
insert into estados (id_estado,estado)
values
(null,'Mendoza'),
(null,'Buenos Aires'),
(null,'Barcelona'),
(null,'Paris'),
(null,'Rio de Janeiro'),
(null,'Florida'),
(null,'Santiago'),
(null,'Tokio'),
(null,'Berlin');
-- 3) Tabla Localidades
insert into localidades (id_localidad,localidad)
values
(null,'Godoy Cruz'),
(null,'Palermo'),
(null,'Badalona'),
(null,'Louvre'),
(null,'Botafogo'),
(null,'Miami'),
(null,'Providencia'),
(null,'Mizuho'),
(null,'Mitte');
-- 4) Tabla Tipos Alojamiento
insert into tipo_alojamiento (id_tipoalojamiento,nombre)
values
(null,'Entero'),
(null,'Compartido'),
(null,'Privado');
-- 5) Tabla Tipos propiedad
insert into tipo_propiedad (id_propiedad,propiedad)
values
(null,'Casa'),
(null,'Departamento'),
(null,'Hotel'),
(null,'Cabaña'),
(null,'Domo'),
(null,'Mansión'),
(null,'Castillo');
-- 6) Tabla Servicios
insert into servicios (id_servicio,servicio)
values
(null,'Wifi'),
(null,'Lavarropas'),
(null,'Aire Acondicionado'),
(null,'Cocina'),
(null,'Calefacción'),
(null,'Televisión'),
(null,'Secador de pelo'),
(null,'Plancha'),
(null,'Desayuno');
-- 7) Tabla Actividades: Se insertan datos con scripts
insert into actividades (id_actividad,actividad)
values
(null,'Futbol'),
(null,'Tenis'),
(null,'Cabalgata'),
(null,'Cine'),
(null,'Senderismo'),
(null,'Pesca'),
(null,'Degustaciones'),
(null,'Paseo en Bicicleta'),
(null,'Esqui'),
(null,'Golf');
-- 8) Tabla Caracteristicas
insert into caracteristicas (id_caracteristica,caracteristica)
values
(null,'Vista al mar'),
(null,'Vista a la montaña'),
(null,'Piletas increibles'),
(null,'Ecológico'),
(null,'Diseño'),
(null,'Granja'),
(null,'Cuevas'),
(null,'Con historia'),
(null,'Viñedos'),
(null,'Adaptados');
-- 9) Tabla Idiomas
insert into idiomas (id_idioma,idioma)
values
(null,'Inglés'),
(null,'Español'),
(null,'Portugues'),
(null,'Catalan'),
(null,'Mandarin'),
(null,'Frances'),
(null,'Arabe'),
(null,'Hindi'),
(null,'Ruso'),
(null,'Alemán');
-- 10) Tabla Personas
insert into personas (id_persona,apellido,nombre,telefono,dni,nacimiento,email,pais,estado,localidad,idioma)
values
(null,'Rodriguez','Julieta','(754) 576-7253',50640680,'1992-10-23','rodriguez.julieta@icloud.org',3,9,9,2),
(null,'Odonnell','Debra','(833) 549-5512',36546212,'1963-03-10','odonnel123@outlook.com',65,6,6,1),
(null,'Pratt','Kim','1-519-838-5736',45362156,'2001-06-02','prattkim@google.net',30,5,5,1),
(null,'Shannon','Raven','(720) 418-4833',14256325,'1986-12-07','raven.shannon@gmail.com',64,3,3,2),
(null,'Andino','Marta','(54) 261-365785',10365987,'1952-09-08','andino.mar@gmail.com',11,1,1,1);
-- 11) Tabla Alojamientos
insert into alojamientos (id_alojamiento,nombre,dormitorios,baños,pais,estado,localidad,tipo_alojamiento,tipo_propiedad,servicios,actividades,caracteristicas)
values
(null,'Los Amigos',1,1,64,3,3,1,3,1,4,2),
(null,'El Descanso',3,2,30,5,5,2,6,2,2,1),
(null,'Royal Home',2,1,11,1,1,1,4,3,3,2),
(null,'Amaneceres',1,1,64,3,3,3,3,2,4,2);
-- 12) Tabla Reservas
<<<<<<< HEAD
insert into reservas (id_reserva,persona,alojamiento,checkin,checkout,precio_dia)
values
(null,1,2,'2023-06-01','2023-06-15',150.00),
(null,3,4,'2023-04-10','2023-05-10',325.20);
=======
insert into reservas (id_reserva,persona,alojamiento,checkin,checkout)
values
(null,1,2,'2023-06-01','2023-06-15'),
(null,3,4,'2023-04-10','2023-05-10');
>>>>>>> e48545250cefdd1469edb44e38821b37e1ebc28d
-- 13) Tabla Medios
insert into medios (id_medio,persona,cbu,alias_cbu,cvu,alias_cvu,n_tarjeta,cvc,fec_exp)
values
(null,1,null,null,null,null,58697854,014,'2025-07-01'),
(null,1,566455215,'mar.estrella.xs',null,null,null,null,null),
(null,3,null,null,548565452,'primavera.rojo.perro',null,null,null),
(null,5,654585458,'cat.ballena.risa',null,null,null,null,null);
-- 14) Tabla Transacciones
insert into transacciones (id_transaccion,medio,importe,fec_trans)
values
(null,1,1000,'2023-02-06'),
(null,2,2000,'2023-01-01'),
(null,3,1800,'2023-01-25'),
(null,4,1600,'2023-01-05');
-- -------------------------------------------------------------------------------------------------------------------------------------
/*                                                      CREACIÓN DE VISTAS                                                           */ 
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 1) PERSONAS REGISTRADAS QUE VIVEN EN ARGENTINA
create view paises_de_procedencia_personas as
select 
T1.nombre,
T1.apellido,
T2.pais
from
personas T1
inner join paises T2
<<<<<<< HEAD
on T1.pais=T2.id_pais;
=======
on T1.pais=T2.id_pais
>>>>>>> e48545250cefdd1469edb44e38821b37e1ebc28d

-- 2) DATOS DE CONTACTO DE PERSONAS CON RESERVAS 
create view contacto_personas_con_reserva as
select
T2.nombre,
T2.apellido,
T2.telefono,
T2.email
from reservas T1
inner join personas T2
on T1.persona = T2.id_persona;

-- 3) GASTO Y ALOJAMIENTO DE PERSONAS CON RESERVAS
create view gasto_alojamiento_por_persona as
select
T3.nombre,
T3.apellido,
T4.alojamiento,
T2.importe
from
medios T1
inner join transacciones T2
on T1.id_medio=T2.medio
inner join personas T3
on T1.persona=T3.id_persona
inner join reservas T4
on T3.id_persona=T4.persona;

-- 4) ACTIVIDADES Y CARACTERISTICAS POR ALOJAMIENTO
create view actividades_y_caracteristicas_por_alojamiento as
select
T1.nombre as nombre_alojamiento,
T2.actividad as Actividades_para_realizar,
T3.caracteristica as Caracteristicas_sobresalientes
from alojamientos T1
inner join actividades T2
on T1.actividades=T2.id_actividad
inner join caracteristicas T3
on T1.caracteristicas=T3.id_caracteristica;

-- 5) Idiomas que son hablantes las personas
create view idiomas_de_personas as
select
T1.nombre,
T1.apellido,
T2.idioma
from personas T1
inner join idiomas T2
on T1.idioma=T2.id_idioma;
<<<<<<< HEAD
-- -------------------------------------------------------------------------------------------------------------------------
/*                                           FUNCIONES PERSONALIZADAS                                                     */
-- -------------------------------------------------------------------------------------------------------------------------
-- 1) FUNCIÓN PARA CALCULAR EL PRECIO EL PRECIO DE LA ESTADIA EN EL ALOJAMIENTO
DELIMITER //
create function costo_alojamiento (checkin date,checkout date,precio_dia numeric(6,2))
returns numeric(6,2)
deterministic
begin
	declare dias int; -- cuenta los dias entre el checkin y el checkout
    declare resultado numeric(6,2);-- multiplica los dias por el precio diario del alojamiento
	set dias = checkout-checkin;
	set resultado=precio_dia*dias;
	return resultado;
end;
//
select costo_alojamiento('2023-05-03','2023-05-10',200);

-- 2) FUNCIÓN PARA DETERMINAR SI APLICAR UNA BONIFICACIÓN O NO A UN CLIENTE FRECUENTE
DELIMITER //
create function bonificacion_cliente (id_persona int)
returns varchar(50)
deterministic
begin
	declare n_reservas int;
    declare mensaje varchar(25);
    set n_reservas = (select count(id_reserva) from reservas where persona=id_persona);
	if n_reservas>=1 then
    set mensaje= 'Aplicar Bonificación';
	else
    set mensaje= 'NO aplicar Bonificación';
    end if;
    return mensaje;
end;
//
select bonificacion_cliente (1), bonificacion_cliente(2), bonificacion_cliente(3);
-- -------------------------------------------------------------------------------------------------------------------------
/*                                           STORED PROCEDURES                                                            */
-- -------------------------------------------------------------------------------------------------------------------------
-- 1) INSERCIÓN DE REGISTRO EN LA TABLA ACTIVIDADES: 
DELIMITER //
create procedure insertar_actividad (in actividad varchar(50)) 
begin
	insert into actividades (id_actividad, actividad) values (null, actividad);
end//
call insertar_actividad ('Rafting'); -- Ejemplo de llamado al procedimiento para insertar un registro

-- 2) ELIMINACIÓN DE REGISTRO EN LA TABLA ACTIVIDADES: 
DELIMITER //
create procedure eliminar_actividad (in id int)
begin
	delete from actividades where id_actividad=id;
end //
call eliminar_actividad (11); -- Ejemplo de llamado al procedimiento para eliminar un registro

-- 3) PROCEDIMIENTO ALMACENADO QUE PERMITE ORDENAR REGISTROS TIPO VARCHAR DE UNA TABLA, CON ORDEN ASCENDENTE O DESCENDENTE: 
DELIMITER //
create procedure ordenar_tabla(
	in tabla varchar(50), --  Nombre de la tabla que se va a ordenar
	in columna varchar(50), -- Aqui especifico en función de que campo de la tabla quiero ordenar la tabla
	in tipo_orden varchar(5) -- Aqui especifico que tipo de orden quiero, ascendente o descendente
)
begin
	declare clausula varchar(50); -- Declaro la variable temporal "clausula"
    set @clausula = -- Genero la variable que va a ordenar los parametros de entrada
		concat( -- utilizo concat para concatenar la consulta
        ' select*from ', tabla ,
        ' order by ', columna ,
        ' ', tipo_orden);
	-- Con la variable runSQL almaceno temporalmente la @consulta
    prepare runSQL from @clausula; -- utilizo prepare para preparar la consulta
    execute runSQL; -- utilizo execute para ejecutar la consulta
    deallocate prepare runSQL; -- utilizo deallocate prepare para borrar la memoria que se había reservado con la variable temporal runSQL
end//
call ordenar_tabla('personas', 'nombre', 'DESC'); -- Ejemplo de llamado al procedimiento para ordenar la tabla personas
call ordenar_tabla('idiomas', 'idioma', 'ASC'); -- Ejemplo de llamado al procedimiento para ordenar la tabla idiomas
-- ---------------------------------------------------------------------------------------------------------------------------
/*                                                    TRIGGERS                                                              */
-- ---------------------------------------------------------------------------------------------------------------------------
/*   1) BITACORA DE INSERCIONES PARA TABLA RESERVAS   */
-- ------------------------------------------------------
create table bitacora_reservas_insercion(-- Creo tabla bitacora que almacenara información del usuario, fecha y hora de las inserciones que realice
	id_insercion int not null auto_increment primary key,
	id_reserva int not null,
	usuario varchar(50) not null,
	fecha_insercion datetime not null
);

DELIMITER // -- Creación del trigger que detecta la inserción de un registro en la tabla reservas
create trigger bitacora_reservas_insercion
	after insert on reservas -- El trigger se ejecutará despues (AFTER) de cada inserción en la tabla reservas y registrará la información en la tabla bitacora_reservas_inserción.
	for each row -- Aqui se especifica que se ejecute para cada registro
	begin
		insert into bitacora_reservas_insercion(
        id_reserva,
        usuario,
        fecha_insercion)
		values (new.id_reserva, user(), curtime());
	end;//
-- ---------------------------------------------------
-- Realizo una inserción de ejemplo
insert into reservas(
	id_reserva,
    persona,
    alojamiento,
    checkin,
    checkout,
    precio_dia)
values
	(null,5,3,'2023-06-01','2023-06-07',450.50);
select*from reservas;
select*from bitacora_reservas_insercion;
-- ----------------------------------------------------------
/*    2) BITACORA DE ELIMINACIONES PARA TABLA RESERVAS    */
-- ----------------------------------------------------------
create table bitacora_reservas_eliminacion( -- Creo tabla bitacora que almacenara información del usuario, fecha y hora de los delete que realice
  id_eliminacion int not null auto_increment primary key,
  id_reserva int not null,
  usuario varchar(50) not null,
  fecha_eliminacion datetime not null
);

DELIMITER // -- Creación del trigger que detecta la eliminación de un registro en la tabla reservas
create trigger bitacora_reservas_eliminacion
	before delete on reservas -- El trigger se ejecutará antes (BEFORE) de cada eliminación en la tabla reservas y registrará la información en la tabla bitacora_reservas_eliminacion. 
	for each row -- Aqui se especifica que se dispare para cada registro
	begin
		insert into bitacora_reservas_eliminacion(
        id_reserva,
        usuario,
        fecha_eliminacion) 
		values (old.id_reserva, user(), curtime());
	end;//
-- Ejemplo de eliminación, realizo un delete del registro insertado en el ejercicio anterior
delete from reservas where id_reserva=3;
select*from reservas;
select*from bitacora_reservas_eliminacion;
=======
>>>>>>> e48545250cefdd1469edb44e38821b37e1ebc28d
