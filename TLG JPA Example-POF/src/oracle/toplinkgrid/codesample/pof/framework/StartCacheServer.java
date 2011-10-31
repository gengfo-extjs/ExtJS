package oracle.toplinkgrid.codesample.pof.framework;


import com.tangosol.net.DefaultCacheServer;

public class StartCacheServer {

	public static void main(String[] args) {
		// Configure Single Server Mode 
		// http://download.oracle.com/docs/cd/E15357_01/coh.360/e15723/cluster_singleserver.htm#sthref19
		System.setProperty("tangosol.coherence.localhost","127.0.0.1");
		System.setProperty("tangosol.coherence.ttl","0");
		// Disable local storage--need to start independent CacheServer
		System.setProperty("tangosol.coherence.cacheconfig","EclipseLink-POF-Cache-Store.xml");
		// Start CacheServer
		DefaultCacheServer.main(new String[0]);
	}
}
