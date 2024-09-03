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

