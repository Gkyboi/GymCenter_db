
ALTER TABLE Member
ADD COLUMN LastModified TIMESTAMP;

Update existing records with the current timestamp
UPDATE Member SET LastModified = CURRENT_TIMESTAMP;

CREATE OR REPLACE FUNCTION update_member_last_modified()
RETURNS TRIGGER AS $$
BEGIN
    NEW.LastModified := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER member_update_trigger
BEFORE UPDATE ON Member
FOR EACH ROW
EXECUTE FUNCTION update_member_last_modified();
