<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#">Smartguide</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
			aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarsExampleDefault">
			<ul class="navbar-nav">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="examples" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Examples</a>
					<div class="dropdown-menu" aria-labelledby="examples">
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-theme")%>'>Theme</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-repeats-table")%>'>Repeat Table</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-repeats-modals")%>'>Repeat & Modals</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-navigation")%>'>Navigation</a>
						<a class="dropdown-item" href='<%=GetURLForSmartlet("sg-8-5-datatable-server-fruits-serverside")%>'>Datatables.Net</a>
					</div>
				</li>
			</ul>
			<apn:ifsmartletmultilingual runat="server">
			<ul class="navbar-nav">
				<li class="nav-item dropdown">
					<apn:locale runat="server" id="loc">
						<%
							string localeEnDesc = "";
							string localeDesc = GetLocaleDescription(loc.Current.getValue(), ref localeEnDesc);
							if(!loc.Current.getValue().Equals("en") && localeEnDesc != "") {
								localeDesc = localeDesc + " (" + localeEnDesc + ")";
							}
						%>
						<a class="nav-link dropdown-toggle" href="#" id="langselect" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=localeDesc%><span class="caret"></span></a>
					</apn:locale>
					<div class="dropdown-menu" aria-labelledby="langselect">
						<apn:forEach runat="server" id="locale" items="languages">
						<%
							string localeEnDesc = "";
							string localeDesc = GetLocaleDescription(locale.Current.getValue(), ref localeEnDesc);
							if(!locale.Current.getValue().Equals("en") && localeEnDesc != "") {
								localeDesc = localeDesc + " (" + localeEnDesc + ")";
							} 
						%>
						<a href='<%= GetRequestURI() %>?lang=<%=locale.Current.getValue()%>' class="dropdown-item link-as-post"><%=localeDesc%></a>
						</apn:forEach>
					</div>
				</li>
			</ul>
			</apn:ifsmartletmultilingual>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item">
					<a class="nav-link" href="https://www.alphinat.com" target="_blank">
						Alphinat.com
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="https://www.getbootstrap.com/" target="_blank">
						Bootstrap
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>