--PSEUDOCOLUNA ROWNUM - REORNA O NÚMERO DE LINHA EM UM CONJUNTO DE RESULTADOS
SELECT ROWNUM, id_cliente, nome, sobrenome
FROM tb_clientes;

SELECT ROWNUM, id_cliente, nome, sobrenome
FROM tb_clientes
WHERE id_cliente = 3;

--CALCULO ARITIMÉTICO - POSSIBILIDADE DE EFETUAR CALCULOS EM INSTRUÇOES SQL
SELECT 2 * 6
FROM dual;

SELECT 10 * 12 / 3 - 1  
FROM dual;

SELECT 10 * (12 / 3 - 1)
FROM dual;

--PODEMOS USAR OPERADORES EM DATAS - PERMITE SOMAR UM NÚMERO REPRESENTADO UM DETERMINDAO NÚMERO DE DIAS EM UMA DATA
--SOMAR DOIS DIAS A 22 DE JULHO DE 2014
SELECT TO_DATE('22/JUN/2014') + 2
FROM dual;

SELECT TO_DATE('31/DEZ/2014') - TO_DATE('22/JUN/2014')
FROM dual;

--OS OPERADORES NAO PRECISAM SER NUMEROS OU DATAS PODEM SER COLUNAS DE UMA TABELA QUALQUER
SELECT nm_produto, preco, preco+20
FROM tb_produtos;

--TABELA DUAL - TABELA DEF
SELECT *
FROM dual;

DESCRIBE dual;

--USANDO 'ALIAS' 
SELECT preco, preco*2 DOBRO_PRECO
FROM tb_produtos;

SELECT preco, preco*2 "dobro preco"
FROM tb_produtos;

--A PALAVRA 'AS' É OPCIONAL 

SELECT preco, preco*2 AS "dobro preco"
FROM tb_produtos;

--CONCATENAÇÃO  -> PERMITE COMBINAR OS VALORES DE COLUNAS USANDO ||
SELECT nome || ' ' || sobrenome AS "Nome Completo"
FROM tb_clientes;

--DESAFIO DE AULA: EXIBIR UM RELATORIO DA SEGUNTE FORMA: "O FUNCIONARIO _____ RECEBE -SALARIO-, MAS GOSTARIA DE RECEBER -SALARIO- x 3
SELECT 'O funcionário ' || nome || ' ' || 
        sobrenome || 'recebe R$' || salario || 
        ', mas gostaria de receber R$' || 
        salario*3 AS "Salario Resultante" 
FROM tb_funcionarios;

--VALORES NULOS -- REPRESENTAÇÃO DE UM VALOR TOTALMENTE DESCONHECIDO
--NÃO É UMA STRING VAZIA, E SIM UM VALOR UNICO 

SELECT *
FROM tb_clientes;

SELECT id_cliente, nome,sobrenome,dt_nascimento
FROM tb_clientes
WHERE dt_nascimento IS NULL;

SELECT id_cliente, nome,sobrenome,telefone
FROM tb_clientes
WHERE telefone IS NULL;

--NVL -RETORNA OUTRO VALOR NO LLUGAR DE UM VALOR NULO
SELECT id_cliente, nome, sobrenome,NVL(telefone, 'Numero do telefone desconhecido') AS "Numero do telefone"
FROM tb_clientes;

SELECT id_cliente, nome, sobrenome, 
       NVL(dt_nascimento, '22/JUN/2013') AS "Datas de Nascimento"
FROM tb_clientes;

--FUNCAO LENGTH 
--FUNCAO NULLIF - COMPARA 2 VALORES E CASO SEJAM IGUAIS ADICIONA NULL NO ATRIBUTO RESULTADO.
SELECT nome, LENGTH(nome) AS "expressão 1",
       sobrenome, LENGTH(sobrenome) AS "expressão 2",
       NULLIF(LENGTH(nome), LENGTH(sobrenome)) as "resultado"
FROM tb_funcionarios;

--FUNCAO COALESCE -- VANTAGEM SOBRE A FUNCAO NVL JA QUE PODE ASSUMIR VARIOS VALORES. SE A PRIMEIRA EXPRESSÃO NAO FOR NULA, A FUNCAO COALESCE RETURNA ESSA EXPRESSÃO
--CASO CONTRARIO ELA REALIZA UM COALESCE DAS EXPRESSOES RESTANTES
SELECT nome, sobrenome, COALESCE(dt_nascimento, TO_DATE('2108/2024')) AS "Exemplo"
FROM tb_clientes;

--EXIBINDO LINHAS DISTINTAS - ELIMINA DUPLICATAS
--listar os clientes que comprarm produtos na nossa loja virtual
--recuperar a coluna id_cliente da tabela tb_compras
SELECT DISTINCT id_cliente
FROM tb_compras;

--COMPARANDO VALORES NO SQL
--RECUPERAR AS LINHAS DA TABELA CLIENTES CUJO VALOR NA CULONA ID CLIENTE SEJA DIFERENTE DE 2
SELECT *
FROM tb_clientes
WHERE id_cliente <> 2;

--RECUPERAR AS COLUNAS  ID PRODUTO E NOME DO PRODUTO ONDE A COLUNA ID PRODUTO SEJA MAIOR QUE 2
SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto > 2;

--USANDO A PSEUDOCOLUNA ROWNUM E O OPERADOR <= PARA RECUPERAR AS TRE PRIMEIRAS LINHAS DA TABELA TB_PRODUTOS
SELECT ROWNUM, id_produto, nm_produto
FROM tb_produtos
WHERE ROWNUM <= 3;

--USO DO OPERADOR ANY EM UMA CLAUSULA WHERE PARA COMPARAR UM VALOR COM QUALQUER UM DOS CALORES DE UMA LISTA - INCLUIR UM OPERADOR ANTES DO ANY
SELECT *
FROM tb_clientes
WHERE id_cliente > ANY(2,3,4);

--OPERADOR ALL - RECUPERAR AS LINHAS DA TABELA CLIENTE ONDE O VALOR DA COLUNA ID_CLIENTE É MAIOR QUE OS VALORES 2,3 OU 4
SELECT *
FROM tb_clientes
WHERE id_cliente > ALL(2,3,4);


