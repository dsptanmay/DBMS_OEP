-- DDL Statements

CREATE TABLE passengers (
    pID INT,
    firstName VARCHAR(100),
    lastName  VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(100),
    PRIMARY KEY (pID)
);

CREATE TABLE airports (
    arpID VARCHAR(100),
    code VARCHAR(100) UNIQUE,
    name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (arpID)
);

CREATE TABLE aircrafts (
    acID VARCHAR(100),
    type VARCHAR(100),
    manufacturer VARCHAR(100),
    model VARCHAR(100),
    totalSeats INT,
    PRIMARY KEY (acID)
);

CREATE TABLE flights (
    fID VARCHAR(100),
    flightNo INT,
    deptArpId VARCHAR(100),
    arrArpId VARCHAR(100),
    deptDateTime DATETIME,
    arrDateTime DATETIME,
    acID VARCHAR(100),
    PRIMARY KEY (fID),
    FOREIGN KEY (deptArpId) REFERENCES airports (arpID),
    FOREIGN KEY (arrArpId) REFERENCES airports (arpID),
    FOREIGN KEY (acID) REFERENCES aircrafts (acID)
);

CREATE TABLE flightsBooked (
    pID INT,
    fID VARCHAR(100),
    PRIMARY KEY (pID, fID),
    FOREIGN KEY (pID) REFERENCES passengers (pID),
    FOREIGN KEY (fID) REFERENCES flights (fID)
);

CREATE TABLE bookings (
    bookingID INT,
    pID INT,
    fID VARCHAR(100),
    seatNo VARCHAR(100),
    bookingDate DATE,
    PRIMARY KEY (bookingID),
    FOREIGN KEY (pID) REFERENCES passengers (pID),
    FOREIGN KEY (fID) REFERENCES flights (fID)
);

-- DML Statements


INSERT INTO aircrafts (acID, type, manufacturer, model, totalSeats) VALUES
('AC1', 'Boeing 737', 'Boeing', '737-800', 30),
('AC2', 'Airbus A320', 'Airbus', 'A320neo', 25),
('AC3', 'Boeing 777', 'Boeing', '777-300ER', 40),
('AC4', 'Airbus A350', 'Airbus', 'A350-900', 35),
('AC5', 'Boeing 787', 'Boeing', '787-9 Dreamliner', 20),
('AC6', 'Airbus A380', 'Airbus', 'A380-800', 38);


