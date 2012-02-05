CREATE TABLE HR.t_forum
(
  forum_id INT  NOT NULL,
  forum_name VARCHAR2(30) ,
  forum_desc VARCHAR2(255) 
,CONSTRAINT pk_t_forum PRIMARY KEY
 (
  forum_id,
  forum_name
 )
)
;


