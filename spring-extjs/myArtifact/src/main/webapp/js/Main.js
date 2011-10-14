Ext.onReady(function() {

  Ext.Direct.addProvider(Ext.app.REMOTING_API, {
    id: 'pollingTimeProvider',
    type: 'polling',
    interval: 100000,
    url: Ext.app.POLLING_URLS.timeChange    
  });

  var directStore = new Ext.data.DirectStore( {
    paramsAsHash: true,
    directFn: userService.load,
    autoLoad: true,
    fields: [ "lastName", "firstName", "email" ]
  });

  var formPanel = new Ext.form.FormPanel( {
    id: 'formPanel',
    title: 'FormPanel',
    paramsAsHash: true,
    bodyStyle: 'padding: 5px',
    defaultType: 'textfield',
    flex: 1,
    defaults: {
      anchor: '100%'
    },
    items: [ {
      name: 'firstName',
      fieldLabel: 'First Name'
    }, {
      name: 'lastName',
      fieldLabel: 'Last Name'
    }, {
      name: 'time',
      fieldLabel: 'Time'
    }, {
      xtype: 'textarea',
      name: 'serverInfo',
      anchor: '100%, -80',
      fieldLabel: 'Server Info'
    } ],
    api: {
      load: formHandler.getFormData,
      submit: formHandler.handleFormSubmit
    },
    bbar: [ '->', {
      text: 'Load Form Data',
      handler: function() {
        formPanel.getForm().load();
      }
    }, '-', {
      text: 'Get Server Info',
      handler: function() {
        serverInfo.getInfo(onGetInfo);
      }
    }, '-', {
      text: 'Submit Form',
      handler: function(e) {
        formPanel.getForm().submit();
      }
    } ]
  });

  var gridPanel = {
    xtype: 'grid',
    title: 'GridPanel',
    viewConfig: {
      forceFit: true
    },
    columns: [ {
      header: 'Last Name',
      dataIndex: 'lastName',
      sortable: true
    }, {
      header: 'First Name',
      dataIndex: 'firstName',
      sortable: true
    }, {
      header: 'Email',
      dataIndex: 'email',
      sortable: true
    } ],
    store: directStore,
    loadMask: true,
    id: 'myGrid'
  };

  var tabPanel = {
    xtype: 'tabpanel',
    activeTab: 0,
    deferredRender: false,
    layoutOnTabChange: true,
    border: false,
    plain: false,
    items: [ formPanel, gridPanel ]
  };

  var myWin = new Ext.Window( {
    height: 280,
    width: 450,
    minHeight: 280,
    minWidth: 350,
    title: 'My Application',
    layout: 'fit',
    items: [ tabPanel ]
  });
  myWin.show();

  var onGetInfo = function(result) {
    Ext.getCmp('formPanel').getForm().setValues( {
      serverInfo: result
    });
  };

  Ext.Direct.on( {
    timeChange: function(e) {
      Ext.getCmp('formPanel').getForm().setValues( {
        time: e.data
      });
    }
  });

});