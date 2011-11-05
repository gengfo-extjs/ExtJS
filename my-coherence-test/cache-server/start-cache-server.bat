set JAVA_HOME=C:\"Program Files"\Java\jdk1.6.0_21

set memory=512m

set java_exec=%java_home%\bin\java

if "%1"=="-jmx" (
	set jmxproperties=-Dcom.sun.management.jmxremote -Dtangosol.coherence.management=all -Dtangosol.coherence.management.remote=true
	shift  
)	

echo "-------------------->"
echo %jmxproperties%

set java_opts=-Xms%memory% -Xmx%memory% %jmxproperties%

%java_exec% -server -showversion %java_opts% -cp "%coherence_home%\lib\coherence.jar";"D:\GengFo\GitRoot\ExtJS\my-coherence-test\config\tangosol-coherence-override.xml" com.tangosol.net.DefaultCacheServer %1


