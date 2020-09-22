<%
	bool bareControl = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true"));
	if (!bareControl){
		Server.Execute(Page.TemplateSourceDirectory + "/label.aspx");
	}	
%>	