-- Data (11/09/2024)


SELECT TO_CHAR(12345.67, '99999.99EEEE')
FROM dual;

SELECT TO_CHAR(0012345.6700, 'FM99999.99')
FROM dual;


SELECT TO_CHAR(12345.67, 'L99,999.99')
FROM dual;


SELECT TO_CHAR(-12345.67, '99,999.99MI')
FROM dual;

SELECT TO_CHAR(-12345.67, '99,999.99PR')
FROM dual;


SELECT TO_CHAR(2024, 'RN')
FROM dual;


SELECT TO_CHAR(12345.67, 'S99999.99')
FROM dual;


SELECT TO_CHAR(12345.67, 'U99,999.99')
FROM dual;


SELECT TO_CHAR(12345.67, '99999V99')
FROM dual;


SELECT TO_CHAR(12345678.90, '99,999.99')
FROM dual;

SELECT id_produto, 'O preço do produto é: ' || TO_CHAR(preco, 'L99.99')
FROM tb_produtos
WHERE id_produto < 5;


SELECT TO_NUMBER('970,13')
FROM dual;

SELECT TO_NUMBER('970,13') + 25.50
FROM dual;

SELECT '970,13' + 25.50
FROM dual;


SELECT TO_NUMBER('-$12,345.67', '$99,999.99')
FROM dual;

SELECT
   CAST(12345.67 AS VARCHAR2(10)),
   CAST('9A4F' AS RAW(2)),
   CAST('01-DEZ-2007' AS DATE),
   CAST(12345.678 AS NUMBER(10,2))
FROM dual;


SELECT 
   CAST(preco AS VARCHAR2(10)),
   CAST(preco + 2 AS NUMBER(7,2)),
   CAST(preco AS BINARY_DOUBLE)
FROM tb_produtos
WHERE id_produto = 1;


SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_clientes
WHERE REGEXP_LIKE(TO_CHAR(dt_nascimento, 'YYYY'), '196[5-8]$');


SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_clientes
WHERE REGEXP_LIKE(nome, 'j', 'i');


SELECT
   REGEXP_INSTR('Teste de expressão regular', 'e', 6, 2) AS resultado
FROM dual;


SELECT 
   REGEXP_REPLACE('Teste de expressão regular', 
                  'd[[:alpha:]]{1}', 'Oracle') AS resultado
FROM dual;


SELECT
   REGEXP_SUBSTR('Teste de expressão regular', 'e[[:alpha:]]{8}') AS resultado
FROM dual;


SELECT 
  REGEXP_COUNT('teste teste teste expressão regular', 't[[:alpha:]]{4}') AS resultado
FROM dual;


SELECT AVG(preco)
FROM tb_produtos;

SELECT CAST(AVG(preco) AS NUMBER(5,2)) "Média de Preço"
FROM tb_produtos;


SELECT AVG(preco + 2.00)
FROM tb_produtos;



SELECT AVG(DISTINCT preco)
FROM tb_produtos;


SELECT COUNT(id_produto)
FROM tb_produtos;


SELECT COUNT(ROWID)
FROM tb_produtos;


SELECT nm_produto, preco
FROM tb_produtos
WHERE preco = (SELECT MAX(preco)
               FROM tb_produtos);

