-- Below is the duration for patients
SELECT 
	p.medical_condition,
	h.admission_type,
	h.admission_date,
    h.discharge_date,
    DATEDIFF(h.discharge_date, h.admission_date) AS duration
FROM sys.hospital AS h
JOIN sys.patient AS p
	ON p.name_id = h.hospital_id;

-- Below filters for urgent medical conditions
SELECT 
	p.medical_condition,
	h.admission_type,
    COUNT(*) AS admission_count
FROM sys.hospital AS h
JOIN sys.patient AS p
	ON p.name_id = h.hospital_id
WHERE h.admission_type = 'Emergency'
GROUP BY h.admission_type, p.medical_condition;
