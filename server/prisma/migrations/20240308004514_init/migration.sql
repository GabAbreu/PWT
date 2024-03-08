BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Users] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [email] NVARCHAR(1000) NOT NULL,
    [password] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Users_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Users_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Users_email_key] UNIQUE NONCLUSTERED ([email])
);

-- CreateTable
CREATE TABLE [dbo].[Characters] (
    [id] NVARCHAR(1000) NOT NULL,
    [userId] NVARCHAR(1000) NOT NULL,
    [nickname] NVARCHAR(1000) NOT NULL,
    [classId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Characters_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [priority] INT NOT NULL,
    CONSTRAINT [Characters_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Classes] (
    [id] INT NOT NULL IDENTITY(1,1),
    [name] NVARCHAR(1000) NOT NULL,
    [shortname] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Classes_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Classes_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Tasks] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [characterId] NVARCHAR(1000) NOT NULL,
    [week_day_reset] INT NOT NULL,
    [time_reset] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Tasks_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Tasks_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Disponibilities] (
    [id] NVARCHAR(1000) NOT NULL,
    [week_day] INT NOT NULL,
    [start_time] NVARCHAR(1000) NOT NULL,
    [end_time] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Disponibilities_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [taskId] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Disponibilities_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- AddForeignKey
ALTER TABLE [dbo].[Characters] ADD CONSTRAINT [Characters_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[Users]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Characters] ADD CONSTRAINT [Characters_classId_fkey] FOREIGN KEY ([classId]) REFERENCES [dbo].[Classes]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Tasks] ADD CONSTRAINT [Tasks_characterId_fkey] FOREIGN KEY ([characterId]) REFERENCES [dbo].[Characters]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Disponibilities] ADD CONSTRAINT [Disponibilities_taskId_fkey] FOREIGN KEY ([taskId]) REFERENCES [dbo].[Tasks]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
