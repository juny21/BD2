--------------------------------------- CRIAR TABELAS ---------------------------------------
-- Tabela País
CREATE TABLE Pais (
 num_pais SERIAL PRIMARY KEY,
 nome VARCHAR(50) NOT NULL,
 num_clubes INT NOT NULL
);


-- Tabela Participante
CREATE TABLE Participante (
 num_participante SERIAL PRIMARY KEY,
 num_pais INT NOT NULL,
 nome VARCHAR(50) NOT NULL,
 endereco VARCHAR(100) NOT NULL,
 telefone VARCHAR(20) NOT NULL,
 tipo_part VARCHAR(10) NOT NULL CHECK (tipo_part IN ('jogador', 'árbitro')),
 FOREIGN KEY (num_pais) REFERENCES Pais(num_pais)
);


-- Tabela Jogador
CREATE TABLE Jogador (
 num_participante INT PRIMARY KEY,
 nivel INT NOT NULL CHECK ( nivel >= 1 AND nivel <= 10 ),
 FOREIGN KEY (num_participante) REFERENCES Participante(num_participante)
);


-- Tabela Hotel
CREATE TABLE Hotel (
nome_hotel VARCHAR(50) PRIMARY KEY NOT NULL,
endereco VARCHAR(100) NOT NULL,
telefone VARCHAR(20) NOT NULL
);


-- Tabela Salão
CREATE TABLE Salao (
num_salao SERIAL PRIMARY KEY,
nome_hotel VARCHAR(50) NOT NULL,
capacidade INT NOT NULL,
FOREIGN KEY (nome_hotel) REFERENCES Hotel(nome_hotel)
);


-- Tabela Jogo
CREATE TABLE Jogo (
 num_jogo INT PRIMARY KEY,
 num_arb INT NOT NULL,
 num_salao INT NOT NULL,
 ent_vendidas INT NOT NULL,
 dia_jorn INT NOT NULL,
 mes_jorn INT NOT NULL,
 ano_jorn INT NOT NULL,
 FOREIGN KEY (num_arb) REFERENCES Participante(num_participante),
 FOREIGN KEY (num_salao) REFERENCES Salao(num_salao)
);


-- Tabela Joga
CREATE TABLE Joga (
 num_jogo INT NOT NULL,
 num_jogador INT NOT NULL,
 cor VARCHAR(6) NOT NULL CHECK (cor IN ('brancas', 'pretas')),
 FOREIGN KEY (num_jogo) REFERENCES Jogo(num_jogo),
 FOREIGN KEY (num_jogador) REFERENCES Jogador(num_participante),
 CHECK ((SELECT num_pais FROM Participante WHERE num_participante = Jogo.num_arb) <> 
        (SELECT num_pais FROM Participante WHERE num_participante = Joga.num_jogador)
         AND Joga.num_jogo = Jogo.num_jogo)


);


-- Tabela Movimento
CREATE TABLE Movimento (
num_jogo INT NOT NULL,
id_movimento INT NOT NULL,
jogada VARCHAR(10) NOT NULL,
comentario VARCHAR(200) NOT NULL,
PRIMARY KEY (num_jogo, id_movimento),
FOREIGN KEY (num_jogo) REFERENCES Jogo(num_jogo)
);




-- Tabela Acomoda
CREATE TABLE Acomoda (
nome_hotel VARCHAR(50) NOT NULL,
num_participante INT NOT NULL,
data_entrada DATE NOT NULL,
data_saida DATE NOT NULL,
PRIMARY KEY (nome_hotel, num_participante),
FOREIGN KEY (nome_hotel) REFERENCES Hotel(nome_hotel),
FOREIGN KEY (num_participante) REFERENCES Participante(num_participante)
);




-- Tabela Meios
CREATE TABLE Meios (
 num_salao INT NOT NULL,
 meio VARCHAR(20) NOT NULL,
 PRIMARY KEY (num_salao, meio),
 FOREIGN KEY (num_salao) REFERENCES Salao(num_salao)
);


-- Tabela Camp_part
CREATE TABLE Camp_part (
 num_participante INT NOT NULL,
 nome_camp VARCHAR(50) NOT NULL,
 tipo_part VARCHAR(20) NOT NULL,
 PRIMARY KEY (num_participante, nome_camp),
 FOREIGN KEY (num_participante) REFERENCES Participante(num_participante)
);




--------------------------------------- ADICIONAR CAMPOS ---------------------------------------




