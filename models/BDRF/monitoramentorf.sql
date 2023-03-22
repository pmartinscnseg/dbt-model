{{ config(materialized="view") }}

with
    rf as (

        select
            hash(numbolocorrencia, trim(chassiveiculo)) as hash_value,
            numbolocorrencia,
            chassiveiculo,
            placaveiculo,
            to_date(dataregocorrencia, 'yyyymmdd') as dataregocorrencia,
            nomemunicipioplaca,
            marcamodeloveiculo,
            tpocorrencia,
            numorgaosegdeclaracao
        from airbyte_database.airbyte_schema.base_roubos_furtos

    ),
    rec as (

        select
            hash(numboldeclaracao, trim(chassiveiculo)) as hash_value,
            numbolrecuperacao,
            municipiorecuperacao,
            numboldeclaracao,
            to_date(datarecuperacao, 'yyyymmdd') as datarecuperacao,
            chassiveiculo,
            numorgaoseguranca,
            siglaufrecuperacao
        from airbyte_database.airbyte_schema.base_recuperacoes

    ),
    dev as (

        select
            hash(numboldeclaracao, trim(chassiveiculo)) as hash_value,
            siglaufdevolucao,
            municipiodevolucao,
            numboldeclaracao,
            to_date(datadevolucao, 'yyyymmdd') as datadevolucao,
            chassiveiculo,
            numorgaoseguranca
        from airbyte_database.airbyte_schema.airbyte_base_devolucoes

    )

select
    rf.*,
    (
        case
            when dev.datadevolucao is not null
            then 'DEVOLVIDO'
            when rec.datarecuperacao is not null
            then 'RECUPERADO'
            else 'NAO RECUPERADO'
        end
    ) as status,
    rec.*,
    dev.*
from rf
left join rec on rf.hash_value = rec.hash_value
-- rf.numbolocorrencia = rec.numboldeclaracao
-- and trim(rf.chassiveiculo) = trim(rec.chassiveiculo)
left join dev on rf.hash_value = dev.hash_value
-- rf.numbolocorrencia = dev.numboldeclaracao
-- and trim(rf.chassiveiculo) = trim(dev.chassiveiculo)
where numbol
order by dataregocorrencia desc
