//archivo de prueba

drop table productos;

CREATE TABLE productos (
    id_producto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    precio NUMBER(10, 2),
    stock NUMBER
);