-- Adicionar campos a tabela País
INSERT INTO Pais (num_pais, nome, num_clubes)
VALUES (1, 'Brasil', 1);
INSERT INTO Pais (num_pais, nome, num_clubes)
VALUES (2, 'Argentina', 2);
INSERT INTO Pais (num_pais, nome, num_clubes)
VALUES (3, 'Chile', 3);




-- Adicionar campos a tabela Participante
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (3, 'Bob Fisher', 'Rua 1', '123456789', 'Jogador');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (3, 'Garry Kasparov', 'Rua 8', '123456789', 'Jogador');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (3, 'Joana', 'Rua 9', '123456789', 'Jogador');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (2, 'Jorge', 'Rua 2', '123456789', 'Jogador');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (3, 'João', 'Rua 3', '123456789', 'Jogador');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (1, 'José', 'Rua 4', '123456789', 'Jogador');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (2, 'Boris Sparski', 'Rua 5', '123456789', 'Arbitro');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (2, 'Júlio', 'Rua 6', '123456789', 'Arbitro');
INSERT INTO Participante (num_pais, nome, endereco, telefone, tipo_part)
VALUES (1, 'Laura', 'Rua 7', '123456789', 'Arbitro');




-- Adicionar campos a tabela Jogador
INSERT INTO Jogador (num_participante, nivel)
VALUES (1, 10);
INSERT INTO Jogador (num_participante, nivel)
VALUES (2, 1);
INSERT INTO Jogador (num_participante, nivel)
VALUES (3, 1);
INSERT INTO Jogador (num_participante, nivel)
VALUES (4, 9);
INSERT INTO Jogador (num_participante, nivel)
VALUES (5, 8);
INSERT INTO Jogador (num_participante, nivel)
VALUES (6, 7);




-- Adicionar campos a tabela Hotel
INSERT INTO Hotel (nome_hotel, endereco, telefone)
VALUES ('Matsoud Plaza', 'Rua 1', '123456789');
INSERT INTO Hotel (nome_hotel, endereco, telefone)
VALUES ('Ibis Consolação', 'Rua 2', '123456788');
INSERT INTO Hotel (nome_hotel, endereco, telefone)
VALUES ('Hilton', 'Rua 2', '123456787');




-- Adicionar campos a tabela Salao
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Matsoud Plaza', 10);
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Ibis Consolação', 20);
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Hilton', 30);
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Matsoud Plaza', 40);
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Matsoud Plaza', 50);
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Ibis Consolação', 60);
INSERT INTO Salao (nome_hotel, capacidade)
VALUES ('Hilton', 60);




-- Adicionar campos a tabela Jogo
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (7, 1, 10, 1, 6, 2023);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (8, 2, 20, 2, 5, 2023);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (9, 3, 30, 3, 4, 2023);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (8, 3, 100, 3, 4, 2024);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (7, 3, 200, 2, 5, 2024);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (7, 7, 200, 2, 5, 2024);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (7, 4, 200, 2, 5, 2024);
INSERT INTO Jogo (num_arb, num_salao, ent_vendidas, dia_jorn, mes_jorn, ano_jorn)
VALUES (9, 4, 200, 2, 5, 2024);


