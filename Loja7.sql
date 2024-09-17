--FUNCOES DE UMA LINHA SO 
--ASCII - A função ASCII retorna o código ASCII, ou o ponto de código Unicode, do primeiro caractere na string que você especificar. 
SELECT ASCII('a')
FROM dual;

--CHR - Retorna uma Cadeia de Caracteres que contém o caractere associado ao código de caractere especificado .
SELECT CHR(97)
FROM dual;

--CONCAT - Permite anexar 2 valores retornando um novo string 
SELECT CONCAT(nome, sobrenome)
FROM tb_funcionarios; 

--INITCAP - Converte a letra inicial de cada palavra em maiusculo
SELECT id_produto, INITCAP(ds_produto)
FROM tb_produtos;

--INSTR - Procura o string em "x", retornando a posicao
SELECT nm_produto, INSTR(nm_produto, 'Science')
FROM tb_produtos
WHERE id_produto = 1;

SELECT nm_produto, INSTR(nm_produto, 'e', 1,2)
FROM tb_produtos
WHERE id_produto = 1;

--LENGTH - Obtem o numero de caracteres
SELECT nm_produto, LENGTH(nm_produto)
FROM tb_produtos;

--LOWER e UPPER - Converte para maiusculo e minusculo
SELECT UPPER(nome), LOWER(sobrenome)
FROM tb_funcionarios;

--LPAD e RPAD - Preenche um valor com espaços a esquerda e direita
SELECT RPAD(nm_produto,30,'.'), LPAD(preco,8, '*+')
FROM tb_produtos
WHERE id_produto <4;

--TRIM - Corta a esquerda e a direita de 'x'
SELECT
    LTRIM('  Tudo normar'),
    RTRIM('Ola pessoar!abcabc','abc'),
    TRIM('0' FROM '00SCIBIRIDOM0000')
FROM dual;

--NVL - Retorna um valor caso 'x' seja nulo
SELECT id_cliente, NVL(telefone, 'Telefone inexistente')
FROM tb_clientes
ORDER BY id_cliente DESC;

--NVL2 - Retorna um valor caso 'x' nao seja nulo, caso contrario retorna outro valor
SELECT id_cliente, NVL2(telefone, 'Telefone existente', 'Telefone não existente')
FROM tb_clientes
ORDER BY id_cliente DESC;

--REPLACE - Substitiu uma string por outra
SELECT REPLACE(nm_produto, 'Science', 'Physics')
FROM tb_produtos
WHERE id_produto = 1;

--SOUNDEX - Obtem um string contendo a representação fonética de um valor
SELECT sobrenome
FROM tb_clientes
WHERE SOUNDEX(sobrenome) = SOUNDEX('whyte');

--SUBSTRING - returna um substring de 'x' que inicia na posicao determinada
SELECT nm_produto, SUBSTR(nm_produto,2,7) -- A partir da 2 posição, pegar mais 7. Pode ser passados valores literais 
FROM tb_produtos
WHERE id_produto<4;

--MESCLAGEM DE FUNCOES
SELECT nm_produto, UPPER(SUBSTR(nm_produto,2,8))
FROM tb_produtos
WHERE id_produto < 4;

-- FUNCOES NUMERICAS
--ABS - Obtem um valor absoluto 
SELECT id_produto, preco, preco -30, abs(PRECO - 30)
FROM tb_produtos
WHERE id_produto < 4;

--CEIL - Obtem o menor inteiro maior ou igual a 'x' - FLOOR - arredondamento inferior.
SELECT CEIL(5.8), CEIL(-5.2)
FROM dual;

--MOD - obtem o resto da divisao de dois valores
SELECT MOD(8,3), MOD(8,4)
FROM dual;

--POWER - Potência
SELECT POWER(2,1), POWER(2,2)
FROM dual;

--ROUND - obtem o resultado do arredondamento de um valor com 'x' casas decimais
SELECT ROUND(5.5), ROUND(5.52,1), ROUND(5.75,-1)
FROM dual;

--SIGN - Obtem o sinal -RETORNA -1 OU 1 
SELECT SIGN(-5), SIGN(3), SIGN(0)
FROM dual;

--SQRT - Obtem a raiz de um numero
SELECT SQRT(25)
FROM dual;

SELECT ROUND(SQRT(5),2)
FROM dual;

--TRUNC - Limitar as casas decimais. 
SELECT TRUNC(5.75), TRUNC(5.75, 1), TRUNC(5.75, -1)
FROM dual;

--TO_CHAR - converte um valor em uma string
SELECT TO_CHAR(123.45)
FROM dual;

SELECT TO_CHAR(1234.56, '9,999.99') 
FROM dual;