--OPERADORES DE CONJUNTO:
    --PERMITEM COMBINAR AS LINHAS RETORNADAS POR DUAS OU MAIS CONSULTAS
    --O NUMERO DE COLUNAS E OS TIPOS DE COLUNAS RETORNADOS PELAS CONSULTAS DEVEM CORRESPONDER, EMBORA OS NOMES COLUNAS POSSAM SER DIFERENTES

--USANDO OS OPERADORES DE CONJUNTO:
--UNION ALL: RETORNA TODAS AS LINHAS RECUPERADAS PELAS CONSULTAS, INCLUINDO AS LINHAS DUPLICADAS
--EXEMPLO: RECUPERANDO TODAS AS LINHAS DE TB_PRODUTOS E TB_MAIS_PRODUTOS
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION ALL
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

--UNION: RETORNA SOMENTE AS LINHAS NAO DUPLICADAS
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION 
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

--INTERSECT: RETORNA SOMENTE AS LINHAS RECUPERADAS PELAS DUAS CONSULTAS - INTERSECÇÃO 
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
INTERSECT 
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

--OPERADOR MINUS: RETORNA AS LINHAS RESTANTES, QUANDO AS LINHAS RECUPERADAS PELA SEGUNDA CONSULTA SÃO SUBTRAIDAS DAS LINHAS RECUPERADAS PELA PRIMEIRA
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
MINUS 
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

--COMBINANDO OPERADORES DE CONJUNTO - PERMITE A COMBINAÇÃO DE MAIS DE DUAS CONSULTAS COM VARIOS OPERADORES DE CONJUNTO
(SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos 
UNION --UNIAO DAS DUAS TABELAS 
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos)
INTERSECT --PEGA SOMENTE OQ TEM EM COMUM
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_alteracoes_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos 
UNION --UNIAO DAS DUAS TABELAS 
(SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos
INTERSECT --PEGA SOMENTE OQ TEM EM COMUM
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_alteracoes_produtos);

--CONSULTAS AVANÇADAS
--TRANSLANTE(X,DA_STRING,PARA_STRING): CONVERTE AS OCORRENCIAS DOS CATACTERES EM "DA_STRING" ENCONTRADAS EM X NOS CARACTERES CORRESPONDENTES EM "PARA_STRING"
--EXEMPLO: USO DO TRANSLATE PARA DESLOCAR QUETRO CASAS PARA A DIREITA CADA CARACTERE NO STRING. 
SELECT TRANSLATE('MENSAGEM SECRETA','ABCDEFGHIJKLMNOPQRSTUVWXYZ','EFGHIJKLMNOPQRSTUVWXYZABCD')
FROM dual;

SELECT TRANSLATE('QIRWEKIQ WIGVIXE','EFGHIJKLMNOPQRSTUVWXYZABCD','ABCDEFGHIJKLMNOPQRSTUVWXYZ')
FROM dual;

SELECT id_produto, TRANSLATE(nm_produto, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', 'EFGHIJKLMNOPQRSTUVWXYZABCDefghijklmnopqrstuvwxyzabcd')
FROM tb_produtos;

SELECT TRANSLATE(12345,54321,67890)
FROM dual;

--DECODE:
--DECODE( expressão, valor_comparado1, resultado1, valor_comparado2, resultado2, ..., valor_padrão )
--expressão: É o valor ou a coluna que será comparada.
--valor_comparado: São os valores que a expressão será comparada.
--resultado: É o valor a ser retornado caso a expressão seja igual ao valor_comparado.
--valor_padrão: É o valor opcional retornado caso nenhuma das comparações seja verdadeira.
SELECT DECODE(1,1,2,3)
FROM dual;

SELECT id_produto, disponivel, DECODE(disponivel, 'Y', 'Produto está disponível', 'Produto NAO está disponível')
FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto, DECODE(id_tipo_produto, 1, 'BOOK', 2, 'VIDEO', 3, 'DVD', 4, 'CD', 'MAGAZINE')
FROM tb_produtos;

--FUNÇÃO ANALOGA DO DECODE - CASE: EXECUTA A LOGICA IF-THEN-ELSE
    --CASE SIMPLES: CASE expression
                        --WHEN 1 THEN X
                        --WHEN 2 THEN Y
                        --WHEN 3 THEN Z
                        --ELSE A
                    --END
SELECT id_produto, id_tipo_produto, 
    CASE id_tipo_produto
        WHEN 1 THEN 'Book'
        WHEN 2 THEN 'Video'
        WHEN 3 THEN 'DVD'
        WHEN 4 THEN 'CD'
        ELSE 'Magazine'
    END AS "CASE"
FROM tb_produtos;

    --CASE PESQUISADO
SELECT id_produto, id_tipo_produto,
    CASE 
        WHEN id_tipo_produto = 1 THEN 'Book'
        WHEN id_tipo_produto = 2 THEN 'Video'
        WHEN id_tipo_produto = 3 THEN 'DVD'
        WHEN id_tipo_produto = 4 THEN 'CD'
        ELSE 'Magazine'
    END AS "CASE"
FROM tb_produtos;
    
 
SELECT id_produto, preco, 
    CASE 
        WHEN preco > 15.00 THEN 'Caro'
        ELSE 'Barato'
    END
FROM tb_produtos;


--CONSULTAS HIERARQUICAS:
    --POSSIBILITA ORGANIZAR DADOS DE FORMA HIERARQUICA
--CLAUSULAS CONNECT BY E START WITH
SELECT LEVEL, id_funcionario, id_gerente, nome,sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY LEVEL;
        
SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;