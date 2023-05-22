select name,zip from customer_card as cc left join customers as c on cc.customer_id = c.id
where card_no in (999,888,777)
order by field (cc.cara_no,999,888,777)

with customer_card_list as (
    select 
        rownum as customer_num
        ,case when card_no is null then FALSE else TRUE end as card_no_flag
        ,card_no
        ,customer_id
    from (
        select 
            ROW_NUMBER() over(order by customer_id) as rownum
            ,card_no
            ,customer_id
        from 
            laravel_db.customer_card
    ) as list
    order by customer_id
    limit 10 /* 発番するカード番号を「N」個分と指定する */
)
select
    cc.card_no
    ,c.customer_id 
    ,c.name
    ,c.zip
from
    laravel_db.customers as c 
left join 
    laravel_db.customer_card cc /*customer_card_list as ccl*/
    on c.customer_id = cc.customer_id
    and cc.card_no in (777,888,999)
order by field (cc.card_no,777,888,999),2
;