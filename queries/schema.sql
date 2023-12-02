--https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4410183661.html#subsect_78154538485
   SELECT T.table_qualifier,
          T.table_name,
          T.oa_userdata AS oa_table_userdata,
          T.remarks AS table_desc,
          C.column_name,
          C.type_name,
          C.oa_length,
          C.oa_precision,
          C.oa_radix,
          C.oa_scale,
          C.oa_userdata AS oa_col_userdata,
          C.remarks AS column_desc,
          PK.pk_name,
          FK.pktable_name,
          FK.pkcolumn_name,
          FK.fk_name
     FROM oa_tables AS T
LEFT JOIN oa_columns AS C ON T.table_name = C.table_name
LEFT JOIN oa_fkeys AS PK ON PK.pktable_name = T.table_name
      AND PK.pkcolumn_name = C.column_name
LEFT JOIN oa_fkeys AS FK ON FK.fktable_name = T.table_name
      AND FK.fkcolumn_name = C.column_name
    WHERE T.table_name = '${DESCRIBE_TABLE}'