# dbt-model

Neste repositório temos os arquivos de configuração, modelagem e transformação  
do dbt que está integrado com o Airbyte, Snowflake, Airflow

### Configuração do modelo:

1. Editar o arquivo dbt_project.yml:  
  

```name: 'nome_do_projeto' ```  
  
```profile: 'o nome do profile definido o profiles.yml'```  
  

```
models:
  nome_do_projeto:
    # Applies to all files under models/example/
    example:
      materialized: view
```

2. Criar o arquivo profiles.yml e colocar as configurações do Snowflake