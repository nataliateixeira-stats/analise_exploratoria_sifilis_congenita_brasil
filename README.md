# Sífilis congênita: perfil das notificações, tendência do pré-natal e letalidade

Projeto final da disciplina **Programação e Análise de Dados** (Prof. Lucas Miguel de Carvalho).

**Grupo:** Natália Teixeira Pinto

## Descrição

Análise exploratória de notificações de sífilis congênita do SINAN (2013–2023), em R. O projeto:

1. carrega e prepara um subconjunto de 8 variáveis de interesse (qualidade dos dados, recodificação, variáveis derivadas e padronização);
2. descreve a amostra (Tabela 1) e produz cinco gráficos (barras, histograma, linhas, boxplot e mapa de calor);
3. implementa duas funções próprias (`resumo_ausentes()` e `freq_por_grupo()`);
4. desenvolve duas análises: (i) tendência da proporção de mães com pré-natal ao longo dos anos e (ii) comparação da letalidade entre grupos.

As análises são descritivas; não foram aplicados testes de hipótese nem ajuste por outras variáveis.

## Dados

- **Fonte:** SINAN / Ministério da Saúde (ficha de notificação de sífilis congênita) — http://tabnet.datasus.gov.br/cgi/tabcgi.exe?sinannet/cnv/sifilisbr.def
- **Arquivo no repositório:** `dados_sifilis_selecionados.csv` (251.659 linhas, 8 colunas), construído a partir dos arquivos anuais `.dbc` de sífilis congênita (`SIFCBR13` a `SIFCBR23`, 2013–2023), lidos com o pacote `read.dbc` pelo script `00_baixar_e_preparar_dados.R`. Contém apenas as variáveis analisadas: ano, UF de residência, idade, raça/cor e escolaridade da mãe, pré-natal, parceiro tratado e evolução do caso. **Não inclui datas, município ou outros campos que possam identificar casos.**
- Dados públicos, sem identificação direta de pessoas. Separador vírgula; todos os valores são códigos numéricos do SINAN (ver dicionário no relatório).

## Conteúdo do repositório

| Arquivo | Descrição |
|---|---|
| `projeto_final_sifilis_congenita.Rmd` | Relatório completo (código, explicações, gráficos e interpretações) |
| `00_baixar_e_preparar_dados.R` | Lê os `.dbc` do SINAN, une os anos e gera o arquivo reduzido |
| `dados_sifilis_selecionados.csv` | Dados reduzidos (8 colunas) usados na análise |
| `README.md` | Este arquivo |

## Como executar

*(Opcional)* Para recriar o arquivo de dados a partir dos `.dbc`: baixe os arquivos `SIFCBR13.dbc` a `SIFCBR23.dbc` (http://tabnet.datasus.gov.br/cgi/tabcgi.exe?sinannet/cnv/sifilisbr.def), coloque-os em `data/dbc/` e rode `00_baixar_e_preparar_dados.R` (pacotes: `read.dbc`, `dplyr`, `stringi`, `janitor`). A pasta `data/dbc/` não é versionada.

**Para rodar o relatório:**

1. Requisitos: **R ≥ 4.1** e RStudio (recomendado).
2. Instale os pacotes (uma vez):

   ```r
   install.packages(c("readr", "dplyr", "tidyr", "ggplot2", "scales",
                      "table1", "knitr", "kableExtra"))
   ```

3. Mantenha `dados_sifilis_selecionados.csv` na mesma pasta do `.Rmd` (já está no repositório).
4. Abra `projeto_final_sifilis_congenita.Rmd` no RStudio e clique em **Knit** (saída HTML).

Para usar outra base, ajuste os objetos `arquivo` e `mapa` no início do relatório.

## Resultados principais

[Resumir em 2 a 3 frases os achados da Análise 1 e da Análise 2, depois de rodar o relatório.]