-- Adicionar campos a tabela Joga
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (1, 1, 'brancas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (1, 2, 'pretas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (2, 3, 'brancas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (2, 4, 'pretas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (3, 5, 'brancas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (3, 6, 'pretas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (4, 1, 'brancas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (4, 3, 'pretas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (5, 2, 'pretas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (5, 4, 'pretas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (6, 4, 'brancas');
INSERT INTO Joga (num_jogo, num_jogador, cor)
VALUES (6, 2, 'pretas');


-- Adicionar campos a tabela Movimento
INSERT INTO Movimento (num_jogo, id_movimento, jogada, comentario)
VALUES (1, 1, 'e4', 'Abertura Ruy Lopez');
INSERT INTO Movimento (num_jogo, id_movimento, jogada, comentario)
VALUES (1, 2, 'e5', 'Abertura Ruy Lopez');
INSERT INTO Movimento (num_jogo, id_movimento, jogada, comentario)
VALUES (2, 1, 'Cf3', 'Comentario');
INSERT INTO Movimento (num_jogo, id_movimento, jogada, comentario)
VALUES (2, 2, 'Cf6', 'Comentario');


--Adicionar campos a tabela Meios de transmissão
INSERT INTO Meios (num_salao, meio)
VALUES (1, 'Internet');
INSERT INTO Meios (num_salao, meio)
VALUES (1, 'Radio');
INSERT INTO Meios (num_salao, meio)
VALUES (1, 'televisão');
INSERT INTO Meios (num_salao, meio)
VALUES (2, 'Radio');
INSERT INTO Meios (num_salao, meio)
VALUES (3, 'televisão');
INSERT INTO Meios (num_salao, meio)
VALUES (4, 'Radio');
INSERT INTO Meios (num_salao, meio)
VALUES (4, 'Internet');


--Adicionar campos a tabela Acomoda
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Matsoud Plaza', 1, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Ibis Consolação', 2, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Ibis Consolação', 3, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Matsoud Plaza', 4, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Matsoud Plaza', 5, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Ibis Consolação', 6, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Matsoud Plaza', 7, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Hilton', 8, '2023-06-01', '2023-06-02');
INSERT INTO Acomoda (nome_hotel, num_participante, data_entrada, data_saida)
VALUES ('Hilton', 9, '2023-06-01', '2023-06-02');


--Adicionar campos a tabela camp_part
INSERT INTO camp_part (num_participante, nome_camp, tipo_part)
   VALUES (1, 'Campeonato Mundial', 'Jogador');
INSERT INTO camp_part (num_participante, nome_camp, tipo_part)
   VALUES (2, 'Campeonato Mundial', 'Arbitro');
INSERT INTO camp_part (num_participante, nome_camp, tipo_part)
   VALUES (3, 'Internacionais', 'Jogador');
INSERT INTO camp_part (num_participante, nome_camp, tipo_part)
   VALUES (4, 'Internacionais', 'Jogador');
INSERT INTO camp_part (num_participante, nome_camp, tipo_part)
   VALUES (5, 'Internacionais', 'Jogador');




-----------------------------------------CONSULTAS-----------------------------------------


-- a)   Listar os salões (NroId, NomeHotel) onde joga o jogador cujo nome é “Bob Fisher”.
--Pego o nome do participante, vejo onde ele joga, vejo o num_jogo, e vejo o num_salao
SELECT num_salao, (SELECT nome_hotel FROM Hotel WHERE nome_hotel = Salao.nome_hotel) FROM Salao
WHERE num_salao IN (SELECT num_salao FROM Jogo
WHERE num_jogo IN (SELECT num_jogo FROM Joga
WHERE num_jogador = (SELECT num_participante FROM Participante
WHERE nome = 'Bob Fisher')));


-- resposta da consulta: 
salões(num_salao, nome_hotel)
(1, Matsoud Plaza)
(3, Hilton)


-- b)   Listar os árbitros (NumAssoc, NOmeAssoc) que arbitram somente jogos realizados no Hotel “Hilton”.
SELECT num_arb, nome FROM Jogo,
     (SELECT num_participante, nome FROM Participante WHERE tipo_part = 'Arbitro') AS arbitros,
     (SELECT num_salao FROM Salao WHERE Salao.nome_hotel IN (SELECT nome_hotel FROM Hotel where nome_hotel = 'Hilton')) as Saloes
       WHERE Jogo.num_arb = arbitros.num_participante AND
             Jogo.num_salao = Saloes.num_salao;


-- resposta da consulta: 
árbitros(num_participante, nome)
(7, Boris Sparski)
(8, Júlio)
(9, Laura)


--c)    Listar os salões (NroId, NomeHotel) que não têm “televisão”
SELECT Salao.num_salao, Salao.nome_hotel FROM Salao, Hotel
WHERE Salao.nome_hotel = Hotel.nome_hotel AND
     Salao.num_salao NOT IN (SELECT num_salao FROM Meios WHERE meio = 'televisão');


-- resposta da consulta: 
salões(num_salao, nome_hotel)
(2, Ibis Consolação)
(4, Matsoud Plaza)


--d)    Listar o nome dos árbitros que arbitram jogos em todos os salões localizados no Hotel “Matsoud Plaza”.
SELECT nome FROM Participante
 WHERE num_participante IN (SELECT num_arb FROM Jogo
   WHERE num_salao IN (SELECT num_salao FROM Salao
     WHERE nome_hotel IN (SELECT nome_hotel FROM Hotel
     WHERE nome_hotel = 'Matsoud Plaza')));


-- resposta da consulta: 
árbitro(nome)
(Boris Sparski)
(Laura)


--e)    Listar os jogos (CodJogo, IdSal) a serem feitos no mês de junho de 2023.
SELECT num_jogo, num_salao FROM Jogo
WHERE mes_jorn = 6 AND ano_jorn = 2023;


-- resposta da consulta: 
jogos(num_jogo, num_salao)
(1, 1)


