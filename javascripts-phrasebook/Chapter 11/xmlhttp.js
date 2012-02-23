function getXMLHttp() {
  var XMLHttp = null;
  if (window.XMLHttpRequest) {
    try {
      XMLHttp = new XMLHttpRequest();
    } catch (e) { }
  } else if (window.ActiveXObject) {
    try {
      XMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try {
        XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (e) { }
    }
  }
  return XMLHttp;
}
