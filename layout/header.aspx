<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
				aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Smartguide</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="examples">Examples<span class="caret"></span></a>
					<ul class="dropdown-menu" aria-labelledby="examples">
						<li><a href='<%=GetURLForSmartlet("sg-8-5-theme")%>'>Theme</a></li>
						<li><a href='<%=GetURLForSmartlet("sg-8-5-repeats-table")%>'>Repeat Table</a></li>
						<li><a href='<%=GetURLForSmartlet("sg-8-5-repeats-modals")%>'>Repeat & Modals</a></li>
						<li><a href='<%=GetURLForSmartlet("sg-8-5-navigation")%>'>Navigation</a></li>
						<li><a href='<%=GetURLForSmartlet("sg-8-5-datatable-server-fruits-serverside")%>'>Datatables.Net</a></li>
					</ul>
				</li>
			</ul>
			<ul class="nav navbar-nav">
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
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="langselect"><%=localeDesc%><span class="caret"></span></a>
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
			<ul class="nav navbar-nav navbar-right">
				<li><a class="nav-link" href="https://www.alphinat.com" target="_blank">Alphinat.com</a></li>
				<li><a class="nav-link" href="https://www.getbootstrap.com/" target="_blank">Bootstrap</a></li>
			</ul>
		</div>
	</div>
</nav>