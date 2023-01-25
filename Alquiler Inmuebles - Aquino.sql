/*                   CURSO SQL                     */
/*    PROYECTO: ALQUILER ONLINE DE INMUEBLES       */
-- Descripción: Base de datos para alquilar inmuebles de forma online

/*          CREACIÓN DE BASE DE DATOS              */
create schema if not exists alquileres;
use alquileres;

/*              CREACIÓN DE TABLAS                 */
-- 1) Tabla Personas: Contiene información de las personas
-- 2) Tabla Inmuebles: Contiene información de los inmuebles
-- 3) Tabla Direcciones: Contiene información sobre las direcciones, de personas (donde habitan permanentemente) y de inmuebles en alquiler
-- 4) Tabla Reservas: Contiene información de las reservas de los inmuebles
-- 5) Tabla Medios: Contiene información de los medios de pago y/o cobro. 
-- 6) Tabla Transacciones: Contiene información de las transacciones monetarias
-- 7) Tabla Calendario: Contiene información de fechas, relaciona temporalmente los registros.
-- 8) 
-- 9)
create table personas(
id_persona int not null auto_increment primary key,
apellido varchar(50) not null,
nombre varchar(50) not null,
telefono int not null,
dni numeric(8,0) not null,
fec_nac date not null -- La fecha de nacimiento se vincularia a una tabla calendario
-- rol_propietario (Aqui va una variable que identifica si la persona es propietaria de algun inmueble)
-- foreign key (fec_nac) references calendario(fecha) 
);
create table inmuebles(
id_inmueble int not null auto_increment primary key,
id_persona int not null,
tipo_inmueble varchar(10) not null,
foreign key (id_persona) references personas(id_persona)
);
create table direcciones(
id_dir int not null auto_increment primary key,
id_persona int not null,
id_inmueble int not null,
-- Luego de esta etapa del proyecto, se añadirian más tablas vinculadas a esta (tabla calles, tabla ciudades, tabla codigos postales, etc)
foreign key (id_persona) references personas(id_persona),
foreign key (id_inmueble) references inmuebles(id_inmueble)
);
create table reservas(
id_reserva int not null auto_increment primary key,
id_persona int not null,
id_inmueble int not null,
fec_inicio date not null,
foreign key (id_persona) references personas(id_persona),
foreign key (id_inmueble) references inmuebles(id_inmueble)
-- foreign key (fec_inicio) references calendario(fecha)
);
create table medios(
id_medio int not null auto_increment primary key,
id_persona int not null,
cbu int,
alias_cbu varchar(50),
cvu int,
alias_cvu varchar(50),
n_tarjeta int,
cvc int,
fec_exp date,
foreign key (id_persona) references personas(id_persona)
-- foreign key (fec_exp) references calendario(fecha)
);
create table transacciones(
id_tran int not null auto_increment primary key,
id_medio int not null,
importe int not null,
fec_trans datetime not null,
foreign key (id_medio) references medios(id_medio)
-- foreign key (fec_trans) references calendario(fecha)
);
-- create table calendario(-----) (para hacer más adelante)

