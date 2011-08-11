<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="./js/extjs-ref/resources/css/ext-all.css"/>
<script type="text/javascript" src="./js/extjs-ref/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="./js/extjs-ref/ext-all-debug.js"></script>
<script type="text/javascript">

Ext.BLANK_IMAGE_URL='./js/extjs-ref/resources/images/default/s.gif';

Ext.onReady(function() {
	var firstDiv = Ext.get("div-1");
	Ext.Msg.alert('Using Ext.get(el)', firstDiv.id);
	}
);
</script>
</head>
<body>
	<div id="div-1">This is the first div</div>
</body>
</html>
