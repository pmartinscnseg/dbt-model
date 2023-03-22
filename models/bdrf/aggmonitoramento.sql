{{ config(materialized="table") }}

select 
    hash(chassiveiculo) as id_veic,
    dataregocorrencia,
    datediff(day, datarecuperacao, dataregocorrencia) as dias_ate_rec,
    datediff(day, datadevolucao, dataregocorrencia) as dias_ate_dev,
    datediff(day, datadevolucao, datarecuperacao) as dias_dev_rec,
    nomemunicipioplaca,
    marcamodeloveiculo,
    tpocorrencia,
    status,
    municipiorecuperacao,
    datarecuperacao,
    numorgaoseguranca as numorgaosegurancarecuperacao,
    siglaufrecuperacao,
    siglaufdevolucao,
    municipiodevolucao,
    datadevolucao,
    numorgaosegurancadevolucao,
    count(hash_value) as qtd
from {{ ref('monitoramento') }}
group by
    id_veic,
    dataregocorrencia,
    --datediff(day, datarecuperacao, dataregocorrencia) as dias_ate_rec,
    --datediff(day, datadevolucao, dataregocorrencia) as dias_ate_dev,
    --datediff(day, datadevolucao, datarecuperacao) as 
    dias_ate_rec,
    dias_ate_dev,
    dias_dev_rec,
    nomemunicipioplaca,
    marcamodeloveiculo,
    tpocorrencia,
    status,
    municipiorecuperacao,
    datarecuperacao,
    numorgaosegurancarecuperacao,
    siglaufrecuperacao,
    siglaufdevolucao,
    municipiodevolucao,
    datadevolucao,
    numorgaosegurancadevolucao
order by qtd DESC