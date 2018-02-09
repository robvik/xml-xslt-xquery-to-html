<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
			xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/allchannels">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

		<fo:layout-master-set>
			<fo:simple-page-master master-name="all"
						  page-height="28cm"  page-width="22cm" margin-top="1cm" 
						  margin-bottom="2.5cm" margin-left="2.5cm" margin-right="2.5cm">
				<fo:region-body margin-top="2cm" margin-bottom="1.5cm"/>
				<fo:region-before extent="1.5cm" background-color="#fdb51f"/>
				<fo:region-after extent="1.5cm" background-color="#fdb51f"/>
			</fo:simple-page-master>
		</fo:layout-master-set>
		  
		<fo:page-sequence master-reference="all">
			<fo:static-content flow-name="xsl-region-before" margin-bottom="1cm">
				<fo:block>
					<fo:external-graphic src="logo.png" content-height="scale-to-fit" content-width="scale-to-fit" height="60px" width="60px"/>
				</fo:block>
			</fo:static-content>
			<fo:static-content flow-name="xsl-region-after">
				<fo:block font-size="12pt" text-align="right">
					Page <fo:page-number/> of 
						<fo:page-number-citation ref-id="last-page"/>
				</fo:block>
			</fo:static-content>
			<fo:flow flow-name="xsl-region-body">
				<xsl:apply-templates/>
				<fo:block id="last-page"/>
			</fo:flow>
		</fo:page-sequence>
	  
		</fo:root>
	</xsl:template>
	

	<xsl:template match="tv">
		<fo:block page-break-after="always">
			<xsl:variable name="logo_path" select="@logo"/> 
			<fo:external-graphic content-height="scale-to-fit" height="128px" width="128px">
				<xsl:attribute name="src">
				 <xsl:value-of select="$logo_path" />
			   </xsl:attribute>
			</fo:external-graphic>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="programme">
		<fo:block padding-bottom="20pt">
			<xsl:apply-templates select="title" />
			<xsl:apply-templates select="desc" />
			<fo:block>
				Tid: 
				<xsl:apply-templates select="start" />
				-
				<xsl:apply-templates select="stop" />
			</fo:block>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="title">
		<fo:block>
			Title: <xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	<xsl:template match="desc">
		<fo:block>
			Beskrivning: <xsl:apply-templates />
		</fo:block>
	</xsl:template>
	<xsl:template match="start">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="stop">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>