-- criando banco de dados para oficina

-- drop database oficina;

create database oficina;
use oficina;

-- criar tabela clientes
create table clientes(
	idCliente int auto_increment primary key,
    Pnome varchar(10),
    sobrenome varchar(20),
    endereco varchar(255),
    telefone varchar(11)
);

desc clientes;

alter table clientes auto_increment=1;

-- criando tabela de equipes
create table equipes(
	idEquipe int auto_increment primary key,
	nome varchar(25)

);

desc equipes;

alter table equipes auto_increment=1;

-- criando tabelas de mecanicos
create table mecanicos(
	idMecanico int auto_increment primary key,
	nome varchar(45),
	endereco varchar(255),
	especialidade varchar(25),
	equipe_id int,

	constraint fk_equipes_id foreign key (equipe_id) references equipes (idEquipe)

);

desc mecanicos;

alter table mecanicos auto_increment=1;

-- criando tabela de veiculos
create table veiculos (
	idVeiculo int auto_increment primary key,
    placa varchar(9),
    modelo varchar(20),
    marca varchar(15),
    ano varchar(4),
    cliente_id int,
    
    constraint fk_clientes_id foreign key (cliente_id) references clientes (idCliente)

);

desc veiculos;

alter table veiculos auto_increment=1;

-- criando tabela de ordens de serviços
create table ordens_de_serviço (
	numero int auto_increment primary key,
    data_emissao varchar(9),
    status_os varchar(25),
	data_conclusao varchar(9),
    veiculo_id int,
    equipe_id int,
    
    constraint fk_veiculos_id foreign key (veiculo_id) references veiculos (idVeiculo),
    constraint fk_equipes_os_id foreign key (equipe_id) references equipes (idEquipe)

);

desc ordens_de_serviço;

alter table ordens_de_serviço auto_increment=1;

-- criando tabela de serviços

create table serviços (
	idServico int auto_increment primary key,
    descricao varchar(255),
    valor float

);

desc serviços;

alter table serviços auto_increment=1;

-- criando tabela de peças

create table peças (
	idPeça int auto_increment primary key,
	nome varchar(25),
    valor float

);

desc peças;

alter table peças auto_increment=1;

-- criando tabela de serviços em cada OS
create table servicos_em_os(
	os_numero int,
    servico_id int,
    subtotal float,
    quantidade int,
    
    constraint fk_os_num_id foreign key (os_numero) references ordens_de_serviço (numero),
    constraint fk_servico_id foreign key (servico_id) references serviços (idServiço)

);

desc servicos_em_os;

-- criando tabela de peças em cada OS
create table peças_em_os(
	os_numero int,
    peça_id int,
    subtotal float,
    quantidade int,
    
    constraint fk_os_num_id foreign key (os_numero) references ordens_de_serviço (numero),
    constraint fk_peças_id foreign key (peça_id) references peças (idPeça)

);

desc peças_em_os;


