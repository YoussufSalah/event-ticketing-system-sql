-- 1. Total tickets sold per event
SELECT e.name AS event_name,
    COUNT(t.id) AS total_tickets
FROM Tickets AS t
    JOIN Events AS e ON e.id = t.event_id
GROUP BY e.name
ORDER BY total_tickets DESC;
-- 2. Attendee list for a given event (with ticket type)
SELECT first_name || ' ' || last_name AS member_name,
    email,
    phone
FROM Members
WHERE id IN (
        SELECT member_id
        FROM tickets
        WHERE ticket_type_id = 1
            AND event_id = 1 -- Sample ticket type, and event
    );
-- 3. Revenue per event (sum of ticket prices)
SELECT e.name AS event_name,
    SUM(t.price) AS total_revenue
FROM Tickets AS t
    JOIN Events AS e ON e.id = t.event_id
GROUP BY e.name
ORDER BY total_revenue DESC;