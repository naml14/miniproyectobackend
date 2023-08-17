/*Creación de la tabla cliente*/
CREATE TABLE cliente (
	cliente_id SERIAL NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	telefono int NOT NULL,
	direccion varchar(100) NOT NULL,
	codigo_postal smallint NOT NULL,
	barrio varchar(50) NOT NULL,
	PRIMARY KEY (cliente_id)
);
/*Creación de la tabla producto*/
CREATE TABLE producto (
	SKU SERIAL NOT NULL,
	nombre varchar(25) NOT NULL,
	precio int NOT NULL,
	descripcion varchar(100) NOT NULL,
	PRIMARY KEY (SKU)
);
/*Creación de la tabla compra*/
CREATE TABLE compra (
	compra_id SERIAL NOT NULL,
	cliente_id SERIAL NOT NULL,
	total_pago int NOT NULL,
	PRIMARY KEY (compra_id),
	FOREIGN KEY (cliente_id)
      REFERENCES cliente (cliente_id)
);
/*Creación de la tabla venta*/
CREATE TABLE venta (
	venta_id SERIAL NOT NULL,
	SKU SERIAL NOT NULL,
	cantidad smallint NOT NULL,
	compra_id SERIAL NOT NULL,
	PRIMARY KEY (venta_id),
	FOREIGN KEY (SKU)
      REFERENCES producto (SKU),
	FOREIGN KEY (compra_id)
      REFERENCES compra (compra_id)
);
