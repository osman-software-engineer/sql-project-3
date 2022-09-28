CREATE TABLE IF NOT EXISTS user_profile (
   id BIGSERIAL PRIMARY KEY,
   first_name TEXT NOT NULL,
   last_name TEXT NOT NULL,
   email TEXT UNIQUE NOT NULL,
   gender TEXT CHECK(gender IN ('MALE', 'FEMALE')) NOT NULL,
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_account (
   id BIGINT PRIMARY KEY REFERENCES user_profile(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_channel (
   id BIGSERIAL PRIMARY KEY,
   youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id),
   channel_name TEXT NOT NULL UNIQUE,
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS channel_subscriber (
   youtube_account_id BIGINT REFERENCES youtube_account(id),
   youtube_channel_id BIGINT REFERENCES youtube_channel(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   PRIMARY KEY (youtube_account_id, youtube_channel_id)
);

CREATE TABLE IF NOT EXISTS video (
   id BIGSERIAL PRIMARY KEY,
   youtube_channel_id BIGINT NOT NULL REFERENCES youtube_channel(id),
    title TEXT NOT NULL,
    url TEXT NOT NULL UNIQUE,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_view (
   id BIGSERIAL PRIMARY KEY,
   youtube_account_id BIGINT REFERENCES youtube_account(id),
   video_id BIGINT NOT NULL REFERENCES video(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_like (
   youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id),
   video_id BIGINT NOT NULL REFERENCES video(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   PRIMARY KEY (youtube_account_id, video_id)
);

CREATE TABLE IF NOT EXISTS video_comment (
    id BIGSERIAL PRIMARY KEY,
   youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id),
   video_id BIGINT NOT NULL REFERENCES video(id),
   comment TEXT NOT NULL,
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_comment_like (
   youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id),
   video_comment_id BIGINT NOT NULL REFERENCES video_comment(id),
   created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   PRIMARY KEY (youtube_account_id, video_comment_id)
);