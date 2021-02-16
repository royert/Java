-- OBJECT: DATABASE [BD_DIABLOS'] 
IF EXISTS (SELECT * FROM SYSDATABASES WHERE (NAME = 'BD_DIABLOS'))
       BEGIN
            USE [MASTER]
		    DROP DATABASE BD_DIABLOS
       END
   ELSE
   USE [MASTER]
   CREATE DATABASE BD_DIABLOS
GO
USE BD_DIABLOS
GO
USE BD_DIABLOS
GO
-- OBJECT: TABLE [DBO].[TBLUSUARIOS] 
IF OBJECT_ID ('[dbo].[TBLUSUARIOS]') IS NOT NULL
   BEGIN
        BEGIN TRY 
          DROP TABLE [dbo].[TBLUSUARIOS];
		END TRY
		BEGIN CATCH
		   PRINT ('Imposible Borrrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE TABLE [dbo].[TBLUSUARIOS]
(
IdUsuario  [INT]  IDENTITY(1,1) NOT NULL, 
Cedula     [VARCHAR](10)  NOT NULL,
Nombres    [VARCHAR](300) NOT NULL,
Apellidos  [VARCHAR](300) NOT NULL,
Direccion  [VARCHAR](300) NOT NULL,
Genero     [VARCHAR](10)  NOT NULL,
Telefono   [VARCHAR](15)  NOT NULL,
Usuario    [VARCHAR](300) NOT NULL,
Contraseņa [VARCHAR](100) NOT NULL,

CONSTRAINT [Pk_TblUsuarios_Id] PRIMARY KEY CLUSTERED (IdUsuario)
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [INC_TBLUSUARIOS] ON [dbo].[TBLUSUARIOS]
(
  [Cedula] ASC
);
GO
-- OBJECT: TABLE [dbo].[TBLENTRENADORES]
IF OBJECT_ID ('[dbo].[TBLENTRENADORES]') IS NOT NULL
   BEGIN
        BEGIN TRY 
          DROP TABLE [dbo].[TBLENTRENADORES];
		END TRY
		BEGIN CATCH
		   PRINT ('Imposible Borrrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE TABLE [dbo].[TBLENTRENADORES]
(
IdEntrenador [INT] IDENTITY(1,1) NOT NULL,
Cedula       [VARCHAR](10)  NOT NULL,
Nombres      [VARCHAR](300) NOT NULL,
Apellidos    [VARCHAR](300) NOT NULL,
Direccion    [VARCHAR](300) NOT NULL,
Genero 	     [VARCHAR](10)  NOT NULL,
Telefono     [VARCHAR](15)  NOT NULL,

CONSTRAINT [Pk_TblEntrenadores_Id] PRIMARY KEY CLUSTERED (IdEntrenador)
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [INC_TBLENTRENADORES] ON [dbo].[TBLENTRENADORES]
(
	[Cedula] ASC
);
GO
-- OBJECT: TABLE [dbo].[TBLREPRESENTANTES]
IF OBJECT_ID ('[dbo].[TBLREPRESENTANTES]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP TABLE [dbo].[TBLREPRESENTANTES];
		END TRY
		BEGIN CATCH
		PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE TABLE [dbo].[TBLREPRESENTANTES]
(
IdRepresentante  [INT] IDENTITY(1,1) NOT NULL,
Cedula           [VARCHAR](10)  NOT NULL,
Nombres          [VARCHAR](300) NOT NULL,
Apellidos        [VARCHAR](300) NOT NULL,
FechaNacimiento  [VARCHAR](10)  NOT NULL,
Genero           [VARCHAR](10)  NOT NULL,
Telefono         [VARCHAR](15)  NOT NULL,

CONSTRAINT [Pk_TblRepresentantes_Id] PRIMARY KEY CLUSTERED (IdRepresentante)
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [INC_TBLREPRESENTANTES] ON [dbo].[TBLREPRESENTANTES]
(
	[Cedula] ASC
);
GO
-- OBJECT: TABLE [dbo].[TBLCATEGORIAS]
IF OBJECT_ID ('[dbo].[TBLCATEGORIAS]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP TABLE [dbo].[TBLCATEGORIAS];
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE TABLE [dbo].[TBLCATEGORIAS]
(

IdCategoria     [INT] IDENTITY(1,1) NOT NULL,
NombreCategoria [VARCHAR](8) NOT NULL,
IdEntrenador    [INT]        NOT NULL,

CONSTRAINT [Pk_TblCategorias_Id] PRIMARY KEY CLUSTERED (IdCategoria),
CONSTRAINT [Fk_TblCategroias_TblEntrenadores] FOREIGN KEY (IdEntrenador) REFERENCES [dbo].[TBLENTRENADORES] (IdEntrenador)
);
GO
-- OBJECT: TABLE [dbo].[TBLJUGADORES]
IF OBJECT_ID ('[dbo].[TBLJUGADORES]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP TABLE [dbo].[TBLJUGADORES]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE TABLE [dbo].[TBLJUGADORES]
(
IdJugador       [INT] IDENTITY(1,1) NOT NULL,
Cedula          [VARCHAR](10)  NOT NULL,
Nombres         [VARCHAR](300) NOT NULL,
Apellidos       [VARCHAR](300) NOT NULL,
FechaNacimiento [VARCHAR](10)  NOT NULL,
Genero          [VARCHAR](10)  NOT NULL,
Telefono        [VARCHAR](15)  NOT NULL,
Posicion        [VARCHAR](20)  NOT NULL,
IdRepresentante [INT]          NOT NULL, 
IdCategoria     [INT]          NOT NULL,


CONSTRAINT [Pk_TblJugadores_Id] PRIMARY KEY CLUSTERED (IdJugador),
CONSTRAINT [Fk_TblJugadores_TblRepresentantes] FOREIGN KEY (IdRepresentante) REFERENCES [dbo].[TBLREPRESENTANTES] (IdRepresentante),
CONSTRAINT [Fk_TblJugadores_TblCategorias]     FOREIGN KEY (IdCategoria) REFERENCES [dbo].[TBLCATEGORIAS] (IdCategoria)

);
GO
CREATE UNIQUE NONCLUSTERED INDEX [INC_TBLJUGADORES] ON [dbo].[TBLJUGADORES]
(
	[Cedula] ASC
);
GO
-- OBJECT : CREATE TABLE [dbo].[TBLERROR]
IF OBJECT_ID ('[dbo].[TBLERROR]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP TABLE [dbo].[TBLERROR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposbile Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE TABLE [dbo].[TBLERROR]
(
ErrorId		   [INT] IDENTITY(1,1),
UserName	   [VARCHAR](100),
ErrorNumber    [INT],
ErrorState	   [INT],
ErrorSeverity  [INT],
ErrorLine	   [INT],
ErrorProcedure [VARCHAR](MAX),
ErrorMessage   [VARCHAR](MAX),
ErrorDateTime  [DATETIME]
);
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_CAPTURAERROR]
IF OBJECT_ID ('[dbo].[PA_CAPTURAERROR]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE  [dbo].[PA_CAPTURAERROR];
		END TRY
		BEGIN CATCH
			PRINT ('Imposbile Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_CAPTURAERROR]
AS 
	SET NOCOUNT ON;
	INSERT INTO [dbo].[TBLERROR] ([UserName], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [ErrorDateTime])
		   VALUES (SUSER_NAME(),
				   ERROR_NUMBER(),
				   ERROR_STATE(),
				   ERROR_SEVERITY(),
				   ERROR_LINE(),
				   ERROR_PROCEDURE(),
				   ERROR_MESSAGE(),
				   GETDATE()
				   )
			PRINT ('Error insertados')
			SELECT * FROM [dbo].[TBLERROR] WHERE [ErrorId] = @@IDENTITY
GO 
-- OBJECT: STORED PROCEDURE [dbo].[PA_LOGIN]
IF OBJECT_ID ('[dbo].[PA_LOGIN]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_LOGIN]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_LOGIN]
(
@username [VARCHAR](100)
)
AS
BEGIN TRY 
    BEGIN TRANSACTION
	SET NOCOUNT ON;
	SELECT  [IdUsuario],[Cedula],[Nombres],[Apellidos],[Direccion],[Genero],[Telefono],[Usuario],[Contraseņa] FROM [dbo].[TBLUSUARIOS] 
			WHERE [Usuario] = @username;
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_AGGUSUARIO]
IF OBJECT_ID ('[dbo].[PA_AGGUSUARIO]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_AGGUSUARIO]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_AGGUSUARIO]
( 
@Cedula     [VARCHAR](10),
@Nombres    [VARCHAR](300),
@Apellidos  [VARCHAR](300),
@Direccion  [VARCHAR](300),
@Genero     [VARCHAR](10),
@Telefono   [VARCHAR](15),
@Usuario    [VARCHAR](300), 
@Contraseņa [VARCHAR](100) 
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	INSERT INTO [dbo].[TBLUSUARIOS] ( [Cedula], [Nombres], [Apellidos], [Direccion], [Genero], [Telefono], [Usuario], [Contraseņa])
		   VALUES (
					@Cedula,
					@Nombres,
					@Apellidos,
					@Direccion,
					@Genero,
					@Telefono,
					@Usuario,
					@Contraseņa
		    )
	PRINT('DATOS INGRESADOS')
	SELECT * FROM [dbo].[TBLUSUARIOS] WHERE [IdUsuario] = @@IDENTITY
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH

EXECUTE [dbo].[PA_AGGUSUARIO] '26768416','Royert Eduardo', 'Romero Escalona', 'Urb Los Crepusculos', 'Masculino', '04145233650', 'royert', 'roger1203'
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_GUARDARENTRENADORES]
IF OBJECT_ID ('[dbo].[PA_GUARDARENTRENADORES]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_GUARDARENTRENADORES]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_GUARDARENTRENADORES]
(
@Cedula		  [VARCHAR](10),
@Nombres      [VARCHAR](300),
@Apellidos    [VARCHAR](300),
@Direccion    [VARCHAR](300),
@Genero       [VARCHAR](10),
@Telefono     [VARCHAR](15)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	INSERT INTO [dbo].[TBLENTRENADORES] ([Cedula], [Nombres], [Apellidos], [Direccion], [Genero], [Telefono])
		   VALUES (@Cedula,
				   @Nombres,
				   @Apellidos,
				   @Direccion,
				   @Genero,
				   @Telefono)
	PRINT ('DATOS INSERTADOS')
	SELECT * FROM [dbo].[TBLENTRENADORES] WHERE [IdEntrenador] = @@IDENTITY
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_ELIMINARENTRENADOR]
IF OBJECT_ID ('[dbo].[PA_ELIMINARENTRENADOR]') IS NOT NULL
	DROP PROCEDURE [dbo].[PA_ELIMINARENTRENADOR]
	GO
CREATE PROCEDURE [dbo].[PA_ELIMINARENTRENADOR]
(
@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	DELETE FROM [dbo].[TBLENTRENADORES] WHERE [Cedula] = @Cedula
	PRINT ('DATO ELIMINADO')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_MODIFICARENTRENADOR]
IF OBJECT_ID ('[dbo].[PA_MODIFICARENTRENADOR]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MODIFICARENTRENADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MODIFICARENTRENADOR]
(
@Cedula		[VARCHAR](10),
@Nombres	[VARCHAR](300),
@Apellidos	[VARCHAR](300),
@Direccion	[VARCHAR](300),
@Genero		[VARCHAR](10),
@Telefono	[VARCHAR](15)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON 
	UPDATE [dbo].[TBLENTRENADORES] SET Cedula    =  @Cedula, 
									   Nombres   =  @Nombres, 
									   Apellidos =  @Apellidos, 
									   Direccion =  @Direccion, 
									   Genero    =  @Genero, 
									   Telefono  =  @Telefono
	PRINT ('DATO MODIFICADO')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_BUSCARENTRENADOR]
IF OBJECT_ID ('[dbo].[PA_BUSCARENTRENADOR]') IS NOT NULL
	BEGIN 
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_BUSCARENTRENADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_BUSCARENTRENADOR]
(
@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON 
		SELECT [Cedula], [Nombres], [Apellidos], [Direccion], [Genero], [Telefono] FROM [dbo].[TBLENTRENADORES] WHERE [Cedula] LIKE CONCAT ('%',@Cedula,'%')
		COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
GO
--OBJECT: STORED PROCEDURE [dbo].[PA_EXISTEENTRENADOR]
IF OBJECT_ID ('[dbo].[PA_EXISTEENTRENADOR]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_EXISTEENTRENADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_EXISTEENTRENADOR]
(
@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT COUNT(Cedula) FROM [dbo].[TBLENTRENADORES] WHERE [Cedula] = @Cedula
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
--OBJECT: STORED PROCEDURE [dbo].[PA_GUARDARREPRESENTANTE]
IF OBJECT_ID('[dbo].[PA_GUARDARREPRESENTANTE]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_GUARDARREPRESENTANTE]
		END TRY
		BEGIN CATCH
			PRINT('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_GUARDARREPRESENTANTE]
(
	@Cedula           [VARCHAR](10),
	@Nombres          [VARCHAR](300),
	@Apellidos        [VARCHAR](300),
	@FechaNacimiento  [VARCHAR](10),
	@Genero           [VARCHAR](10),
	@Telefono         [VARCHAR](15)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	INSERT INTO [dbo].[TBLREPRESENTANTES] ([Cedula], [Nombres], [Apellidos], [Genero], [Telefono])
		   VALUES (@Cedula,
				   @Nombres,
				   @Apellidos,
				   @Genero,
				   @Telefono)
	PRINT ('DATOS INSERTADOS')
	SELECT * FROM [dbo].[TBLREPRESENTANTES] WHERE [IdRepresentante] = @@IDENTITY
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_MODIFICARREPRESENTANTE]
IF OBJECT_ID ('[dbo].[PA_MODIFICARREPRESENTANTE]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MODIFICARREPRESENTANTE]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MODIFICARREPRESENTANTE]
(
	@Cedula           [VARCHAR](10),
	@Nombres          [VARCHAR](300),
	@Apellidos        [VARCHAR](300),
	@FechaNacimiento  [VARCHAR](10),
	@Genero           [VARCHAR](10),
	@Telefono         [VARCHAR](15)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON 
	UPDATE [dbo].[TBLREPRESENTANTES] SET Cedula			 =  @Cedula, 
										 Nombres		 =  @Nombres, 
										 Apellidos		 =  @Apellidos, 
										 FechaNacimiento = @FechaNacimiento,
										 Genero			 =  @Genero, 
										 Telefono		 =  @Telefono
	PRINT ('DATO MODIFICADO')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_ELIMINARREPRESENTANTE]
IF OBJECT_ID ('[dbo].[PA_ELIMINARREPRESENTANTE]') IS NOT NULL
	DROP PROCEDURE [dbo].[PA_ELIMINARREPRESENTANTE]
	GO
CREATE PROCEDURE [dbo].[PA_ELIMINARREPRESENTANTE]
(
@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	DELETE FROM [dbo].[TBLREPRESENTANTES] WHERE [Cedula] = @Cedula
	PRINT ('DATO ELIMINADO')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_BUSCARREPRESENTANTE]
IF OBJECT_ID ('[dbo].[PA_BUSCARREPRESENTANTE]') IS NOT NULL
	BEGIN 
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_BUSCARREPRESENTANTE]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_BUSCARREPRESENTANTE]
(
@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON 
		SELECT [Cedula], [Nombres], [Apellidos],[FechaNacimiento], [Genero], [Telefono] FROM [dbo].[TBLREPRESENTANTES] WHERE [Cedula] LIKE CONCAT ('%',@Cedula,'%')
		COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
--OBJECT: STORED PROCEDURE [dbo].[PA_EXISTEREPRESENTANTE]
IF OBJECT_ID ('[dbo].[PA_EXISTEREPRESENTANTE]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_EXISTEREPRESENTANTE]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_EXISTEREPRESENTANTE]
(
@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT COUNT(Cedula) FROM [dbo].[TBLREPRESENTANTES] WHERE [Cedula] = @Cedula
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_MOSTRARTODO]
IF OBJECT_ID ('[dbo].[PA_MOSTRARTODO]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MOSTRARTODO]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MOSTRARTODO]
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT * FROM [dbo].[TBLENTRENADORES]
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_MOSTRAR]
IF OBJECT_ID ('[dbo].[PA_MOSTRAR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MOSTRAR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MOSTRAR]
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT * FROM [dbo].[TBLENTRENADORES]
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO 
-- OBJECT: STORED PROCEDURE [dbo].[PA_GUARDARJUGADOR]
IF OBJECT_ID ('[dbo].[PA_GUARDARJUGADOR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_GUARDARJUGADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_GUARDARJUGADOR]
(
	@Cedula          [VARCHAR](10),
	@Nombres         [VARCHAR](300),
	@Apellidos       [VARCHAR](300),
	@FechaNacimiento [VARCHAR](10),
	@Genero          [VARCHAR](10),
	@Telefono        [VARCHAR](15),
	@Posicion        [VARCHAR](20),
	@IdRepresentante [INT], 
	@IdCategoria     [INT]
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	INSERT INTO [dbo].[TBLJUGADORES] ([Cedula], [Nombres], [Apellidos], [FechaNacimiento], [Genero], [Telefono], [Posicion],
				[IdRepresentante], [IdCategoria])
	VALUES (@Cedula,
			@Nombres,
			@Apellidos,
			@FechaNacimiento,
			@Genero,
			@Telefono,
			@Posicion,
			@IdRepresentante,
			@IdCategoria)
	PRINT ('DATOS INSERTADOS')
	SELECT * FROM [dbo].[TBLJUGADORES] WHERE [IdJugador] = @@IDENTITY
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT: STORED PROCEDURE [dbo].[PA_MODIFICARJUGADOR]
IF OBJECT_ID ('[dbo].[PA_MODIFICARJUGADOR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MODIFICARJUGADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MODIFICARJUGADOR]
(
	@Cedula          [VARCHAR](10),
	@Nombres         [VARCHAR](300),
	@Apellidos       [VARCHAR](300),
	@FechaNacimiento [VARCHAR](10),
	@Genero          [VARCHAR](10),
	@Telefono        [VARCHAR](15),
	@Posicion        [VARCHAR](20),
	@IdRepresentante [INT], 
	@IdCategoria     [INT]
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	UPDATE [dbo].[TBLJUGADORES] SET Cedula           = @Cedula,
									Nombres		     = @Nombres,
									Apellidos		 = @Apellidos,
									FechaNacimiento  = @FechaNacimiento,
									Genero			 = @Genero,
									Telefono		 = @Telefono,
									Posicion		 = @Posicion,
									IdRepresentante  = @IdRepresentante,
									IdCategoria		 = @IdCategoria
	PRINT ('DATO MODIFICADO')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT : STORED PROCEDURE [dbo].[PA_ELIMINARJUGADOR]
IF OBJECT_ID ('[dbo].[PA_ELIMINARJUGADOR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_ELIMINARJUGADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_ELIMINARJUGADOR]
(
	@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	DELETE [dbo].[TBLJUGADORES] WHERE [Cedula] = @Cedula
	PRINT ('DATO ELIMINADO')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT : STORED PROCEDURE [dbo].[PA_BUSCARJUGADOR]
IF OBJECT_ID ('[dbo].[PA_BUSCARJUGADOR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_BUSCARJUGADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_BUSCARJUGADOR] 
(
	@Cedula [VARCHAR](10) 
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT [IdJugador],	[Cedula], [Nombres], [Apellidos], [FechaNacimiento], [Genero], [Telefono], 
		   [Posicion], [IdRepresentante], [IdCategoria]	FROM [dbo].[TBLJUGADORES] WHERE [CEDULA] LIKE CONCAT ('%',@Cedula,'%')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT : STORED PROCEDURE [dbo].[PA_EXISTEJUGADOR]
IF OBJECT_ID ('[dbo].[PA_EXISTEJUGADOR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_EXISTEJUGADOR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_EXISTEJUGADOR]
(
	@Cedula [VARCHAR](10)
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT COUNT(Cedula) FROM [dbo].[TBLJUGADORES] WHERE [Cedula] = @Cedula
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT : STORED PROCEDURE [dbo].[PA_MOSTRARTODO]
IF OBJECT_ID ('[dbo].[PA_MOSTRARTODO]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MOSTRARTODO]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MOSTRARTODO]
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	SELECT * FROM [dbo].[TBLJUGADORES]
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT : STORED PROCEDURE [dbo].[PA_MOSTRAR]
IF OBJECT_ID ('[dbo].[PA_MOSTRAR]')IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_MOSTRAR]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_MOSTRAR]
AS
BEGIN TRY
	BEGIN TRANSACTION 
	SET NOCOUNT ON
	SELECT * FROM [dbo].[TBLJUGADORES]
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH
GO
-- OBJECT : STORED PROCEDURE [dbo].[PA_GUARDARCATEGORIA]
IF OBJECT_ID ('[dbo].[PA_GUARDARCATEGORIA]') IS NOT NULL
	BEGIN
		BEGIN TRY
			DROP PROCEDURE [dbo].[PA_GUARDARCATEGORIA]
		END TRY
		BEGIN CATCH
			PRINT ('Imposible Borrar, Mensaje Error: '+ ERROR_MESSAGE());
		END CATCH
	END
GO
CREATE PROCEDURE [dbo].[PA_GUARDARCATEGORIA]
(
@IdCategoria [INT],
@NombreCategoria [VARCHAR],
@IdEntrenador    [INT]
)
AS
BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON
	INSERT INTO [dbo].[TBLCATEGORIAS] ( [IdCategoria], [NombreCategoria], [IdEntrenador])
	VALUES (@IdCategoria, @NombreCategoria, @IdEntrenador)
	PRINT ('DATOS INGRESADOS')
	SELECT * FROM [dbo].[TBLCATEGORIAS] WHERE [IdCategoria] = @@IDENTITY
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	EXECUTE [dbo].[PA_CAPTURAERROR]
END CATCH