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

--TRANSA��ES: USADA INTERNAMENTE. PERMITE QUE UMA APLICA��O SE COMUNIQUE COM O BANCO. UMA TRANSA��O � INICIADA SEMPRE QYE UMA INSTRU��O SQL � INICIADA.
--� UM GRUPO DE INSTRUCOES SQL QUE EXECUTAM UMA UNIDADE LOGICA DE TRABALHO 
--PODEMOS CONSIDERAR UMA TRANSA��O COMO UM CONJUNTO INSEPARAVEL DE INSTRU��ES SQL CUJO RESULTADO DEVEM SE TORNAR PERMANENTES NO BANCO.

INSERT INTO tb_clientes
VALUES(12, 'Geraldo', 'Henrique', '31-JUL-1977', '800-112233', 1);

COMMIT;

--INICIANDO E TERMINANDO UMA TRANSA��O:
    --A transa��o come�a quando um dos seguintes eventos ocorre:
        --Executamos uma instru��o de COMMIT OU ROLLBACK
        --Executamos uma instru��o DDL (COMMIT � executado automaticamente)
        --Executamos uma instru��o DCL (COMMIT � executado automaticamente)
        --Quando executamos ma instru��o DML que falha (ROLLBACK e executado automaticamente)
--N�O CONFIRMAR OU REVERTER EXPLICITAMENTE SUAS TRANSA��ES � CONSIDERADA UMA M� PRATICA
--EXECUTE UM COMMIT OU ROLLBACK NO FUNAL SE SUAS TRANSA��ES.

--SAVEPOINTS
    --PERMITE DEFINIR UM SAVEPOINT EM QUALQUER LUGAR DENTRE DE UMA TRANSA��O
    --PROMOVE FACILIDADES NO QUE DIZ RESPEITO A REVERTER ALTERA��ES ATE ESSE SAVEPOINT
    --SAVEPOINTS SAO UTEIS PARA SEGMENTAR TRANSA��ES MUITO LONGAS, POIS, SE OCORRER UM ERRO APOS TER DEFINIDO UM SAVEPOINT, NAO � NECESSARIO REVERTER A TRANSA��O ATE O INICIO
    
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
--a instru��o a seguir define um savepoint chamado save1
SAVEPOINT save1;
--TODAS AS INSTRU��ES DML EXECUTADAS POSTERIORMENTE PODEM SER REVERTIDAS PARA O SAVEPOINT.

--AUMENTAR EM 30% O PRECO DO PRODUTO DE N6
UPDATE tb_produtos
    SET preco = preco*1.30
WHERE id_produto = 6;

--VALORES APOS A ALTERA��O
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

--Propriedades de Transa��o (ACID)
    --Defini��o de uma transa��o (convencional):
        --Unidade l�gica de trabalho
       --Grupo de instru��es SQL relacionadas que sofrem um COMMIT ou ROLLBACK
--Defini��o adequada, diz que uma transa��o possui 4 propriedades fundamentais (ACID)
    --At�mica: significa que as instru��es SQL contidas em uma transa��o constituem uma �nica unidade de trabalho (tudo ou nada)
    --Consist�ncia: significa que o BD est� em um estado consistente quando uma transa��o inicia, e, ao seu t�rmino, em outro estado consistente
    --Isolada: transa��es separadas n�o devem interferir uma com a outra
    --Dur�vel: uma vez que a transa��o sofreu COMMIT, as altera��es feitas no BD s�o preservadas, mesmo que a m�quina em que o SGBD apresente falha posteriormente

