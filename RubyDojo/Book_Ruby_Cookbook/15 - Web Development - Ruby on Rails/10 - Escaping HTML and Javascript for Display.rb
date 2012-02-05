<%= @data %>
#---
<%=h @data %>
#---
<!-- index.rhtml -->
<script lang="javascript">
var text = "<%= escape_javascript @javascript_alert_text %>";
alert(text);
</script>
#---
