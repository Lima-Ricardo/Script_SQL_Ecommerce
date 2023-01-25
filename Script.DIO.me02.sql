
-- inserts da tabela cliente

INSERT INTO cliente (nome, tipo, cpf_cnpj) VALUES
('João Silva', 'PF', '111.111.111-11'),
('Maria Silva', 'PF', '222.222.222-22'),
('José da Silva', 'PF', '333.333.333-33'),
('Empresa LTDA', 'PJ', '44.444.444/0001-44'),
('Fulano de Tal', 'PF', '555.555.555-55'),
('Ciclano', 'PF', '666.666.666-66'),
('Empresa S/A', 'PJ', '77.777.777/0001-77'),
('Beltrano', 'PF', '888.888.888-88'),
('Empresa ME', 'PJ', '99.999.999/0001-99'),
('Outro cliente', 'PF', '000.000.000-00');

-- inserts da tabela produto

INSERT INTO produto (nome, descricao, preco) VALUES
('Produto 1', 'Descrição do produto 1', 10.50),
('Produto 2', 'Descrição do produto 2', 20.00),
('Produto 3', 'Descrição do produto 3', 30.00),
('Produto 4', 'Descrição do produto 4', 40.00),
('Produto 5', 'Descrição do produto 5', 50.00),
('Produto 6', 'Descrição do produto 6', 60.00),
('Produto 7', 'Descrição do produto 7', 70.00),
('Produto 8', 'Descrição do produto 8', 80.00),
('Produto 9', 'Descrição do produto 9', 90.00),
('Produto 10', 'Descrição do produto 10', 100.00);

-- inserts da tabela vendedor

INSERT INTO vendedor (nome, cpf) VALUES
('Vendedor 1', '111.111.111-11'),
('Vendedor 2', '222.222.222-22'),
('Vendedor 3', '333.333.333-33'),
('Vendedor 4', '444.444.444-44'),
('Vendedor 5', '555.555.555-55'),
('Vendedor 6', '666.666.666-66'),
('Vendedor 7', '777.777.777-77'),
('Vendedor 8', '888.888.888-88'),
('Vendedor 9', '999.999.999-99'),
('Vendedor 10', '000.000.000-00');

-- insert tabela fornecedor

INSERT INTO fornecedor (nome, cnpj) VALUES
('Fornecedor 1', '11.111.111/0001-11'),
('Fornecedor 2', '22.222.222/0002-22'),
('Fornecedor 3', '33.333.333/0003-33'),
('Fornecedor 4', '44.444.444/0004-44'),
('Fornecedor 5', '55.555.555/0005-55'),
('Fornecedor 6', '66.666.666/0006-66'),
('Fornecedor 7', '77.777.777/0007-77'),
('Fornecedor 8', '88.888.888/0008-88'),
('Fornecedor 9', '99.999.999/0009-99'),
('Fornecedor 10', '00.000.000/0010-00');

-- Abaixo as querys que respondem as perguntas do projeto.

-- 01 Quantos pedidos foram feitos por cada cliente?

SELECT cliente.nome, COUNT(pedido.id) as num_pedidos
FROM cliente
LEFT JOIN pedido ON cliente.id = pedido.cliente_id
GROUP BY cliente.id, cliente.nome
ORDER BY num_pedidos DESC;

-- 02 Algum vendedor também é fornecedor?

SELECT vendedor.nome, fornecedor.nome
FROM vendedor
LEFT JOIN fornecedor ON vendedor.nome = fornecedor.nome;

-- 04 Relação de produtos fornecedores e estoques

SELECT produto.nome, fornecedor.nome, produto.estoque
FROM produto
LEFT JOIN fornecedor_produto ON produto.id = fornecedor_produto.produto_id
LEFT JOIN fornecedor ON fornecedor_produto.fornecedor_id = fornecedor.id
ORDER BY produto.estoque;

-- 05 Relação de nomes dos fornecedores e nomes dos produtos

SELECT fornecedor.nome as fornecedor, produto.nome as produto
FROM fornecedor
LEFT JOIN fornecedor_produto ON fornecedor.id = fornecedor_produto.fornecedor_id
LEFT JOIN produto ON fornecedor_produto.produto_id = produto.id
ORDER BY fornecedor.nome, produto.nome;


