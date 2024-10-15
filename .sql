--SUBCONSULTAS
--SUBCONSULTAS QUE MANIPULAM UMA UNICA LINHA - É AQUELA QUE RETORNA ZERO OU UMA LINHA PARA A INSTRUÇÃO SQL EXTERNA
--PODE SER INSERIDA EM UMA CLÁUSULA WHERE, HAVING OU FROM DE UM SELECT

--recuperar os valores de nome e sobrenome da tb_clientes, cujo valor do sobrenome seja "blue"
SELECT nome, sobrenome
FROM tb_clientes
WHERE id_cliente = (SELECT id_cliente 
                    FROM tb_clientes   
                    WHERE sobrenome = 'Blue');

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos);
               
--SUBCONSULTAS USANDO A CLAUSULA HAVING (usado para filtrar grupos de linhas)
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

--SUBCONSULTA EM UMA CLÁUSULA FROM - esses tipos de subconsultas tambem são conhecids como visoes inline
--exemplo: RECUPERARA OS PRODUTOS CUJO VALOR DE ID_PRODUTO SEJA MENOR QUE 3
SELECT id_produto
FROM (SELECT id_produto
      FROM tb_produtos
      WHERE id_produto < 3); 
    
SELECT p.id_produto, preco, dados_compra.count_produto
FROM tb_produtos p, (SELECT id_produto, COUNT(id_produto) count_produto
                    FROM tb_compras
                    GROUP BY id_produto) dados_compra
WHERE p.id_produto = dados_compra.id_produto;


--SUBCONSULTA DE VARIAS LINHAS