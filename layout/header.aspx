<%@ Page Language="C#" %>
<%@ Import Namespace="com.alphinat.sg5" %>
<%@ Register Tagprefix="apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:api5 id="sg5" runat="server" />
<!-- #include file="../helpers.aspx" -->
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<a href="#" class="navbar-brand">SmartGuide</a>
			<button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		</div>
		<div class="navbar-collapse collapse" id="navbar-main">
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Examples <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href='<%=getURLForSmartlet("sg-8-5-theme")%>'>Theme</a></li>
						<li><a href='<%=getURLForSmartlet("sg-8-5-repeats-table")%>'>Repeat Table</a></li>
						<li><a href='<%=getURLForSmartlet("sg-8-5-repeats-modals")%>'>Repeat & Modals</a></li>
						<li><a href='<%=getURLForSmartlet("sg-8-5-navigation")%>'>Navigation</a></li>
					</ul>
				</li>
				<apn:ifsmartletmultilingual runat="server">
					<li class="dropdown">
						<apn:locale runat="server" id="loc2"><a class="dropdown-toggle" data-toggle="dropdown" href="#" id=""><%=loc2.Current.getLabel()%> <span class="caret"></span></a></apn:locale>
						<ul class="dropdown-menu" aria-labelledby="langselect">
							<apn:forEach runat="server" id="locale" items="languages"><li><a href='<%= getRequestURI() %>?lang=<%=locale.Current.getValue()%>'><%=locale.Current.getLabel()%></a></li></apn:forEach>
						</ul>
					</li>
				</apn:ifsmartletmultilingual>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="https://www.alphinat.com" target="_blank">Alphinat.com</a></li>
				<li><a href="https://www.getbootstrap.com/" target="_blank">Bootstrap</a></li>
			</ul>
		</div>
	</div>
</div>