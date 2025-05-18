-- 1. DDL Queries
-- 1.1. Database Creation Query
CREATE DATABASE IF NOT EXISTS events;
-- 1.2. Event Types Table Creation Query
CREATE TABLE IF NOT EXISTS EventTypes (
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE
);
-- 1.3. Venues Table Creation Query
CREATE TABLE IF NOT EXISTS Venues (
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    address TEXT,
    capacity INT CHECK (capacity > 0)
);
-- 1.4. Ticket Types Table Creation Query
CREATE TABLE IF NOT EXISTS TicketTypes (
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    price FLOAT NOT NULL,
    -- Event Can Be Free To Attend So There's No CHECK(price > 0)
    description TEXT
);
-- 1.5. Members Table Creation Query
CREATE TABLE IF NOT EXISTS Members (
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(128) UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE
);
-- 1.6. Events Table Creation Query
CREATE TABLE IF NOT EXISTS Events (
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    description TEXT,
    event_type_id INT NOT NULL,
    venue_id INT NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    capacity INT NOT NULL,
    is_active BOOLEAN NOT NULL,
    FOREIGN KEY (event_type_id) REFERENCES EventTypes(id),
    FOREIGN KEY (venue_id) REFERENCES Venues(id),
);
-- 1.7. Tickets Table Creation Query
CREATE TABLE IF NOT EXISTS Tickets (
    id SERIAL NOT NULL UNIQUE PRIMARY KEY,
    event_id INT NOT NULL,
    member_id INT NOT NULL,
    ticket_type_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    qr_code VARCHAR(256) NOT NULL,
    status VARCHAR(64) NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(id),
    FOREIGN KEY (member_id) REFERENCES Members(id),
    FOREIGN KEY (ticket_type_id) REFERENCES TicketTypes(id),
);
-- 2. Setting Up Indexes For Frequently Queried Columns
-- 2.1. Tables PKs (ids) Indexes
CREATE INDEX event_type_id_index ON EventTypes(id);
CREATE INDEX venue_id_index ON Venues(id);
CREATE INDEX ticket_type_id_index ON TicketTypes(id);
CREATE INDEX event_id_index ON Events(id);
CREATE INDEX member_id_index ON Members(id);
CREATE INDEX ticket_id_index ON Tickets(id);
-- 2.2. Main Columns Indexes
CREATE INDEX member_full_name_index ON Members(first_name, last_name);
CREATE INDEX member_contact_info_index ON Members(phone, email);
CREATE INDEX ticket_price_index ON Tickets(price);