INSERT INTO flights (fID, flightNo, deptArpId, arrArpId, deptDateTime, arrDateTime, acID) VALUES
('FID1', 101, 'ARP1', 'ARP3', '2020-07-15 08:30:00', '2020-07-15 11:00:00', 'AC1'),
('FID2', 102, 'ARP3', 'ARP1', '2022-05-20 13:45:00', '2022-05-20 17:15:00', 'AC2'),
('FID3', 103, 'ARP2', 'ARP4', '2023-09-10 18:20:00', '2023-09-10 22:20:00', 'AC3'),
('FID4', 104, 'ARP4', 'ARP2', '2021-12-25 10:00:00', '2021-12-25 15:30:00', 'AC4'),
('FID5', 105, 'ARP5', 'ARP6', '2020-11-08 22:45:00', '2020-11-09 04:15:00', 'AC5'),
('FID6', 106, 'ARP6', 'ARP5', '2022-08-02 04:30:00', '2022-08-02 09:00:00', 'AC6'),
('FID7', 107, 'ARP7', 'ARP8', '2021-10-15 14:15:00', '2021-10-15 19:45:00', 'AC1'),
('FID8', 108, 'ARP8', 'ARP7', '2023-06-30 09:00:00', '2023-06-30 13:30:00', 'AC2'),
('FID9', 109, 'ARP9', 'ARP10', '2020-09-03 12:30:00', '2020-09-03 17:00:00', 'AC3'),
('FID10', 110, 'ARP10', 'ARP9', '2022-04-18 08:00:00', '2022-04-18 12:30:00', 'AC4'),
('FID11', 111, 'ARP11', 'ARP12', '2021-03-22 16:45:00', '2021-03-22 23:00:00', 'AC5'),
('FID12', 112, 'ARP12', 'ARP11', '2023-08-11 06:30:00', '2023-08-11 13:15:00', 'AC6'),
('FID13', 113, 'ARP13', 'ARP14', '2020-10-29 20:00:00', '2020-10-30 00:30:00', 'AC1'),
('FID14', 114, 'ARP14', 'ARP13', '2022-12-12 11:20:00', '2022-12-12 15:50:00', 'AC2'),
('FID15', 115, 'ARP15', 'ARP1', '2023-05-05 18:00:00', '2023-05-05 21:30:00', 'AC3'),
('FID16', 116, 'ARP1', 'ARP15', '2021-07-08 09:45:00', '2021-07-08 14:15:00', 'AC4'),
('FID17', 117, 'ARP2', 'ARP3', '2024-02-14 17:30:00', '2024-02-14 22:00:00', 'AC5'),
('FID18', 118, 'ARP3', 'ARP2', '2020-04-01 06:15:00', '2020-04-01 11:45:00', 'AC6'),
('FID19', 119, 'ARP4', 'ARP5', '2022-11-11 22:00:00', '2022-11-12 02:30:00', 'AC1'),
('FID20', 120, 'ARP5', 'ARP4', '2021-01-28 04:20:00', '2021-01-28 09:50:00', 'AC2'),
('FID21', 121, 'ARP6', 'ARP7', '2023-03-17 14:00:00', '2023-03-17 18:30:00', 'AC3'),
('FID22', 122, 'ARP7', 'ARP6', '2020-08-09 10:30:00', '2020-08-09 15:00:00', 'AC4'),
('FID23', 123, 'ARP8', 'ARP9', '2024-09-28 19:15:00', '2024-09-28 23:45:00', 'AC5'),
('FID24', 124, 'ARP9', 'ARP8', '2022-06-06 08:50:00', '2022-06-06 13:20:00', 'AC6'),
('FID25', 125, 'ARP10', 'ARP11', '2021-12-19 15:00:00', '2021-12-19 20:30:00', 'AC1'),
('FID26', 126, 'ARP11', 'ARP10', '2023-02-05 11:45:00', '2023-02-05 16:15:00', 'AC2'),
('FID27', 127, 'ARP12', 'ARP13', '2020-05-07 13:10:00', '2020-05-07 17:40:00', 'AC3'),
('FID28', 128, 'ARP13', 'ARP12', '2022-07-23 08:25:00', '2022-07-23 13:00:00', 'AC4'),
('FID29', 129, 'ARP14', 'ARP15', '2023-11-01 17:50:00', '2023-11-01 21:20:00', 'AC5'),
('FID30', 130, 'ARP15', 'ARP14', '2020-09-10 06:40:00', '2020-09-10 11:10:00', 'AC6'),
('FID31', 131, 'ARP1', 'ARP2', '2021-08-24 22:30:00', '2021-08-25 03:00:00', 'AC1'),
('FID32', 132, 'ARP2', 'ARP1', '2023-04-03 14:35:00', '2023-04-03 18:45:00', 'AC2'),
('FID33', 133, 'ARP3', 'ARP4', '2020-10-12 11:25:00', '2020-10-12 16:00:00', 'AC3'),
('FID34', 134, 'ARP4', 'ARP3', '2022-12-30 19:00:00', '2022-12-31 00:30:00', 'AC4'),
('FID35', 135, 'ARP5', 'ARP6', '2021-06-28 16:20:00', '2021-06-28 21:00:00', 'AC5'),
('FID36', 136, 'ARP6', 'ARP5', '2023-09-16 08:55:00', '2023-09-16 13:25:00', 'AC6'),
('FID37', 137, 'ARP7', 'ARP8', '2020-03-05 10:10:00', '2020-03-05 14:45:00', 'AC1'),
('FID38', 138, 'ARP8', 'ARP7', '2022-11-07 17:30:00', '2022-11-07 21:55:00', 'AC2'),
('FID39', 139, 'ARP9', 'ARP10', '2024-07-14 14:40:00', '2024-07-14 19:15:00', 'AC3'),
('FID40', 140, 'ARP10', 'ARP9', '2021-02-18 12:15:00', '2021-02-18 17:00:00', 'AC4'),
('FID41', 141, 'ARP11', 'ARP12', '2023-10-20 09:20:00', '2023-10-20 13:50:00', 'AC5'),
('FID42', 142, 'ARP12', 'ARP11', '2020-05-31 14:55:00', '2020-05-31 19:30:00', 'AC6'),
('FID43', 143, 'ARP13', 'ARP14', '2022-04-22 22:00:00', '2022-04-23 02:35:00', 'AC1'),
('FID44', 144, 'ARP14', 'ARP13', '2023-09-07 07:40:00', '2023-09-07 12:15:00', 'AC2'),
('FID45', 145, 'ARP15', 'ARP1', '2020-08-12 18:10:00', '2020-08-12 22:40:00', 'AC3'),
('FID46', 146, 'ARP1', 'ARP15', '2022-03-24 09:35:00', '2022-03-24 14:10:00', 'AC4'),
('FID47', 147, 'ARP2', 'ARP3', '2024-05-16 15:50:00', '2024-05-16 20:20:00', 'AC5'),
('FID48', 148, 'ARP3', 'ARP2', '2021-09-28 06:05:00', '2021-09-28 10:40:00', 'AC6'),
('FID49', 149, 'ARP4', 'ARP5', '2020-12-03 08:40:00', '2020-12-03 13:15:00', 'AC1'),
('FID50', 150, 'ARP5', 'ARP4', '2022-02-14 22:20:00', '2022-02-15 02:50:00', 'AC2'),
('FID51', 151, 'ARP6', 'ARP7', '2023-07-30 14:30:00', '2023-07-30 19:00:00', 'AC3'),
('FID52', 152, 'ARP7', 'ARP6', '2021-01-19 10:00:00', '2021-01-19 14:35:00', 'AC4'),
('FID53', 153, 'ARP8', 'ARP9', '2024-10-02 17:15:00', '2024-10-02 21:45:00', 'AC5'),
('FID54', 154, 'ARP9', 'ARP8', '2020-11-28 07:50:00', '2020-11-28 12:20:00', 'AC6'),
('FID55', 155, 'ARP10', 'ARP11', '2022-06-11 13:20:00', '2022-06-11 17:55:00', 'AC1'),
('FID56', 156, 'ARP11', 'ARP10', '2023-08-17 08:05:00', '2023-08-17 12:40:00', 'AC2'),
('FID57', 157, 'ARP12', 'ARP13', '2020-09-20 15:25:00', '2020-09-20 20:00:00', 'AC3'),
('FID58', 158, 'ARP13', 'ARP12', '2022-11-15 08:40:00', '2022-11-15 13:15:00', 'AC4'),
('FID59', 159, 'ARP14', 'ARP15', '2023-04-09 18:50:00', '2023-04-09 23:25:00', 'AC5'),
('FID60', 160, 'ARP15', 'ARP14', '2020-12-21 11:10:00', '2020-12-21 15:45:00', 'AC6');


