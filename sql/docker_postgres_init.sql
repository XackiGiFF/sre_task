-- Creation of contacts table
CREATE TABLE IF NOT EXISTS contacts (
  id SERIAL,
  PhoneNumber varchar(40) NOT NULL,
  FullName varchar(255) NOT NULL,
  Address varchar(255),
  Email VARCHAR(255),
  PRIMARY KEY (id)
);

-- Set params
set session my.id = '1';
set session my.phonenumber = '312997789';
set session my.fullname = 'Yurij Dyatlov';
set session my.address = 'Kazan, st.Komsomolskaya d.53 kv.22';
set session my.email = 'y.dyatlov@ygoogle.com';


-- Filling of contacts
INSERT INTO contacts VALUES (
    1
  , concat(current_setting('my.phonenumber'))
	, concat(current_setting('my.fullname'))
  , concat(current_setting('my.address'))
  , concat(current_setting('my.email')))
ON CONFLICT (id) DO NOTHING;

/*UPDATE SET
phonenumber = EXCLUDED.phonenumber,
fullname = EXCLUDED.fullname,
address = EXCLUDED.address,
email = EXCLUDED.email;
*/