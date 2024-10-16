--SUBCONSULTAS

--TIPOS DE SUBCONSULTAS: 
    --UNICA LINHA: RETORNAM ZERO OU UMA LINHA PARA A INSTRUÇÃO SELECT EXTERNA. EXISTE UM CASO ESPECIAL E SUBCONSULTA DE UMA UNICA LINHA QUE CONTEM UMA COLUNA, CHAMADA DE SCALAR
    --VARIAS LINHAS: RETORNAM UMA OU MAIS LINHAS PARA A INSTRUÇÃO SQL EXTERNA.
        --Correlacionadas: referenciam uma ou mais colunas na instrução SQL externa. Elas são chamadas de subconsultas "correlacionadas" porque são relacionadas à instrução SQL externa por meio das mesmas colunas.
        --Aninhadas: inseridas dentro de outra subconsulta. É permitido aninhar subconsultas até uma profundidade de 255.
        
--SUBCONSULTAS DE UMA UNICA LINHA:
    --PODE SER INSERIDA EM UMA CLAUSULA WHERE, HAVING OU FROM 
    --EXEMPLO WHERE
SELECT nome, sobrenome
FROM tb_clientes
WHERE id_cliente = (SELECT id_cliente
                    FROM tb_clientes
                    WHERE sobrenome = 'Blue');
--ESSA SUBCONSULTA É EXECUTADA PRIMEIRO, E APENA UMA VEZ, E RETORNA O ID DO CLIENTE CUJO VALOR DO SOBRENOME = 'BLUE'
--O VALOR DO ID É 5, O QUAL É PASSADO PARA A CLAUSULA WHERE DA CONSULTA EXTERNA.
--OUTROS OPERADORES DE COMPARAÇÃO PODEM SER USADOS COMO: <>, <, >, =>, <=
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos);
--AVG(preco): 19,73083333333333333333333333333333333333
--ESSA SUBCONSULTA É UM EXEMPLO DE SUBCONSULTA ESCALAR POIS RETORNA EXATAMENTE UMA LINHA

--SUBCONSULTA USANDO HAVING:
    --HAVING - USADO PARA FILTRAR GRUPOS DE LINHAS
    --PERMITE INSERIR UMA SUBCONSULTA NA CALUSULA HAVING DE UMA CONSULTA EXTERNA
    --POSSIBILITA FILTRAR GRUPOS DE LINHAS COM BASE NO RESULTADO RETORNADO POR UMA SUBCONSULTA
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;
--RECUPERA O ID DO TIPO DO PRODUTO E O PRECO MEDIO DOS PRODUTOS CUJO PRECO MEDIO É MENOR QUE O MAXIMO DA MEDIA DOS GRUPOS DE MESMO TIPO DE PRODUTO

--SUBCONSULTA EM UMA CLAUSULA FROM (VISOES INLINE)
--EXEMPLO: RECUPERAR OS PRODUTOS CUJO VALOR DO ID SEJA MENOR QUE 3
SELECT id_produto
FROM (SELECT id_produto
      FROM tb_produtos
      WHERE id_produto < 3);
--A SAIDA DA SUBCONSULTA É APENAS UMA FONTE DE DADOS

SELECT p.id_produto, preco, dados_compra.count_produto
FROM tb_produtos p, (SELECT id_produto, COUNT(id_produto) count_produto
                     FROM tb_compras
                     GROUP BY id_produto) dados_compra
WHERE p.id_produto = dados_compra.id_produto;

--SUBCONSULTAS DE VARIAS LINHAS;
    --UMA CONSULTA DE VARIAS LINHAS RETORNA UMA OU MAIS LINHAS PARA UMA INSTRUÇÃO SLQ EXTERNA.
    --OS OPERADORES IN, ANY, ALL SAO USADOS PARA REALIZAR O TRATAMENTO DE UMA SUBCONSULTA QUE RETORNA VARIAS LINHAS

--OPERADOR IN
SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (1,2,3);
--UMA LISTA DE VALORES PODE VIR DE UM RESULTADO DE UMA SUBCONSULTA. PERMITE UTILIZAR O NOT PARA EXECUTAR A LOGICA OPOSTA

