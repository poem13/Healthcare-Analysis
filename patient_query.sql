/* This query ranks by blood type. 
ASC is least common and DESC is most common blood type by condition */
WITH RankedBloodTypes AS (
	SELECT
		medical_condition,
        b.blood_type,
        COUNT(*) AS blood_type_count,
        RANK() OVER(PARTITION BY medical_condition ORDER BY blood_type ASC) AS ranking
	FROM sys.patient
    JOIN sys.bloodtype AS b
		ON sys.patient.name_id = b.blood_id
    GROUP BY medical_condition, blood_type
)

SELECT 
	medical_condition,
    blood_type,
    blood_type_count
FROM
	RankedBloodTypes
WHERE 
	ranking = 1;

/* This query finds the correlation between gender
and age in certain medical conditions */

SELECT 
    p.gender,
    p.age,
    p.medical_condition,
    b.blood_type,
	AVG(p.age) OVER() AS avg_age,
    COUNT(p.gender) OVER() AS gender_count
FROM sys.patient AS p
LEFT JOIN sys.bloodtype AS b
	ON b.blood_id = p.name_id
WHERE p.medical_condition = 'Obesity'
	AND p.gender = 'Male';