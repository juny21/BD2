import psycopg2
import matplotlib.pyplot as plt

# Função para conectar ao banco de dados
def conectar_bd():
    conn = psycopg2.connect(
        host="seu_host",
        database="seu_banco_de_dados",
        user="seu_usuario",
        password="sua_senha"
    )
    return conn


# Função para gerar a programação dos jogos
def gerar_programacao_jogos():
    conn = conectar_bd()
    cur = conn.cursor()

    cur.execute("""
        SELECT j.num_jogo, p1.nome AS jogador1, p2.nome AS jogador2, pa.nome AS arbitro, s.nome_hotel, j.dia_jorn, j.mes_jorn, j.ano_jorn
        FROM Jogo j
        JOIN Joga jg1 ON j.num_jogo = jg1.num_jogo
        JOIN Joga jg2 ON j.num_jogo = jg2.num_jogo
        JOIN Participante p1 ON jg1.num_jogador = p1.num_participante
        JOIN Participante p2 ON jg2.num_jogador = p2.num_participante
        JOIN Participante pa ON j.num_arb = pa.num_participante
        JOIN Salao s ON j.num_salao = s.num_salao
    """)

    programacao_jogos = cur.fetchall()
    cur.close()
    conn.close()

    return programacao_jogos


# Função para gerar a lista de jogos programados para um hotel, jogador e árbitro específico
def gerar_jogos_programados(nome_hotel, num_jogador, num_arbitro):
    conn = conectar_bd()
    cur = conn.cursor()

    cur.execute("""
        SELECT j.num_jogo, p1.nome AS jogador1, p2.nome AS jogador2, pa.nome AS arbitro, s.nome_hotel, j.dia_jorn, j.mes_jorn, j.ano_jorn
        FROM Jogo j
        JOIN Joga jg1 ON j.num_jogo = jg1.num_jogo
        JOIN Joga jg2 ON j.num_jogo = jg2.num_jogo
        JOIN Participante p1 ON jg1.num_jogador = p1.num_participante
        JOIN Participante p2 ON jg2.num_jogador = p2.num_participante
        JOIN Participante pa ON j.num_arb = pa.num_participante
        JOIN Salao s ON j.num_salao = s.num_salao
        WHERE s.nome_hotel = %s AND jg1.num_jogador = %s AND j.num_arb = %s
    """, (nome_hotel, num_jogador, num_arbitro))

    jogos_programados = cur.fetchall()
    cur.close()
    conn.close()

    return jogos_programados


# Função para gerar a curva de jogos por número de movimentos
def gerar_curva_movimentos():
    conn = conectar_bd()
    cur = conn.cursor()

    cur.execute("""
        SELECT num_jogo, COUNT(*) AS num_movimentos
        FROM Movimento
        GROUP BY num_jogo
    """)

    resultados = cur.fetchall()
    cur.close()
    conn.close()

    num_jogos = [r[0] for r in resultados]
    num_movimentos = [r[1] for r in resultados]

    # Plotar a curva
    plt.plot(num_jogos, num_movimentos)
    plt.xlabel('Número do Jogo')
    plt.ylabel('Número de Movimentos')
    plt.title('Curva de Jogos por Número de Movimentos')
    plt.show()


# Função para gerar a curva de número de jogadores por país
def gerar_curva_jogadores_por_pais():
    conn = conectar_bd()
    cur = conn.cursor()

    cur.execute("""
        SELECT p.num_pais, COUNT(*) AS num_jogadores
        FROM Participante p
        WHERE p.tipo_part = 'jogador'
        GROUP BY p.num_pais
    """)

    resultados = cur.fetchall()
    cur.close()
    conn.close()

    paises = [r[0] for r in resultados]
    num_jogadores = [r[1] for r in resultados]

    # Plotar a curva
    plt.bar(paises, num_jogadores)
    plt.xlabel('Número do País')
    plt.ylabel('Número de Jogadores')
    plt.title('Curva de Número de Jogadores por País')
    plt.show()


# Exemplos de uso
programacao_jogos = gerar_programacao_jogos()
print("Programação de Jogos:")
for jogo in programacao_jogos:
    print(jogo)

jogos_programados = gerar_jogos_programados("Nome do Hotel", 1, 2)
print("Jogos Programados:")
for jogo in jogos_programados:
    print(jogo)

gerar_curva_movimentos()

gerar_curva_jogadores_por_pais()