--f)    Qual é a quantidade total de jogos a serem arbitrados por “Boris Sparski”?
SELECT COUNT(*) FROM Jogo
WHERE num_arb IN (SELECT num_participante FROM Participante
WHERE nome = 'Boris Sparski');


-- resposta da consulta: 
4


--g)    Qual é o pais(num, nome) com o maior número de participantes


SELECT Pais.num_pais, Pais.nome, COUNT(*) as total_participantes
FROM Participante
JOIN Pais ON Participante.num_pais = Pais.num_pais
GROUP BY Pais.num_pais, Pais.nome
ORDER BY total_participantes DESC
LIMIT 1;


-- resposta da consulta: 
pais(num_pais, nome)
(3, Chile)


--h)    Listar os jogos(num_identificador) nos quais o jogador “Garry Kasparov” joga com as fichas pretas.


SELECT Jogo.num_jogo AS num_identificador
FROM Jogador
JOIN Joga ON Jogador.num_participante = Joga.num_jogador
JOIN Jogo ON Jogo.num_jogo = Joga.num_jogo
JOIN Participante ON Participante.num_participante = Jogador.num_participante
WHERE Participante.nome = 'Garry Kasparov' AND Joga.cor = 'pretas';


-- resposta da consulta: 
jogos(num_jogo)
(1)
(5)
(6)


--i)     Remover todos os participantes acomodados no Hotel “Matsoud Plaza”


DELETE FROM Acomoda WHERE nome_hotel = 'Matsoud Plaza';


-- antes da transação:
acomoda (nome_hotel, num_participante, data_entrada, data_saida)
(Matsoud Plaza, 1, 2023–06-01, 2023-06-02)
(Ibis Consolação, 2, 2023–06-01, 2023-06-02)
(Ibis Consolação, 3, 2023–06-01, 2023-06-02)
(Matsoud Plaza, 4, 2023–06-01, 2023-06-02)
(Matsoud Plaza, 5, 2023–06-01, 2023-06-02)
(Ibis Consolação, 6, 2023–06-01, 2023-06-02)
(Matsoud Plaza, 7, 2023–06-01, 2023-06-02)
(Hilton, 8, 2023–06-01, 2023-06-02)
(Hilton, 9, 2023–06-01, 2023-06-02)




-- depois da transação:
acomoda (nome_hotel, num_participante, data_entrada, data_saida)
(Ibis Consolação, 2, 2023–06-01, 2023-06-02)
(Ibis Consolação, 3, 2023–06-01, 2023-06-02)
(Ibis Consolação, 6, 2023–06-01, 2023-06-02)
(Hilton, 8, 2023–06-01, 2023-06-02)
(Hilton, 9, 2023–06-01, 2023-06-02)


--j)    Transferir todos os participantes acomodados no Hotel "Matsoud Plaza" para o hotel "Ibis Consolação"


BEGIN TRANSACTION;
UPDATE Acomoda SET nome_hotel = 'Ibis Consolação' WHERE nome_hotel = 'Matsoud Plaza';
COMMIT;


-- antes da transação:
acomoda (nome_hotel, num_participante, data_entrada, data_saida)
(Matsoud Plaza, 1, 2023–06-01, 2023-06-02)
(Ibis Consolação, 2, 2023–06-01, 2023-06-02)
(Ibis Consolação, 3, 2023–06-01, 2023-06-02)
(Matsoud Plaza, 4, 2023–06-01, 2023-06-02)
(Matsoud Plaza, 5, 2023–06-01, 2023-06-02)
(Ibis Consolação, 6, 2023–06-01, 2023-06-02)
(Matsoud Plaza, 7, 2023–06-01, 2023-06-02)
(Hilton, 8, 2023–06-01, 2023-06-02)
(Hilton, 9, 2023–06-01, 2023-06-02)


-- depois da transação:
acomoda (nome_hotel, num_participante, data_entrada, data_saida)
(Ibis Consolação, 1, 2023–06-01, 2023-06-02)
(Ibis Consolação, 2, 2023–06-01, 2023-06-02)
(Ibis Consolação, 3, 2023–06-01, 2023-06-02)
(Ibis Consolação, 4, 2023–06-01, 2023-06-02)
(Ibis Consolação, 5, 2023–06-01, 2023-06-02)
(Ibis Consolação, 6, 2023–06-01, 2023-06-02)
(Ibis Consolação, 7, 2023–06-01, 2023-06-02)
(Hilton, 8, 2023–06-01, 2023-06-02)
(Hilton, 9, 2023–06-01, 2023-06-02)
