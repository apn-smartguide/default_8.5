<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<div class="navbar navbar-dark bg-dark navbar-expand-md fixed-top py-0">
	<div class="container">
		<a href="#" class="navbar-brand">SmartGuide</a>
		<button class="navbar-toggler fload-right" type="button" data-toggle="collapse" data-target="#navbar-main">
			<span class="navbar-toggler-icon"/>
		</button>
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
						<apn:locale runat="server" id="loc2"><a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id=""><%=loc2.Current.getLabel()%> <span class="caret"></span></a></apn:locale>
						<ul class="dropdown-menu" aria-labelledby="langselect">
							<apn:forEach runat="server" id="locale" items="languages"><a class="dropdown-item" href='<%= GetRequestURI() %>?lang=<%=locale.Current.getValue()%>'><%=locale.Current.getLabel()%></a></apn:forEach>
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