
Ext.BLANK_IMAGE_URL='./js/extjs-ref/resources/images/default/s.gif';

Ext.onReady(function() {
	var firstDiv = Ext.get("div-1");
	Ext.Msg.alert('Using Ext.get(el)', firstDiv.id);
	}
);