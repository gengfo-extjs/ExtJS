To compile this example project in Eclipse:

1. Download TopLink from OTN [1] and define user library 'TopLink' containing
   o eclipselink.jar
   o javax.persistence_2.0.0.jar
   o toplink-grid.jar

   [1] http://www.oracle.com/technetwork/middleware/toplink/downloads/index.html   
   
2. Download Coherence from OTN [2] and define user library 'Coherence' containing
   o coherence.jar
   
   [2] http://www.oracle.com/technetwork/middleware/coherence/downloads/index.html

3. From Oracle XE database define user library 'Oracle JDBC' containing
   o ojdbc14.jar

To run this example:

1. Enable the SCOTT user in Oracle XE. 
2. Run gridcache.example.CreateDatabase to drop and create tables
3. Run gridcache.example.StartCacheServer
4. Run gridcache.example.InsertExample to persist some objects
5. Run gridcache.example.QueryExample to query objects

NOTE: All code examples should be run with bytecode weaving enabled 
for optimal performance and to enable lazy loading of OneToOne and
ManyToOne relationships. In Java SE, you'll need to run with the VM argument:
	 -javaagent:<TOPLINK_HOME>\jlib\eclipselink.jar
