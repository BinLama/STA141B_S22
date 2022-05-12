CREATE TABLE Foo (
 g INTEGER,
 age  INTEGER
);

INSERT INTO Foo VALUES
(1, 20),
(1, 30),
(1, 10),
(2, 55),
(2, 27);

select * FROM Foo
GROUP BY g
HAVING age = MIN(age);


select * FROM Foo
GROUP BY g
HAVING (MAX(age) - MIN(age)) > 20;

