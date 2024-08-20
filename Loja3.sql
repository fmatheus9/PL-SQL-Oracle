INSERT INTO tb_grades_salarios(id_salario, base_salario, teto_salario, fg_ativo)
VALUES
(1, 1, 2500.00, 1);

INSERT INTO tb_grades_salarios(id_salario, base_salario, teto_salario, fg_ativo)
VALUES
(2, 2500.01, 5000.00, 1);

INSERT INTO tb_grades_salarios(id_salario, base_salario, teto_salario, fg_ativo)
VALUES
(3, 5000.01, 7500.00, 1);

INSERT INTO tb_grades_salarios(id_salario, base_salario, teto_salario, fg_ativo)
VALUES
(4, 7500.011, 9999.99, 1);

COMMIT;

SELECT *
FROM tb_grades_salarios

--INSTRUÇÃO UPDATE -> USADA PARA ALTERAR TUPLAS EM TABELAS DO BD 
    --EM UMA INSTRUÇÃO DE UPDATE PODEMOS ESPECIFICAR AS SEGUINTES INFORMAÇÕES: A TABELA QUE CONTEM AS LINHAS A SEREM ALTERADAS
    --UMA CLAUSULA WHERE ESPECIFICANDO AS LINHAS A SEREM ALTERADAS
    --UMA LISTA DE NOMES DE COLUNAS, JUNTO COM SEUS NOVOS VALORES, ESPECIFICADO COM A CLAUSULA SET
    --OBS:ROLLBACK DESFAZ AS ALTERAÇÕES
    
--EXEMPLO ATUALIZAR O SOBRENOME PARA "Orange" DO CLIENTE CUJO ID CORRESPONDE AO NÚMERO 2
UPDATE tb_clientes
SET sobrenome = 'Orange'
WHERE id_cliente =2;

SELECT *
FROM tb_clientes

ROLLBACK;

--INSTRUÇÃO DELETE -> REMOVE TUPLAS DE UMA TABELA EM UM BANCO DE DADOS
    --A CLAUSULA WHERE LIMITA AS LINHAS QUE SE DESEJA EXCLUIR, CASO CONTRARIO TODAS AS LINHAS SERÃO EXCLUIDAS DA TABELA
    
--EXEMPLO REMOVER O CLIENTE QUE POSSUI O ID EQUIVALENTE A 2
DELETE 
FROM tb_clientes
WHERE id_cliente = 2; 
--Rollback concluído.
--Erro a partir da linha : 42 no comando -
--DELETE 
--FROM tb_clientes
--WHERE id_cliente = 2
--Relatório de erros -
-- -->ORA-02292: restrição de integridade (LOJA.FK_TB_COMPRAS_ID_CLIENTE) violada - registro filho localizado

--INSTRUÇÃO PL/SQL --> LINGUAGEM PROCEDURAL DA ORACLE
    --Procedure é basicamente um bloco de código que executa alguma ação dentro do nosso banco de dados, 
    --é um conjunto de comando que podemos executar de uma vez e ele faz determinada tarefa.
    --PERMITE ADICIONAR PROGRAMAÇÃO EM TORNO DE INSTRUÇOES SQL
    --USADO PRINCIPALMENTE PARA CRIAÇÃO DE PROCEDURES E FUNCTIONS EM UM BD
--CODIGO PL/SQL: 
    --DECLARAÇÃO DE VARIAVEIS
    --LOGICA CONDICIONAL
    --LOOPS
    --PROCEDURES E FUNCTIONS

--ESSE PROCEDURE CHAMADO DE "get_cliente" RETORNA O VALOR DE NOME E SOBRENOME DE UMA LINHA SE O ID PASSADO COMO PARÂMETRO "p_id_cliente" FOR ENCONTRADO

create or replace PROCEDURE get_cliente(p_id_cliente IN tb_clientes.id_cliente%TYPE) AS
v_nome      tb_clientes.nome%TYPE; --TIPO DE DADOS DO v_nome = tipo de dados do atributo nome na tabela clientes
v_sobrenome tb_clientes.sobrenome%TYPE;
v_controle  INTEGER;

BEGIN
SELECT COUNT(1) INTO v_controle
FROM tb_clientes
WHERE id_cliente = p_id_cliente;

