--Consulte a tabela TB_FUNCAO e retorne uma expressão única da forma “O identificador da <descrição da função> é o ID: <id_funcao>”. 
--Utilize um alias para essa expressão de coluna como “Descrição da Função” usando a palavra-chave AS.
SELECT 'O identificador da ' || ds_funcao || ' é o ID: ' || id_funcao AS "Descrição da Função"
FROM tb_funcao;


--Usando a tabela DUAL, calcule a área de uma circunferência com um raio de 6000 unidades, com PI sendo,
--aproximadamente, 22/7. Use a fórmula: Área = pi x raio x raio. Crie um alias no resultado como “Área”.
SELECT TRUNC((22/7) * (6000 * 6000), 2) AS "Área"
FROM dual;


--Recupere o(s) nome(s) do(s) departamento(s) que termine com as três letras “ing” da tabela TB_DEPARTAMENTO.
SELECT nm_departamento 
FROM tb_departamento
WHERE nm_departamento LIKE '%ing';


--A tabela TB_FUNCAO contém descrições de diferentes tipos de funções que um empregado da empresa podeocupar. 
--Ela contém as colunas ID_FUNCAO, DS_FUNCAO, BASE_SALARIO e TETO_SALARIO. 
--Você precisa escrever uma consulta que extraia as colunas DS_FUNCAO, BASE_SALARIO, e a diferença entre os valores TETO_SALARIO e BASE_SALARIO para cada linha. 
--Os resultados somente podem incluir valores DS_FUNCAO que contenham a palavra “Presidente” ou “Gerente”. 
--Classifique a lista em ordem descendente baseado na expressão DIFERENÇA. 
--Se mais de uma linha tiver o mesmo valor DIFERENÇA, então, em adição, classifique essas linhas por DS_FUNCAO na ordem alfabética reversa.
SELECT ds_funcao, base_salario, (teto_salario - base_salario) AS "Diferença"
FROM tb_funcao
WHERE ds_funcao LIKE '%Presidente%' OR ds_funcao LIKE '%Gerente%' 
ORDER BY 3 DESC, ds_funcao DESC;


--Para o exercício abaixo, utilize impreterivelmente, variáveis de substituição (& comercial)
--Um cálculo comum executado pelo Departamento de Recursos Humanos está relacionado ao cálculo de impostos cobrados sobre um determinado empregado.
--Apesar disso ser feito para todos os empregados, sempre há algunsmembros da equipe que discutem os impostos retidos de seus salários.
--O imposto retido por empregado écalculado obtendo o salário anual do empregado e multiplicando-o pela alíquota atual, que pode variar de ano paraano. 
--Você precisa escrever uma consulta reutilizável usando a alíquota atual e os números ID_EMPREGADO como entradas e retornar as informações: 
--ID_EMPREGADO, NOME, SALARIO, SALARIO ANUAL (SALARIO * 12), ALIQUOTA, e ALIQUOTA (ALIQUOTA * SALARIO ANUAL).

ACCEPT aliquota NUMBER PROMPT 'Entre com a alíquota: '
ACCEPT v_id_empregado NUMBER PROMPT 'Entre com o ID: '
SELECT id_empregado, nome, salario, salario*12 AS "Salário anual", &aliquota AS "Alíquota", salario*12 *&aliquota AS "Imposto"
FROM tb_empregado
WHERE id_empregado = &v_id_empregado;
