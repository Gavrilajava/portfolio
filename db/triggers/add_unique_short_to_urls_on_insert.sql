CREATE OR REPLACE FUNCTION add_unique_short()
RETURNS TRIGGER AS $$
DECLARE
    l int := 5;
    hash varchar(32);
    found boolean;
BEGIN
    hash := MD5(NEW.long); -- Generate the hash based on the 'long' URL

    -- Check for uniqueness of the short URL
    LOOP
        SELECT EXISTS(SELECT 1 FROM "urls" WHERE "urls"."short" = LEFT(hash, l)) INTO found;
        EXIT WHEN NOT found OR l >= 32;
        l := l + 1;
    END LOOP;

    -- Handle the case where a unique short hash is not found
    IF l >= 32 AND found THEN
        RAISE EXCEPTION 'Unable to generate a unique short URL';
    END IF;

    -- Set the short URL
    NEW.short := LEFT(hash, l);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS add_unique_short_to_urls_on_insert ON urls;

CREATE TRIGGER add_unique_short_to_urls_on_insert
BEFORE INSERT OR UPDATE OF long ON urls
FOR EACH ROW
EXECUTE FUNCTION add_unique_short();