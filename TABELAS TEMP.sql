SELECT * 
FROM tb_status_encomenda_temp;

 --CRIANDO UMA TABELA USANDO SUBCONSULTA
 --CRIANDO A TABELA TB_FUNCIONARIOS_TESTE A PARTIR DE UMA SUBCONSULTA
CREATE TABLE tb_funcionarios_teste
AS
    SELECT id_funcionario, nome, salario
    FROM tb_funcionarios
    WHERE id_funcionario = 3;

SELECT *
FROM tb_funcionarios_teste;

 --RECUPERANDO TODAS AS COLUNAS DE USER_TABLES ONDE TABLE_NAME CORRESPONDE A TB_STATUS_ENCOMENDA_2 E TB_STATUS_ENCOMENDA_TEMP
SELECT table_name, tablespace_name, temporary
FROM user_tables
WHERE table_name IN('TB_STATUS_ENCOMENDA_2', 'TB_STATUS_ENCOMENDA_TEMP');

 --OBTENDO UNFORMAÇÕES SOBRE AS COLUNAS NAS TABLEAS POR MEIO DA VISAO USER_TAB_COLUMNS
SELECT column_name, data_type, data_length, data_precision, data_scale
FROM user_tab_columns
WHERE table_name = 'TB_PRODUTOS';

 --ADICIONANDO UMA COLUNA 
ALTER TABLE tb_status_encomenda_2
ADD modificado_por INTEGER;

DESCRIBE tb_status_encomenda_2;

ALTER TABLE tb_status_encomenda_2
ADD criado_inicialmente DATE DEFAULT SYSDATE NOT NULL;

 --ADICIONANDO UMA COLUNA VIRTUAL - REFERE-SE A COLUNAS EXISTENTES DE OUTRAS TABELAS
 ALTER TABLE tb_grades_salarios
 ADD (media_salarial AS ((base_salario + teto_salario)/2));
 
 DESCRIBE tb_grades_salarios;
 
 SELECT * 
 FROM tb_grades_salarios;
 
 --MODIFICANDO UMA COLUNA USANDO ALTER TABLE PARA:
    --ALTERANDO O COMPRIMENTO DA COLUNA "tb_status_encomenda_2.status" PARA 15 CARACTERES
ALTER TABLE tb_status_encomenda_2
MODIFY status VARCHAR2(15);
    --É PERMITIDO REDUZIR O COMPRIMENTO DE UMA COLUNA SE NAO HOUVER UMA LINHA NA TABELA OUSE TODAS AS COLUNAS CONTIVER VALORES NULOS
    
 --A INSTRUCAO ALTER TABLE ABAIXO ALTERA A PRECISAO DA COLUNA PARA 5
ALTER TABLE tb_status_encomenda_2
MODIFY id_status_encomenda NUMBER(5);
    --É PERMITIDO REDUZIR O COMPRIMENTO DE UMA COLUNA SE NAO HOUVER UMA LINHA NA TABELA OUSE TODAS AS COLUNAS CONTIVER VALORES NULOS
    
 --ALTERANDO O VALOR PADRAO DA COLUNA ultima_modificacao PARA SYSDATE -1
ALTER TABLE tb_status_encomenda_2
MODIFY ultima_modificacao DEFAULT (SYSDATE - 1);

ALTER TABLE tb_status_encomenda_2
MODIFY status CHAR(15);

 --EXCLUINDO A COLUNA criado_inicialmente
ALTER TABLE tb_status_encomenda_2
DROP COLUMN criado_inicialmente;

 --RESTRICAO CHECK
ALTER TABLE tb_status_encomenda_2
ADD CONSTRAINT ck_status_encomenda_2
    CHECK(status IN ('COLOCADO', 'PENDENTE', 'ENVIADO'));

INSERT INTO tb_status_encomenda_2(id_status_encomenda, status, ultima_modificacao, modificado_por)
VALUES(2, 'PENDENTE', '01-MAI-2013',1);

SELECT *
FROM tb_status_encomenda_2;

ALTER TABLE tb_status_encomenda_2
MODIFY status CONSTRAINT nn_status_encomenda_2 NOT NULL;

ALTER TABLE tb_status_encomenda_2
MODIFY modificado_por CONSTRAINT nn_status_encomenda_2_modificado_por NOT NULL;