BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "applications" (
    "id" bigserial PRIMARY KEY,
    "individualId" bigint NOT NULL,
    "offerId" bigint NOT NULL,
    "shortDescription" text NOT NULL,
    "qualifyIndices" json NOT NULL,
    "status" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat" (
    "id" bigserial PRIMARY KEY,
    "isGroup" boolean NOT NULL,
    "name" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_participant" (
    "id" bigserial PRIMARY KEY,
    "chatId" bigint NOT NULL,
    "participant" bigint NOT NULL,
    "deletedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "responseToPost" bigint NOT NULL,
    "author" bigint NOT NULL,
    "text" text NOT NULL,
    "time" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "connect" (
    "id" bigserial PRIMARY KEY,
    "accountId" bigint,
    "activeConnections" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customdetails" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "images" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "documents" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "title" text NOT NULL,
    "url" text NOT NULL,
    "uploadedBy" bigint NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "follow" (
    "id" bigserial PRIMARY KEY,
    "orgId" bigint NOT NULL,
    "followedBy" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "individual" (
    "id" bigserial PRIMARY KEY,
    "bio" text NOT NULL,
    "accountId" bigint NOT NULL,
    "gender" text NOT NULL,
    "residence" text,
    "dob" timestamp without time zone,
    "contact" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invitation" (
    "id" bigserial PRIMARY KEY,
    "sender" bigint NOT NULL,
    "receiver" bigint NOT NULL,
    "isRejected" boolean NOT NULL DEFAULT false,
    "personalText" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "meetings" (
    "id" bigserial PRIMARY KEY,
    "teamId" bigint NOT NULL,
    "agenda" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "duration" bigint NOT NULL,
    "status" text NOT NULL,
    "startedBy" bigint NOT NULL,
    "url" text NOT NULL,
    "members" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "member" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "workspaceId" bigint NOT NULL,
    "name" text NOT NULL,
    "designation" text NOT NULL,
    "globalRole" text NOT NULL,
    "avatar" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "message" (
    "id" bigserial PRIMARY KEY,
    "chatId" bigint NOT NULL,
    "senderId" bigint NOT NULL,
    "content" text NOT NULL,
    "sentAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification" (
    "id" bigserial PRIMARY KEY,
    "forUser" bigint NOT NULL,
    "content" text NOT NULL,
    "referencedUser" bigint NOT NULL,
    "triggeredAt" timestamp without time zone NOT NULL,
    "unread" boolean NOT NULL,
    "objectId" bigint,
    "objectType" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "offers" (
    "id" bigserial PRIMARY KEY,
    "author" bigint NOT NULL,
    "authorName" text NOT NULL,
    "title" text NOT NULL,
    "acceptingApplications" boolean NOT NULL,
    "isActive" boolean NOT NULL,
    "pay" text NOT NULL,
    "offerType" text NOT NULL,
    "location" text NOT NULL,
    "description" text NOT NULL,
    "duration" bigint NOT NULL,
    "qualifications" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization" (
    "id" bigserial PRIMARY KEY,
    "accountId" bigint NOT NULL,
    "founded" timestamp without time zone NOT NULL,
    "about" text NOT NULL,
    "events" json NOT NULL,
    "jobOpenings" json NOT NULL,
    "customFields" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post" (
    "id" bigserial PRIMARY KEY,
    "authorId" bigint NOT NULL,
    "text" text NOT NULL,
    "media" json,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "professional_data" (
    "id" bigserial PRIMARY KEY,
    "accountId" bigint NOT NULL,
    "type" text NOT NULL,
    "title" text NOT NULL,
    "institute" text NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endData" timestamp without time zone,
    "supportingLink" text NOT NULL,
    "images" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project" (
    "id" bigserial PRIMARY KEY,
    "spaceId" bigint NOT NULL,
    "projectTitle" text NOT NULL,
    "projectOverview" text NOT NULL,
    "status" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project_assigned" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "teamId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reaction" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "reactableId" bigint NOT NULL,
    "reactableType" text NOT NULL,
    "type" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reply" (
    "id" bigserial PRIMARY KEY,
    "author" bigint NOT NULL,
    "text" text NOT NULL,
    "react" bigint NOT NULL,
    "_commentRepliesCommentId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "report_post" (
    "id" bigserial PRIMARY KEY,
    "reporterId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "reason" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "report_user" (
    "id" bigserial PRIMARY KEY,
    "reporterId" bigint NOT NULL,
    "reportedId" bigint NOT NULL,
    "reason" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "space" (
    "id" bigserial PRIMARY KEY,
    "ownerId" bigint NOT NULL,
    "credentials" text,
    "avatar" text NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "memberLimit" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "space_invite" (
    "id" bigserial PRIMARY KEY,
    "spaceId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "designation" text NOT NULL,
    "globalRole" text NOT NULL,
    "teams" json NOT NULL,
    "sentOn" timestamp without time zone NOT NULL,
    "sentBy" bigint NOT NULL,
    "status" text NOT NULL,
    "unread" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task" (
    "id" bigserial PRIMARY KEY,
    "projectId" bigint NOT NULL,
    "taskName" text NOT NULL,
    "status" text NOT NULL,
    "deadline" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task_assigned" (
    "id" bigserial PRIMARY KEY,
    "taskId" bigint NOT NULL,
    "memberId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "team_member" (
    "id" bigserial PRIMARY KEY,
    "teamId" bigint NOT NULL,
    "memberId" bigint NOT NULL,
    "role" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "teams" (
    "id" bigserial PRIMARY KEY,
    "spaceId" bigint NOT NULL,
    "teamTitle" text NOT NULL,
    "chatId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "userInfoId" bigint,
    "name" text NOT NULL,
    "accountType" text NOT NULL,
    "password" text NOT NULL,
    "email" text NOT NULL,
    "spaceLimit" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_idx" ON "user" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "userview" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "headline" text NOT NULL,
    "avatar" text NOT NULL,
    "accountType" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "applications"
    ADD CONSTRAINT "applications_fk_0"
    FOREIGN KEY("individualId")
    REFERENCES "individual"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "chat_participant"
    ADD CONSTRAINT "chat_participant_fk_0"
    FOREIGN KEY("chatId")
    REFERENCES "chat"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("responseToPost")
    REFERENCES "post"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_1"
    FOREIGN KEY("author")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "connect"
    ADD CONSTRAINT "connect_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "documents"
    ADD CONSTRAINT "documents_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "documents"
    ADD CONSTRAINT "documents_fk_1"
    FOREIGN KEY("uploadedBy")
    REFERENCES "member"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "follow"
    ADD CONSTRAINT "follow_fk_0"
    FOREIGN KEY("orgId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "follow"
    ADD CONSTRAINT "follow_fk_1"
    FOREIGN KEY("followedBy")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invitation"
    ADD CONSTRAINT "invitation_fk_0"
    FOREIGN KEY("sender")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invitation"
    ADD CONSTRAINT "invitation_fk_1"
    FOREIGN KEY("receiver")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "meetings"
    ADD CONSTRAINT "meetings_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "teams"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "member"
    ADD CONSTRAINT "member_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "member"
    ADD CONSTRAINT "member_fk_1"
    FOREIGN KEY("workspaceId")
    REFERENCES "space"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "message"
    ADD CONSTRAINT "message_fk_0"
    FOREIGN KEY("chatId")
    REFERENCES "chat"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "message"
    ADD CONSTRAINT "message_fk_1"
    FOREIGN KEY("senderId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_0"
    FOREIGN KEY("forUser")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "notification"
    ADD CONSTRAINT "notification_fk_1"
    FOREIGN KEY("referencedUser")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "offers"
    ADD CONSTRAINT "offers_fk_0"
    FOREIGN KEY("author")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "organization"
    ADD CONSTRAINT "organization_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "post"
    ADD CONSTRAINT "post_fk_0"
    FOREIGN KEY("authorId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "professional_data"
    ADD CONSTRAINT "professional_data_fk_0"
    FOREIGN KEY("accountId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "project"
    ADD CONSTRAINT "project_fk_0"
    FOREIGN KEY("spaceId")
    REFERENCES "space"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reaction"
    ADD CONSTRAINT "reaction_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reply"
    ADD CONSTRAINT "reply_fk_0"
    FOREIGN KEY("author")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reply"
    ADD CONSTRAINT "reply_fk_1"
    FOREIGN KEY("_commentRepliesCommentId")
    REFERENCES "comment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "report_post"
    ADD CONSTRAINT "report_post_fk_0"
    FOREIGN KEY("reporterId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "report_post"
    ADD CONSTRAINT "report_post_fk_1"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "report_user"
    ADD CONSTRAINT "report_user_fk_0"
    FOREIGN KEY("reporterId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "report_user"
    ADD CONSTRAINT "report_user_fk_1"
    FOREIGN KEY("reportedId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "space"
    ADD CONSTRAINT "space_fk_0"
    FOREIGN KEY("ownerId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "space_invite"
    ADD CONSTRAINT "space_invite_fk_0"
    FOREIGN KEY("spaceId")
    REFERENCES "space"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "space_invite"
    ADD CONSTRAINT "space_invite_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "space_invite"
    ADD CONSTRAINT "space_invite_fk_2"
    FOREIGN KEY("sentBy")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "task"
    ADD CONSTRAINT "task_fk_0"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "task_assigned"
    ADD CONSTRAINT "task_assigned_fk_0"
    FOREIGN KEY("taskId")
    REFERENCES "task"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "teams"
    ADD CONSTRAINT "teams_fk_0"
    FOREIGN KEY("spaceId")
    REFERENCES "space"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "teams"
    ADD CONSTRAINT "teams_fk_1"
    FOREIGN KEY("chatId")
    REFERENCES "chat"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR cotree
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('cotree', '20250830032035920', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250830032035920', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
