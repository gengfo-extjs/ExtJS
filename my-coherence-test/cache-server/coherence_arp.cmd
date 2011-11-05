@echo off
title ARP Local Coherence Test...

@rem 9501 
@rem D:/ToCheck/local-coh-scripts/cohgridServer
@rem C:/oracle/Middleware/jdk160_21/jre
@rem ARP.CM.DEV.1
@rem 146.222.51.50
@rem 8581
@rem 146.222.51.50


set JAVA_OPT=-showversion 
echo %JAVA_OPT%

set JMX_PARAMS=-Dcom.sun.management.jmxremote -Dtangosol.coherence.mode=prod -Dtangosol.coherence.management=all -Dtangosol.coherence.management.remote=true -Dcom.sun.management.jmxremote.port=9501 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false 
echo %JMX_PARAMS%

set COH_ROOT=D:/ToCheck/local-coh-scripts/cohgridServer
echo %COH_ROOT%

set CONFIG_PATH=%COH_ROOT%\config
echo %CONFIG_PATH%

set LIB_PATH=%COH_ROOT%\lib
echo %LIB_PATH%

set JAVA_HOME=C:/oracle/Middleware/jdk160_21/jre
echo %JAVA_HOME%

@rem set COH_HOME_LOG_DIR=%COH_ROOT%\logs
@rem echo %COH_HOME_LOG_DIR%
@rem set CACHE_REDIRECT_LOG=%COH_HOME_LOG_DIR%\redirect.log
@rem echo %CACHE_REDIRECT_LOG%
@rem set THIRDPARTY_LIB_PATH=%COH_ROOT%\lib
@rem set APP_LIB_PATH=%COH_ROOT%\lib
@rem set FRM_LIB_PATH=%COH_ROOT%\lib
@rem set APP_CONFIG=%COH_ROOT%\config
@rem set ENV=-DSPSINT_SPS_HKG

set JAVA_MEM= -Xms256m -Xmx256m
echo %JAVA_MEM%

set COHERENCE_OPT= -Dtangosol.coherence.member=ARP.CM.DEV.1 -Dtangosol.coherence.machine=146.222.51.50 -Dtangosol.coherence.override=%CONFIG_PATH%\tangosol-coherence-override.xml -Dtangosol.coherence.cacheconfig=%CONFIG_PATH%\arp-cache-config.xml -Dlog4j.configuration=log4j.xml
echo %COHERENCE_OPT%

set NODE_PORT=-Dtangosol.coherence.localport=8581 -Dtangosol.coherence.localhost=146.222.51.50
echo %NODE_PORT%

set LIBS=%LIB_PATH%\coherence.jar;%LIB_PATH%\je.jar;%LIB_PATH%\log4j.jar;%LIB_PATH%\IODT-frmwk.jar;%LIB_PATH%\OOCL_PFW-frmwk.jar;%LIB_PATH%\ARP_Domain.jar;%LIB_PATH%\eclipselink.jar;%LIB_PATH%\toplink-grid.jar;%CONFIG_PATH%
echo %LIBS%



set EXEC= %JAVA_HOME%\bin\java %JAVA_OPT% %JAVA_MEM% %COHERENCE_OPT% %NODE_PORT% %JMX_PARAMS% -cp %LIBS% com.tangosol.net.DefaultCacheServer
echo %EXEC%

%EXEC%