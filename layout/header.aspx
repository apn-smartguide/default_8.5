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
		  <li class="active">
			<a href="#"><apn:localize runat="server" key="theme.text.services"/></a>
		  </li>
		  <apn:ifsmartletmultilingual runat="server">
		  <li class="dropdown">
			  <apn:locale runat="server" id="loc2">
			  <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="	"><%=loc2.Current.getLabel()%> <span class="caret"></span></a>
			  </apn:locale>
			  <ul class="dropdown-menu" aria-labelledby="langselect">
				  <apn:forEach runat="server" id="locale" items="languages">
				  <li><a href="<%=Context.Items["requestUri"]%>?lang=<%=locale.Current.getValue()%>"><%=locale.Current.getLabel()%></a></li>
				  </apn:forEach>
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