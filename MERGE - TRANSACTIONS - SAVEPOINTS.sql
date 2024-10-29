CREATE TABLE tb_status_encomenda(
id_status_encomenda     INTEGER,
status                  VARCHAR2(40) DEFAULT 'Encomenda disponibilizada' NOT NULL,
ultima_modificacao      DATE DEFAULT SYSDATE,
PRIMARY KEY (id_status_encomenda)
);

INSERT INTO tb_status_encomenda(id_status_encomenda)
VALUES(1);

INSERT INTO tb_status_encomenda(id_status_encomenda, status, ultima_modificacao)
VALUES
(2, 'Encomenda enviada', '01-MAI-2013');

SELECT *
FROM tb_status_encomenda;

UPDATE tb_status_encomenda
    SET status = DEFAULT
WHERE id_status_encomenda = 2;

--MERGE: PERMITE MESCLAR LINHAS DE UMA TABELA EM OUTRA.
    --POSSIBILIDADE DE MESCLAR AS LINHAS DE DUAS TABELAS
    
MERGE INTO tb_produtos p
USING tb_produtos_alterados pa ON (p.id_produto = pa.id_produto)
WHEN MATCHED THEN 
    UPDATE
    SET
        p.id_tipo_produto = pa.id_tipo_produto,
        p.nm_produto = pa.nm_produto,
        p.ds_produto = pa.ds_produto,
        p.preco = pa.preco,
        p.fg_ativo = pa.fg_ativo
WHEN NOT MATCHED THEN
    INSERT (p.id_produto, p.id_tipo_produto, p.nm_produto, p.ds_produto, p.preco, p.fg_ativo)
    VALUES (pa.id_produto, pa.id_tipo_produto, pa.nm_produto, pa.ds_produto, pa.preco, pa.fg_ativo);
    
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto IN (1,2,3,13,14,15);

SELECT *
FROM tb_produtos;

--TRANSAÇÕES: USADA INTERNAMENTE. PERMITE QUE UMA APLICAÇÃO SE COMUNIQUE COM O BANCO. UMA TRANSAÇÃO É INICIADA SEMPRE QYE UMA INSTRUÇÃO SQL É INICIADA.
--É UM GRUPO DE INSTRUCOES SQL QUE EXECUTAM UMA UNIDADE LOGICA DE TRABALHO 
--PODEMOS CONSIDERAR UMA TRANSAÇÃO COMO UM CONJUNTO INSEPARAVEL DE INSTRUÇÕES SQL CUJO RESULTADO DEVEM SE TORNAR PERMANENTES NO BANCO.

INSERT INTO tb_clientes
VALUES(12, 'Geraldo', 'Henrique', '31-JUL-1977', '800-112233', 1);

COMMIT;

--INICIANDO E TERMINANDO UMA TRANSAÇÃO:
    --A transação começa quando um dos seguintes eventos ocorre:
        --Executamos uma instrução de COMMIT OU ROLLBACK
        --Executamos uma instrução DDL (COMMIT é executado automaticamente)
        --Executamos uma instrução DCL (COMMIT é executado automaticamente)
        --Quando executamos ma instrução DML que falha (ROLLBACK e executado automaticamente)
--NÃO CONFIRMAR OU REVERTER EXPLICITAMENTE SUAS TRANSAÇÕES É CONSIDERADA UMA MÁ PRATICA
--EXECUTE UM COMMIT OU ROLLBACK NO FUNAL SE SUAS TRANSAÇÕES.

--SAVEPOINTS
    --PERMITE DEFINIR UM SAVEPOINT EM QUALQUER LUGAR DENTRE DE UMA TRANSAÇÃO
    --PROMOVE FACILIDADES NO QUE DIZ RESPEITO A REVERTER ALTERAÇÕES ATE ESSE SAVEPOINT
    --SAVEPOINTS SAO UTEIS PARA SEGMENTAR TRANSAÇÕES MUITO LONGAS, POIS, SE OCORRER UM ERRO APOS TER DEFINIDO UM SAVEPOINT, NAO É NECESSARIO REVERTER A TRANSAÇÃO ATE O INICIO
    
SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN(4,6);
--4	13,95
--6	49,99

--AUMENTAR EM 20% O PRECO DO PRODUTO DE N4
UPDATE tb_produtos
    SET preco = preco *1.20
WHERE id_produto = 4;
COMMIT;
--a instrução a seguir define um savepoint chamado save1
SAVEPOINT save1;
--TODAS AS INSTRUÇÕES DML EXECUTADAS POSTERIORMENTE PODEM SER REVERTIDAS PARA O SAVEPOINT.

--AUMENTAR EM 30% O PRECO DO PRODUTO DE N6
UPDATE tb_produtos
    SET preco = preco*1.30
WHERE id_produto = 6;

--VALORES APOS A ALTERAÇÃO
SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN(4,6);
--4	16,74
--6	64,99

ROLLBACK TO SAVEPOINT save1;

--VALORES APOS O ROLLBACK
SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN(4,6);
--4	16,74
--6	49,99

--Propriedades de Transação (ACID)
    --Definição de uma transação (convencional):
        --Unidade lógica de trabalho
       --Grupo de instruções SQL relacionadas que sofrem um COMMIT ou ROLLBACK
--Definição adequada, diz que uma transação possui 4 propriedades fundamentais (ACID)
    --Atômica: significa que as instruções SQL contidas em uma transação constituem uma única unidade de trabalho (tudo ou nada)
    --Consistência: significa que o BD está em um estado consistente quando uma transação inicia, e, ao seu término, em outro estado consistente
    --Isolada: transações separadas não devem interferir uma com a outra
    --Durável: uma vez que a transação sofreu COMMIT, as alterações feitas no BD são preservadas, mesmo que a máquina em que o SGBD apresente falha posteriormente

