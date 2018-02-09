<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<!-- 
	Author: Robin Viktorsson (rovi1601)
	Date:	2017-11-02
	Filename: merge_xml_files.xsl
-->

<xsl:variable name="svt1" select="doc('xml_docs/svt1.svt.se_2017-11-03.xml')"/>
<xsl:variable name="svt2" select="doc('xml_docs/svt2.svt.se_2017-11-03.xml')"/>
<xsl:variable name="tv3" select="doc('xml_docs/tv3.se_2017-11-03.xml')"/>
<xsl:variable name="tv4" select="doc('xml_docs/tv4.se_2017-11-03.xml')"/>
<xsl:variable name="kanal5" select="doc('xml_docs/kanal5.se_2017-11-03.xml')"/>
<xsl:variable name="tv6" select="doc('xml_docs/tv6.se_2017-11-03.xml')"/>
<xsl:variable name="sjuan" select="doc('xml_docs/sjuan.se_2017-11-03.xml')"/>
<xsl:variable name="tv8" select="doc('xml_docs/tv8.se_2017-11-03.xml')"/>

<xsl:variable name="channels" select="$svt1, $svt2, $tv3, $tv4, $kanal5, $tv6, $sjuan, $tv8" />

 <xsl:template name="main" match="/">
   <allchannels>
   <xsl:for-each select="$channels">
     <xsl:copy>
       <xsl:apply-templates/>
     </xsl:copy>
   </xsl:for-each>
   </allchannels>
 </xsl:template>

 <xsl:template match="tv">
   <tv>
     <xsl:variable name="channelname" select="*[1]/@channel"/>
     <xsl:attribute name="channel"><xsl:value-of select="$channelname"/></xsl:attribute>
     <xsl:attribute name="logo"><xsl:value-of select="concat($channelname, '.png')"/></xsl:attribute>
     <xsl:apply-templates select="programme"/>
   </tv>
 </xsl:template>

 <xsl:template match="programme">
      <programme>
		  <id><xsl:value-of select="generate-id()"/></id>
          <xsl:apply-templates select="title" />
          <xsl:apply-templates select="desc" />
          <xsl:apply-templates select="@start" />
          <xsl:apply-templates select="@stop" />
		  <xsl:apply-templates select="date" />
          <xsl:apply-templates select="category" />
      </programme>
 </xsl:template>

 <xsl:template match="title">
     <title><xsl:value-of select="."/></title>
 </xsl:template>

 <xsl:template match="desc">
     <desc><xsl:value-of select="."/></desc>
 </xsl:template>

 <xsl:template match="@start">
     <start><xsl:value-of select="concat(substring(., 9, 2), ':', substring(., 11, 2))"/></start>
 </xsl:template>

 <xsl:template match="@stop">
     <stop><xsl:value-of select="concat(substring(., 9, 2), ':', substring(., 11, 2))"/></stop>
 </xsl:template>

<xsl:template match="date">
    <date><xsl:value-of select="."/></date>
</xsl:template>

<xsl:template match="category">

    <xsl:for-each select=".">
		<xsl:choose>
		<xsl:when test=". = 'movie' or . = 'series' or . = 'tvshow' or . = 'sports'">
		   <type><xsl:value-of select="."/></type>
		 </xsl:when>
		 <xsl:otherwise>
		  <category><xsl:value-of select="."/></category>
		 </xsl:otherwise>
	   </xsl:choose>
	</xsl:for-each>

</xsl:template>

</xsl:stylesheet>
