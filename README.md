# quant-energia-raw

Pacotes compactados de parte do `raw/` do `quant-energia-app` (dados brutos de fontes públicas), para levar os
arquivos a outra aplicação sem passar pelo histórico do git. **Os zips ficam nos releases, não no repositório.**

| Pacote | Conteúdo |
|---|---|
| `raw-pequenos.zip` | `aneel_bandeiras`, `ccee_limites_pld`, `ccee_patamares`, `cpc_enso_previsao`, `noaa_indices`, `ons_ena_historica` |
| `raw-ons_ena_diaria.zip` | `ons_ena_diaria` (subsistema e bacia, todas as versões) |
| `raw-ccee_boletim.zip` | `ccee_boletim` (InfoBandeira) |
| `raw-ons_pmo.zip` | `ons_pmo` (relato, ENA e renovaveis por mês) |
| `raw-noaa_ersst.zip` | `noaa_ersst` (grade ERSST v6, ~90 MB) |

Cada zip guarda as pastas com o nome da fonte na raiz: descompactar dentro de `data/raw/` reconstitui o layout.

## Baixar

```bash
./baixar.sh                      # último release, para ./raw
./baixar.sh raw-2026-11-04 ~/projects/outra-app/data/raw
```

O script baixa os zips do release, confere o `SHA256SUMS` e descompacta no destino. Sem dependência além de
`curl`, `shasum` e `unzip`. Os arquivos não são sobrescritos silenciosamente: o `unzip` pergunta antes.

## Atualizar (novo release)

```bash
gh release create raw-AAAA-MM-DD raw-*.zip SHA256SUMS --repo pimenta-arthur/quant-energia-raw \
  --title "raw AAAA-MM-DD" --notes "<o que mudou>"
```

## Observações

- Os dados vêm de ANEEL, CCEE, ONS, NOAA e CPC e entram **como foram baixados** (`raw/` é imutável no app).
- Cada release é um retrato completo dos pacotes; a ERSST guarda só a publicação mais recente.
