<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:jscript="http://jscript.org">
	
	<!--
		Author: Robin Viktorsson
		Date:	2017-11-02
		Filename: convert_xml_to.html.xsl
	-->
	
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes" exclude-result-prefixes="msxsl jscript"/>
	<msxsl:script language="JavaScript" implements-prefix="jscript">
	<![CDATA[
	public function getChannelName(text)
	{
		switch (text) {
			case "svt1.svt.se":
				return "Svt1";
				break;
			case "svt2.svt.se":
				return "Svt2";
				break;
			case "tv3.se":
				return "Tv3";
				break;
			case "tv4.se":
				return "Tv4";
				break;
			case "kanal5.se":
				return "Kanal5";
				break;
			case "tv6.se":
				return "Tv6";
				break;
			case "sjuan.se":
				return "Sjuan";
				break;
			case "tv8.se":
				return "Tv8";
				break;
			default:
				return "Test";
		}	
	}
	]]>
	</msxsl:script>

	<xsl:variable name="merged_xml_file" select="doc('xml_docs/allChannels.xml')"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta charset="utf-8"/>
				<title>XML, XSLT and XQuery Project</title>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<link rel="stylesheet" href="css/style.css"/>
				<link rel="stylesheet" href="css/jquery-ui.min.css"/>
				<script src="js/jquery-3.2.1.min.js"></script>
				<script src="js/jquery-ui.min.js"></script>
				<script type="text/javascript" src="js/custom.js"></script>
 			</head>
			<body>

				<div class="main_container">
					<div class="top_container">
						<div id="logo"></div>
					</div>
					<div class="middle_container">
						<xsl:apply-templates select="allchannels"/>
					</div>
					<div class="footer">
						<div class="footer_container">
							<p class="footer_title">Om oss</p>
							<p class="footer_content">
		              tv.nu är Sveriges största tv-guide med över 2,3 miljoner unika besökare varje vecka.
								<br/>
								<br/>
								<a href="#">Kontakt</a>
								<br/>
								<a href="#">Tyck till</a>
								<br/>
								<a href="#">Mer om oss</a>
								<br/>
								<a href="#">Anmäl störande/felaktig annons</a>
								<br/>
							</p>
						</div>
						<div class="footer_container">
							<p class="footer_title">Samarbete</p>
							<p class="footer_content">
		          tv.nu används i soffan framför tv:n och trafiken ökar upp till 800% under tv-reklampauserna. Med annonsering hos oss får ni räckvidd i en brusfri och ren annonsmiljö.
								<br/>
								<br/>
								<a href="#">Annonsera här</a>
								<br/>
								<a href="#">Jobb</a>
								<br/>
							</p>
						</div>
						<div class="footer_container">
							<p class="footer_title">Övrigt</p>
							<p class="footer_content">
								<a href="#">Kanalbibliotek</a>
								<br/>
								<a href="#">Skriv ut tablån</a>
								<br/>
								<a href="#">Sitemap</a>
								<br/>
							</p>
						</div>
						<div class="footer_container">
							<p class="footer_title">Följ oss</p>
							<p class="footer_content">
								<img src="images/facebook.jpg" style="margin-right: 10px;"/>
								<img src="images/twitter.jpg" style="margin-right: 10px;"/>
								<img src="images/instagram.jpg"/>
								<br/>
								<a href="#">Tv.nu blogg</a>
								<br/>
								<br/>
		          Tv.nu:s nyhetsbrev:
								<br/>
								<input id="nyhetsbrev" type="search" placeholder="Fyll i din e-post"/>
								<br/>
								<input type="submit" value="Prenumerera" style="margin-top: 5px;"/>
							</p>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="tv">
		<xsl:for-each select=".">
			<div class="channel_container">
				<div class="channel_header">
					<div class="channel_logo">
						<xsl:apply-templates select="@logo"/>
					</div>
					<div class="channel_name">
						<xsl:apply-templates select="@channel"/>
					</div>
				</div>
				<xsl:apply-templates select="programme"/>
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="programme">
			<xsl:for-each select=".">
				<div class="channel_programmes">
					<xsl:attribute name="data-id">
					   <xsl:value-of select="current()/id"/>
					</xsl:attribute>
					<span class="programme_time">
					   <xsl:attribute name="data-stoptime">
						   <xsl:value-of select="current()/stop"/>
					   </xsl:attribute>
						<xsl:apply-templates select="start"/>
					</span>
					<span class="programme_title">
						<xsl:apply-templates select="title"/>
					</span>
					<xsl:apply-templates select="type"/>
				</div>
			</xsl:for-each>
	</xsl:template>

	<xsl:template match="@logo">
		<img>
			<xsl:attribute name="src">images/<xsl:value-of select="."/></xsl:attribute>
		</img>
	</xsl:template>

	<xsl:template match="@channel">
		<xsl:value-of select="jscript:getChannelName(.)"/>
	</xsl:template>

	<xsl:template match="start">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="title">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="type">
		<xsl:variable name="cate" select="."/>
		<xsl:if test="$cate = 'movie'">
			<span class="movie">Film</span>
		</xsl:if>
		<xsl:if test="$cate = 'series'">
			<span class="series">Serie</span>
		</xsl:if>
		<xsl:if test="$cate = 'tvshow'">
			<span class="tvshow">Tv show</span>
		</xsl:if>
		<xsl:if test="$cate = 'sports'">
			<span class="sports">Sport</span>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