-- Generating passenger data with valid email addresses and phone numbers
INSERT INTO passengers (pID, firstName, lastName, email, phone) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '+1234567890'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+1987654321'),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '+14445556666'),
(4, 'Emily', 'Brown', 'emily.brown@example.com', '+17778889999'),
(5, 'William', 'Taylor', 'william.taylor@example.com', '+15556667777'),
(6, 'Olivia', 'Martinez', 'olivia.martinez@example.com', '+18884445555'),
(7, 'James', 'Anderson', 'james.anderson@example.com', '+16663334444'),
(8, 'Emma', 'Hernandez', 'emma.hernandez@example.com', '+19997778888'),
(9, 'Alexander', 'Walker', 'alexander.walker@example.com', '+12223334444'),
(10, 'Sophia', 'Lopez', 'sophia.lopez@example.com', '+13334445555'),
(11, 'Daniel', 'Hill', 'daniel.hill@example.com', '+17775556666'),
(12, 'Isabella', 'Scott', 'isabella.scott@example.com', '+18889997777'),
(13, 'Matthew', 'Green', 'matthew.green@example.com', '+14447778899'),
(14, 'Amelia', 'Adams', 'amelia.adams@example.com', '+15553334444'),
(15, 'David', 'Baker', 'david.baker@example.com', '+19996667777'),
(16, 'Ella', 'Rivera', 'ella.rivera@example.com', '+12224445555'),
(17, 'Logan', 'Mitchell', 'logan.mitchell@example.com', '+13338889999'),
(18, 'Avery', 'Perez', 'avery.perez@example.com', '+16669998888'),
(19, 'Oliver', 'Roberts', 'oliver.roberts@example.com', '+17773334444'),
(20, 'Mia', 'Turner', 'mia.turner@example.com', '+18883334455'),
(21, 'Benjamin', 'Phillips', 'benjamin.phillips@example.com', '+14445557788'),
(22, 'Charlotte', 'Campbell', 'charlotte.campbell@example.com', '+15556668899'),
(23, 'Lucas', 'Parker', 'lucas.parker@example.com', '+19993336666'),
(24, 'Lily', 'Evans', 'lily.evans@example.com', '+12228889999'),
(25, 'Alexander', 'Gonzalez', 'alexander.gonzalez@example.com', '+13336667777'),
(26, 'Grace', 'Young', 'grace.young@example.com', '+16664443322'),
(27, 'Ryan', 'Allen', 'ryan.allen@example.com', '+17778884455'),
(28, 'Elijah', 'King', 'elijah.king@example.com', '+18885553344'),
(29, 'Ava', 'Wright', 'ava.wright@example.com', '+14443332211'),
(30, 'Noah', 'Lewis', 'noah.lewis@example.com', '+15551112233'),
(31, 'Zoey', 'Hill', 'zoey.hill@example.com', '+19994445555'),
(32, 'Daniel', 'Harris', 'daniel.harris@example.com', '+12223334455'),
(33, 'Harper', 'Martin', 'harper.martin@example.com', '+13339998877'),
(34, 'Ethan', 'Thompson', 'ethan.thompson@example.com', '+16668887766'),
(35, 'Chloe', 'Walker', 'chloe.walker@example.com', '+17773331122'),
(36, 'Liam', 'Garcia', 'liam.garcia@example.com', '+18882223344'),
(37, 'Aria', 'Martinez', 'aria.martinez@example.com', '+14447776655'),
(38, 'Jacob', 'Ward', 'jacob.ward@example.com', '+15554447766'),
(39, 'Sophia', 'Jackson', 'sophia.jackson@example.com', '+19991112233'),
(40, 'Aiden', 'White', 'aiden.white@example.com', '+12224446677'),
(41, 'Madison', 'Davis', 'madison.davis@example.com', '+13332227788'),
(42, 'Mason', 'Wilson', 'mason.wilson@example.com', '+16669990099'),
(43, 'Ava', 'Lee', 'ava.lee@example.com', '+17778889900'),
(44, 'Liam', 'Hill', 'liam.hill@example.com', '+18887776611'),
(45, 'Isabella', 'Nelson', 'isabella.nelson@example.com', '+14442223344'),
(46, 'Ethan', 'Young', 'ethan.young@example.com', '+15557776633'),
(47, 'Mia', 'Gomez', 'mia.gomez@example.com', '+19998887722'),
(48, 'Logan', 'Cook', 'logan.cook@example.com', '+12221112233'),
(49, 'Charlotte', 'Cooper', 'charlotte.cooper@example.com', '+13334445566'),
(50, 'Lucas', 'Foster', 'lucas.foster@example.com', '+16661112233'),
(51, 'Amelia', 'Kelly', 'amelia.kelly@example.com', '+17774445522'),
(52, 'Oliver', 'Howard', 'oliver.howard@example.com', '+18883334411'),
(53, 'Avery', 'Barnes', 'avery.barnes@example.com', '+14445556688'),
(54, 'Emma', 'Rossi', 'emma.rossi@example.com', '+15556667711'),
(55, 'William', 'Ferrari', 'william.ferrari@example.com', '+19991112233'),
(56, 'Sophia', 'Esposito', 'sophia.esposito@example.com', '+12223334499'),
(57, 'Alexander', 'Romano', 'alexander.romano@example.com', '+13332221100'),
(58, 'Emily', 'Russo', 'emily.russo@example.com', '+16663334411'),
(59, 'James', 'Conti', 'james.conti@example.com', '+17776665500'),
(60, 'Olivia', 'Moretti', 'olivia.moretti@example.com', '+18885556611'),
(61, 'Michael', 'Colombo', 'michael.colombo@example.com', '+14443332288'),
(62, 'Isabella', 'Greco', 'isabella.greco@example.com', '+15554443300'),
(63, 'Daniel', 'Marino', 'daniel.marino@example.com', '+19992223344'),
(64, 'Emma', 'Gallo', 'emma.gallo@example.com', '+12221113355'),
(65, 'Noah', 'Conti', 'noah.conti@example.com', '+13334445500'),
(66, 'Ava', 'Mancini', 'ava.mancini@example.com', '+16665554411'),
(67, 'Ethan', 'Barbieri', 'ethan.barbieri@example.com', '+17777778822'),
(68, 'Mia', 'Fontana', 'mia.fontana@example.com', '+18888882233'),
(69, 'Lucas', 'Martini', 'lucas.martini@example.com', '+14445556699'),
(70, 'Lily', 'Caputo', 'lily.caputo@example.com', '+15553332211'),
(71, 'Benjamin', 'Santoro', 'benjamin.santoro@example.com', '+19994445566'),
(72, 'Charlotte', 'Ricci', 'charlotte.ricci@example.com', '+12224443377'),
(73, 'Oliver', 'De Angelis', 'oliver.deangelis@example.com', '+13336669900'),
(74, 'Avery', 'Marini', 'avery.marini@example.com', '+16667778811'),
(75, 'Emily', 'Bianchi', 'emily.bianchi@example.com', '+17778889922');

