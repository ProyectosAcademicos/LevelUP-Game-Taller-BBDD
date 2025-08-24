/*archivo de prueba - esto es solo un ejemplo y propuesta:*/

drop table productos;

CREATE TABLE productos (
    id_producto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    precio NUMBER(10, 2),
    stock NUMBER
);

/*Crear (Insertar producto)*/

CREATE OR REPLACE PROCEDURE crear_producto (
    p_id_producto IN productos.id_producto%TYPE,
    p_nombre IN productos.nombre%TYPE,
    p_precio IN productos.precio%TYPE,
    p_stock IN productos.stock%TYPE
) AS
BEGIN
    INSERT INTO productos (id_producto, nombre, precio, stock)
    VALUES (p_id_producto, p_nombre, p_precio, p_stock);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar: ' || SQLERRM);
END;

/*Leer (Obtener producto por ID)*/

CREATE OR REPLACE FUNCTION obtener_producto (
    p_id_producto IN productos.id_producto%TYPE
) RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT * FROM productos WHERE id_producto = p_id_producto;
    RETURN v_cursor;
END;

/*Leer Todos (Listar todos los productos)*/

CREATE OR REPLACE FUNCTION listar_productos RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT * FROM productos;
    RETURN v_cursor;
END;


/*Actualizar*/
CREATE OR REPLACE PROCEDURE actualizar_producto (
    p_id_producto IN productos.id_producto%TYPE,
    p_nombre IN productos.nombre%TYPE,
    p_precio IN productos.precio%TYPE,
    p_stock IN productos.stock%TYPE
) AS
BEGIN
    UPDATE productos
    SET nombre = p_nombre,
        precio = p_precio,
        stock = p_stock
    WHERE id_producto = p_id_producto;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar: ' || SQLERRM);
END;

/* Eliminar */
CREATE OR REPLACE PROCEDURE eliminar_producto (
    p_id_producto IN productos.id_producto%TYPE
) AS
BEGIN
    DELETE FROM productos
    WHERE id_producto = p_id_producto;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar: ' || SQLERRM);
END;

/*
¿Cómo probarlo en Oracle SQL Developer?
Crear un producto:
BEGIN
    crear_producto(1, 'Laptop Lenovo', 799.99, 10);
END;

Obtener un producto:
VARIABLE cur REFCURSOR;
EXEC :cur := obtener_producto(1);
PRINT cur;

Listar todos los productos:
VARIABLE cur REFCURSOR;
EXEC :cur := listar_productos;
PRINT cur;

Actualizar un producto:
BEGIN
    actualizar_producto(1, 'Laptop Lenovo X', 849.99, 15);
END;

Eliminar un producto:
BEGIN
    eliminar_producto(1);
END;


*/
