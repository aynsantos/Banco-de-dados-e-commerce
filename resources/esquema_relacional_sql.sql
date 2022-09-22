/*Banco de dados para o cenário de E-commerce*/

/*drop database ecommerce;*/

create database ecommerce;

use ecommerce;

/* tabela cliente*/

create table cliente(
	idClient int auto_increment primary key,
    Fname varchar(20),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Adress varchar(45),
    constraint unique_cpf_client unique(CPF)
    
);

alter table cliente auto_increment=1;

desc cliente;

/* tabela produto*/

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(20),
    Category enum ('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis')not null,
    descrição varchar(45),
    avaliação float default 0

);

/* tabela pagamento*/

create table payments(
	idClient int,
	idPayment int,
	type_payments enum ('PIX', 'CARTÃO CRÉDITO', 'CARTÃO DÉBITO'),
	primary key(idClient, idPayment)

);

/* tabela pedido*/

create table orders(
	idOrders int auto_increment primary key,
	idOrderClient int,
	ordersStatus enum ('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	ordersDescription varchar (255),
	sendValue float default 0,
	paymentCash bool default false, 
	constraint fk_orders_client foreign key (idOrderClient) references cliente(idClient)
			on update cascade

);
desc orders;
/* tabela estoque */

create table productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0

);

/* tabela fornecedor */

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(14) not null,
    constraint  unique_supplier unique (CNPJ)
    
);

desc supplier;

/* tabela vendedor */

create table seller (
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(14),
    CPF char(9),
    location varchar(255),
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CNPJ)
);

create table productSeller(
	idPseller int,
    idPproduct int,
    productQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fK_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)

);

desc productSeller;

create table productOrder(
	idPOProduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fK_product_order_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_order_product foreign key (idPOorder) references orders(idOrders)

);

create table StorageLocation(
	idLproduct int,
    idLstorage int,
    Location varchar(255),
    primary key (idLproduct, idLstorage),
    constraint fK_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)

);

create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)

);

show tables;

show databases;

use information_schema;

select * from referential_constraints where constraint_schema = 'ecommerce';
