/*

User Table:
    id
    name
    email
    password

CREATE TABLE User (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    password TEXT
);

INSERT INTO "User" ("id", "name", "email", "password") VALUES
(1, "Ilyas", "Ilyas@gmail.com", "12345")
(2, "Emmanuel", "Emmanuel@gmail.com", "12345")
(3, "Giorgio", "Giorgio@gmail.com", "12345")
(4, "Ollie", "Ollie@gmail.com", "12345")
(1, "Deborah", "Deborah@gmail.com", "12345");



Space Table:
    id
    name
    description
    ppn (price per night)
    user_id

CREATE TABLE spaces (
    id SERIAL PRIMARY KEY, 
    name TEXT, 
    description TEXT
    ppn INT,
    -- FOREIGN KEYS
    user_id INT
    CONSTRAINT fk_user_394 FOREIGN KEY (user_id) REFERENCES users(id)
);

Booking:
    id 
    user_id
    space_id
    date
    status



CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    date DATE,
    status TEXT,  
-- FOREIGN KEYS
    user_id INT,
    spaee_id INT,
    FOREIGN KEY (user_id) REFERENCES User(id)
    FOREIGN KEY (space_id) REFERENCES Space(id)
);
*/



DROP TABLE IF EXISTS users CASCADE; 
DROP TABLE IF EXISTS spaces CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    password TEXT,
    UNIQUE (email)
);
 
INSERT INTO users (name, email, password) VALUES
('Ilyas', 'Ilyas@gmail.com', '$2a$12$Bt9MBMhw.WZPlacasJPSC.vD15yHnMp2P6tu0V0SLfBMuEuph/RNu'),
('Emmanuel', 'Emmanuel@gmail.com', '$2a$12$Bt9MBMhw.WZPlacasJPSC.vD15yHnMp2P6tu0V0SLfBMuEuph/RNu'),
('Giorgio', 'Giorgio@gmail.com', '$2a$12$Bt9MBMhw.WZPlacasJPSC.vD15yHnMp2P6tu0V0SLfBMuEuph/RNu'),
('Ollie', 'Ollie@gmail.com', '$2a$12$Bt9MBMhw.WZPlacasJPSC.vD15yHnMp2P6tu0V0SLfBMuEuph/RNu'),
('Deborah', 'Deborah@gmail.com', '$2a$12$Bt9MBMhw.WZPlacasJPSC.vD15yHnMp2P6tu0V0SLfBMuEuph/RNu');



CREATE TABLE spaces (
    id SERIAL PRIMARY KEY, 
    name TEXT, 
    description TEXT,
    ppn INT,
    contact TEXT,
    -- FOREIGN KEYS
    user_id INT,
    CONSTRAINT fk_users_394 FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO spaces (name, description, ppn, contact, user_id) VALUES
('Buckingham palace', 'Be a royal for a day', 1000,'Ilyas@gmail.com', 1),
('windsor castle', 'it is a good castle', 200, 'Emmanuel@gmail.com', 2);



CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    date DATE,
    status TEXT,  
-- FOREIGN KEYS
    user_id INT,
    space_id INT,
    CONSTRAINT fk_users_123 FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_spaces_123 FOREIGN KEY (space_id) REFERENCES spaces(id)
);

INSERT INTO bookings (user_id, space_id, status, date) VALUES
(1, 2, 'pending' ,'2022-11-01'),
(1, 2, 'rejected' ,'2022-11-02'),
(1, 2, 'approved' ,'2022-11-03'),

(1, 2, 'rejected' ,'2022-11-01'),
(1, 2, 'pending' ,'2022-11-02'),
(2, 2, 'pending' ,'2022-11-02'),
(3, 2, 'pending' ,'2022-11-02'),

(2, 2, 'pending' ,'2022-11-01');




