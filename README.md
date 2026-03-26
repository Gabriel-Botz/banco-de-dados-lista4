# 📚 Sistema de Banco de Dados - Biblioteca

## 📖 Descrição do Projeto

Este projeto consiste na modelagem e implementação de um banco de dados relacional para um sistema de biblioteca, desenvolvido utilizando PostgreSQL.

O sistema permite o gerenciamento de:

* 📚 Livros
* 👤 Usuários
* 🔄 Empréstimos

O objetivo principal é simular o funcionamento básico de uma biblioteca, permitindo o controle de empréstimos de livros e o relacionamento entre usuários e obras.

---

## 🛠️ Tecnologias Utilizadas

* PostgreSQL
* SQL (DDL e DML)
* pgAdmin (opcional para execução)

---

## 🧱 Estrutura do Banco de Dados

O banco é composto por três entidades principais:

### 📘 Tabela: `livro`

Armazena informações sobre os livros disponíveis.

| Campo              | Tipo    | Descrição             |
| ------------------ | ------- | --------------------- |
| id_livro           | SERIAL  | Identificador único   |
| titulo             | VARCHAR | Nome do livro         |
| autor              | VARCHAR | Autor da obra         |
| ano_publicacao     | INT     | Ano de publicação     |
| genero             | VARCHAR | Gênero do livro       |
| quantidade_estoque | INT     | Quantidade disponível |
| editora            | VARCHAR | Editora do livro      |

---

### 👤 Tabela: `usuario`

Armazena os dados dos usuários.

| Campo      | Tipo    | Descrição           |
| ---------- | ------- | ------------------- |
| id_usuario | SERIAL  | Identificador único |
| nome       | VARCHAR | Nome do usuário     |
| cpf        | VARCHAR | CPF (único)         |
| email      | VARCHAR | Email (único)       |
| telefone   | VARCHAR | Contato             |
| endereco   | VARCHAR | Endereço            |

---

### 🔄 Tabela: `emprestimo`

Responsável por relacionar usuários e livros.

| Campo           | Tipo   | Descrição                   |
| --------------- | ------ | --------------------------- |
| id_emprestimo   | SERIAL | Identificador único         |
| id_usuario      | INT    | FK para usuário             |
| id_livro        | INT    | FK para livro               |
| data_emprestimo | DATE   | Data do empréstimo          |
| data_devolucao  | DATE   | Data de devolução           |
| status          | ENUM   | 'emprestado' ou 'devolvido' |

---

## 🔗 Relacionamentos

* Um usuário pode ter vários empréstimos (**1:N**)
* Um livro pode estar em vários empréstimos (**1:N**)
* A tabela `emprestimo` atua como tabela intermediária

---

## 🧪 Consultas Implementadas

### 1️⃣ Listar todos os livros

```sql
SELECT titulo AS Livros_Cadastrados FROM biblioteca.livro;
```

---

### 2️⃣ Listar usuários e livros emprestados (JOIN)

```sql
SELECT
    biblioteca.usuario.nome,
    biblioteca.livro.titulo
FROM biblioteca.emprestimo
JOIN biblioteca.usuario
    ON biblioteca.emprestimo.id_usuario = biblioteca.usuario.id_usuario
JOIN biblioteca.livro
    ON biblioteca.emprestimo.id_livro = biblioteca.livro.id_livro;
```

---

### 3️⃣ Empréstimos não devolvidos

```sql
SELECT
    biblioteca.usuario.nome,
    biblioteca.livro.titulo,
    biblioteca.emprestimo.status
FROM biblioteca.emprestimo
JOIN biblioteca.usuario
    ON biblioteca.emprestimo.id_usuario = biblioteca.usuario.id_usuario
JOIN biblioteca.livro
    ON biblioteca.emprestimo.id_livro = biblioteca.livro.id_livro
WHERE biblioteca.emprestimo.status = 'emprestado';
```

---

### 4️⃣ Autores e seus livros

```sql
SELECT autor, titulo FROM biblioteca.livro;
```

---

### 5️⃣ Usuários com ou sem empréstimos (LEFT JOIN)

```sql
SELECT
    biblioteca.usuario.nome,
    biblioteca.livro.titulo,
    biblioteca.emprestimo.status
FROM biblioteca.usuario
LEFT JOIN biblioteca.emprestimo
    ON biblioteca.usuario.id_usuario = biblioteca.emprestimo.id_usuario
LEFT JOIN biblioteca.livro
    ON biblioteca.emprestimo.id_livro = biblioteca.livro.id_livro;
```

---

## 🚀 Como Executar o Projeto

1. Criar o banco de dados:

```sql
CREATE DATABASE biblioteca;
```

2. Executar o script SQL completo:

* Criação das tabelas
* Inserção de dados
* Execução das queries

3. Utilizar pgAdmin ou terminal (psql) para testar as consultas.

---

## 🎯 Objetivos de Aprendizado

Este projeto foi desenvolvido com foco em:

* Modelagem de banco de dados
* Criação de tabelas (DDL)
* Inserção de dados (DML)
* Uso de JOIN e LEFT JOIN
* Aplicação de filtros com WHERE
* Boas práticas em SQL

---

## 📌 Autor

Gabriel Carneiro Botelho
Estudante de Análise e Desenvolvimento de Sistemas
Desenvolvedor em formação 🚀

---

## ⭐ Considerações Finais

Este projeto representa a aplicação prática de conceitos fundamentais de banco de dados, sendo uma excelente base para evolução em sistemas mais complexos.

---
