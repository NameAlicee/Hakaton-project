USE [master]
GO
/****** Object:  Database [Hakaton_project]    Script Date: 27.09.2020 12:34:39 ******/
CREATE DATABASE [Hakaton_project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hakaton_project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Hakaton_project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hakaton_project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Hakaton_project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Hakaton_project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hakaton_project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hakaton_project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hakaton_project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hakaton_project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hakaton_project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hakaton_project] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hakaton_project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hakaton_project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hakaton_project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hakaton_project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hakaton_project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hakaton_project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hakaton_project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hakaton_project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hakaton_project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hakaton_project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hakaton_project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hakaton_project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hakaton_project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hakaton_project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hakaton_project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hakaton_project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hakaton_project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hakaton_project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hakaton_project] SET  MULTI_USER 
GO
ALTER DATABASE [Hakaton_project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hakaton_project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hakaton_project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hakaton_project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hakaton_project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hakaton_project] SET QUERY_STORE = OFF
GO
USE [Hakaton_project]
GO
/****** Object:  Table [dbo].[buildings]    Script Date: 27.09.2020 12:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[buildings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Address] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocType]    Script Date: 27.09.2020 12:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourseLocation]    Script Date: 27.09.2020 12:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourseLocation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[locationType] [int] NOT NULL,
	[building] [int] NOT NULL,
	[floor] [int] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK__Resourse__3214EC277341009B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resourses]    Script Date: 27.09.2020 12:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resourses](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Genre] [nvarchar](max) NOT NULL,
	[ResourseType] [int] NOT NULL,
	[status] [int] NOT NULL,
	[location] [int] NOT NULL,
	[shelf] [int] NULL,
	[Section] [nvarchar](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourseTypes]    Script Date: 27.09.2020 12:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourseTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type name] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 27.09.2020 12:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResourseLocation]  WITH CHECK ADD  CONSTRAINT [FK_ResourseLocation_buildings] FOREIGN KEY([building])
REFERENCES [dbo].[buildings] ([ID])
GO
ALTER TABLE [dbo].[ResourseLocation] CHECK CONSTRAINT [FK_ResourseLocation_buildings]
GO
ALTER TABLE [dbo].[ResourseLocation]  WITH CHECK ADD  CONSTRAINT [FK_ResourseLocation_LocType] FOREIGN KEY([locationType])
REFERENCES [dbo].[LocType] ([id])
GO
ALTER TABLE [dbo].[ResourseLocation] CHECK CONSTRAINT [FK_ResourseLocation_LocType]
GO
ALTER TABLE [dbo].[Resourses]  WITH CHECK ADD  CONSTRAINT [FK_Resourses_ResourseLocation] FOREIGN KEY([location])
REFERENCES [dbo].[ResourseLocation] ([ID])
GO
ALTER TABLE [dbo].[Resourses] CHECK CONSTRAINT [FK_Resourses_ResourseLocation]
GO
ALTER TABLE [dbo].[Resourses]  WITH CHECK ADD  CONSTRAINT [FK_Resourses_ResourseTypes] FOREIGN KEY([ResourseType])
REFERENCES [dbo].[ResourseTypes] ([ID])
GO
ALTER TABLE [dbo].[Resourses] CHECK CONSTRAINT [FK_Resourses_ResourseTypes]
GO
ALTER TABLE [dbo].[Resourses]  WITH CHECK ADD  CONSTRAINT [FK_Resourses_Status] FOREIGN KEY([status])
REFERENCES [dbo].[Status] ([ID])
GO
ALTER TABLE [dbo].[Resourses] CHECK CONSTRAINT [FK_Resourses_Status]
GO
USE [master]
GO
ALTER DATABASE [Hakaton_project] SET  READ_WRITE 
GO
