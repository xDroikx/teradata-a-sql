---TERADATA---
cast(cast( ( 1900000+(cast((coalesce(nullifzero(cxeft),1)) as integer))) as char(8)) as date format 'yyyyddd') AS fecha
---SQL SERVER---
CONVERT(DATE, DATEADD (d, CAST(NULLIF(cxeft, 0) AS INT) - ((CAST(NULLIF(cxeft, 0) AS INT) / 1000) * 1000), CONVERT(DATETIME, STR((CAST(NULLIF(cxeft, 0) AS INT) / 1000) + 1900 ) + '0101')) - 1, 103) AS fecha
                            --
---TERADATA---
coalesce(T1.fecha, cast('1900001' as date format 'yyyyddd')) as fecha_desde
---SQL SERVER---
COALESCE(T1.fecha, CONVERT(DATE, '19000101', 103)) as fecha_desde
---TERADATA---
CAST(CAST(9999001  AS CHAR(8)) AS DATE FORMAT 'YYYYDDD')
---SQL SERVER---
CONVERT(DATE, '99990101', 103)
---TERADATA---
coalesce(T2.Fecha -1, cast('9999001' as date format 'yyyyddd')) as fecha_hasta
---SQL SERVER---
COALESCE(DATEADD(DAY, -1, T2.Fecha), CONVERT(DATE, '99990101', 103)) as fecha_hasta
--Fecha Sin Hora.
SELECT *, CONVERT(DATE, DateAdd (d, CAST(ADUPMJ AS INT) - ((CAST(ADUPMJ AS INT) / 1000) * 1000), convert(datetime, str((CAST(ADUPMJ AS INT) / 1000) + 1900 ) + '0101')) - 1, 103)  FROM T911F76A4211
--Fecha Con Hora.
SELECT *, DateAdd (d, CAST(ADUPMJ AS INT) - ((CAST(ADUPMJ AS INT) / 1000) * 1000), convert(datetime, str((CAST(ADUPMJ AS INT) / 1000) + 1900 ) + '0101')) - 1  FROM T911F76A4211
---TERADATA---
CAST(CAST((1900000+(CAST((COALESCE(NULLIFZERO(a.sdivd),1)) AS INTEGER)))  AS CHAR(8)) AS DATE FORMAT 'YYYYDDD')
---SQL SERVER---
CONVERT(DATE, DateAdd (d, CAST(NULLIF(sdivd, 0) AS INT) - ((CAST(NULLIF(sdivd, 0) AS INT) / 1000) * 1000), convert(datetime, str((CAST(NULLIF(sdivd, 0) AS INT) / 1000) + 1900 ) + '0101')) , 103)
--ESTO ES PARA OBTENER EL NUMERO DE TERADATA DE LA FECHA JULIANA
--Teradata. La fecha en numero mas 1900000, me da como resultado un numero de 7 digitos, donde los 4 primeros corresponden al año y los 3 siguientes al dia del año
--SQL Server. - Con esto obtengo la fecha del dia 316 del año 2023
SELECT DATEADD(DAY, 316 - 1, DATEFROMPARTS(2023, 1, 1)) AS FechaDia316
--SQL Server. - Con esto obtengo el dia del año 2023
SELECT DATEPART(DAYOFYEAR, '2024-02-09') AS DiaDelAño
--SQL Server. - Con esto obtengo el numero que guarda teradata como fecha en formato juliana para la fecha del dia
SELECT ((YEAR(GETDATE()) * 1000) + DATEPART(DAYOFYEAR, GETDATE())) - 1900000
--SQL Server. - Con esto obtengo el numero que guarda teradata como fecha en formato juliana para una fecha X
SELECT ((YEAR('2023-11-12') * 1000) + DATEPART(DAYOFYEAR, '2023-11-12')) - 1900000
---TERADATA---
CAST(((P.pnddj /1000) * 10000) + 0101 AS DATE ) + ( (P.pnddj  MOD 1000 ) - 1 ) Fix_Due_Dt
---SQL SERVER---
COALESCE((CONVERT(DATE, DATEADD (d, CAST(NULLIF(P.pnddj, 0) AS INT) - ((CAST(NULLIF(P.pnddj, 0) AS INT) / 1000) * 1000),
	CONVERT(DATETIME, STR((CAST(NULLIF(P.pnddj, 0) AS INT) / 1000) + 1900 ) + '0101')) - 1, 103)), CONVERT(DATE, '31-12-1899',103)) AS fecha

--esta funcion es del extract
---TERADATA---	
extract(year from Date)  
---SQL SERVER---
YEAR(GETDATE())
---TERADATA---
extract(month from Date)
---SQL SERVER---
MONTH(GETDATE())

CONVERT(DATE, DATEADD (d, CAST(NULLIF(UMUPMJ, 0) AS INT) - ((CAST(NULLIF(UMUPMJ, 0) AS INT) / 1000) * 1000), CONVERT(DATETIME, STR((CAST(NULLIF(UMUPMJ, 0) AS INT) / 1000) + 1900 ) + '0101')) - 1, 103) AS UOM_Transl_Start_Dt,

--esta funcion usaste en AR_ITM_MT_UNIT_OF_MEASURE_TRNS

--que tambien devuelve el mismo valor que DATE_Year_Month_Day

dbo.Jul_To_Date() -- pasa fecha juliana a dato
dbo.Jul_To_Month() --pasa fecha juliana a int
dbo.Date_To_Jul() --pasa dato a fecha juliana

--TERADATE TE PERMITE PERMITE USAR UN TIPO DE DATO "DATE" COMO FECHA Y COMO NUMERO

--TERADATA--
AND (d.abac22, a.sddcto) not in (SELECT TRIM(substr(drky,8,3)) abac22, TRIM(substr(drky,6,2)) sddcto FROM p_sourcing.t001f0005
--SQL--
AND EXISTS (SELECT TRIM(SUBSTRING(drky,8,3)) abac22, TRIM(SUBSTRING(drky,6,2)) sddcto FROM DWL_SOURCING_JDE.dbo.t001f0005