-- Create schema
CREATE TABLE IF NOT EXISTS clients (
  id UUID NOT NULL PRIMARY KEY,
  username uuid NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
  username UUID NOT NULL PRIMARY KEY,
  password VARCHAR(50) NOT NULL,
  enabled boolean NOT NULL,
  email VARCHAR(255),
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS authorities (
    username uuid NOT NULL,
    authority VARCHAR(50) NOT NULL
);

-- Foreign keys
ALTER TABLE authorities ADD CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users(username);
ALTER TABLE clients ADD CONSTRAINT fk_clients_users FOREIGN KEY (username) REFERENCES users(username) ON UPDATE CASCADE ON DELETE CASCADE ;



-- Indexes
CREATE UNIQUE INDEX ix_auth_username ON authorities (username,authority);

