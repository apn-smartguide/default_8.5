<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server"/>
<!-- Check to see if there are required fields and if any validation errors occurred -->
<% Context.Items["required"] = false; %>
<% Context.Items["alert"] = false; %>
<% Context.Items["underCrudRepeat"] = false; %>

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
%> 
<apn:forEach id="index" items="alert-controls" runat="server">
	<% Context.Items["alert"] = true; %>
</apn:forEach>
<div id="alerts"><%-- do not change the div id as it is referenced in smartguide.js --%>
<% if (( (bool)Context.Items["alert"] == true) || ((bool)Context.Items["required"] == true)) {%>
    <apn:IfRequiredControlExists runat="server">
        <blockquote><p><span class="required">*</span> <apn:localize runat="server" key="theme.text.required"/></p></blockquote>
	</apn:IfRequiredControlExists>
	<apn:forEach items="alert-controls" id="control1" runat="server">
		<div id="error_<%= control1.Current.getName() %>" class="alert alert-danger" role="alert">
			<% if(control1.Current.getAlert().Trim().Equals("error.goto.summary")) {%>
				<apn:localize runat="server" key="theme.text.flowchange"/>
			<% }else if (control1.Current.getAlert().Trim().Equals("error.language.change")) { %>
				<apn:localize runat="server" key="theme.text.languagechange"/>
			<% }else{ %>
			   <a href="" onclick="$('body,html').animate({scrollTop: $('#div_<%= control1.Current.getName() %>').offset().top}, 1000);return false;"/><%= control1.Current.getAlert() %></a>
			<% } %>
		</div>
	</apn:forEach>
<%}%>
</div>

<script runat="server">
	public bool isUnderRepeat(ISmartletField f) { 
		bool result = false;
		
		while(f.getParent() != null) {
			int type = f.getParent().getTypeConst();
			if(type == DotnetConstants.ElementType.REPEAT) {
				result = true;
				break;
			}
			f = f.getParent();
		}   
		return result;
	}
</script>
