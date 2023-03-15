# dbt-model

Neste repositório temos os arquivos de configuração, modelagem e transformação  
do dbt que está integrado com o Airbyte, Snowflake, Airflow

### Configuração do modelo:

1. Editar o arquivo dbt_project.yml:  
  
  
```name: 'nome_do_projeto' ```  
```
models:
  nome_do_projeto:
    # Applies to all files under models/example/
    example:
      materialized: view
```