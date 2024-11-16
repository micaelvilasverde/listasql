-- Criação das tabelas
CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE disciplina (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    data_matricula DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT NOT NULL,
    id_disciplina INT NOT NULL,
    horario TIME NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

-- Consultas
-- 1
SELECT nome, data_nascimento
FROM aluno
ORDER BY nome ASC, data_nascimento ASC;

-- 2
SELECT nome, especialidade
FROM professor
ORDER BY nome DESC;

-- 3
SELECT nome, carga_horaria
FROM disciplina
ORDER BY carga_horaria DESC;

-- 4
SELECT status, COUNT(*) AS total_alunos
FROM matricula
GROUP BY status;

-- 5
SELECT curso.nome, SUM(disciplina.carga_horaria) AS carga_total
FROM curso
JOIN disciplina ON curso.id_curso = disciplina.id_curso
GROUP BY curso.nome;

-- 6
SELECT professor.nome
FROM professor
JOIN turma ON professor.id_professor = turma.id_professor
GROUP BY professor.nome
HAVING COUNT(turma.id_turma) > 3;

-- 7
SELECT aluno.nome, COUNT(matricula.id_disciplina) AS total_disciplinas
FROM aluno
JOIN matricula ON aluno.id_aluno = matricula.id_aluno
GROUP BY aluno.nome
HAVING COUNT(matricula.id_disciplina) > 1
ORDER BY total_disciplinas DESC;

-- 8
SELECT curso.nome, SUM(disciplina.carga_horaria) AS carga_total
FROM curso
JOIN disciplina ON curso.id_curso = disciplina.id_curso
GROUP BY curso.nome
HAVING SUM(disciplina.carga_horaria) > 2000;

-- 9
SELECT professor.nome, COUNT(turma.id_turma) AS total_turmas
FROM professor
JOIN turma ON professor.id_professor = turma.id_professor
GROUP BY professor.nome
ORDER BY total_turmas DESC;

-- 10
SELECT curso.nome, AVG(disciplina.carga_horaria) AS media_carga_horaria
FROM curso
JOIN disciplina ON curso.id_curso = disciplina.id_curso
GROUP BY curso.nome;

-- 11
SELECT aluno.nome, matricula.status, matricula.data_matricula
FROM aluno
JOIN matricula ON aluno.id_aluno = matricula.id_aluno
ORDER BY matricula.status, matricula.data_matricula DESC;

-- 12
SELECT nome, FLOOR((SYSDATE - data_nascimento) / 365) AS idade
FROM aluno
ORDER BY idade DESC;

-- 13
SELECT disciplina.nome, COUNT(matricula.id_aluno) AS total_alunos
FROM disciplina
JOIN matricula ON disciplina.id_disciplina = matricula.id_disciplina
GROUP BY disciplina.nome
ORDER BY total_alunos DESC;

-- 14
SELECT professor.nome AS professor, disciplina.nome AS disciplina, turma.horario
FROM turma
JOIN professor ON turma.id_professor = professor.id_professor
JOIN disciplina ON turma.id_disciplina = disciplina.id_disciplina
ORDER BY turma.horario;

-- 15
SELECT COUNT(*) AS total_disciplinas
FROM disciplina
WHERE carga_horaria > 80;

-- 16
SELECT curso.nome, COUNT(disciplina.id_disciplina) AS total_disciplinas
FROM curso
JOIN disciplina ON curso.id_curso = disciplina.id_curso
GROUP BY curso.nome;

-- 17
SELECT professor.nome
FROM professor
JOIN turma ON professor.id_professor = turma.id_professor
JOIN disciplina ON turma.id_disciplina = disciplina.id_disciplina
WHERE disciplina.carga_horaria > 100
GROUP BY professor.nome
HAVING COUNT(disciplina.id_disciplina) > 2;

-- 18
SELECT disciplina.nome
FROM disciplina
JOIN matricula ON disciplina.id_disciplina = matricula.id_disciplina
GROUP BY disciplina.nome
HAVING COUNT(matricula.id_aluno) >= 5;

-- 19
SELECT status, COUNT(id_aluno) AS total_alunos
FROM matricula
GROUP BY status
ORDER BY total_alunos DESC;

-- 20
SELECT professor.nome, SUM(disciplina.carga_horaria) AS carga_total
FROM professor
JOIN turma ON professor.id_professor = turma.id_professor
JOIN disciplina ON turma.id_disciplina = disciplina.id_disciplina
GROUP BY professor.nome
ORDER BY carga_total DESC;
