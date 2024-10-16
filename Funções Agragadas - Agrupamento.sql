--FUNCOES AGREGADAS - OPERAM EM GRUPOS DE LINHAS E RETORNAM **UMA LINHA** DE SAIDA
--VALORES NULOS S�O IGNORADOS PELAS FUNCOES AGREGADAS.
--USO DA PALAVRA DISTINCT EM UMA FUN��O AGRAGADA PARA EXCLUIR ENTRADAS DUPLICADAS

--AVG - OBTEM O VALOR M�DIO DE X
SELECT AVG(preco)
FROM tb_produtos;
--19,73083333333333333333333333333333333333

SELECT AVG(preco)+2
FROM tb_produtos;
--21,73083333333333333333333333333333333333

--USO DA PALAVRA DISTINCT PARA EXCLUIR VALORES ID�NTICOS AO CALCULAR A M�DIA
SELECT AVG(DISTINCT preco)
FROM tb_produtos;
--20,29818181818181818181818181818181818182

--COUNT - OBTEM O N�MERO DE LINHAS RETORNADAS POR UMA CONSULTA
SELECT COUNT(id_produto)
FROM tb_produtos;
--EVITAR O USO DE * NA FUN��O COUNT

--MAX & MIN - OBTEM OS VALORES M�XIMOS E M�NIMOS 
SELECT MAX(preco), MIN(preco)
FROM tb_produtos;
--49,99	& 10,99

--� PERMITIDO USAR COM QUALQUER TIPO DE DADOS.
--COM STRINGS S�O CLASSIFICADOS EM ORDEM ALFAB�TICA
SELECT MAX(nm_produto), MIN(nm_produto)
FROM tb_produtos;
--Z Files & 2412: The Return

--A DATA M�XIMA OCORRE NO PONTO MAIS RECENTE NO TEMPO E A DATA M�NIMA , NO PONTO MAIS ANTIGO
SELECT MAX(dt_nascimento), MIN(dt_nascimento)
FROM tb_clientes;
--16/03/71 & 01/01/65

--STDDEV - STDDEV � uma fun��o estat�stica que calcula o desvio padr�o de um conjunto de dados, geralmente usada em consultas SQL em bancos de dados. 
--O desvio padr�o � uma medida de dispers�o que indica o quanto os valores de um conjunto se afastam, em m�dia, do valor m�dio (m�dia aritm�tica).
SELECT STDDEV(preco)
FROM tb_produtos;

--SUM - SOMA TODOS OS VALORES PRESENTES EM X
SELECT SUM(preco)
FROM tb_produtos;
--236,77

---------------------------------------------------------------------------------

--AGRUPANDO LINHAS:
--PERMITE AGRUPAR LINHAS EM UMA TABELA PARA OBTER ALGUMA INFORMA��O SOBRE ESSE GRUPO
--POR EXEMPLO: OBTER O PRE�O M�DIO DOS DIFERENTES TIPOS DE PRODUTOS DA TB_PRODUTOS
             --FACILITADOR: USO DO GROUP BY PARA AGRUPAR AS LINHAS SEMELHANTES 
--AGRUPAR AS LINHAS DA TB_PRODUTOS EM BLOCOS COM O MESMO VALOR DE ID_TIPO_PRODUTO
SELECT id_tipo_produto
FROM tb_produtos
GROUP BY id_tipo_produto;

--MOSTRAR O ID_PORDUTO E O ID DO CLIENTE QUE COMPROU O PRODUTO
SELECT id_produto, id_cliente
FROM tb_compras
GROUP BY id_produto, id_cliente;

--OBTER O NUMERO DE LINHAS COM O MESMO VALOR DE ID_TIPO_PRODUTO DA TB_PRODUTOS
SELECT id_tipo_produto, COUNT(ROWID)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

--OBTER OS TIPOS DE ITENS QUE TEM PRECO M�DIO MAIOR QUE 20
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) > 20
ORDER BY id_tipo_produto;

--NAO � PERMITIDO USAR UMA FUNCAO AGREGADA PARA LIMITAR A CLAUSULA WHERE
--USANDO A CLAUSULA WHERE E GROUP BY JUNTAS
    --PRIMEIRO O WHERE FITRA AS LINHAS E RETORNADAS E POSTERIORMENTE O GROUP BY AGRUPA AS LINHAS RESTANTES EM BLOCOS
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE preco < 15.00
GROUP BY id_tipo_produto
ORDER BY id_tipo_produto;

--USANDO A CLAUSULA WHERE , HAVING E GROUP BY JUNTAS
    --PRIMEIRO A CLAUSULA WHERE LMITA AS LINHAS, DEPOIS O GROUP BY AGRUPA E POR FIM O HAVING FILTA OS GRUPOS DE LINHAS
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
WHERE preco < 15.00
GROUP BY id_tipo_produto
HAVING AVG(preco) > 13.00
ORDER BY id_tipo_produto;