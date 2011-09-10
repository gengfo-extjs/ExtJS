<#import "spring.ftl" as spring />
<html>
	<head>
		<title>宝宝淘论坛用户注册</title>
	</head>
	<body> 
	    
        <form action="<@spring.url '/registerUser.html'/>" method="POST">
        
			用户名：<@spring.formInput "command.userName"/>
            <@spring.showErrors "<br>"/>      
			密 码：<@spring.formPasswordInput "command.password"/>
			<@spring.showErrors "<br>"/>
			<input type="submit" value="注册" />
			<input type="reset" value="重置" />
		</form>
	</body>
</html>