CREATE TABLE Users (
  Id TEXT
);

CREATE TABLE Badges (
  UserId TEXT,
  Badge TEXT
);

CREATE TABLE Posts (
  Id TEXT,
  UserId TEXT,
  PostTypeId INTEGER,
  ParentId TEXT
);

.import --skip 1 --csv Posts.csv Posts
.import --skip 1 --csv Badges.csv Badges
.import --skip 1 --csv Users.csv Users

