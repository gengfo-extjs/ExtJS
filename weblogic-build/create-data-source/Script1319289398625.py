edit()
startEdit()

cd('/')
cmo.createJDBCSystemResource('ipsDev')

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev')
cmo.setName('ipsDev')

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev/JDBCDataSourceParams/ipsDev')
set('JNDINames',jarray.array([String('ipsDev')], String))

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev/JDBCDriverParams/ipsDev')
cmo.setUrl('jdbc:oracle:thin:@localhost:1521:xe')
cmo.setDriverName('oracle.jdbc.xa.client.OracleXADataSource')
setEncrypted('Password', 'Password_1319289460406', 'Script1319289398625Config', 'Script1319289398625Secret')

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev/JDBCConnectionPoolParams/ipsDev')
cmo.setTestTableName('employees\r\n')

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev/JDBCDriverParams/ipsDev/Properties/ipsDev')
cmo.createProperty('user')

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev/JDBCDriverParams/ipsDev/Properties/ipsDev/Properties/user')
cmo.setValue('hr')

cd('/JDBCSystemResources/ipsDev/JDBCResource/ipsDev/JDBCDataSourceParams/ipsDev')
cmo.setGlobalTransactionsProtocol('TwoPhaseCommit')

cd('/SystemResources/ipsDev')
set('Targets',jarray.array([], ObjectName))

activate()

startEdit()
set('Targets',jarray.array([ObjectName('com.bea:Name=myserver,Type=Server')], ObjectName))

activate()

startEdit()
