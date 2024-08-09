USE [DWL_TABLES]
GO
/****** Object:  StoredProcedure [dbo].[STJDE_DW_AR_ACC_MT_REMITTANCE_TYPE]    Script Date: 16/5/2024 17:24:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
==============================================================================================================
Fecha: 25/06/2024
Creado por:	DataMind - Gabriel Zilli
Version 1.0
Descripcion: Sin descripcion
==============================================================================================================
*/
ALTER PROC [dbo].[STJDE_DW_AR_ACC_MT_REMITTANCE_TYPE]
	
AS 

--Inicio de la ejecucion del Proceso de carga de AR_ACC_MT_REMITTANCE_TYPE.

--Paso 1: Generacion del Lote de Carga para el proceso.

EXEC DWL_SOURCING_JDE.dbo.JDE_ST_ETL_LOAD_CONTROL 'STJDE_DW_AR_ACC_MT_REMITTANCE_TYPE', 'I', NULL, 0;

--Paso 2: Genera temporal. 
SELECT  
	TRIM (drky ) AS Remittance_Type_cd,
	'AR' AS Src_Env_Id,
	drdl01 AS Remittance_Type_Desc
INTO #TMP_REMITTANCE_TYPE
FROM DWL_SOURCING_JDE.dbo.T001F0005
WHERE 
	drsy = '00'  
	AND drrt = 'DT' 
	AND drky <> ' ';

-- Paso 3: Inserta valor no informado
INSERT INTO #TMP_REMITTANCE_TYPE 
(
	Remittance_Type_cd,
	Src_Env_Id,
	Remittance_Type_Desc
)
VALUES ('-1', 'AR', 'Valor no informado');

 --Paso 4: Borrado de la tabla del Relacional. 
DELETE FROM DWL_TABLES.dbo.REMITTANCE_TYPE
WHERE EXISTS (
    SELECT 1
    FROM #TMP_REMITTANCE_TYPE
    WHERE REMITTANCE_TYPE.Remittance_Type_cd = #TMP_REMITTANCE_TYPE.Remittance_Type_cd
	AND REMITTANCE_TYPE.Src_Env_Id = #TMP_REMITTANCE_TYPE.Src_Env_Id
);
      
--Paso 5: Insercion de las novedades en el Relacional.
INSERT INTO DWL_TABLES.dbo.REMITTANCE_TYPE 
(
	Remittance_Type_cd,
	Src_Env_Id,
	Remittance_Type_Desc,
	Load_Id
 )
SELECT 
	Remittance_Type_cd,
	Src_Env_Id,
	Remittance_Type_Desc,
	Load_Id
FROM #TMP_REMITTANCE_TYPE,
	##TMP_LOAD_ID;

--Paso 6: Actualizacion del lote de carga con los registros utilizados y la hora de finalizacion.
DECLARE @LineasActualiza NUMERIC(10);
SELECT @LineasActualiza = COUNT(1) FROM #TMP_REMITTANCE_TYPE;
EXEC DWL_SOURCING_JDE.dbo.JDE_ST_ETL_LOAD_CONTROL NULL, 'F', '#TMP_REMITTANCE_TYPE', @LineasActualiza;

--Paso 7: Elimino las tablas temporales.
DROP TABLE #TMP_REMITTANCE_TYPE; 