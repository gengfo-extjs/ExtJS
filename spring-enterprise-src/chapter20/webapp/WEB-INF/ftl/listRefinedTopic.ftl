<#-- 这是用于显示精华帖子的模板 -->
<#import "spring.ftl" as spring />
<html>
	<head>
		<title>
		  baobaotao
		</title>
	</head>
	<body>
		精华文章
		<table>
		    <#list topicList as topic>
				<tr>
					<td>
						${topic.topicId}
					</td>
					<td>					   
						<a href="<@spring.url '/showTopic.html?topicId=${topic.topicId}'/>">${topic.title}</a>
					</td>
					<td>
					   ${topic.createDate?string("yyyy-MM-dd HH:mm:ss")}
					</td>
				</tr>
			</#list>
		 <table>
	</body>
</html>
