--CREATE DATABASE minhaBiblioteca
--CREATE SCHEMA biblioteca

--drop table biblioteca.livro

CREATE TABLE biblioteca.livro(
	id_livro SERIAL PRIMARY KEY,
	titulo varchar (40) NOT NULL,
	autor varchar (40) NOT NULL,
	ano_publicacao int NOT NULL,
	genero varchar(20) NOT NULL,
	quantidade_estoque int NOT NULL
);

CREATE TABLE biblioteca.usuario(
	id_usuario SERIAL PRIMARY KEY,
	nome varchar (40) NOT NULL,
	cpf varchar (15) UNIQUE,
	email varchar (40) UNIQUE,
	telefone varchar(20) NOT NULL,
	endereco varchar (40) NOT NULL	
);

	UPDATE biblioteca.usuario
	SET telefone = '(22)2222-2222'
	WHERE id_usuario = 3;

	CREATE TYPE status_pedido AS ENUM ('emprestado', 'devolvido')

CREATE TABLE biblioteca.emprestimo(
	id_emprestimo SERIAL PRIMARY KEY,
	id_usuario int REFERENCES biblioteca.usuario(id_usuario),
	id_livro int REFERENCES biblioteca.livro(id_livro),
	data_emprestimo DATE NOT NULL,
	data_devolucao DATE,
	status status_pedido	 	
);
		
	ALTER TABLE biblioteca.livro 
	ADD COLUMN editora varchar(100);

---------------------------------------------------------------------------------------
------------------------------------DIVISÃO--------------------------------------------	
---------------------------------------------------------------------------------------

	INSERT INTO biblioteca.livro (titulo, autor, ano_publicacao, genero, quantidade_estoque, editora)
	VALUES ('A Sombra do Amanhã', 'Lucas Andrade', 2018, 'Ficção', 5, 'Nova Era'),
		   ('Código Invisível', 'Mariana Silva', 2021, 'Tecnologia', 8, 'TechBooks'),
		   ('O Último Horizonte', 'Rafael Costa', 2015, 'Aventura', 3, 'Mundo Livre'),
		   ('Entre Linhas e Segredos', 'Fernanda Rocha', 2019, 'Romance', 6, 'Coração Literário'),
		   ('A Fórmula do Caos', 'Bruno Martins', 2020, 'Suspense', 4, 'Mistério Editora'),
		   ('Ecos do Passado', 'Juliana Alves', 2017, 'Drama', 7, 'Memória Viva' ),
		   ('Além do Código', 'Gabriel Souza', 2022, 'Tecnologia', 9, 'DevBooks'),
		   ('A Cidade Perdida', 'Ricardo Nunes', 2016, 'Aventura', 2, 'Explorar'),
		   ('Segredos da Mente', 'Patrícia Lima', 2014, 'Psicologia', 5, 'Saber'),
		   ('O Despertar Final', 'André Ferreira', 2023, 'Ficção', 10, 'Futuro');

	INSERT INTO biblioteca.usuario (nome, cpf, email, telefone, endereco)
	VALUES ('Gabriel Botelho', '111.111.111-11', 'email@1.com', '(11)1111-1112', 'rua 1'),
		   ('João Pedro Pires', '111.111.111-12', 'email@2.com', '(11)1111-1113', 'rua 2'),
		   ('Emanuel Ribeiro', '111.111.111-13', 'email@3.com', '(11)1111-1114', 'rua 3'),
		   ('Jonathan Carvalho', '111.111.111-14', 'email@4.com', '(11)1111-1115', 'rua 4'),
		   ('Eduardo Motta', '111.111.111-15', 'email@5.com', '(11)1111-1116', 'rua 5'),
		   ('Eduarda Mello', '111.111.111-16', 'email@6.com', '(11)1111-1117', 'rua 6'),
		   ('Carlos Carvalho', '111.111.111-17', 'email@7.com', '(11)1111-1118', 'rua 7'),
		   ('Gabriela Mesquita', '111.111.111-18', 'email@8.com', '(11)1111-1119', 'rua 8'),
		   ('Sabrina Louro', '111.111.111-19', 'email@9.com', '(11)1111-1111', 'rua 9'),
		   ('Guilherme Louro', '111.111.111-10', 'email@10.com', '(11)1111-1110', 'rua 10');
	

	INSERT INTO biblioteca.emprestimo (id_livro, id_usuario, data_emprestimo, data_devolucao, status)
	VALUES (1, 1, '2026-03-12', '2026-03-22', 'emprestado'),
		   (2, 1, '2026-02-15', '2026-04-02', 'devolvido'),
		   (5, 2, '2026-01-05', '2026-04-05', 'emprestado'),
		   (4, 2, '2026-01-05', '2026-04-06', 'emprestado'),
		   (10, 3, '2026-01-05', '2026-04-07', 'emprestado'),
		   (9, 3, '2026-01-05', '2026-04-08', 'devolvido'),
		   (6, 4, '2026-01-05', '2026-04-09', 'emprestado'),
		   (7, 4, '2026-01-05', '2026-04-10', 'devolvido'),
		   (6, 4, '2026-01-05', '2026-04-11', 'emprestado'),
		   (8, 5, '2026-01-05', '2026-04-12', 'devolvido');

---------------------------------------------------------------------------------------
------------------------------------DIVISÃO--------------------------------------------	
---------------------------------------------------------------------------------------

--1. Selecione todos os livros cadastrados no banco de dados. 

		
SELECT titulo AS Livros_Cadastrados FROM biblioteca.livro 
	
	
--2. Liste o nome do usuário e o título do livro de todos os empréstimos realizados, utilizando um
--JOIN. 


SELECT
	   biblioteca.usuario.nome,
	   biblioteca.livro.titulo   
  FROM biblioteca.emprestimo
  JOIN biblioteca.usuario
  	   ON biblioteca.emprestimo.id_usuario = biblioteca.usuario.id_usuario
  JOIN biblioteca.livro
  	   ON biblioteca.emprestimo.id_livro = biblioteca.livro.id_livro;


--3. Selecione todos os empréstimos que ainda não foram devolvidos (status = 'emprestado'). 

 
SELECT
	   biblioteca.usuario.nome,
	   biblioteca.livro.titulo,
	   biblioteca.emprestimo.status
  FROM biblioteca.emprestimo
  
  JOIN biblioteca.usuario
  	   ON biblioteca.emprestimo.id_usuario = biblioteca.usuario.id_usuario
  JOIN biblioteca.livro
  	   ON biblioteca.emprestimo.id_livro = biblioteca.livro.id_livro
 WHERE biblioteca.emprestimo.status = 'emprestado'
	

--4. Liste todos os autores e os livros que eles escreveram. 	


 SELECT biblioteca.livro.autor,
		biblioteca.livro.titulo
   FROM biblioteca.livro	


--5. Crie uma consulta que mostre todos os usuários e os livros que já pegaram emprestado,
--incluindo usuários que nunca pegaram livros..

SELECT biblioteca.usuario.nome,
       biblioteca.livro.titulo,
       biblioteca.emprestimo.status
  FROM biblioteca.usuario

    LEFT JOIN biblioteca.emprestimo
              ON biblioteca.usuario.id_usuario = biblioteca.emprestimo.id_usuario
    LEFT JOIN biblioteca.livro
              ON biblioteca.emprestimo.id_livro = biblioteca.livro.id_livro;
	


	


	








	
		
