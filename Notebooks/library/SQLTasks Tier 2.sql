/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name
FROM Facilities
WHERE membercost > 0

/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT(name)
FROM Facilities
WHERE membercost > 0

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost < (0.2* monthlymaintenance)

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT *
FROM Facilities
WHERE facid IN (1, 5)


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance, 
CASE WHEN monthlymaintenance>100 THEN 'expensive' ELSE 'cheap' END AS label
FROM Facilities


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT surname, firstname
FROM Members
WHERE joindate = (SELECT max(joindate) from Members)


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT CONCAT(m.firstname,' ', m.surname) AS name,
f.name AS tennis_court_type
FROM Bookings as b
JOIN Members as m
ON m.memid = b.memid
JOIN Facilities as f
ON b.facid = f.facid
WHERE b.facid IN (0,1)
GROUP BY name
ORDER BY name


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT CONCAT(m.surname,' ',m.firstname) AS name, f.name AS facility_name, CASE WHEN m.memid=0 THEN f.guestcost ELSE f.membercost END AS cost
FROM Bookings as b
JOIN Members as m
ON m.memid = b.memid
JOIN Facilities as f
ON b.facid = f.facid
WHERE (b.starttime LIKE "2012-09-14%") AND (cost>30)
GROUP BY name
ORDER BY cost DESC



/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT f.name, CONCAT(m.surname,' ',m.firstname) as MemberName, 
CASE WHEN b.memid=0 THEN b.slots*f.guestcost 
    ELSE b.slots*membercost END AS Cost
FROM Bookings as b
INNER JOIN Facilities as f
ON b.facid = f.facid
INNER JOIN Members as m
ON b.memid = m.memid
WHERE DATE(b.starttime) in (SELECT DATE(starttime)
                      FROM Bookings
                      WHERE DATE(starttime) = '2012-09-14')
AND CASE WHEN b.memid=0 THEN b.slots*f.guestcost 
        ELSE b.slots*membercost END > 30
ORDER BY Cost DESC


/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  


QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

facilities_<_10k_revenue = 
pd.read_sql_query(
"SELECT name, SUM(CASE WHEN memid = 0 THEN slots * guestcost ELSE slots * membercost END) as Revenue 
FROM Bookings 
LEFT JOIN Facilities using(facid) 
GROUP BY name 
HAVING Revenue < 1000",engine)

facilities_<_10k_revenue


/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */

recommended_members = pd.read_sql_query(
"SELECT (a.surname || ' ' || a.firstname) as members, (b.surname || ' ' || b.firstname) as recommended_by 
FROM Members a, Members b 
WHERE a.recommendedby >0 and a.recommendedby = b.memid 
ORDER BY b.surname", engine)

recommended_members

/* Q12: Find the facilities with their usage by member, but not guests */

facility_usage_by_members = pd.read_sql_query(
"SELECT name, (firstname || ' ' || surname) as MemberName, COUNT(surname) as 'Usage' 
FROM Bookings 
INNER JOIN Facilities USING(facid) INNER JOIN Members USING(memid) 
WHERE memid != 0 GROUP BY name, MemberName", engine)

facility_usage_by_members

/* Q13: Find the facilities usage by month, but not guests */

facility_usage_by_month = pd.read_sql_query("
SELECT strftime('%m', starttime) as Month, name, COUNT(name) as Usage 
FROM Bookings 
INNER JOIN Facilities USING(facid) 
WHERE memid != 0 GROUP BY Month, name", engine)

facility_usage_by_month