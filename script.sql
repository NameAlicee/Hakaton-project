
USE [Hakaton_project]
GO
/****** Object:  Table [dbo].[buildings]    Script Date: 26.09.2020 19:56:56 ******/
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
/****** Object:  Table [dbo].[LocType]    Script Date: 26.09.2020 19:56:56 ******/
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
/****** Object:  Table [dbo].[ResourseLocation]    Script Date: 26.09.2020 19:56:56 ******/
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
/****** Object:  Table [dbo].[Resourses]    Script Date: 26.09.2020 19:56:56 ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResourseTypes]    Script Date: 26.09.2020 19:56:56 ******/
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
/****** Object:  Table [dbo].[Status]    Script Date: 26.09.2020 19:56:56 ******/
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
