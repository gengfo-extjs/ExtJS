<!-- app/views/layouts/application.rhtml -->

<html>
  <head>
    <title>My Web App</title>
    aardvark*<%= javascript_include_tag "prototype", "effects" %>*aardvark
  </head>
  <body>
    <%= @content_for_layout %>
  </body>
</html>
#---
<p id="important">Here is some important text, it will be highlighted
when the page loads.</p>

<script type="text/javascript">
<%= visual_effect(:highlight, "important", :duration => 1.5) %>
</script>
#---
<p id="deleted">Here is some old text, it will fade away when the page
loads.</p>

<script type="text/javascript">
<%= visual_effect(:fade, "deleted", :duration => 1.0) %>
</script>
#---
<img id="to-squish" src="bug.jpg">
<%=link_to_function("Squish the bug!", visual_effect(:squish, "to-squish"))%>
#---
<script type="text/javascript">
<%= visual_effect(:fade, 'deleted-text', :duration => 1.0) %>
</script>
#---
<script type="text/javascript">
new Effect.Fade("deleted-text", {duration:1.0});
</script>
#---
