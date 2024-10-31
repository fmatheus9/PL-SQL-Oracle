--

SELECT e.nome || ' trabalha para ' || dp.nm_departamento || ' localizado na cidade ' || lc.cidade || ' estado ' || lc.estado || ' pais ' || p.nm_pais AS "Informação dos Empregados"
FROM tb_empregado e
INNER JOIN tb_departamento dp USING (id_departamento)
INNER JOIN tb_localizacao lc USING (id_localizacao)
INNER JOIN tb_pais p USING (id_pais)
ORDER BY 1 ASC;


SELECT nome, sobrenome
FROM tb_empregado 
WHERE LOWER(nome)LIKE 'e______e%'
AND id_departamento = 80 
OR id_gerente = 148;

--
SELECT NVL(G.nome, 'os acionistas') || ' gerencia '|| e.nome
FROM tb_empregado e
LEFT OUTER JOIN tb_empregado g ON(e.id_gerente = g.id_empregado)
ORDER BY g.nome;