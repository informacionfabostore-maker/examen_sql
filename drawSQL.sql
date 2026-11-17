CREATE TABLE `Autores`(
    `id_autor` INT NOT NULL,
    `nombre` TEXT NOT NULL,
    `fecha_nacimiento` TEXT NOT NULL,
    `nacionalidad` TEXT NOT NULL,
    PRIMARY KEY(`id_autor`)
);
CREATE TABLE `Libros`(
    `id_libro` INT NOT NULL,
    `titulo` TEXT NOT NULL,
    `editorial` TEXT NOT NULL,
    `categoria` TEXT NOT NULL,
    `fecha_publicacion` TEXT NOT NULL,
    `isbn` TEXT NOT NULL,
    `precio` DECIMAL(8, 2) NOT NULL,
    `stock` INT NOT NULL,
    PRIMARY KEY(`id_libro`)
);
ALTER TABLE
    `Libros` ADD UNIQUE `libros_isbn_unique`(`isbn`);
CREATE TABLE `LibroAutor`(
    `id_libro` INT NOT NULL,
    `id_autor` INT NOT NULL,
    PRIMARY KEY(`id_libro`)
);
ALTER TABLE
    `LibroAutor` ADD PRIMARY KEY(`id_autor`);
CREATE TABLE `Clientes`(
    `id_cliente` INT NOT NULL,
    `nombre` TEXT NOT NULL,
    `correo` TEXT NOT NULL,
    `telefono` TEXT NULL,
    `direccion` TEXT NOT NULL,
    PRIMARY KEY(`id_cliente`)
);
ALTER TABLE
    `Clientes` ADD UNIQUE `clientes_correo_unique`(`correo`);
CREATE TABLE `Pedidos`(
    `id_pedido` INT NOT NULL,
    `id_cliente` INT NOT NULL,
    `fecha_compra` TEXT NOT NULL,
    `estado` TEXT NOT NULL DEFAULT 'pendiente',
    PRIMARY KEY(`id_pedido`)
);
CREATE TABLE `DetallePedido`(
    `id_detalle` INT NOT NULL,
    `id_pedido` INT NOT NULL,
    `id_libro` INT NOT NULL,
    `cantidad` INT NOT NULL,
    `precio_unitario` DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY(`id_detalle`)
);
ALTER TABLE
    `DetallePedido` ADD UNIQUE `detallepedido_id_pedido_id_libro_unique`(`id_pedido`, `id_libro`);
CREATE TABLE `Transacciones`(
    `id_transaccion` INT NOT NULL,
    `id_pedido` INT NOT NULL,
    `metodo_pago` TEXT NOT NULL,
    `monto_total` DECIMAL(8, 2) NOT NULL,
    `fecha_transaccion` TEXT NOT NULL,
    PRIMARY KEY(`id_transaccion`)
);
ALTER TABLE
    `Transacciones` ADD UNIQUE `transacciones_id_pedido_unique`(`id_pedido`);
ALTER TABLE
    `Pedidos` ADD CONSTRAINT `pedidos_id_cliente_foreign` FOREIGN KEY(`id_cliente`) REFERENCES `Clientes`(`id_cliente`);
ALTER TABLE
    `DetallePedido` ADD CONSTRAINT `detallepedido_id_pedido_foreign` FOREIGN KEY(`id_pedido`) REFERENCES `Pedidos`(`id_pedido`);
ALTER TABLE
    `LibroAutor` ADD CONSTRAINT `libroautor_id_autor_foreign` FOREIGN KEY(`id_autor`) REFERENCES `Autores`(`id_autor`);
ALTER TABLE
    `Pedidos` ADD CONSTRAINT `pedidos_id_pedido_foreign` FOREIGN KEY(`id_pedido`) REFERENCES `Transacciones`(`id_pedido`);
ALTER TABLE
    `DetallePedido` ADD CONSTRAINT `detallepedido_id_libro_foreign` FOREIGN KEY(`id_libro`) REFERENCES `Libros`(`id_libro`);
ALTER TABLE
    `LibroAutor` ADD CONSTRAINT `libroautor_id_libro_foreign` FOREIGN KEY(`id_libro`) REFERENCES `Libros`(`id_libro`);