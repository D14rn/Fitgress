CREATE TABLE IF NOT EXISTS fitgress_user (
	id UUID NOT NULL DEFAULT gen_random_uuid(),
	email VARCHAR(255) NOT NULL UNIQUE,
	display_name VARCHAR(255) NOT NULL,
	created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS progression_track (
	id UUID NOT NULL DEFAULT gen_random_uuid(),
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS progression_track_item (
	id UUID NOT NULL DEFAULT gen_random_uuid(),
	track_id UUID NOT NULL,
	name VARCHAR(255) NOT NULL,
	position TEXT NOT NULL, -- Fractional index key (base-62 digits, never ends in 0).
	PRIMARY KEY(id)
);

COMMENT ON COLUMN progression_track_item.position IS 'Fractional index key (base-62 digits, never ends in 0).';

ALTER TABLE progression_track_item
ADD FOREIGN KEY(track_id) REFERENCES progression_track(id)
ON UPDATE NO ACTION ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS user_progression_track (
	user_id UUID NOT NULL,
	track_id UUID NOT NULL,
	started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
	PRIMARY KEY(user_id, track_id)
);

ALTER TABLE user_progression_track
ADD FOREIGN KEY(user_id) REFERENCES fitgress_user(id)
ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE user_progression_track
ADD FOREIGN KEY(track_id) REFERENCES progression_track(id)
ON UPDATE NO ACTION ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS user_progression_track_item (
	user_id UUID NOT NULL,
	track_item_id UUID NOT NULL,
	completed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
	PRIMARY KEY(user_id, track_item_id)
);

ALTER TABLE user_progression_track_item
ADD FOREIGN KEY(user_id) REFERENCES fitgress_user(id)
ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE user_progression_track_item
ADD FOREIGN KEY(track_item_id) REFERENCES progression_track_item(id)
ON UPDATE NO ACTION ON DELETE CASCADE;
