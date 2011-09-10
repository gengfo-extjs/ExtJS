package com.baobaotao.dao;

import java.util.List;

import com.baobaotao.domain.Forum;

public interface ForumDao {
   void initDb();
   void addForum(Forum forum);
   void addForums(List<Forum> forums);
   Forum getForum(int forumId);
   List getForums(final int fromId,final int toId);
   int getForumNum();
}
