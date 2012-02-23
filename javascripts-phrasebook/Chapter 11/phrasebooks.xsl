<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<ul>
  <xsl:for-each select="books/book">
    <li>
      <xsl:value-of select="title" />
      by
      <xsl:value-of select="publisher" />
      (<xsl:value-of select="@pubdate" />)
    </li>
  </xsl:for-each>    
</ul>
</xsl:template>
</xsl:stylesheet>