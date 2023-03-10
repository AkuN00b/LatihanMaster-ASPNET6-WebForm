USE [master]
GO
/****** Object:  Database [LatihanMaster]    Script Date: 2022-12-15 오후 3:33:37 ******/
CREATE DATABASE [LatihanMaster]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LatihanMaster', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LatihanMaster.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LatihanMaster_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LatihanMaster_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LatihanMaster] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LatihanMaster].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LatihanMaster] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LatihanMaster] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LatihanMaster] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LatihanMaster] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LatihanMaster] SET ARITHABORT OFF 
GO
ALTER DATABASE [LatihanMaster] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LatihanMaster] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LatihanMaster] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LatihanMaster] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LatihanMaster] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LatihanMaster] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LatihanMaster] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LatihanMaster] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LatihanMaster] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LatihanMaster] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LatihanMaster] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LatihanMaster] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LatihanMaster] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LatihanMaster] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LatihanMaster] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LatihanMaster] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LatihanMaster] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LatihanMaster] SET RECOVERY FULL 
GO
ALTER DATABASE [LatihanMaster] SET  MULTI_USER 
GO
ALTER DATABASE [LatihanMaster] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LatihanMaster] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LatihanMaster] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LatihanMaster] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LatihanMaster] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LatihanMaster', N'ON'
GO
ALTER DATABASE [LatihanMaster] SET QUERY_STORE = OFF
GO
USE [LatihanMaster]
GO
/****** Object:  Table [dbo].[JenisMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JenisMobil](
	[id_jenis_mobil] [int] IDENTITY(1,1) NOT NULL,
	[nama_jenis_mobil] [varchar](50) NOT NULL,
 CONSTRAINT [PK_JenisMobil] PRIMARY KEY CLUSTERED 
(
	[id_jenis_mobil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mobil](
	[id_mobil] [int] IDENTITY(1,1) NOT NULL,
	[nama_mobil] [varchar](50) NOT NULL,
	[merk_mobil] [varchar](50) NOT NULL,
	[harga_mobil] [varchar](50) NOT NULL,
	[id_jenis_mobil] [int] NOT NULL,
 CONSTRAINT [PK_Mobil] PRIMARY KEY CLUSTERED 
(
	[id_mobil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Mobil]  WITH CHECK ADD  CONSTRAINT [FK_Mobil_JenisMobil] FOREIGN KEY([id_jenis_mobil])
REFERENCES [dbo].[JenisMobil] ([id_jenis_mobil])
GO
ALTER TABLE [dbo].[Mobil] CHECK CONSTRAINT [FK_Mobil_JenisMobil]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteJenisMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_DeleteJenisMobil]
	@id		int
AS
BEGIN
	DELETE FROM JenisMobil WHERE id_jenis_mobil = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_DeleteMobil]
	@id		int
AS
BEGIN
	DELETE FROM Mobil WHERE id_mobil = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataForUpdateJenisMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_getDataForUpdateJenisMobil]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT nama_jenis_mobil FROM JenisMobil WHERE id_jenis_mobil = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataForUpdateMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_getDataForUpdateMobil]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT nama_mobil, merk_mobil, harga_mobil, id_jenis_mobil FROM Mobil WHERE id_mobil = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataJenisMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_getDataJenisMobil]
	@query VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT id_jenis_mobil, ROW_NUMBER() OVER (ORDER BY id_jenis_mobil ASC) AS rownum, nama_jenis_mobil
	FROM JenisMobil
	WHERE nama_jenis_mobil LIKE '%' + @query + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_getDataMobil]
	@query VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT m.id_mobil, ROW_NUMBER() OVER (ORDER BY m.id_mobil ASC) AS rownum, m.nama_mobil, m.merk_mobil, m.harga_mobil, jm.nama_jenis_mobil
	FROM Mobil m
	INNER JOIN JenisMobil jm ON m.id_jenis_mobil = jm.id_jenis_mobil
	WHERE m.nama_mobil LIKE '%' + @query + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertJenisMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_InsertJenisMobil]
	@namaJenisMobil		varchar(50)
AS
BEGIN
	INSERT INTO JenisMobil (nama_jenis_mobil)
	VALUES (@namaJenisMobil)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_InsertMobil]
	@namaMobil				varchar(50),
	@merkMobil				varchar(50),
	@hargaMobil				varchar(50),
	@idJenisMobil			int
AS
BEGIN
	INSERT INTO Mobil (nama_mobil, merk_mobil, harga_mobil, id_jenis_mobil)
	VALUES(@namaMobil, @merkMobil, @hargaMobil, @idJenisMobil)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateJenisMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_UpdateJenisMobil]
	@id				int,
	@namaJenisMobil	varchar(50)
AS
BEGIN
	UPDATE JenisMobil
	SET nama_jenis_mobil = @namaJenisMobil
	WHERE id_jenis_mobil = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateMobil]    Script Date: 2022-12-15 오후 3:33:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdateMobil]
	@id				int,
	@namaMobil		varchar(50),
	@merkMobil		varchar(50),
	@hargaMobil		varchar(50),
	@idJenisMobil	int
AS
BEGIN
	UPDATE Mobil
	SET nama_mobil = @namaMobil,
		merk_mobil = @merkMobil,
		harga_mobil = @hargaMobil,
		id_jenis_mobil = @idJenisMobil
	WHERE id_mobil = @id
END
GO
USE [master]
GO
ALTER DATABASE [LatihanMaster] SET  READ_WRITE 
GO
