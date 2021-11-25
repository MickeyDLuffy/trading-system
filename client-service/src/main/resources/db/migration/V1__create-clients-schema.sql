-- Create schema
CREATE TABLE IF NOT EXISTS incident (
  id UUID NOT NULL PRIMARY KEY,
  service_record_number BIGSERIAL,
  owner VARCHAR(255) NOT NULL,
  assigned_to VARCHAR(255) NOT NULL,
  due_date TIMESTAMPTZ NOT NULL,
  type_id UUID,
  category_id UUID,
  sub_category_id UUID,
  third_level_category_id UUID,
  priority_id UUID NOT NULL,
  severity_id UUID NOT NULL,
  region_id UUID,
  client_id UUID,
  site_id UUID,
  unit_id UUID,
  status_id UUID NOT NULL,
  contact_person VARCHAR(255) NOT NULL,
  contact_on_site VARCHAR(255),
  description TEXT,
--   cause TEXT,
  solution TEXT,
  created_by VARCHAR(255) NOT NULL,
  created_timestamp TIMESTAMPTZ NOT NULL,
  last_modified_by VARCHAR(255) NOT NULL,
  last_modified_timestamp TIMESTAMPTZ NOT NULL,
  current_event VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS notes (
  id UUID NOT NULL PRIMARY KEY,
  details TEXT,
  incident_id UUID,
  created_by VARCHAR(255) NOT NULL,
  created_timestamp TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS activity (
  id UUID NOT NULL PRIMARY KEY,
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  username VARCHAR(255),
  incident_id UUID,
  description TEXT
);

CREATE TABLE IF NOT EXISTS attachments (
  id UUID NOT NULL PRIMARY KEY,
  file_name VARCHAR(255),
  location VARCHAR(255),
  content_type VARCHAR(255),
  incident_id UUID
);

CREATE TABLE IF NOT EXISTS incident_history (
  id UUID NOT NULL PRIMARY KEY,
  incident_id UUID,
  details JSONB,
  event_type VARCHAR(100),
  event_timestamp TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS incident_type (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT 
);

CREATE TABLE IF NOT EXISTS status (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  editable BOOLEAN DEFAULT TRUE,
  description TEXT 
);

CREATE TABLE IF NOT EXISTS category (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS sub_category (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  category_id UUID
);

CREATE TABLE IF NOT EXISTS third_level_category (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  sub_category_id UUID
);

CREATE TABLE IF NOT EXISTS priority (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  editable BOOLEAN DEFAULT TRUE,
  description TEXT
);

CREATE TABLE IF NOT EXISTS severity (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  editable BOOLEAN DEFAULT TRUE,
  description TEXT
);

CREATE TABLE IF NOT EXISTS client (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS site (
  id UUID NOT NULL PRIMARY KEY,
  number NUMERIC NOT NULL,
  branch_name VARCHAR(100),
  region_id UUID,
  client_id UUID,
  technology_id UUID,
  link_type_id UUID,
  type_id UUID
);

CREATE TABLE IF NOT EXISTS technology (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100),
  description TEXT
);

CREATE TABLE IF NOT EXISTS region (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS link_type (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS unit (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  parent_id UUID,
  description TEXT
);

CREATE TABLE IF NOT EXISTS site_type (
  id UUID NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

-- Remove timestamp and fetch value from ts_ms of CDC
CREATE TABLE IF NOT EXISTS users (
  id UUID NOT NULL PRIMARY KEY,
  username VARCHAR(255),
  email VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  enabled BOOLEAN,
  unit_id UUID,
  created_timestamp TIMESTAMPTZ NOT NULL
);

-- Create indexes
CREATE UNIQUE INDEX severity_name_idx ON severity(name);
CREATE UNIQUE INDEX priority_name_idx ON priority(name);
CREATE UNIQUE INDEX status_name_idx ON status(name);
CREATE UNIQUE INDEX client_name_idx ON client(name);
CREATE UNIQUE INDEX region_name_idx ON region(name);
CREATE UNIQUE INDEX technology_name_idx ON technology(name);
CREATE UNIQUE INDEX category_name_idx ON category(name);
CREATE UNIQUE INDEX site_type_name_idx ON site_type(name);
CREATE UNIQUE INDEX link_type_name_idx ON link_type(name);
CREATE UNIQUE INDEX unit_name_idx ON unit(name);
CREATE UNIQUE INDEX users_username_idx ON users(username);
CREATE UNIQUE INDEX incident_type_name_idx ON incident_type(name);
CREATE UNIQUE INDEX sub_category_name_category_id_idx ON sub_category(name, category_id);
CREATE UNIQUE INDEX third_level_category_name_sub_category_id_idx ON third_level_category(name, sub_category_id);
CREATE UNIQUE INDEX site_number_client_id_idx ON site(number);

-- Comments
COMMENT ON COLUMN incident.region_id IS 'This is the region of the incident.';
COMMENT ON COLUMN incident.unit_id IS 'No foreign key constraint on Unit';
COMMENT ON COLUMN unit.name IS 'name represents the name given to the administrative group';

-- Foreign keys
ALTER TABLE sub_category ADD CONSTRAINT sub_category_category_id_fk FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE;
ALTER TABLE third_level_category ADD CONSTRAINT third_level_category_sub_category_id_fk FOREIGN KEY (sub_category_id) REFERENCES sub_category (id) ON DELETE CASCADE;
ALTER TABLE site ADD CONSTRAINT site_region_id_fk FOREIGN KEY (region_id) REFERENCES region (id) ON DELETE CASCADE;
ALTER TABLE site ADD CONSTRAINT site_client_id_fk FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE;
ALTER TABLE site ADD CONSTRAINT site_link_type_id_fk FOREIGN KEY (link_type_id) REFERENCES link_type (id) ON DELETE CASCADE;
ALTER TABLE site ADD CONSTRAINT site_technology_id_fk FOREIGN KEY (technology_id) REFERENCES technology (id) ON DELETE CASCADE;
ALTER TABLE site ADD CONSTRAINT site_type_id_fk FOREIGN KEY (type_id) REFERENCES site_type (id) ON DELETE CASCADE;
ALTER TABLE users ADD CONSTRAINT users_unit_id_fk FOREIGN KEY (unit_id) REFERENCES unit (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE unit ADD CONSTRAINT unit_parent_id_fk FOREIGN KEY (parent_id) REFERENCES unit (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_type_id_fk FOREIGN KEY (type_id) REFERENCES incident_type (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_status_id_fk FOREIGN KEY (status_id) REFERENCES status (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_priority_id_fk FOREIGN KEY (priority_id) REFERENCES priority (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_severity_id_fk FOREIGN KEY (severity_id) REFERENCES severity (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_category_id_fk FOREIGN KEY (third_level_category_id) REFERENCES third_level_category (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_region_id_fk FOREIGN KEY (region_id) REFERENCES region (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_client_id_fk FOREIGN KEY (client_id) REFERENCES client (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE incident ADD CONSTRAINT incident_site_id_fk FOREIGN KEY (site_id) REFERENCES site (id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE notes ADD CONSTRAINT notes_incident_id_fk FOREIGN KEY (incident_id) REFERENCES incident (id) ON DELETE CASCADE;
ALTER TABLE attachments ADD CONSTRAINT attachments_incident_id_fk FOREIGN KEY (incident_id) REFERENCES incident (id) ON DELETE CASCADE;
ALTER TABLE incident_history ADD CONSTRAINT incident_history_incident_id_fk FOREIGN KEY (incident_id) REFERENCES incident (id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE activity ADD CONSTRAINT activity_incident_id_fk FOREIGN KEY (incident_id) REFERENCES incident (id) ON UPDATE CASCADE ON DELETE CASCADE;

-- Change Data Capture
ALTER TABLE incident REPLICA IDENTITY FULL;
ALTER TABLE activity REPLICA IDENTITY FULL;
