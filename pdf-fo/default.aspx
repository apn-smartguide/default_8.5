<?xml version="1.0" encoding="UTF-8"?>
<apn:api5 id="sg5" runat="server"/>
<%@ Page Language="C#" autoeventwireup="true" CodeFile="../default.aspx.cs" Inherits="Default" Trace="false"%>
<%@ Assembly src="../../default_8.5/SGWebCore.cs" %>
<%
	IsPdf = true;
	ThemesLocations = new string[]{"/..",Theme};
	LogoutURL = GetURLForSmartlet(SmartletName);
%>
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
<fo:layout-master-set>
	<fo:simple-page-master master-name="all-pages"  margin-right="1cm" margin-left="1cm" margin-bottom="2cm" margin-top="1cm" page-width="21cm" page-height="29.7cm">
		<fo:region-body  margin="1cm" column-gap="0.25in"/>
		<fo:region-before extent="0.5cm" display-align="after"/>
		<fo:region-after extent="1cm" display-align="before"/>
	</fo:simple-page-master>
</fo:layout-master-set>
<fo:page-sequence master-reference="all-pages">
	 <!-- header -->
	 <fo:static-content flow-name="xsl-region-before">
		<fo:block color="rgb(105,105,105)" text-align-last="justify" border-bottom-width="1pt" border-bottom-color="rgb(192,192,192)" border-bottom-style="solid"  font-size="10pt" font-family="Helvetica">
			<apn:control type="title" runat="server"><Apn:value runat="server"/></apn:control>
			<fo:leader/>
			<fo:inline font-size="10pt" font-weight="normal">
				Page <fo:page-number/>
			</fo:inline>
		</fo:block>
	</fo:static-content>
	<!-- body -->
	<fo:flow flow-name="xsl-region-body">
		<!-- smartlet page title -->
		<fo:block font-size="16pt" font-family="sans-serif" background-color="rgb(105,105,105)" color="white" text-align="center" padding-top="3pt" font-weight="bold">
			<apn:control type="step" runat="server"><Apn:label runat="server"/></apn:control>
		</fo:block>
		<fo:table border-collapse="collapse" height="17cm" border-color="rgb(192,192,192)" border-style="solid" border-width="0.1mm" table-layout="fixed" width="100%">
		<fo:table-column column-width="50%"/>
		<fo:table-column column-width="50%"/>
			<fo:table-body font-family="sans-serif" font-weight="normal" font-size="10pt">
				<% ExecutePath("/pdf-fo/fields.aspx"); %>
			</fo:table-body>
		</fo:table>
	</fo:flow>
</fo:page-sequence>
</fo:root>
<% IsPdf = false; %>
