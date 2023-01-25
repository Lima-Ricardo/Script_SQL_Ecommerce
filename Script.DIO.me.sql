-- Criação das tabelas

CREATE TABLE cliente (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('PJ', 'PF')),
  cpf_cnpj VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE produto (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE vendedor (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cpf VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE fornecedor (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cnpj VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE pagamento (
  id SERIAL PRIMARY KEY,
  tipo VARCHAR(255) NOT NULL,
  numero_cartao VARCHAR(20) NOT NULL,
  validade DATE NOT NULL,
  cliente_id INTEGER NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

CREATE TABLE entrega (
  id SERIAL PRIMARY KEY,
  status VARCHAR(255) NOT NULL,
  codigo_rastreio VARCHAR(255) NOT NULL
);

CREATE TABLE pedido (
  id SERIAL PRIMARY KEY,
  data DATE NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  cliente_id INTEGER NOT NULL,
  vendedor_id INTEGER NOT NULL,
  entrega_id INTEGER NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES cliente (id),
  FOREIGN KEY (vendedor_id) REFERENCES vendedor (id),
  FOREIGN KEY (entrega_id) REFERENCES entrega (id)
);

CREATE TABLE produto_pedido (
  produto_id INTEGER NOT NULL,
  pedido_id INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  PRIMARY KEY (produto_id, pedido_id),
  FOREIGN KEY (produto_id) REFERENCES produto (id),
  FOREIGN KEY (pedido_id) REFERENCES pedido (id)
);

CREATE TABLE fornecedor_produto (
  fornecedor_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,
  PRIMARY KEY (fornecedor_id, produto_id),
  FOREIGN KEY (fornecedor_id) REFERENCES fornecedor (id),
  FOREIGN KEY (produto_id) REFERENCES produto (id)
);

-- Trigger Estoque

CREATE OR REPLACE FUNCTION reduzir_estoque() RETURNS TRIGGER AS $$
BEGIN
  UPDATE produto SET estoque = estoque - NEW.quantidade WHERE id = NEW.produto_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reduzir_estoque
AFTER INSERT ON produto_pedido
FOR EACH ROW
EXECUTE FUNCTION reduzir_estoque();

-- Trigger Confirmação de Venda 

CREATE OR REPLACE FUNCTION gerar_uid() RETURNS TRIGGER AS $$
BEGIN
  NEW.uid := md5(random()::text || clock_timestamp()::text);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER gerar_uid
BEFORE INSERT ON pedido
FOR EACH ROW
EXECUTE FUNCTION gerar_uid();

-- Esses triggers acima, são exemplos gerais, é necessário adaptar conforme sua necessidade.
-- Nota-se que o primeiro trigger, a cada nova inserção na tabela produto_pedido, ele ira diminuir o estoque do produto correspondente.
-- Já no segundo trigger, é gerado um UID único antes de cada nova inserção na tabela pedido.

