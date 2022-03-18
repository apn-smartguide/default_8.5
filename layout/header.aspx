<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<div class="navbar navbar-dark bg-dark navbar-expand-md fixed-top py-0">
	<div class="container">
		<div class="navbar-header">
			<a href="#" class="navbar-brand">SmartGuide</a>
			<button class="sg <% if(BootstrapVersion == "4") { Response.Outpout.Write("navbar-toggler float-right"); } else { Response.Output.Write("navbar-toggle"); }" type="button" data-toggle="collapse" data-target="#navbar-main">
				<% if(BootstrapVersion == "4") { %>
				<span class="navbar-toggler-icon"/>
				<% } else { %>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<% } %>
			</button>
		</div>
		<div class="navbar-collapse collapse" id="navbar-main">
			<ul class="navbar-nav mr-auto">
				<li class="dropdown nav-item">
					<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Examples <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-theme")%>'>Theme</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-repeats-table")%>'>Repeat Table</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-repeats-modals")%>'>Repeat & Modals</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-navigation")%>'>Navigation</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-datatable-server-fruits-serverside")%>'>Datatables.Net</a>
					</ul>
				</li>
				<apn:ifsmartletmultilingual runat="server">
					<li class="dropdown">
						<apn:locale runat="server" id="loc">
							<%
							string localeEnDesc = "";
							string localeDesc = GetLocaleDescription(loc.Current.getValue(), ref localeEnDesc);
							if(!loc.Current.getValue().Equals("en") && localeEnDesc != "") {
								localeDesc = localeDesc + " (" + localeEnDesc + ")";
							}
							%>
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="langselect"><%=localeDesc%> <span class="caret"></span></a>
						</apn:locale>
						<ul class="dropdown-menu" aria-labelledby="langselect">
							<apn:forEach runat="server" id="locale" items="languages">
								<%
								string localeEnDesc = "";
								string localeDesc = GetLocaleDescription(locale.Current.getValue(), ref localeEnDesc);
								if(!locale.Current.getValue().Equals("en") && localeEnDesc != "") {
									localeDesc = localeDesc + " (" + localeEnDesc + ")";
								}
								%>
								<li><a href='<%= GetRequestURI() %>?lang=<%=locale.Current.getValue()%>' class="dropdown-item link-as-post"><%=localeDesc%></a></li>
							</apn:forEach>
						</ul>
					</li>
				</apn:ifsmartletmultilingual>
			</ul>
			<ul class="navbar-nav">
				<a class="nav-link" href="https://www.alphinat.com" target="_blank">Alphinat.com</a>
				<a class="nav-link" href="https://www.getbootstrap.com/" target="_blank">Bootstrap</a>
			</ul>
		</div>
	</div>
</div> 