IF(v_controle = 1) THEN
 --OS VALORES DE NOME, SOBRENOME SÃO ATRIBUIDOS PARA AS VARIAVEIS v_nome,v_sobrenome. Na tabela cliente onde o id_cliente for igual ao p_id_cliente
    SELECT nome, sobrenome INTO v_nome, v_sobrenome
    FROM tb_clientes
    WHERE id_cliente = p_id_cliente;
    
    --DBMS_OUTPUT.PUT_LINE = print
    DBMS_OUTPUT.PUT_LINE('Cliente localizado: ' || v_nome || ' ' || v_sobrenome);

ELSE
    DBMS_OUTPUT.PUT_LINE('Cliente não localizado');
END IF;

--EXCEPTION TREATMENT
EXCEPTION 
  WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('Erro!!!'); 
END get_cliente;


-- Invocando o objeto "get_c liente" por meio da saída DBMS OUTPUT
-- Menu: Exibir > Saída Dbms
CALL get_cliente(1);

CALL get_cliente(90);

-- Invocando o objeto "get_cliente" por meio de um bloco anônimo
SET serveroutput ON
BEGIN
  get_cliente(3);
END;

SET serveroutput ON
BEGIN
  get_cliente(99);
END;

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (5, 2, 'Rob', 'Green', 'Sales Person', 400000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (6, 4, 'Jane', 'Brown', 'Support Person', 450000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (7, 4, 'John', 'Grey', 'Support Manager', 300000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (8, 7, 'Jean', 'Blue', 'Support Person', 290000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES (9, 6, 'Henry', 'Heyson', 'Support Person', 300000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES (10, 1, 'Kevin', 'Black', 'Ops Manager', 100000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES (11, 10, 'Keith', 'Long', 'Ops Person', 500000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES (12, 10, 'Frank', 'Howard', 'Ops Person', 450000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES (13, 10, 'Doreen', 'Penn', 'Ops Person', 470000, 1);

-- commit the transaction
COMMIT;

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES (6, 2, 'Z Files', 'Series on mysterious activities', 49.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES (7, 2, '2412: The Return', 'Aliens return', 14.95, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (8, 3, 'Space Force 9', 'Adventures of heroes', 13.49, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES (9, 3, 'From Another Planet', 'Alien from another planet lands on Earth', 12.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (10, 4, 'Classical Music', 'The best classical music', 10.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES (11, 4, 'Pop 3', 'The best popular music', 15.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES (12, 4, 'Creative Yell', 'Debut album', 14.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES (13, NULL, 'My Front Line', 'Their greatest hits', 13.49, 1);

-- commit the transaction
COMMIT;

CREATE TABLE tb_promocao (
  id_promocao        INTEGER CONSTRAINT pk_promocao PRIMARY KEY,
  nome               VARCHAR2(30) NOT NULL,
  duracao            INTERVAL DAY(3) TO SECOND (4)
);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(1, '10% off Z Files', INTERVAL '3' DAY);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(2, '20% off Pop 3', INTERVAL '2' HOUR);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(3, '30% off Modern Science', INTERVAL '25' MINUTE);
INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(4, '20% off Tank War', INTERVAL '45' SECOND);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(5, '10% off Chemistry', INTERVAL '3 2:25' DAY TO MINUTE);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(6, '20% off Creative Yell', INTERVAL '3 2:25:45' DAY TO SECOND);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(7, '15% off My Front Line', INTERVAL '123 2:25:45.12' DAY(3) TO SECOND(2));

COMMIT;

SELECT id_cliente, nome, sobrenome, dt_nascimento, telefone
FROM tb_clientes;

SELECT *
FROM tb_clientes;

--ESPECIFICANDO AS LINHAS A SEREM RECUPERADAS USANDO A CLÁUSULA WHERE
SELECT *
FROM tb_clientes
WHERE id_cliente = 2;

--IDENTIFICADORES DE LINHA --> CADA LINHA DE UMA TABELA NO ORACLE TEM UM IDENTIFICADOR EXCLUSIVO DENOMINADO ROWID
--RECUPERANDO AS COLUNAS ROWID E id_cliente EM UMA CONSULTA UTILIZANDO A TABELA tb_clientes
SELECT ROWID, id_cliente
FROM tb_clientes;