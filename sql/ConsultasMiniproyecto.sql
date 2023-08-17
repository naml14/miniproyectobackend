/*1) ID de los clientes de la Ciudad de Monterrey*/
select cliente_id from cliente where barrio='Monterrey';
/*2) ID y descripción de los productos que cuesten menos de 15 pesos*/
select SKU, descripcion from producto where precio<15;
/*3) ID y nombre de los clientes, cantidad vendida, y descripción del producto, en las ventas en las cuales se vendieron más de 10 unidades.*/
select
	cliente.cliente_id,
	cliente.nombre,
	venta.cantidad,
	producto.descripcion
from
	cliente
inner join compra
	on cliente.cliente_id=compra.cliente_id
inner join venta
	on compra.compra_id=venta.compra_id
inner join producto
	on venta.cantidad>10
order by cliente.cliente_id;
/*4) ID y nombre de los clientes que no aparecen en la tabla de ventas (Clientes que no han comprado productos)*/
select
	cliente.cliente_id,
	cliente.nombre
from
	cliente
left join compra
	on compra.cliente_id=cliente.cliente_id
where compra.compra_id is null
order by cliente.cliente_id;
/*5) ID y nombre de los clientes que han comprado todos los productos de la empresa.*/
select
	cliente.cliente_id,
	cliente.nombre
from
	cliente
left join compra
	on compra.cliente_id=cliente.cliente_id
left join venta
	on venta.compra_id=compra.compra_id
left join producto
	on producto.sku=venta.sku
group by
	cliente.cliente_id
having
	count(compra.compra_id)=max(producto.sku);
/*6) ID y nombre de cada cliente y la suma total (suma de cantidad) de los productos que ha comprado.*/
select
	cliente.cliente_id,
	cliente.nombre,
	coalesce(sum(venta.cantidad),0) as productos_comprados
from
	cliente
left join compra
	on compra.cliente_id=cliente.cliente_id
left join venta
	on venta.compra_id=compra.compra_id
left join producto
	on producto.sku=venta.sku
group by
	cliente.cliente_id
order by
	cliente.cliente_id;
/*7) ID de los productos que no han sido comprados por clientes de Guadalajara.*/
select
	producto.sku
from
	cliente
full join compra
	on cliente.cliente_id = compra.cliente_id
	and cliente.barrio='Guadalajara'
full join venta
	on compra.compra_id = venta.compra_id
full join producto
	on venta.sku = producto.sku
group by
	producto.sku
	having count(distinct cliente.cliente_id)=0
order by
	producto.sku;
/*8) ID de los productos que se han vendido a clientes de Monterrey y que también se han vendido a clientes de Cancún.*/
select 
	producto.sku
from 
	producto
right join venta
	on venta.sku=producto.sku
right join compra
	on compra.compra_id=venta.compra_id
right join cliente
	on cliente.cliente_id=compra.cliente_id
where barrio='Monterrey'
and producto.sku in(
	select 
		producto.sku
	from 
		producto
	right join venta
		on venta.sku=producto.sku
	right join compra
		on compra.compra_id=venta.compra_id
	right join cliente
		on cliente.cliente_id=compra.cliente_id
	where barrio='Cancún'
)
group by
	producto.sku
order by
	producto.sku;
/*9) Nombre de las ciudades en las que se han vendido todos los productos.*/
select
	cliente.barrio as Ciudades
from cliente
inner join compra
	on cliente.cliente_id = compra.cliente_id
inner join venta
	on compra.compra_id = venta.compra_id
inner join producto
	on venta.sku = producto.sku
group by
	cliente.barrio
having
	count(distinct producto.sku)=(select count(distinct sku) from producto);

