<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<% 
    Context.Items["basePath"] = "";
    string pdf = (string)Request["pdf"];
   
    if(pdf == null) {
     try {
       Context.Items["basePath"] = Page.TemplateSourceDirectory + "/" + "..";
       Session["beforePdfPath"] = Context.Items["basePath"];
     } catch (Exception e) {
       Context.Items["basePath"] = (string)Session["beforePdfPath"];
     }    
    } else {
       Context.Items["basePath"] = (string)Session["beforePdfPath"];
    }
    
	Context.Items["optionIndex"] = ""; 
	string requestUri = Request.Url.PathAndQuery;
	requestUri = requestUri.Substring(requestUri.LastIndexOf("/")+1);
	Context.Items["requestUri"] = Request.Url.AbsolutePath;
%>
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
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="mobile-web-app-capable" content="yes">
		<meta name="generator" content="SmartGuide 7.0"> <!-- leave this for stats please -->
                <meta name="application-name" content="<apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control>">
		<meta name="description" content='<apn:control runat="server" type="smartlet-description"><apn:value runat="server"/></apn:control>'>
		<meta name="theme" content='<apn:control runat="server" type="smartlet-theme"><apn:value runat="server"/></apn:control>'>
		<meta name="author" content='<apn:control runat="server" type="smartlet-author"><apn:value runat="server"/></apn:control>'>
		<meta name="lastmodified" content='<apn:control runat="server" type="smartlet-lastmodification"><apn:value runat="server"/></apn:control>'>
		<meta name="keywords" content='<apn:control runat="server" type="keyword"><apn:value runat="server"/></apn:control>' />
                <link rel="icon" sizes="192x192" href='<%=Context.Items["basePath"] + "/resources/apn_icon.png"%>' />
		<link rel="apple-touch-icon" href='<%=Context.Items["basePath"] + "/resources/img/apn_icon.png"%>' />
		<link rel="icon" href='<%=Context.Items["basePath"] + "/resources/img/favicon.ico"%>' />

		<title><apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control> &gt; <apn:control runat="server" type="step"><apn:label runat="server"/></apn:control></title>

		<!-- Bootstrap CSS -->
		<link href='<%=Context.Items["basePath"] + "/resources/css/bootstrap.min.css" %>' rel="stylesheet">

		<!-- Datatable support -->
		<link href='<%=Context.Items["basePath"] + "/resources/css/datatables.min.css" %>' rel="stylesheet">
		<link href='<%=Context.Items["basePath"] + "/resources/css/responsive.datatables.min.css" %>' rel="stylesheet">
		<!-- Date widget support -->
		<link href='<%=Context.Items["basePath"] + "/resources/css/bootstrap-datepicker.min.css" %>' rel="stylesheet">
		<!-- Autocomplete support -->
		<link href='<%=Context.Items["basePath"] + "/resources/css/autocomplete.min.css" %>' rel="stylesheet">
		<!-- SmartGuide CSS -->
		<link href='<%=Context.Items["basePath"] + "/resources/css/smartguide.min.css" %>' rel="stylesheet">
		<link href='<%=Context.Items["basePath"] + "/resources/css/custom.css" %>' rel="stylesheet">
                <!-- Load base jQuery --><%-- in case some fields output html/js requiring jQuery --%>
		<script src='<%=Context.Items["basePath"] + "/resources/js/jquery.min.js" %>' ></script>

	</head>
	<body role="document" class='<apn:control runat="server" type="step"><apn:cssclass runat="server"/></apn:control>' style='<apn:control runat="server" type="step"><apn:cssstyle runat="server"/></apn:control>' >

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

		<div class="container" role="main">
			<!-- SMARTGUIDE MAIN FORM -->
			<form id='smartguide_<apn:control runat="server" type="smartlet-code"><apn:value runat="server"/></apn:control>' action="do.aspx" method="post" enctype="multipart/form-data"><%-- do not change the form id as it is referenced in smartguide.js --%>
				<input type="hidden" name="com.alphinat.sgs.anticsrftoken" value="<%=Session["com.alphinat.sgs.anticsrftoken"] %>"/>
				<!-- SmartGuide library definitions -->
				<div id="sglib"><% Server.Execute(Page.TemplateSourceDirectory + "/sglib.aspx"); %></div><%-- required to support actions on fields, must be placed within the SmartGuide form --%>

				<div class="page-header">
				<div class="row">
					<div class="col-sm-6">
						<img class="logo" src='<%=Context.Items["basePath"] + "/resources/img/logo.jpg"%>' />
					</div>
					<div class="col-sm-6 hidden-xs">
						<div class="pull-right">
							<span class="glyphicon glyphicon-duplicate" aria-hidden="true"></span> <apn:localize runat="server" key="theme.text.services"/>
						</div>
					</div>
				</div>

				<!-- Smartlet title -->
				<h1>
					<apn:control runat="server" type="smartlet-name"><apn:value runat="server"/></apn:control>
				</h1>
				
				<!-- Breadcrumb trail-->
					<% 
						Context.Items["currentSectionName"]  = "";
						Context.Items["sectionIndex"]  = 1;
						Context.Items["totalSection"]  = 0;
					%>
					<apn:control runat="server" type="section" id="currentSection">
						<% Context.Items["currentSectionName"] = currentSection.Current.getLabel();%>
					</apn:control>
					<apn:forEach runat="server" items="sections" id="section">
						<% 
							if (section.Current.getLabel().Equals(Context.Items["currentSectionName"])) Context.Items["sectionIndex"] = section.getCount();
							Context.Items["totalSection"] = (int)Context.Items["totalSection"] + 1;
						%>
					</apn:forEach>
					<% if ( (int)Context.Items["totalSection"] >0 ) { %>
					<div class="section section-count-<%= (int)Context.Items["totalSection"] + 1 %>">
					<ol>
						<apn:forEach runat="server" items="sections" id="section1">			            
							<li>
								<% if ((int)Context.Items["sectionIndex"] == section1.getCount()) { %>
									<p class="current"><strong>
								<% } else if ((int)Context.Items["sectionIndex"] - section1.getCount() == 1) { %>
									<p class="before-current">
								<% } else { %>
									<p>
								<% } %>
								<span class="number"><%= section1.getCount() %></span><span class="text"><apn:label runat="server"/></span></strong></p>
							</li>
						</apn:forEach>
					 </ol>
				</div>
					<% } %>
					<!-- End breadcrumb trail -->
                    <!-- Validation messages -->
       				<% Server.Execute(Page.TemplateSourceDirectory + "/" + "controls/validation.aspx"); %>
				
					<div class="row page-title">
                                        <!-- Page title -->
					<%-- Display a progress bar only if a breadcrumb trail doesn't exist --%>
                                        <% if ((int)Context.Items["totalSection"] >0) { %>
					<div class="col-md-12">
						<h2>
						<apn:control runat="server" type="step"><apn:label runat="server"/></apn:control>
						</h2>
					</div>
					<% } else { %>
						<div class="col-md-6 col-md-push-6">
                            <!-- Progress bar -->
							<apn:control runat="server" type="progress" id="progressBar">
								<div class="progress">
									<div class="progress-bar" role="progressbar" aria-valuenow="<%= int.Parse(progressBar.Current.getValue()) %>" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;width: <%= int.Parse(progressBar.Current.getValue()) %>%">
										<%= int.Parse(progressBar.Current.getValue()) %> %
									</div>
								</div>
							</apn:control>
						</div>
						<div class="col-md-6 col-md-pull-6">
							<h2>
                                <apn:control runat="server" type="step"><apn:label runat="server"/></apn:control>
                            </h2>
						</div>
					<% } %>
					</div>
				</div>

				<!-- MAIN LOOP OVER PAGE CONTROLS -->
				<div id="sgControls"><%-- do not change the div id as it is referenced in smartguide.js --%>
					<div id="loader"></div>
					<% Server.Execute(Page.TemplateSourceDirectory + "/" + "controls/controls.aspx"); %>
				</div>
				<!-- NAVIGATION BUTTONS -->
				<div class="navigation">
					<% Server.Execute(Page.TemplateSourceDirectory + "/" + "controls/navigation.aspx"); %>
				</div>

			</form>
		</div> <!-- /container -->

		<footer>
			<div class="container footer">
				<p class="text-muted"><apn:localize runat="server" key="theme.text.copyright"/></p>
			</div>
		</footer>
		
		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/jquery.form.min.js" %>' ></script>
		<!-- JQuery UI -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/ui/jquery-ui-1.10.4.custom.min.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/bootstrap.min.js" %>' ></script>
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script src='<%=Context.Items["basePath"] + "/resources/js/html5shiv.min.js" %>' ></script>
		  <script src='<%=Context.Items["basePath"] + "/resources/js/respond.min.js" %>' ></script>
		<![endif]-->
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/ie10-viewport-bug-workaround.js" %>' ></script>
		<!-- Date widget support -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/moment.min.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/locale/fr.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/locale/en-ca.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/bootstrap-datepicker.min.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/locale/bootstrap-datepicker.fr.min.js" %>' ></script>
		<!-- Datatables support -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/datatables.min.js" %>' ></script>
		<!-- repeat pagination -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/jquery.bootpag.min.js" %>' ></script>
		<!-- Autocomplete support -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/jquery.autocomplete.min.js" %>' ></script>
		<!-- Inputmask support -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/inputmask.min.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/inputmask.extensions.min.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/inputmask.numeric.extensions.min.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/jquery.inputmask.min.js" %>' ></script>
		<!-- SmartGuide JS -->
		<script src='<%=Context.Items["basePath"] + "/resources/js/custom.js" %>' ></script>
		<script src='<%=Context.Items["basePath"] + "/resources/js/smartguide.min.js?v=8.0.0.0" %>' ></script>
		<script>
			var currentLocale = "<%=Context.Items["currentLocale"]%>";
			var dataTableTranslations = {
				'zeroRecords':    '<apn:localize runat="server" key="theme.text.datatable.zeroRecords"/>',
				'infoEmpty':    '<apn:localize runat="server" key="theme.text.datatable.infoEmpty"/>',
				'emptyTable':     '<apn:localize runat="server" key="theme.text.datatable.emptyTable"/>',
				'search': '<apn:localize runat="server" key="theme.text.datatable.search"/>',
				'lengthMenu': '<apn:localize runat="server" key="theme.text.datatable.lengthMenu"/>',
				'info': '<apn:localize runat="server" key="theme.text.datatable.info"/>',
				'paginate': {
					'next': '<apn:localize runat="server" key="theme.text.datatable.paginate.next"/>',
					'previous': '<apn:localize runat="server" key="theme.text.datatable.paginate.previous"/>'
				}};
			var currentLang = '<%=Context.Items["currentLocale"]%>';
			var crudModalsTranslations = {
				'discardChanges':    $("<div>").html('<apn:localize runat="server" key="theme.text.modals.discardChanges"/>').text(),
				'deleteRow':    $("<div>").html('<apn:localize runat="server" key="theme.text.modals.deleteRow"/>').text()
			};
		</script>
	</body>
</html>
