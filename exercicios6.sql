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


--1) Insira as seguintes tuplas na tabela “homem”
INSERT INTO tb_homem
VALUES(10, 'Anderson', null);
INSERT INTO tb_homem
VALUES(20, 'Jander', 1);
INSERT INTO tb_homem
VALUES(30, 'Rogério', 2);

--2) Insira as seguintes tuplas na tabela “mulher”
INSERT INTO tb_mulher
VALUES(1, 'Edna');
INSERT INTO tb_mulher
VALUES(2, 'Stefanny');
INSERT INTO tb_mulher
VALUES(3, 'Cássia');

COMMIT;

--3) Todas as questões a seguir utilizarão INNER JOINS:
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
    --e. Por meio de um produto cartesiano, simule todos os casamentos possíveis. Existem duas respostas para essa questão, realize ambas
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h, tb_mulher m;
    
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    CROSS JOIN tb_mulher m;
    
--4) Todas as questões a seguir utilizarão OUTER JOINS:
    --a. Selecionar os casamentos, caso não exista homens casados, é desejável exibi-los
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    LEFT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --b. Selecionar os casamentos, caso não exista mulheres casadas, é desejável exibi-las
    SELECT h.nm_homem, m.nm_mulher
    FROM tb_homem h
    RIGHT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --c. Além do símbolo (+), um OUTER JOIN pode ser realizada por meio da NATURAL OUTER JOIN, OUTER JOIN...USING e OUTER JOIN...ON. 
    --Selecionar os casamentos e todos os homens que não estejam casados
    SELECT h.nm_homem, NVL(m.nm_mulher, 'Não é casado')
    FROM tb_homem h
    LEFT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --d. Selecionar os casamentos e todas as mulheres mesmo que não estejam casadas
    SELECT NVL(h.nm_homem, 'Não é casada'), m.nm_mulher
    FROM tb_homem h
    RIGHT OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --e. Refaça as consultas acima (c e d) usando OUTER JOIN...USING e OUTER JOIN...ON
    SELECT h.nm_homem, NVL(m.nm_mulher, 'Não é casado')
    FROM tb_homem h
    LEFT OUTER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);
    
    SELECT NVL(h.nm_homem, 'Não é casada'), m.nm_mulher
    FROM tb_homem h
    RIGHT OUTER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);
    
    --f. Selecionar todos os casamentos e, caso não exista homens e mulheres casados também é desejável exibi-los.
    SELECT NVL(h.nm_homem, 'Não é casada'), NVL(m.nm_mulher, 'Não é casado')
    FROM tb_homem h
    FULL OUTER JOIN tb_mulher m
    USING(id_mulher);
    
    --Refaça a consulta anterior (f) usando OUTER JOIN...USING e OUTER JOIN...ON. Observe que não é possível o uso do símbolo (+).
    SELECT NVL(h.nm_homem, 'Não é casada'), NVL(m.nm_mulher, 'Não é casado')
    FROM tb_homem h
    FULL OUTER JOIN tb_mulher m
    ON( h.id_mulher = m.id_mulher);