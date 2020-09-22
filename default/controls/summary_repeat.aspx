<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:control runat='server' id='control'>

<% if ( (control.Current.getAttribute("rendermode").Equals("table") || control.Current.getCSSClass().IndexOf("table-render") > -1 || control.Current.getCSSClass().IndexOf("grid-view") > -1) && control.Current.getCSSClass().IndexOf("block-render") == -1) { %>
<h4><apn:label runat='server'/> </h4>
<% } %>
<apn:forEach id="control2" runat="server">
<% if (control2.Current.getType() == com.alphinat.xmlengine.interview.tag.ControlInfo.GROUP) { %>
<div <apn:ifnotcontrolvalid runat='server'>class="has-error"</apn:ifnotcontrolvalid> >
<% if ( (!control.Current.getAttribute("rendermode").Equals("table") && control.Current.getCSSClass().IndexOf("table-render") == -1 && control.Current.getCSSClass().IndexOf("grid-view") == -1) || control.Current.getCSSClass().IndexOf("block-render") != -1) { %>
<h4><apn:label runat='server'/> <% if (!(control2.getCount() == 1 && control2.Last)) { %><%= control2.getCount() %><% } %></h4>
<% } %>
																
  
</div>	
<% Server.Execute(Page.TemplateSourceDirectory + "/summary_controls.aspx"); %>
<% }%>
</apn:forEach>

</apn:control>