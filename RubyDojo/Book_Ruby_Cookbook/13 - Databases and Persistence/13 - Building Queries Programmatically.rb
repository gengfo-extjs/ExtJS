require 'cookbook_dbconnect'

class ActiveRecord::Base 
  def self.find_by_map(id, args={}.freeze)
    sql = []
    values = []
    args[:conditions].each do |field, value|
      sql << "#{field} = ?"
      values << value
    end if args[:conditions]
    args[:conditions] = [sql.join(' AND '), values]
    find(id, args)
  end
end
#---
activerecord_connect

class BlogPost < ActiveRecord::Base
end

BlogPost.create(:title => 'Game Review: Foosball Carnage',
                :content => 'Four stars!')
BlogPost.create(:title => 'Movie Review: Foosball Carnage: The Movie', 
                :content => 'Zero stars!')

BlogPost.find_by_map(:first, 
                     :conditions => {:title => 
	                             'Game Review: Foosball Carnage' }
                    ).content
# => "Four stars!"
#---
class Criteria < Hash
  def initialize(values)
    values.each { |k,v| add(k, *v) }
    @or_criteria = nil
    @and_criteria = nil
  end

  :private
  attr_accessor :or_criteria, :and_criteria

  :public
  def add(field, value, operation='=')
    self[field] = [value, operation]
  end

  def or(criteria)
    c = self
    while c.or_criteria != nil
      break if c == criteria
      c = c.or_criteria 
    end
    c.or_criteria = criteria
    return self
  end

  def and(criteria)
    c = self
    while c.and_criteria != nil
      break if c == criteria
      c = c.and_criteria
    end
    c.and_criteria = criteria
    return self
  end   
#---
class Criteria
  def to_where_clause
    sql = []
    values = []
    each do |field, value|
      if value.respond_to? :to_str
        value, operation = value, '='
      else
        value, operation = value[0..1]
      end
      sql << "#{field} #{operation} ?"
      values << value      
    end
    sql = '(' + sql.join(' AND ') + ')'
    
    if or_criteria
      or_where = or_criteria.to_where_clause
      sql = "(#{sql} OR #{or_where.shift})"
      values += or_where
    end

    if and_criteria
      and_where = and_criteria.to_where_clause
      sql = "(#{sql} AND #{and_where.shift})"
      values += and_where
    end
    return values.unshift(sql)
  end    
end
#---
class ActiveRecord::Base 
  def self.find_by_criteria(id, criteria, args={}.freeze)
    args = args.dup
    args[:conditions] = criteria.to_where_clause
    find(id, args)
  end
end
#---
review = Criteria.new(:title => ['%Review%', 'LIKE'])
bad_movie = Criteria.new(:title => ["%Movie%", 'LIKE'],
                         :content => 'Zero stars!')
good_game = Criteria.new(:title => ['%Game%', 'LIKE'],
                          :content => 'Four stars!')
no_cricket = Criteria.new(:title => ['%Cricket%', 'NOT LIKE'])

review.and(bad_movie.or(good_game)).and(no_cricket)
review.to_where_clause
# => ["((title LIKE ?) AND 
#       (((content = ? AND title LIKE ?) OR (content = ? AND title LIKE ?)) 
#      AND (title NOT LIKE ?)))", 
#     "%Review%", "Zero stars!", "%Movie%", "Four stars!", "%Game%",
#      "%Cricket%"]

BlogPost.find_by_criteria(:all, review).each { |post| puts post.title }
# Game Review: Foosball Carnage
# Movie Review: Foosball Carnage: The Movie
#---
# Just an idea...
order_by = [[:title, 'ASC']]
#---
