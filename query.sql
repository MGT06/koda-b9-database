--1

SELECT id,
       name,
       email,
       role,
       position,
       image_url
FROM accounts
WHERE email = 'andi.pratama@mail.com'
    AND password = 'password123';

-- 2

INSERT INTO accounts (name, email, position, password)
VALUES ('given', 'given@mail.com', 'Founder', 'password123');

--3

SELECT e.title
FROM event_categories
JOIN events e ON event_categories.event_id = e.id
JOIN categories c ON event_categories.category_id = c.id
WHERE e.title ILIKE '%wo%'
    AND c.name = 'Technology';

--4

SELECT a.name,
       e.title,
       e.description,
       e.image_url,
       e.format,
       e.location,
       e.capacity,
       e.status,
       e.speakers,
       c.name
FROM event_categories
JOIN events e ON event_categories.event_id = e.id
JOIN categories c ON event_categories.category_id = c.id
JOIN accounts a ON e.organizer_id = a.id 

--5

INSERT INTO join_event (account_id, event_id)
VALUES (1,1);


DELETE
FROM join_event
WHERE id = 1;

--6

SELECT title,
       description,
       image_url,
       format,
       location,
       capacity,
       status,
       speakers
FROM events
WHERE start_at > now();

--7

SELECT a.name,
       e.title
FROM join_event
JOIN accounts a ON a.id = join_event.account_id
JOIN events e ON e.id = join_event.event_id
WHERE a.id = 5;

--8

SELECT e.name
FROM community_categories
JOIN communities e ON e.id = community_categories.community_id
JOIN categories c ON c.id = community_categories.category_id
WHERE e.name ILIKE '%ja%'
    AND c.name = 'Technology';


--9

SELECT e.name,
       e.description,
       e.image_url,
       c.name
FROM community_categories
JOIN communities e ON e.id = community_categories.community_id
JOIN categories c ON c.id = community_categories.category_id;

--10
 WITH CommunityCounts AS
    (SELECT c.name,
            COUNT(cm.account_id) AS total_members
     FROM communities c
     JOIN community_members cm ON c.id = cm.community_id
     GROUP BY c.name)
SELECT name
FROM CommunityCounts
WHERE total_members >
        (SELECT AVG(total_members)
         FROM CommunityCounts);

--11

INSERT INTO community_members (community_id, account_id)
VALUES (1,1);


DELETE
FROM community_members
WHERE id = 1;

--12

SELECT a.name,
       c.name
FROM community_members
JOIN communities c ON c.id = community_members.community_id
JOIN accounts a ON a.id = community_members.account_id 

--13

SELECT a.name,
       a.email,
       a.bio,
       a.location,
       a.position
FROM accounts a
WHERE a.id = 10;    

--14

UPDATE accounts
SET bio = 'dimana mana hatiku senang'
WHERE accounts.id = 10;

--15

UPDATE accounts
SET password = 'password321'
WHERE accounts.id = 10;

--16

SELECT a.name,
       t.message
FROM testimony t
JOIN accounts a ON a.id = t.account_id;

INSERT INTO testimony (account_id, message)
VALUES (13, 'mantap')

--17

SELECT a.name,
       n.title,
       n.message
FROM notifications n
JOIN accounts a ON a.id = n.account_id
WHERE account_id = 5;

--18

SELECT
    (SELECT COUNT(title)
     FROM events
     WHERE organizer_id = 3) AS "Total Event Created",

    (SELECT COUNT(DISTINCT je.account_id)
     FROM join_event je
     JOIN events e ON je.event_id = e.id
     WHERE e.organizer_id = 3) AS "Total Attendess Joined";
     
--19

INSERT INTO events (organizer_id,
                    community_id,
                    title,
                    description,
                    image_url,
                    start_at,
                    end_at,
                    format,
                    location,
                    capacity,
                    status,
                    speakers)
VALUES (2, 1, 'Workshop React dari Dasar hingga Mahir', 'Workshop intensif satu hari untuk memahami komponen, state, hooks, dan praktik terbaik pengembangan aplikasi React.', 'https://picsum.photos/seed/event1/800/400', now() - interval '60 days', now() - interval '60 days' + interval '6 hours', 'offline', 'Co-Working Space Sudirman, Jakarta Pusat', 50, 'end', '[{"name":"Rina Kusuma","title":"Senior Frontend Engineer","image_url":"https://i.pravatar.cc/150?img=32"},{"name":"Yoga Firmansyah","title":"Tech Lead, Tokoku","image_url":"https://i.pravatar.cc/150?img=53"}]'::jsonb)
UPDATE events
SET format = 'online'
WHERE id = 1;


INSERT INTO event_categories (event_id, category_id)
VALUES (16, 5) INSERT INTO event_categories (event_id, category_id) VALUES (16, 3)

--20

SELECT
    (SELECT COUNT(*)
     FROM accounts) AS "Total Users",

    (SELECT COUNT(*)
     FROM events) AS "Total Events",

    (SELECT COUNT(*)
     FROM communities) AS "Total Communities"