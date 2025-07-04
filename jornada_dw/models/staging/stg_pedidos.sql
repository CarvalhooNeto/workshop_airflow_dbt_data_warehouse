with source as (
    select 
        *
    from
        {{ ref('pedidos') }}
    ),
transformado as (
    select
        -- chaves
        id_pedido,
        cpf,

        --valores
        valor_pedido,
        valor_frete,
        valor_desconto,
        (valor_pedido + valor_frete + coalesce(valor_desconto, 0)) as valor_total_pedido,

        --cupons
        cupom,
        case when cupom is not null then true else false end as tem_cupom,

        --endereços 
        endereco_entrega_logradouro,
        endereco_entrega_numero,
        endereco_entrega_bairro,
        endereco_entrega_cidade,
        endereco_entrega_estado,
        endereco_entrega_pais,

        -- Status
        status_pedido,
        data_pedido as dt_pedido,

        --Metadados
        current_timestamp as etl_inserted_at
    from
        source
)
select
    *
from        
    transformado