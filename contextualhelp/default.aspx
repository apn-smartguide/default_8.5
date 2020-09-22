<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<apn:locale runat="server" id="loc">
	<% Context.Items["currentLocale"] = loc.Current.getValue(); %>
</apn:locale>

<!DOCTYPE html>
<html lang="<%=Context.Items["currentLocale"]%>">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<link rel="icon" href='<%=Page.TemplateSourceDirectory + "/" + "../resources/favicon.ico" %>' >

		<title><apn:localize key='theme.text.helplink' runat='server'/></title>

		<!-- Bootstrap core CSS -->
		<link href='<%=Page.TemplateSourceDirectory + "/" + "../resources/css/bootstrap.min.css" %>' rel="stylesheet">
		<!-- SmartGuide classes -->
		<link href='<%=Page.TemplateSourceDirectory + "/" + "../resources/css/main.css" %>' rel="stylesheet">
                <!-- Custom classes -->
		<link href='<%=Page.TemplateSourceDirectory + "/" + "../resources/css/custom.css" %>' rel="stylesheet">
	</head>
	<body role="document">
                <br/>
		<div class="container" role="main">
			<div class="panel panel-default">
  				<div class="panel-body">
			<!-- SMARTGUIDE MAIN FORM -->
			<form id="smartguide" action="do.aspx" method="post" enctype="multipart/form-data">
				<div class="jumbotron" id="sgControls">
				  <h1><apn:localize runat='server' key="theme.text.helplink"/></h1>
				  <apn:forEach runat='server'>										
					<apn:choosecontrol runat='server'>
					  <apn:whencontrol runat='server' type="GROUP">																							
						<apn:control runat='server'>
							<p><apn:label runat='server'/></p>
							<apn:help runat='server'/>
						</apn:control>												
					  </apn:whencontrol>
					</apn:choosecontrol>
				  </apn:forEach>
				</div>

				<div class="navigation">
				  <apn:control runat='server' type="previous" id="button">
					 <input type="submit" class="btn btn-default" name="<apn:name runat='server'/>" id="<apn:name runat='server'/>" value="<apn:localize runat='server' key="theme.text.helpprevbutton"/>" />
					</apn:control>
				</div>
			</form>
				</div>
			</div>
		</div> <!-- /container -->

		<footer>
			<div class="container footer">
				<p class="text-muted"><apn:localize runat="server" key="theme.text.copyright"/></p>
			</div>
		</footer>
		
		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src='<%=Page.TemplateSourceDirectory + "/" + "../resources/js/jquery.min.js" %>' ></script>
		<script src='<%=Page.TemplateSourceDirectory + "/" + "../resources/js/jquery.form.min.js" %>' ></script>
		<script src='<%=Page.TemplateSourceDirectory + "/" + "../resources/js/bootstrap.min.js" %>' ></script>
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script src='<%=Page.TemplateSourceDirectory + "/" + "../resources/js/html5shiv.min.js" %>' ></script>
		  <script src='<%=Page.TemplateSourceDirectory + "/" + "../resources/js/respond.min.js" %>' ></script>
		<![endif]-->
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src='<%=Page.TemplateSourceDirectory + "/" + "../resources/js/ie10-viewport-bug-workaround.js" %>' ></script>
	</body>
</html>
