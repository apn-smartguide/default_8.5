<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>

<apn:control runat="server" id="control">
<% 
Context.Items["hiddenName"] = ""; 
Context.Items["isOnlyStatic"] = true ; 
int currentLevel = -1;
   
   if(Context.Items["repeat-level"] != null) {
     currentLevel = (int)Context.Items["repeat-level"];
   }
   
   currentLevel++;
   
   Context.Items["repeat-level"] = currentLevel;
   
if (control.Current.getAttribute("visible").Equals("false")) {	
%>
	<!-- #include file="render_hidden_div.inc" -->
<%
} else {
	if (control.Current.getCSSClass().IndexOf("grid-view") > -1) {
		Server.Execute(Page.TemplateSourceDirectory + "/repeat_crud.aspx"); 
	} else {
		if ( (control.Current.getAttribute("rendermode").Equals("table") || control.Current.getCSSClass().IndexOf("table-render") > -1) && control.Current.getCSSClass().IndexOf("block-render") == -1) {
			Server.Execute(Page.TemplateSourceDirectory + "/repeat_table.aspx"); 
		} else {
			Server.Execute(Page.TemplateSourceDirectory + "/repeat_block.aspx");
		}
	}
}%>  						
</apn:control>	
