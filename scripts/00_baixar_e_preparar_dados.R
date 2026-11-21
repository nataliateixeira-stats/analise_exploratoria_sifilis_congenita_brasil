# ============================================================
# Preparação dos dados — Sífilis congênita (SINAN, 2013–2023)
#
# 1) Lê os arquivos anuais .dbc (SIFCBR13.dbc ... SIFCBR23.dbc),
#    baixados do DATASUS/SINAN.
# 2) Une os anos em uma única base e padroniza os nomes das colunas.
# 3) Seleciona as 8 variáveis usadas no relatório e salva
#    "dados_sifilis_selecionados.csv" 
#
# Como usar:
#   - Coloque os arquivos .dbc na pasta data/dbc/ (esta pasta NÃO
#     é versionada no GitHub; veja o .gitignore).
#   - Rode o script a partir da pasta do projeto.
# ============================================================
devtools::install_github("danicat/read.dbc")
pak::pak("danicat/read.dbc")
library(read.dbc)   # leitura de arquivos .dbc do DATASUS
library(dplyr)      # manipulação de dados
library(stringi)    # padronização de texto/codificação
library(janitor)    # clean_names(): nomes de colunas em minúsculas

# ---- Configuração -------------------------------------------
dir_dbcs <- file.path("data", "dbc")       # pasta com os .dbc
anos     <- 13:23                          # 2013 a 2023
saida    <- "dados_sifilis_selecionados.csv"

# Variáveis mantidas (nomes já padronizados por clean_names)
variaveis <- c("nu_ano", "sg_uf", "ant_idade", "ant_raca",
               "escolmae", "ant_pre_na", "ant_tratad", "evolucao")

# ---- Leitura de todos os .dbc -------------------------------
arquivos <- file.path(dir_dbcs, sprintf("SIFCBR%02d.dbc", anos))
existem  <- file.exists(arquivos)
if (!all(existem)) {
  warning("Arquivos ausentes:\n", paste(arquivos[!existem], collapse = "\n"))
}

ler_um_dbc <- function(path) {
  df <- read.dbc(path)
  # Garante UTF-8 e nomes de colunas sem acentos
  names(df) <- stri_trans_general(names(df), "Latin-ASCII")
  df <- data.frame(lapply(df, function(col) {
    if (is.character(col)) return(stri_encode(col, "", "UTF-8"))
    col
  }), check.names = FALSE)
  janitor::clean_names(df)
}

lista <- lapply(arquivos[existem], ler_um_dbc)
raw   <- bind_rows(lista) %>%
  mutate(nu_ano = as.integer(substr(nu_ano, 1, 4)))

str(raw)

# ---- Seleção das variáveis e gravação -----------------------
dados_sel <- raw %>% select(all_of(variaveis))

write.csv(dados_sel, saida, row.names = FALSE, na = "", fileEncoding = "UTF-8")
cat("Arquivo salvo:", saida, "(", nrow(dados_sel), "linhas )\n")
