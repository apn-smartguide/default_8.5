<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- #include file="../helpers.aspx" -->
<% Context.Items["required"] = false; %>
<% Context.Items["alert"] = false; %>
<% Context.Items["underCrudRepeat"] = false; %>
<% Context.Items["counter"] = 1; %>
<%
  ISmartletPage pg = sg5.Context.getSmartlet().getCurrentPage();
  ISmartletField f = null;
  ISmartletField[] fields = pg.findAllFields();
  for(int i = 0; i < fields.Length; i++) {
    if((fields[i].getTypeConst() == DotnetConstants.ElementType.REPEAT) && fields[i].getCSSClass().Contains("grid-view")) {
        Context.Items["underCrudRepeat"] = true;              
    } 
    else if (isUnderRepeat(fields[i]) && ((bool)Context.Items["underCrudRepeat"])){
        continue;
    } else {
        Context.Items["underCrudRepeat"] = false;
        if(fields[i].isRequired()) {
            f = fields[i];
            Context.Items["required"] = true;
            break;
        }
    }
  }
  Context.Items["alerts-count"] = 0;
%> 
<apn:forEach id="alerts" items="alert-controls" runat="server">
	<% Context.Items["alerts-count"] = alerts.getCount(); %>
</apn:forEach>
<div id='alerts'><%-- do not change the div id as it is referenced in smartguide.js --%>
    <apn:IfRequiredControlExists runat="server">
        <div class='alert alert-info' role='alert'>
			<span class='required'>*</span>
			<apn:localize runat="server" key="theme.text.required"/>
		</div>
	</apn:IfRequiredControlExists>
	<% if ((int)Context.Items["alerts-count"] > 0) { %>
	<section id="errors-fdbck-frm" class='alert alert-danger' role='alert'>
		<h2><%=sg5.Context.getSmartlet().getLocalizedResource("theme.text.errors-found").Replace("{1}", Context.Items["alerts-count"].ToString()) %></h2>
		<ul>
		<apn:forEach items="alert-controls" id="control1" runat="server">
			<li id='error_<%=Context.Items["counter"] %>_<%= control1.Current.getName() %>'>
				<% if(control1.Current.getAlert().Trim().Equals("error.goto.summary")) { %>
					<apn:localize runat="server" key="theme.text.flowchange"/>
				<% } else if (control1.Current.getAlert().Trim().Equals("error.language.change")) { %>
					<apn:localize runat="server" key="theme.text.languagechange"/>
				<% } else { %>
				<%
				    string toDisplay = "";
					if(!string.IsNullOrEmpty(control1.Current.getName())) {					
						string id =control1.Current.getName().Remove(0,2);							
						int indexOfStringToStrip = id.IndexOf("[");
						if(indexOfStringToStrip > -1) {
							id = id.Substring(0, indexOfStringToStrip);
						}	
					    toDisplay = sg5.getSmartlet().getSessionSmartlet().findFieldById(id).getLabel();
					}
				%>
				<a href='' onclick="$('body,html').animate({scrollTop: $('#div_<%= control1.Current.getName() %>').offset().top}, 1000);return false;"/><span class="prefix">Error <%= Context.Items["counter"] %>:</span> <%= toDisplay %> - <%= control1.Current.getAlert() %></a>
				<% } %>
			</li>
			<% Context.Items["counter"] = (int)Context.Items["counter"] + 1; %>
		</apn:forEach>
		<ul>
	</section>
	<% } %>
</div>