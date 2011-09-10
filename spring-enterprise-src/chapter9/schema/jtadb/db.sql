
DROP DATABASE IF EXISTS topicdb;
CREATE DATABASE topicdb DEFAULT CHARACTER SET utf8;
USE topicdb;
drop table if exists t_topic;
create table t_topic
(
   topic_id             int(11) not null auto_increment,
   forum_id             int(11) not null default 0,
   topic_title          varchar(100) not null default '',
   user_id              int(11) not null default 0,
   topic_time           datetime default NULL,
   topic_views          int(11) default 1,
   topic_replies        int(11) default 0,
   primary key (topic_id)
);
create index IDX_TOPIC_USER_ID on t_topic
(
   user_id
);

DROP DATABASE IF EXISTS postdb;
CREATE DATABASE postdb DEFAULT CHARACTER SET utf8;
USE postdb;
create table t_post
(
   post_id              int(11) not null auto_increment,
   topic_id             int(11) not null default 0,
   forum_id             int(11) not null default 0,
   user_id              int(11) not null default 0,
   post_text            text,
   post_attach          blob,
   post_time            datetime default NULL,
   primary key (post_id)
);
create index IDX_POST_TOPIC_ID on t_post
(
   topic_id
);