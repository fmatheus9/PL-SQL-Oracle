SELECT id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY id_divisao
ORDER BY id_divisao;

--ROLLUP: O ROLLUP é útil quando você quer calcular tanto subtotais quanto um total geral em uma única consulta.
SELECT id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

SELECT id_divisao, id_cargo, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

--CUBE: ESTENDE GROUP BY PARA RETORNAR AS LINHAS QUE CONTEM UM SUBTOTAL PARA TOAS AS COMBINAÇÕES DE COLUNAS, ALEM DE UM TOTAL GERAL
SELECT id_divisao, id_cargo, SUM(salario)
FROM tb_funcionarios_2
GROUP BY CUBE(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

--FUNCAO GOUPING - ACEITA UMA COLUNA E RETORNA 0-NAO NULO OU 1-NULO
SELECT GROUPING(id_divisao), id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

SELECT
    CASE GROUPING(id_divisao)
        WHEN 1 THEN 'Todas as divisões'
        ELSE id_divisao
    END AS DIVISAO, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

--DML - ALTERANDO CONTEUDO DAS TABLES
INSERT INTO tb_clientes(id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES(7,'Joaquim', 'Silva', '26-FEV-1977', '800-666-2522', 1);

SELECT *
FROM tb_clientes;

INSERT INTO tb_clientes
VALUES
(8, 'Jane', 'Green', '01-JAN-1970', '800-5559999', 1);

SELECT *
FROM tb_clientes;

INSERT INTO tb_clientes
VALUES
(9, 'Sophie', 'White', NULL, NULL, 1);

INSERT INTO tb_clientes
VALUES
(10, 'Kyle', 'O''Malley', NULL, NULL, 1);

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES(14,1,'The ''Great'' Gastby', NULL, 19.99, 1);

SELECT *
FROM tb_produtos;

--RECUPERAR AS COLUNAS NOME E SOBRENOME DO CLIENTE NUMERO 1 E FORNECER ESSAS COLUNAS PARA A INSTRUCAO INSERT
INSERT INTO tb_clientes(id_cliente, nome, sobrenome)
SELECT 11, nome, sobrenome
FROM tb_clientes
WHERE id_cliente = 1;

UPDATE tb_clientes
  SET sobrenome = 'Orange'
WHERE id_cliente = 2;

SELECT *
FROM tb_clientes
WHERE id_cliente = 2;

UPDATE tb_produtos
    SET preco = preco * 1.20,
    nm_produto = LOWER(nm_produto)
WHERE preco > 20.00;

SET SERVEROUTPUT ON
DECLARE media_preco_produto NUMBER;
BEGIN
    UPDATE tb_produtos
    SET preco = preco *0.75
    RETURNING AVG(preco) INTO media_preco_produto;
DBMS_OUTPUT.PUT_LINE('Valor da variável: ' || media_preco_produto);
END;

--DELETE - REMOVE A TUPLA INTEIRA 

DELETE
FROM tb_clientes
WHERE id_cliente = 10;

ROLLBACK;

