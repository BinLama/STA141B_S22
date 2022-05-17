CREATE TABLE Posts (
   Id INTEGER,
   Type INTEGER,
   ParentId INTEGER,
   Label TEXT);

CREATE TABLE Comments (
   Id INTEGER,
   PostId INTEGER,
   NAME TEXT);

#.mode csv
#.separator "," "\n"

.import --csv --skip 1 Comments.csv Comments
.import --csv --skip 1 Posts.csv Posts


UPDATE Posts SET ParentId = NULL WHERE ParentId = '';
