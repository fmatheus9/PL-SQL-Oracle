--JOIN
SELECT tb_produtos.nm_produto, tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto AND tb_produtos.id_produto = 3;

SELECT tb_produtos.nm_produto, tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto
ORDER BY tb_produtos.nm_produto;

--USANDO APELIDOS
SELECT p.nm_produto, tp.nm_tipo_produto
FROM tb_produtos p , tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

--PRODUTO CARTESIANO - OMISSAO DA CLAUSULA WHERE
SELECT p.id_tipo_produto, tp.id_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp;

SELECT c.nome, c.sobrenome, p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_clientes c, tb_produtos p, tb_tipos_produtos tp, tb_compras co
WHERE c.id_cliente = co.id_cliente AND p.id_produto = co.id_produto AND p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

SELECT f.nome, f.sobrenome, f.cargo, f.salario, gs.id_salario
FROM tb_funcionarios f, tb_grades_salarios gs
WHERE f.salario BETWEEN gs.base_salario AND gs.teto_salario
ORDER BY gs.id_salario;

--JUNCAO EXTERNA RECUPERA UMA LINHA MESMO QUANDO UMA DE SUAS CILUNAS CONTEM UM VALOR NULO
--O PRODUTO MY FRONT LINE CUJO ID_TIPO_PRODUTO É NULO.
--O OPERADOR + ESTA NO LADO OPOSTO DA COLUNA ID_TIPO_PRODUT NA TABELA TB_PRODUTOS
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto(+) 
ORDER BY 1;

--PODEM SER DIVIDIDAS ENTRE DIREITA E ESQUERDA 
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto (+)= tp.id_tipo_produto 
ORDER BY 1;

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto(+) = tp.id_tipo_produto(+) 
ORDER BY 1;
--ORA-01468: um predicado só pode fazer referência a uma tabela unidade externamente

--NOA É POSSIVEL USAR UMA JOIN EXTERNA NUM JOIN QUE ESTEJA USANDO O OPERADOR OR

SELECT f.nome || ' ' || f.sobrenome || ' trabalha para ' || NVL(g.nome, 'os acionistas') AS resultante
FROM tb_funcionarios f, tb_funcionarios g
WHERE f.id_gerente = g.id_funcionario (+)
ORDER BY f.sobrenome DESC;

SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp ON (p.id_tipo_produto = tp.id_tipo_produto)
ORDER BY p.nm_produto;

SELECT f.nome, f.sobrenome, f.cargo, f.salario, gs.id_salario
FROM tb_funcionarios f
INNER JOIN tb_grades_salarios gs ON (f.salario BETWEEN gs.base_salario AND gs.teto_salario)
ORDER BY gs.id_salario;

SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (id_tipo_produto);

SELECT c.nome, c.sobrenome, p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_clientes c
INNER JOIN tb_compras co USING (id_cliente)
INNER JOIN tb_produtos p USING (id_produto)
INNER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

--PRESERVA OS VALORES DA TABELA ESQUERDA(TB_PRODUTOS) MESMO QUANDO OS VALORES DO PREDICADO FALHAM.
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p LEFT
OUTER JOIN tb_tipos_produtos tp USING(id_tipo_produto)
ORDER BY p.nm_produto;

--PRESERVA OS VALORES DA TABELA DIREITA(TB_TIPOS_PRODUTOS) MESMO QUANDO OS VALORES DO PREDICADO FALHAM.
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p 
RIGHT OUTER JOIN tb_tipos_produtos tp USING(id_tipo_produto)
ORDER BY p.nm_produto;

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p 
FULL OUTER JOIN tb_tipos_produtos tp USING(id_tipo_produto)
ORDER BY p.nm_produto;

--USANDO VARIAVEIS
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto = &v_id_produto;

SELECT nm_produto, &v_coluna
FROM &v_tabela
WHERE &v_coluna = &v_id_produto;

--PARA EVITAR A DIGITAÇÃO REPETITIVA USAMOS O && EM UMA DETERMINADA VARIAVEL
SELECT nm_produto, &&v_coluna
FROM &v_tabela
WHERE &&v_coluna = &v_id_produto;

--DEFINIR UMA VARIAVEL NOMEADA v_id_produto, ATRIBUINDO O VALOR 7
DEFINE v_id_produto = 7;

SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;

--DEFINE UMA VARIAVEL NOMEADA DE V_ID COMO UM NUMERO DE NO MAXIMO DOIS DIGITOS
ACCEPT v_id NUMBER FORMAT 99 PROMPT 'Entre com o ID':
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto = &v_id;

DEFINE v_id_produto = 7;
SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;
UNDEFINE v_id_produto;

--POSIBILIDADE DE GERAR RELATORIOS USANDO VARIAVEIS EM UM SCRIPT SQL
    --CRIANDO O SCRIPT IDENTIFICADO COM teste1.sql
    --CRIADO EM UMA NOVA PLANILHA SQL
@ C:\temp\teste_1.sql
@ C:\temp\teste_2.sql
@ C:\temp\teste_3.sql 2