--VERIFICAR SE UM VALOR DE ID_PRODUTO SE ENCONTRA NA LISTA DE VALORES RETORNADOS NA SUBCONSULTA
SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (SELECT id_produto
                     FROM tb_produtos
                     WHERE nm_produto LIKE '%e%')
ORDER BY id_produto;

--OBTER OS PRODUTOS QUE NAO ESTAO NA TB_COMPRAS
SELECT id_produto, nm_produto
FROM tb_produtos 
WHERE id_produto NOT IN (SELECT id_produto
                         FROM tb_compras) --RETORNA OS IDs DA TABELA DE COMPRAS 
ORDER BY id_produto;             

--OPERADOR ANY
    --USADO PARA COMPARA UM VALOR COM QUALQUER VALOR PRESENTE EM UMA LISTA
    --PERMITE INSERIR UM OPERADOR LOGICO ANTES

--OPERADOR ALL
    --COMPARAR UM VALOR COM TODOS PRESENETES EM UMA LISTA
SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario > ALL (SELECT teto_salario
                     FROM tb_grades_salarios);

--POSSIBILIDADE DE ESCREVER SUBCONSULTAS QUE RETORNAM VARIAS COLUNAS 
--EXEMPLO: RECUPERAR OS PRODUTOS COM O MENOR PRECO PARA CADA GRUPO DE TIPO DE PRODUTO
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE (id_tipo_produto, preco) IN (SELECT id_tipo_produto, MIN(preco)
                                   FROM tb_produtos
                                   GROUP BY id_tipo_produto);
--É RETORNADO O VALOR DO ID_PRODUTO E O VALOR DO PRECO MINIMO PARA CADA GURPO DE PRODUTOS, ONDE OS MESMOS SAO COMPARADOS
--COM OS VALORES ID_TIPO_PRODUTO E PRECO PARA CADA PRODUTO DA CLAUSULA WHERE EXTERNA.

--SUBCONSULTAS CORELACIONADAS
    --REFERENCIA UMA OU MAIS COLUNAS NA INSTRUÇÃO SQL EXTERNA
    --É EXECUTADA UMA VEZ PARA CADA LINHA NA CONSULTA EXTERNA, DIFERENCIANDO-SE DA SUBCONSULTA NAO CORRELACIONADA
    --PERMITE TRABALHAR COM VALORES NULOS
--EXEMPLO: RECUPERAR TODOS OS PRODUTOS QUE POSUEM PREÇO MAIOR QUE A MÉDIA PARA O TIPO DE PRODUTO
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos interna
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);
--USAMOS O APELIDO EXTERNA PARA ROTULAR A CONSULTA EXTERNA E INTERNA PARA A SUBCONSULTA
--A REFERENCIA DA COLUNA ID_TIPO_PRODUTO NAS PARTES INTERNAS E EXTERNA É O QUE TORNA SUBCONSULTA CORRELACIONADA 
--CADA LINHA DA EXTERNA É PASSADA POR VEZ PARA A SUBCONSULTA

--USANDO EXISTS E NOT EXISTS 
    --VERIFICA A EXISTêNCIA DE LINHAS RETORNADAS POR UMA SUBCONSULTA
    --EXEMPLO: RECUPERAR FUNCIONARIOS QUE GERENCIAM OUTROS
SELECT id_funcionario, nome, sobrenome 
FROM tb_funcionarios externa
WHERE EXISTS (SELECT id_funcionario
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);
SELECT id_funcionario, nome, sobrenome 
FROM tb_funcionarios externa
WHERE EXISTS (SELECT 1
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);
              
--SUBCONSULTAS ANINHADAS
    --PERMITE ANINHAR SUBCONSULTAS DENTRO DE OUTRAS ATE UMA PROFUNDIDADE DE 255
    --EXEMPLO: CONTEM 3 SUBCONSULTAS
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     WHERE id_produtos IN (SELECT id_produto
                                           FROM tb_compras 
                                           WHERE quantidade > 1)
                     GROUP BY id_tipo_produto)
GROUP BY id_tipo_produto;