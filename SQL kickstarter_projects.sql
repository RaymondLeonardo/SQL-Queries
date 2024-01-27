-- 1. Which category has the highest success percentage? How many projects have been successful?

SELECT
    Category,
    COUNT(*) AS TotalProjects,
    SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulProjects,
    (SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) / CAST(COUNT(*)AS float)) * 100 AS SuccessPercentage
FROM
    projects
GROUP BY
    Category
ORDER BY
    SuccessPercentage DESC
LIMIT 1;

/* 
SELECT 
	Category, 
	COUNT(*) AS totalprojects
FROM projects
WHERE state = 'Successful'
GROUP BY category
*/

-- 2. What project with a goal over $1,000 USD, had the biggest Goal Completion % (Pledged / Goal)? How much money was pledged?

SELECT
    ID,
    Name,
    Goal,
    Pledged,
    (Pledged / Goal) * 100 AS GoalCompletionPercentage
FROM
    projects
WHERE
    Goal > 1000
ORDER BY
    GoalCompletionPercentage DESC
LIMIT 1;

-- 3. Can you identify any trends in project success rates over the years?

SELECT
	EXTRACT(MONTH FROM Launched) AS LaunchMonth,
    EXTRACT(YEAR FROM Launched) AS LaunchYear,
    COUNT(*) AS TotalProjects,
    SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulProjects,
    (SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) / CAST(COUNT(*) AS float)) * 100 AS SuccessPercentage
FROM
    projects
GROUP BY
	LaunchMonth,
    LaunchYear
ORDER BY
    LaunchYear;
	
	
	
-- 4. As an investor, what types of projects should you be looking at to guarantee future success?

SELECT
    Category,
    COUNT(*) AS TotalProjects,
    SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulProjects,
    (SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) / COUNT(*)::float) * 100 AS SuccessPercentage
FROM
    projects
GROUP BY
    Category
ORDER BY
    SuccessPercentage DESC;