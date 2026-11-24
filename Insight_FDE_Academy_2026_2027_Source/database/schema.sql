-- Proposed Azure SQL schema. Not deployed; apply through reviewed migrations.
CREATE TABLE dbo.AcademyUser (
 UserId uniqueidentifier NOT NULL PRIMARY KEY DEFAULT NEWID(),
 TenantId uniqueidentifier NOT NULL, EntraObjectId uniqueidentifier NOT NULL,
 DisplayName nvarchar(200) NOT NULL,
 CONSTRAINT UQ_User_Identity UNIQUE(TenantId,EntraObjectId)
);
CREATE TABLE dbo.Module (
 ModuleId int NOT NULL PRIMARY KEY, Title nvarchar(200) NOT NULL,
 Phase varchar(20) NOT NULL CHECK(Phase IN ('Foundation','Build','Deliver')),
 ContentJson nvarchar(max) NOT NULL CHECK(ISJSON(ContentJson)=1)
);
CREATE TABLE dbo.MentorAssignment (
 MentorId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 LearnerId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 PRIMARY KEY(MentorId,LearnerId), CHECK(MentorId<>LearnerId)
);
CREATE TABLE dbo.ModuleProgress (
 UserId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 ModuleId int NOT NULL REFERENCES dbo.Module(ModuleId),
 IsComplete bit NOT NULL DEFAULT 0, UpdatedAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
 Version rowversion, PRIMARY KEY(UserId,ModuleId)
);
CREATE TABLE dbo.RoadmapProgress (
 UserId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 ArcYear smallint NOT NULL, DayNumber tinyint NOT NULL CHECK(DayNumber BETWEEN 1 AND 30),
 IsComplete bit NOT NULL DEFAULT 0, UpdatedAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
 Version rowversion, PRIMARY KEY(UserId,ArcYear,DayNumber)
);
CREATE TABLE dbo.WorkLog (
 WorkLogId uniqueidentifier NOT NULL PRIMARY KEY DEFAULT NEWID(),
 UserId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 ModuleId int NOT NULL REFERENCES dbo.Module(ModuleId),
 WorkDate date NOT NULL, MinutesSpent smallint NOT NULL CHECK(MinutesSpent BETWEEN 1 AND 1440),
 Summary nvarchar(3000) NOT NULL, Blocker nvarchar(1500) NULL, EvidenceUrl nvarchar(2000) NULL,
 Status varchar(20) NOT NULL CHECK(Status IN ('Draft','Submitted')),
 CreatedAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME(), UpdatedAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
 Version rowversion
);
CREATE INDEX IX_WorkLog_User_Date ON dbo.WorkLog(UserId,WorkDate DESC);
CREATE TABLE dbo.MentorReview (
 ReviewId uniqueidentifier NOT NULL PRIMARY KEY DEFAULT NEWID(),
 LearnerId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 MentorId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 ModuleId int NOT NULL REFERENCES dbo.Module(ModuleId),
 Technical tinyint NOT NULL CHECK(Technical BETWEEN 1 AND 5),
 Reproducibility tinyint NOT NULL CHECK(Reproducibility BETWEEN 1 AND 5),
 Teaching tinyint NOT NULL CHECK(Teaching BETWEEN 1 AND 5),
 ClientCraft tinyint NOT NULL CHECK(ClientCraft BETWEEN 1 AND 5),
 Production tinyint NOT NULL CHECK(Production BETWEEN 1 AND 5),
 Reuse tinyint NOT NULL CHECK(Reuse BETWEEN 1 AND 5),
 Gate1 bit NOT NULL, Gate2 bit NOT NULL, Gate3 bit NOT NULL,
 Notes nvarchar(3000) NOT NULL, RubricVersion varchar(20) NOT NULL DEFAULT '2026-v1',
 CreatedAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE TABLE dbo.AuditEvent (
 AuditId bigint IDENTITY PRIMARY KEY, ActorId uniqueidentifier NOT NULL REFERENCES dbo.AcademyUser(UserId),
 ActionName nvarchar(100) NOT NULL, EntityType nvarchar(100) NOT NULL, EntityId nvarchar(100) NOT NULL,
 OccurredAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME(), CorrelationId uniqueidentifier NOT NULL
);
-- API must derive identity from validated access tokens, enforce tenant isolation,
-- mentor assignments and roles, validate December dates for the selected program,
-- and write transactional audit records. DDL alone does not enforce access control.