INSERT INTO bookings (bID, pID, fID, seatNo, bookingDate)
SELECT
    ROW_NUMBER() OVER (ORDER BY RAND()) AS bID,
    pf.pID,
    pf.fID,
    CONCAT('Seat-', FLOOR(1 + RAND() * a.totalSeats)) AS seatNo,
    DATE_ADD(f.deptDateTime, INTERVAL FLOOR(RAND() * 30) DAY) AS bookingDate
FROM
    (SELECT 
        pID,
        fID
    FROM
        passengers
    CROSS JOIN
        flights
    ORDER BY
        RAND()
    LIMIT 150) AS pf
JOIN
    flights f ON pf.fID = f.fID
JOIN
    aircrafts a ON f.acID = a.acID
LEFT JOIN
    (SELECT
        pID,
        COUNT(*) AS num_bookings
    FROM
        bookings
    GROUP BY
        pID) AS b_count ON pf.pID = b_count.pID
LEFT JOIN
    (SELECT
        fID,
        COUNT(*) AS num_bookings
    FROM
        bookings
    GROUP BY
        fID) AS f_count ON pf.fID = f_count.fID
WHERE
    (b_count.pID IS NULL OR b_count.num_bookings < 5)
    AND (f_count.fID IS NULL OR f_count.num_bookings < a.totalSeats);


-- Automatically insert data into flightsBooked table to match all the flights booked by passengers
INSERT INTO flightsBooked (pID, fID)
SELECT DISTINCT
    pID,
    fID
FROM
    bookings;

