CREATE TABLE tb_mulher(
id_mulher   INTEGER,
nm_mulher   VARCHAR2(20),
CONSTRAINT pk_tb_mulher_id_mulher PRIMARY KEY(id_mulher)
);

CREATE TABLE tb_homem(
id_homem    INTEGER,
nm_homem    VARCHAR2(20),
id_mulher   INTEGER,
CONSTRAINT pk_tb_homem_id_homem PRIMARY KEY(id_homem),
CONSTRAINT fk_tb_homem_id_mulher FOREIGN KEY(id_mulher)
    REFERENCES tb_mulher(id_mulher)
);


--1) Insira as seguintes tuplas na tabela �homem�
INSERT INTO tb_homem
VALUES(10, 'Anderson', null);
INSERT INTO tb_homem
VALUES(20, 'Jander', 1);
INSERT INTO tb_homem
VALUES(30, 'Rog�rio', 2);

--2) Insira as seguintes tuplas na tabela �mulher�
INSERT INTO tb_mulher
VALUES(1, 'Edna');
INSERT INTO tb_mulher
VALUES(2, 'Stefanny');
INSERT INTO tb_mulher
VALUES(3, 'C�ssia');

COMMIT;

--3) Todas as quest�es a seguir utilizar�o INNER JOINS:
    --a. Selecionar os casamentos
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h, tb_mulher m
    WHERE h.id_mulher = m.id_mulher;
    --b. Selecionar os casamentos utilizando NATURAL JOIN
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    NATURAL JOIN tb_mulher m;
    --c. Selecionar os casamentos utilizando JOIN...USING
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    INNER JOIN tb_mulher m
    USING(id_mulher);
    --d. Selecionar os casamentos utilizando JOIN...ON
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    INNER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);
    --e. Por meio de um produto cartesiano, simule todos os casamentos poss�veis. Existem duas respostas para essa quest�o, realize ambas
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h, tb_mulher m;
    
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    CROSS JOIN tb_mulher m;
    
--4) Todas as quest�es a seguir utilizar�o OUTER JOINS:
    --a. Selecionar os casamentos, caso n�o exista homens casados, � desej�vel exibi-los
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    LEFT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --b. Selecionar os casamentos, caso n�o exista mulheres casadas, � desej�vel exibi-las
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    RIGHT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --c. Al�m do s�mbolo (+), um OUTER JOIN pode ser realizada por meio da NATURAL OUTER JOIN, OUTER JOIN...USING e OUTER JOIN...ON. 
    --Selecionar os casamentos e todos os homens que n�o estejam casados
    SELECT h.nm_homem, NVL(m.nm_mulher, 'N�o � casado')
    FROM tb_homem h
    LEFT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --d. Selecionar os casamentos e todas as mulheres mesmo que n�o estejam casadas
    SELECT NVL(h.nm_homem, 'N�o � casada'), m.nm_mulher
    FROM tb_homem h
    RIGHT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --e. Refa�a as consultas acima (c e d) usando OUTER JOIN...USING e OUTER JOIN...ON
    SELECT h.nm_homem, NVL(m.nm_mulher, 'N�o � casado')
    FROM tb_homem h
    LEFT OUTER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);
    
    SELECT NVL(h.nm_homem, 'N�o � casada'), m.nm_mulher
    FROM tb_homem h
    RIGHT OUTER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);
    
    --f. Selecionar todos os casamentos e, caso n�o exista homens e mulheres casados tamb�m � desej�vel exibi-los.
    SELECT NVL(h.nm_homem, 'N�o � casada'), NVL(m.nm_mulher, 'N�o � casado')
    FROM tb_homem h
    FULL OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --Refa�a a consulta anterior (f) usando OUTER JOIN...USING e OUTER JOIN...ON. Observe que n�o � poss�vel o uso do s�mbolo (+).
    SELECT NVL(h.nm_homem, 'N�o � casada'), NVL(m.nm_mulher, 'N�o � casado')
    FROM tb_homem h
    FULL OUTER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);