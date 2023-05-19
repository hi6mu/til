SELECT 
    TO_DATE(start_date,'YYYY/MM/DD' HH24:MI:SS')+LEVEL -1 AS effective_date
    ,employee_no
FROM 
    EMPLOYEE 
CONNECT BY 
    TO_DATE(start_date,'YYYY/MM/DD' HH24:MI:SS')+LEVEL -1 <=TO_DATE(end_date,'YYYY/MM/DD' HH24:MI:SS'); 
;

select 
    row_number() over(order by start_date) as ROWNUM 
    ,TO_DATE('2023-01-01','YYYY/MM/DD' HH24:MI:SS')+ROWNUM AS CAL_DATE
from 
    mysql.user
limit 10
;

select 
    --ROW_NUMBER() over(order by user) as ROWNUM
    TO_DATE(password_lifetime,'YYYY/MM/DD HH24:MI:SS') as CAL_DATE
from 
    mysql.user
limit 10
;

SET @in_date = '2022-12-31';
--

with cal as (
    select 
        DATE_ADD('2023-01-02', INTERVAL ROWNUM DAY) as effective_date
    from (
        select 
            ROW_NUMBER() over(order by employee_no) as ROWNUM
        from 
            laravel_db.employee
    ) as r
    order by effective_date 
    limit 3 /* カレンダーを「N」日間分と指定する */
)
select
    cal.effective_date
    ,em.employee_no
from 
    cal
left join 
    laravel_db.employee em 
    on cal.effective_date between em.start_date and em.end_date
order by cal.effective_date, em.employee_no
;

+-----------+------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+----------+------------------------+--------------------------+----------------------------+---------------+-------------+-----------------+----------------------+-----------------------+------------------------------------------------------------------------+------------------+-----------------------+-------------------+----------------+------------------+----------------+------------------------+---------------------+--------------------------+-----------------+
| Host      | User             | Select_priv | Insert_priv | Update_priv | Delete_priv | Create_priv | Drop_priv | Reload_priv | Shutdown_priv | Process_priv | File_priv | Grant_priv | References_priv | Index_priv | Alter_priv | Show_db_priv | Super_priv | Create_tmp_table_priv | Lock_tables_priv | Execute_priv | Repl_slave_priv | Repl_client_priv | Create_view_priv | Show_view_priv | Create_routine_priv | Alter_routine_priv | Create_user_priv | Event_priv | Trigger_priv | Create_tablespace_priv | ssl_type | ssl_cipher             | x509_issuer              | x509_subject               | max_questions | max_updates | max_connections | max_user_connections | plugin                | authentication_string                                                  | password_expired | password_last_changed | password_lifetime | account_locked | Create_role_priv | Drop_role_priv | Password_reuse_history | Password_reuse_time | Password_require_current | User_attributes |
+-----------+------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+----------+------------------------+--------------------------+----------------------------+---------------+-------------+-----------------+----------------------+-----------------------+------------------------------------------------------------------------+------------------+-----------------------+-------------------+----------------+------------------+----------------+------------------------+---------------------+--------------------------+-----------------+
| %         | hiromu           | N           | N           | N           | N           | N           | N         | N           | N             | N            | N         | N          | N               | N          | N          | N            | N          | N                     | N                | N            | N               | N                | N                | N              | N                   | N                  | N                | N          | N            | N                      |          | 0x                     | 0x                       | 0x                         |             0 |           0 |               0 |                    0 | caching_sha2_password | $A$005$^}ZI5+S    |'oHK3Toi/2DDS7O9FZh45JEXExQBla.l1C.f.oakDuR9fRNtqc8 | N                | 2023-05-16 15:30:06   |              NULL | N              | N                | N              |                   NULL |                NULL | NULL                     | NULL            |
| %         | root             | Y           | Y           | Y           | Y           | Y           | Y         | Y           | Y             | Y            | Y         | Y          | Y               | Y          | Y          | Y            | Y          | Y                     | Y                | Y            | Y               | Y                | Y                | Y              | Y                   | Y                  | Y                | Y          | Y            | Y                      |          | 0x                     | 0x                       | 0x                         |             0 |           0 |               0 |                    0 | caching_sha2_password | $A$005/}m4e_f718gwul8kVFugAGer..oD/Q2MLtOo3xVqYNVh9YhBRWO4P9 | N                | 2023-05-16 15:30:06   |              NULL | N              | Y                | Y              |                   NULL |                NULL | NULL                     | NULL            |
| localhost | mysql.infoschema | Y           | N           | N           | N           | N           | N         | N           | N             | N            | N         | N          | N               | N          | N          | N            | N          | N                     | N                | N            | N               | N                | N                | N              | N                   | N                  | N                | N          | N            | N                      |          | 0x                     | 0x                       | 0x                         |             0 |           0 |               0 |                    0 | caching_sha2_password | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | N                | 2023-05-16 15:29:45   |              NULL | Y              | N                | N              |                   NULL |                NULL | NULL                     | NULL            |
| localhost | mysql.session    | N           | N           | N           | N           | N           | N         | N           | Y             | N            | N         | N          | N               | N          | N          | N            | Y          | N                     | N                | N            | N               | N                | N                | N              | N                   | N                  | N                | N          | N            | N                      |          | 0x                     | 0x                       | 0x                         |             0 |           0 |               0 |                    0 | caching_sha2_password | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | N                | 2023-05-16 15:29:45   |              NULL | Y              | N                | N              |                   NULL |                NULL | NULL                     | NULL            |
| localhost | mysql.sys        | N           | N           | N           | N           | N           | N         | N           | N             | N            | N         | N          | N               | N          | N          | N            | N          | N                     | N                | N            | N               | N                | N                | N              | N                   | N                  | N                | N          | N            | N                      |          | 0x                     | 0x                       | 0x                         |             0 |           0 |               0 |                    0 | caching_sha2_password | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | N                | 2023-05-16 15:29:45   |              NULL | Y              | N                | N              |                   NULL |                NULL | NULL                     | NULL            |
| localhost | root             | Y           | Y           | Y           | Y           | Y           | Y         | Y           | Y             | Y            | Y         | Y          | Y               | Y          | Y          | Y            | Y          | Y                     | Y                | Y            | Y               | Y                | Y                | Y              | Y                   | Y                  | Y                | Y          | Y            | Y                      |          | 0x                     | 0x                       | 0x                         |             0 |           0 |               0 |                    0 | caching_sha2_password | $A$005$/2Wyv,O        d
                 ^[9*(zzLQBSCp7SnI1DpNgSImDArF3vOxdNwCHiQVzt7dq.C | N                | 2023-05-16 15:30:06   |              NULL | N              | Y                | Y              |                   NULL |                NULL | NULL                     | NULL            |
+-----------+------------------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+------------+-----------------+------------+------------+--------------+------------+-----------------------+------------------+--------------+-----------------+------------------+------------------+----------------+---------------------+--------------------+------------------+------------+--------------+------------------------+----------+------------------------+--------------------------+----------------------------+---------------+-------------+-----------------+----------------------+-----------------------+------------------------------------------------------------------------+------------------+-----------------------+-------------------+----------------+------------------+----------------+------------------------+---------------------+--------------------------+-----------------+

+-----------+----------+--------------+-------------+-----------+-----------------+-----------+---------------+-----------+-----------+----------+-----------------+------------------+------------------+-------------+-------------+-----------------+------------+----------------------+---------------------------------+-----------------------------+-----------------------+------------------+--------------------+
| THREAD_ID | EVENT_ID | END_EVENT_ID | EVENT_NAME  | STATE     | TRX_ID          | GTID      | XID_FORMAT_ID | XID_GTRID | XID_BQUAL | XA_STATE | SOURCE          | TIMER_START      | TIMER_END        | TIMER_WAIT  | ACCESS_MODE | ISOLATION_LEVEL | AUTOCOMMIT | NUMBER_OF_SAVEPOINTS | NUMBER_OF_ROLLBACK_TO_SAVEPOINT | NUMBER_OF_RELEASE_SAVEPOINT | OBJECT_INSTANCE_BEGIN | NESTING_EVENT_ID | NESTING_EVENT_TYPE |
+-----------+----------+--------------+-------------+-----------+-----------------+-----------+---------------+-----------+-----------+----------+-----------------+------------------+------------------+-------------+-------------+-----------------+------------+----------------------+---------------------------------+-----------------------------+-----------------------+------------------+--------------------+
|         1 |       21 |           21 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3343242418000 |    3343338335000 |    95917000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       22 |           22 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3347779001000 |    3348027001000 |   248000000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       23 |           23 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3352040210000 |    3352180293000 |   140083000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       24 |           24 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3357068293000 |    3357150710000 |    82417000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       15 |           15 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3206965293000 |    3208465501000 |  1500208000 | READ WRITE  | REPEATABLE READ | NO         |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       16 |           16 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3256671168000 |    3256774251000 |   103083000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       17 |           17 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3257575710000 |    3258080960000 |   505250000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       18 |           18 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3258668126000 |    3272363335000 | 13695209000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       19 |           19 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3314060376000 |    3315193793000 |  1133417000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|         1 |       20 |           20 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3335188751000 |    3336060626000 |   871875000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|        38 |        1 |            1 | transaction | COMMITTED | 281750261474952 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    2943238626000 |    2943719835000 |   481209000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|        47 |        1 |            1 | transaction | COMMITTED | 281750261475760 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 |    3402915210000 |    3403268460000 |   353250000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |             NULL | NULL               |
|        52 |        3 |            3 | transaction | COMMITTED | 281750261476568 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 | 2868046175077000 | 2868051008411000 |  4833334000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |                2 | STATEMENT          |
|        52 |        5 |            5 | transaction | COMMITTED | 281750261476568 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 | 2920559075490000 | 2920566531699000 |  7456209000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |                4 | STATEMENT          |
|        52 |        7 |            7 | transaction | COMMITTED | 281750261476568 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 | 3108101190619000 | 3108103303744000 |  2113125000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |                6 | STATEMENT          |
|        52 |        9 |            9 | transaction | COMMITTED | 281750261476568 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 | 3163259314117000 | 3163268408825000 |  9094708000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |                8 | STATEMENT          |
|        52 |       11 |           11 | transaction | COMMITTED | 281750261476568 | AUTOMATIC |          NULL | NULL      | NULL      | NULL     | handler.cc:1346 | 3194930590534000 | 3194950579076000 | 19988542000 | READ WRITE  | REPEATABLE READ | YES        |                    0 |                               0 |                           0 |                  NULL |               10 | STATEMENT          |
+-----------+----------+--------------+-------------+-----------+-----------------+-----------+---------------+-----------+-----------+----------+-----------------+------------------+------------------+-------------+-------------+-----------------+------------+----------------------+---------------------------------+-----------------------------+-----------------------+------------------+--------------------+