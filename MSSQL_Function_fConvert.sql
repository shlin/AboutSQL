CREATE FUNCTION fConvert( 

@str NVARCHAR(4000), --要轉換的字元串 

@flag bit --轉換標誌,0轉換成半形,1轉換成全形 

)RETURNS nvarchar(4000) 

AS 

BEGIN 

DECLARE @pat nvarchar(8),@step int,@i int,@spc int 

IF @flag=0 

SELECT @pat=N'%[！-～]%',@step=-65248, 

@str=REPLACE(@str,N'　 ',N' ') 

ELSE 

SELECT @pat=N'%[!-~]%',@step=65248, 

@str=REPLACE(@str,N' ',N'　 ') 

SET @i=PATINDEX(@pat COLLATE LATIN1_GENERAL_BIN,@str) 

WHILE @i> 0 

SELECT @str=REPLACE(@str, 

SUBSTRING(@str,@i,1), 

NCHAR(UNICODE(SUBSTRING(@str,@i,1))+@step)) 

,@i=PATINDEX(@pat COLLATE LATIN1_GENERAL_BIN,@str) 

RETURN(@str) 

END 
