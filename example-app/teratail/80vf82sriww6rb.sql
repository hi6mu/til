DELIMITER //

SET @row_count = (SELECT COUNT(*) FROM t_juchu_dtl WHERE juchu_id = '12' AND line_no = '1');

IF @row_count = 0 THEN 
    INSERT INTO t_juchu_dtl (
        juchu_id,
        line_no,
        syohin_cd
    )
    VALUES (
        '12',
        '1',
        '1'
    );
ELSE 
    -- UPDATE文
    UPDATE t_juchu_dtl 
    SET
        syohin_cd = '1'
    WHERE
        juchu_id = '12' AND line_no = '1';
END IF //

DELIMITER ;