--FLASHBACK
SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <=5;
--1	Modern Science	40
--2	New Chemistry	35
--3	Super Nova	    25,99
--4	Tank War	    16,74

UPDATE tb_produtos
    SET preco = preco * 0.75
WHERE id_produto <= 5;
--1	Modern Science	30
--2	New Chemistry	26,25
--3	Super Nova	    19,49
--4	Tank War	    12,56

COMMIT;

--EXECUTANDO O COMIIT
EXECUTE DBMS_FLASHBACK.ENABLE_AT_TIME(SYSDATE - 10/1440);

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <=5;
--1	Modern Science	40
--2	New Chemistry	35
--3	Super Nova	    25,99
--4	Tank War	    16,74

--DESATIVANDO O FLASHBACK
EXECUTE DBMS_FLASHBACK.DISABLE();

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <=5;
--1	Modern Science	30
--2	New Chemistry	26,25
--3	Super Nova	    19,49
--4	Tank War	    12,56

--USANDO FALSHBACK BASEADO NO NUMERO DE ALTERAÇÃO DO SISTEMA (SCN)
VARIABLE scn_atual NUMBER;
EXECUTE :scn_atual :=DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER();
PRINT scn_atual;

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto, ds_produto, preco,fg_ativo)
VALUES(16,1,'Física', 'Livro sobre física', 39.95,1);

COMMIT;

SELECT *
FROM tb_produtos
WHERE id_produto = 16;

--EXECUTANDO O FLSHBACK scn_atual
EXECUTE DBMS_FLASHBACK.ENABLE_AT_SYSTEM_CHANGE_NUMBER(:scn_atual);

SELECT *
FROM tb_produtos
WHERE id_produto = 16;

EXECUTE DBMS_FLASHBACK.DISABLE();

CREATE TABLE tb_teste(
ID      INTEGER,
VALOR   VARCHAR2(100)
);

BEGIN 
    FOR v_loop IN 1..1000 LOOP
        INSERT INTO tb_teste(id, valor)
        VALUES (v_loop, 'DBA_' || v_loop);
    END LOOP;
END;

SELECT *
FROM tb_teste;

COMMIT;

DROP TABLE tb_teste;

FLASHBACK TABLE tb_teste TO BEFORE DROP;

