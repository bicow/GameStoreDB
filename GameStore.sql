CREATE DATABASE GameStore;
use GameStore;

CREATE TABLE Cliente (
    id_cliente INT IDENTITY PRIMARY KEY,
    nome VARCHAR(80),
    cpf VARCHAR(11),
    endereco VARCHAR(120)
);

CREATE TABLE Fornecedor (
    id_fornecedor INT IDENTITY PRIMARY KEY,
    nome VARCHAR(80),
    cnpj VARCHAR(14)
);

CREATE TABLE MarcaProduto (
    id_marca INT IDENTITY PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE CategoriaProduto (
    id_categoria INT IDENTITY PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE Produto (
    id_produto INT IDENTITY PRIMARY KEY,
    nome VARCHAR(80),
    preco DECIMAL(10,2),
    id_fornecedor INT REFERENCES Fornecedor(id_fornecedor),
    id_categoria INT REFERENCES CategoriaProduto(id_categoria),
    id_marca INT REFERENCES MarcaProduto(id_marca)
);

CREATE TABLE QuantidadeEstoque (
    id_produto INT PRIMARY KEY REFERENCES Produto(id_produto),
    quantidade INT
);

CREATE TABLE Transporte (
    id_transporte INT IDENTITY PRIMARY KEY,
    nome VARCHAR(80),
    tipo VARCHAR(30)
);

CREATE TABLE Pedido (
    id_pedido INT IDENTITY PRIMARY KEY,
    id_cliente INT REFERENCES Cliente(id_cliente),
    id_transporte INT REFERENCES Transporte(id_transporte),
    data_pedido DATE
);

CREATE TABLE ItensPedido (
    id_item INT IDENTITY PRIMARY KEY,
    id_pedido INT REFERENCES Pedido(id_pedido),
    id_produto INT REFERENCES Produto(id_produto),
    quantidade INT
);

CREATE TABLE NotaPedido (
    id_nota INT IDENTITY PRIMARY KEY,
    id_pedido INT REFERENCES Pedido(id_pedido),
    data_emissao DATE
);

-- SELECTS --
-- CLIENTES
INSERT INTO Cliente (nome, cpf, endereco) VALUES
('João Silva', '12345678901', 'Rua Alpha 100'),
('Maria Souza', '98765432100', 'Av. Beta 200'),
('Carlos Lima', '45678912300', 'Travessa Gama 50');

-- FORNECEDORES
INSERT INTO Fornecedor (nome, cnpj) VALUES
('TechSupply', '11223344556677'),
('GameParts', '99887766554433');

-- MARCAS
INSERT INTO MarcaProduto (nome) VALUES
('HyperX'),
('Razer'),
('Logitech');

-- CATEGORIAS
INSERT INTO CategoriaProduto (nome) VALUES
('Teclado'),
('Mouse'),
('Headset');

-- PRODUTOS
INSERT INTO Produto (nome, preco, id_fornecedor, id_categoria, id_marca) VALUES
('Teclado Mecânico HyperX Alloy', 499.90, 1, 1, 1),
('Mouse Razer DeathAdder', 349.90, 2, 2, 2),
('Headset Logitech G Pro', 799.90, 1, 3, 3);

-- ESTOQUE
INSERT INTO QuantidadeEstoque (id_produto, quantidade) VALUES
(1, 20),
(2, 35),
(3, 15);

-- TRANSPORTE
INSERT INTO Transporte (nome, tipo) VALUES
('Correios', 'PAC'),
('Sedex', 'Express'),
('Transportadora Gamer', 'Rodoviário');

-- PEDIDOS
INSERT INTO Pedido (id_cliente, id_transporte, data_pedido) VALUES
(1, 1, '2025-01-15'),
(2, 2, '2025-01-20'),
(1, 3, '2025-01-25');

-- ITENS PEDIDO
INSERT INTO ItensPedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 2),
(3, 1, 1);

-- NOTA PEDIDO
INSERT INTO NotaPedido (id_pedido, data_emissao) VALUES
(1, '2025-01-15'),
(2, '2025-01-20'),
(3, '2025-01-25');

-- SELECTS --
-- Listar produtos com suas marcas e categorias
SELECT p.nome AS Produto, p.preco, m.nome AS Marca, c.nome AS Categoria
FROM Produto p
JOIN MarcaProduto m ON p.id_marca = m.id_marca
JOIN CategoriaProduto c ON p.id_categoria = c.id_categoria;

-- Pedidos com cliente e valor total estimado
SELECT 
    pe.id_pedido,
    c.nome AS Cliente,
    SUM(i.quantidade * p.preco) AS ValorTotal
FROM Pedido pe
JOIN Cliente c ON pe.id_cliente = c.id_cliente
JOIN ItensPedido i ON pe.id_pedido = i.id_pedido
JOIN Produto p ON i.id_produto = p.id_produto
GROUP BY pe.id_pedido, c.nome;

-- Produtos com estoque baixo (< 20 unidades)
SELECT p.nome, q.quantidade
FROM Produto p
JOIN QuantidadeEstoque q ON p.id_produto = q.id_produto
WHERE q.quantidade < 20;

-- Clientes que fizeram mais de 1 pedido
SELECT c.nome, COUNT(*) AS TotalPedidos
FROM Pedido pe
JOIN Cliente c ON pe.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING COUNT(*) > 1;

-- Listar pedidos por ordem de data
SELECT id_pedido, id_cliente, data_pedido
FROM Pedido
ORDER BY data_pedido DESC;

-- UPDATES -- 
-- Atualizar preço de um produto
UPDATE Produto
SET preco = preco + 50
WHERE id_produto = 1;

-- Aumentar o estoque de um produto
UPDATE QuantidadeEstoque
SET quantidade = quantidade + 10
WHERE id_produto = 3;

-- Alterar o transporte de um pedido
UPDATE Pedido
SET id_transporte = 2
WHERE id_pedido = 3;

-- DELETES --
-- Deletar um item de pedido específico
DELETE FROM ItensPedido
WHERE id_item = 4;

-- Remover um cliente
DELETE FROM Cliente
WHERE id_cliente = 3;

-- Deletar produtos sem estoque cadastrado
DELETE FROM Produto
WHERE id_produto NOT IN (SELECT id_produto FROM QuantidadeEstoque);