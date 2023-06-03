import psycopg2
import matplotlib.pyplot as plt

# Função para conectar ao banco de dados
def connect():
    conn = psycopg2.connect(
        host="localhost",
        database="T2.sql",
        user="",
        password=""
    )
    return conn

# Função para gerar a programação dos jogos
def gerar_programacao():
    conn = connect()
    cursor = conn.cursor()

    # Consulta para obter os detalhes dos jogos
    query = """
        SELECT j.num_jogo, j.dia_jorn, j.mes_jorn, j.ano_jorn, p1.nome AS jogador1, p2.nome AS jogador2, p.nome AS arbitro, s.nome_hotel, s.capacidade
        FROM Jogo j
        INNER JOIN Joga jg1 ON j.num_jogo = jg1.num_jogo
        INNER JOIN Joga jg2 ON j.num_jogo = jg2.num_jogo
        INNER JOIN Participante p1 ON jg1.num_jogador = p1.num_participante
        INNER JOIN Participante p2 ON jg2.num_jogador = p2.num_participante
        INNER JOIN Participante p ON j.num_arb = p.num_participante
        INNER JOIN Salao s ON j.num_salao = s.num_salao
    """

    cursor.execute(query)
    rows = cursor.fetchall()

    # Exibir os detalhes dos jogos
    for row in rows:
        num_jogo, dia_jorn, mes_jorn, ano_jorn, jogador1, jogador2, arbitro, nome_hotel, capacidade = row
        print(f"Jogo #{num_jogo}")
        print(f"Data: {dia_jorn}/{mes_jorn}/{ano_jorn}")
        print(f"Jogadores: {jogador1} vs {jogador2}")
        print(f"Árbitro: {arbitro}")
        print(f"Local: {nome_hotel} (Capacidade: {capacidade})")
        print("----------------------------------------")

    cursor.close()
    conn.close()

# Função para gerar a lista de jogos programados para um Hotel, jogador e árbitro específico
def listar_jogos_programados(hotel, jogador, arbitro):
    conn = connect()
    cursor = conn.cursor()

    # Consulta para obter os jogos programados
    query = """
        SELECT j.num_jogo, j.dia_jorn, j.mes_jorn, j.ano_jorn
        FROM Jogo j
        INNER JOIN Salao s ON j.num_salao = s.num_salao
        INNER JOIN Hotel h ON s.nome_hotel = h.nome_hotel
        INNER JOIN Joga jg1 ON j.num_jogo = jg1.num_jogo
        INNER JOIN Joga jg2 ON j.num_jogo = jg2.num_jogo
        INNER JOIN Participante p1 ON jg1.num_jogador = p1.num_participante
        INNER JOIN Participante p2 ON jg2.num_jogador = p2.num_participante
        INNER JOIN Participante p ON j.num_arb = p.num_participante
        WHERE h.nome_hotel = %s AND p1.nome = %s AND p.nome = %s
    """

    cursor.execute(query, (hotel, jogador, arbitro))
    rows = cursor.fetchall()

    # Exibir os jogos programados
    for row in rows:
        num_jogo, dia_jorn, mes_jorn, ano_jorn = row
        print(f"Jogo #{num_jogo}")
        print(f"Data: {dia_jorn}/{mes_jorn}/{ano_jorn}")
        print("----------------------------------------")

    cursor.close()
    conn.close()

# Função para gerar uma curva que apresente os jogos por número de movimentos
def gerar_curva_movimentos():
    conn = connect()
    cursor = conn.cursor()

    # Consulta para obter o número de movimentos de cada jogo
    query = """
        SELECT num_jogo, COUNT(*) AS num_movimentos
        FROM Movimento
        GROUP BY num_jogo
    """

    cursor.execute(query)
    rows = cursor.fetchall()

    # Extrair os dados para o gráfico
    jogos = []
    num_movimentos = []
    for row in rows:
        num_jogo, num_movimento = row
        jogos.append(num_jogo)
        num_movimentos.append(num_movimento)

    # Gerar o gráfico
    plt.plot(jogos, num_movimentos)
    plt.xlabel("Número do Jogo")
    plt.ylabel("Número de Movimentos")
    plt.title("Curva de Jogos por Número de Movimentos")
    plt.show()

    cursor.close()
    conn.close()

# Função para gerar uma curva que liste o número de jogadores por país
def gerar_curva_jogadores_por_pais():
    conn = connect()
    cursor = conn.cursor()

    # Consulta para obter o número de jogadores por país
    query = """
        SELECT p.num_pais, COUNT(*) AS num_jogadores
        FROM Jogador j
        INNER JOIN Participante p ON j.num_participante = p.num_participante
        GROUP BY p.num_pais
    """

    cursor.execute(query)
    rows = cursor.fetchall()

    # Extrair os dados para o gráfico
    paises = []
    num_jogadores = []
    for row in rows:
        num_pais, num_jogador = row
        paises.append(num_pais)
        num_jogadores.append(num_jogador)

    # Gerar o gráfico
    plt.bar(paises, num_jogadores)
    plt.xlabel("Número do País")
    plt.ylabel("Número de Jogadores")
    plt.title("Curva de Número de Jogadores por País")
    plt.show()

    cursor.close()
    conn.close()

# Exemplo de uso das funções
gerar_programacao()
listar_jogos_programados("Nome do Hotel", "Nome do Jogador", "Nome do Árbitro")
gerar_curva_movimentos()
gerar_curva_jogadores_por_pais()
