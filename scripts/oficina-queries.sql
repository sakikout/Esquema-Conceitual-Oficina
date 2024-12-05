use oficina;

-- povoando a tabela clientes
insert into clientes (Pnome, sobrenome, endereco, telefone)
values 
('João', 'Silva', 'Rua das Flores, 123', '31987654321'),
('Maria', 'Oliveira', 'Av. Brasil, 456', '31912345678'),
('Carlos', 'Santos', 'Rua da Paz, 789', '31911223344'),
('Ana', 'Costa', 'Rua Bela Vista, 101', '31999887766'),
('Lucas', 'Pereira', 'Av. Minas Gerais, 202', '31966554433');

-- povoando a tabela equipes
insert into equipes (nome)
values
('Equipe A'),
('Equipe B'),
('Equipe C'),
('Equipe D'),
('Equipe E');

-- povoando a tabela mecanicos
insert into mecanicos (nome, endereco, especialidade, equipe_id)
values
('Pedro Almeida', 'Rua Verde, 111', 'Motor', 1),
('Júlia Castro', 'Rua Amarela, 222', 'Suspensão', 2),
('Rafael Lopes', 'Av. Central, 333', 'Elétrica', 3),
('Sofia Lima', 'Rua Azul, 444', 'Freios', 4),
('Marcos Souza', 'Rua Vermelha, 555', 'Pintura', 5);

-- povoando a tabela veiculos
insert into veiculos (placa, modelo, marca, ano, cliente_id)
values
('ABC1234', 'Civic', 'Honda', '2020', 1),
('XYZ5678', 'Corolla', 'Toyota', '2021', 2),
('DEF9012', 'Focus', 'Ford', '2019', 3),
('GHI3456', 'Cruze', 'Chevrolet', '2018', 4),
('JKL7890', 'Sentra', 'Nissan', '2022', 5);

-- povoando a tabela ordens_de_serviço
insert into ordens_de_serviço (data_emissao, status_os, data_conclusao, veiculo_id, equipe_id)
values
('2024-12-01', 'Aberta', null, 1, 1),
('2024-12-02', 'Em andamento', null, 2, 2),
('2024-12-03', 'Concluída', '2024-12-04', 3, 3),
('2024-12-04', 'Aberta', null, 4, 4),
('2024-12-05', 'Concluída', '2024-12-05', 5, 5);

-- povoando a tabela serviços
insert into serviços (descricao, valor)
values
('Troca de óleo', 150.00),
('Alinhamento', 100.00),
('Balanceamento', 120.00),
('Troca de pastilhas de freio', 200.00),
('Revisão geral', 500.00);

-- povoando a tabela peças
insert into peças (nome, valor)
values
('Filtro de óleo', 50.00),
('Pneu', 400.00),
('Bateria', 300.00),
('Correia dentada', 200.00),
('Velas de ignição', 80.00);

-- povoando a tabela servicos_em_os
insert into servicos_em_os (os_numero, servico_id, subtotal, quantidade)
values
(1, 1, 150.00, 1),
(2, 2, 200.00, 2),
(3, 3, 120.00, 1),
(4, 4, 400.00, 2),
(5, 5, 500.00, 1);

-- povoando a tabela peças_em_os
insert into peças_em_os (os_numero, peça_id, subtotal, quantidade)
values
(1, 1, 50.00, 1),
(2, 2, 800.00, 2),
(3, 3, 300.00, 1),
(4, 4, 400.00, 2),
(5, 5, 160.00, 2);

-- ------------ QUERIES -------------

-- mostrando todos os clientes
SELECT idCliente, Pnome, sobrenome, endereco, telefone
FROM clientes;

-- mostrando clientes cujo sobrenome começa com 'S'
SELECT * FROM clientes
WHERE sobrenome LIKE 'S%';

-- mostrando o nome e telefone dos mecânicos
SELECT nome, telefone FROM mecanicos;

-- listando os veículos ordenados por ano de fabricação (do mais novo para o mais antigo)
SELECT * FROM veiculos
ORDER BY ano DESC;

-- listando os clientes ordenados por sobrenome em ordem alfabética
SELECT * FROM clientes
ORDER BY sobrenome ASC;

-- listando os serviços por valor (do maior para o menor)
SELECT * FROM serviços
ORDER BY valor DESC;


-- mostrando todos os veiculos e o nome do seu respectivo dono
SELECT 	v.idVeiculo as ID, 
		v.placa as Placa, 
        v.modelo as Modelo, 
        v.marca as Marca, 
        c.Pnome as Nome_Cliente,
        c.sobrenome AS Sobrenome_Cliente
FROM clientes c
JOIN veiculos v ON v.cliente_id = c.idCliente;

-- ordem de serviço de cada cliente
SELECT 	os.numero as Numero,
		os.status_os as Status_OS,
        os.valor as Valor,
        os.data_emissao as Data_Emissao,
        os.data_conclusao as Data_Conclusao,
        v.placa as Placa_Veiculo,
        c.Pnome as Nome_Cliente,
        c.sobrenome as Sobrenome_Cliente
FROM ordens_de_serviço os
JOIN veiculos v ON v.idVeiculo = os.veiculo_id
JOIN clientes c ON c.idCliente = v.cliente_id
GROUP BY c.idCliente;

-- ordens de serviço com custo total acima de R$1000
SELECT 	os_numero AS Numero_OS, 
		SUM(subtotal) AS Custo_Total
FROM servicos_em_os
GROUP BY os_numero
HAVING SUM(subtotal) > 1000;

-- todos os serviços realizados em uma OS junto com a descrição
SELECT os.numero AS Numero_OS, s.descricao AS Descriçao_Serviço, sos.subtotal AS Subtotal
FROM ordens_de_serviço os
JOIN servicos_em_os sos ON os.numero = sos.os_numero
JOIN serviços s ON s.idServico = sos.servico_id;


-- equipes e o número de serviços associados a cada uma
SELECT 	e.nome AS Equipe, 
		COUNT(servicos_em_os.os_numero) AS Total_de_Serviços
FROM equipes e
JOIN ordens_de_serviço os ON e.idEquipe = os.equipe_id
JOIN servicos_em_os serv ON os.numero = serv.os_numero
GROUP BY e.nome;

