.mode tabs
.headers on

SELECT *
FROM Posts AS p1
LEFT JOIN Posts AS p2
       ON  p1.Id = p2.ParentId
LEFT JOIN Comments AS c
       ON  c.PostId = p2.Id
LEFT JOIN Comments AS c2
       ON  c2.PostId = p1.Id       
ORDER BY p1.Id;

             Posts  (Question)                       Posts (Answers)               Comments (Answer)      Comments (Question)
-------------------------------------	-------------------------------------  ----------------------  ---------------------
Id	Type	ParentId	Label	Id	Type	ParentId	Label	Id	PostId	NAME	Id	PostId	NAME
1	1		Q1	2	2	1	A1	3	2	cA1	1	1	cQ1
1	1		Q1	2	2	1	A1	3	2	cA1	2	1	cQ2
1	1		Q1	2	2	1	A1	4	2	cA1	1	1	cQ1
1	1		Q1	2	2	1	A1	4	2	cA1	2	1	cQ2
1	1		Q1	3	2	1	A2				1	1	cQ1
1	1		Q1	3	2	1	A2				2	1	cQ2
1	1		Q1	4	2	1	A3	5	4	cA3	1	1	cQ1
1	1		Q1	4	2	1	A3	5	4	cA3	2	1	cQ2
1	1		Q1	4	2	1	A3	6	4	cA3	1	1	cQ1
1	1		Q1	4	2	1	A3	6	4	cA3	2	1	cQ2
1	1		Q1	4	2	1	A3	7	4	cA3	1	1	cQ1
1	1		Q1	4	2	1	A3	7	4	cA3	2	1	cQ2
2	2	1	A1								3	2	cA1
2	2	1	A1								4	2	cA1
3	2	1	A2										
4	2	1	A3								5	4	cA3
4	2	1	A3								6	4	cA3
4	2	1	A3								7	4	cA3
11	1		Q2								8	11	cQ2
21	1		Q3	22	2	21	A4						
21	1		Q3	23	2	21	A5	9	23	cQ3A2_1			
21	1		Q3	23	2	21	A5	10	23	cQ3A2_2			
21	1		Q3	23	2	21	A5	11	23	cQ3A2_3			
21	1		Q3	24	2	21	A6	12	24	cQ3A3_1			
21	1		Q3	25	2	21	A7	13	25	cQ3A4_1			
21	1		Q3	25	2	21	A7	14	25	cQ3A4_2			
21	1		Q3	25	2	21	A7	15	25	cQ3A4_3			
21	1		Q3	25	2	21	A7	16	25	cQ3A4_4			
22	2	21	A4										
23	2	21	A5								9	23	cQ3A2_1
23	2	21	A5								10	23	cQ3A2_2
23	2	21	A5								11	23	cQ3A2_3
24	2	21	A6								12	24	cQ3A3_1
25	2	21	A7								13	25	cQ3A4_1
25	2	21	A7								14	25	cQ3A4_2
25	2	21	A7								15	25	cQ3A4_3
25	2	21	A7								16	25	cQ3A4_4







# Sum the ParentId by Question Id




SELECT p1.Id AS QId, COUNT(DISTINCT p2.Id) AS NumAns, COUNT(DISTINCT c.Id) AS NumAnswerComments, COUNT(DISTINCT c2.Id) AS NumQuestionComments
FROM Posts AS p1
LEFT JOIN Posts AS p2
       ON  p1.Id = p2.ParentId
LEFT JOIN Comments AS c
       ON  c.PostId = p2.Id
LEFT JOIN Comments AS c2
       ON  c2.PostId = p1.Id       
GROUP BY p1.Id
ORDER BY QId;





