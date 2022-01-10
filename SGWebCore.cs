using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using com.alphinat.sg;
using com.alphinat.sg5;
using com.alphinat.sg5.widget.repeat;
using com.alphinat.sgs;
using com.alphinat.sgs.smartlet;
using com.alphinat.sgs.smartlet.api5impl;
using com.alphinat.sgs.smartlet.session;
using com.alphinat.sgs.smartlet.util;
using com.alphinat.sgs.smartlet.display;
using com.alphinat.xmlengine.interview.tag;
using com.alphinat.interview.si.xml.servlet.environment;
using Alphinat.SmartGuideServer.Controls;

public partial class SGWebCore : System.Web.UI.Page 
{	
	protected string currentLocale = "";
	protected string lastModificationDate = "";
	protected DateTime beginThemeProcessingTimer;
	protected DateTime endThemeProcessingTimer;

	protected bool hideSuffix;

	protected void Page_Init(object sender, EventArgs e) {
		beginThemeProcessingTimer = DateTime.UtcNow;
	}
	protected void Init(object sender, EventArgs e) {
		
		var env = GetEnvironment(HttpContext.Current);
		RequestContainer rq = RequestContainer.getRequestContainer(env);
		rq.setEnvironment(env);

		beginThemeProcessingTimer = DateTime.UtcNow;

		Context.Items["optionIndex"] = "";
		Context.Items["javascript"] = ""; // injected javascript via designer using custom javascript control, rendered at end of page
		
		HttpBrowserCapabilities browser = Request.Browser;
		Session["BrowserVersion"] = browser.Version;
		Session["BrowserType"] = browser.Type;
	}

	public bool IsIE() {
		return (((string)Session["BrowserType"]).Contains("IE") || ((string)Session["BrowserType"]).Contains("InternetExplorer"));
	}

	protected void Load(object sender, EventArgs e) {
		if(Request.QueryString["cache"] != null && Request.QueryString["cache"].Equals("reset")){
			ClearCaches();
		}
		
		if(Context.Items["WebPartMode"] == null) {
			Context.Items["WebPartMode"] = false;
		}

		if(!(bool)Context.Items["WebPartMode"]) {
			// handling of PDF or XML generation in tag mode
			if(Context.Items["com.alphinat.download:bytes"] != null && Context.Items["com.alphinat.download:contenttype"] != null && Context.Items["com.alphinat.download:filename"] != null) {
				byte[] bytes = (byte[])Context.Items["com.alphinat.download:bytes"];
				String contentType = (String)Context.Items["com.alphinat.download:contenttype"];
				String fileName = (String)Context.Items["com.alphinat.download:filename"];

				if (bytes != null) {
					Response.ContentType = contentType;
					Response.AddHeader("Content-Disposition","attachment; filename="+fileName);
					Response.OutputStream.Write(bytes, 0, bytes.Length);
					Response.OutputStream.Flush();
					Response.OutputStream.Close();
				}
			}
		}
	}
	protected void PreRender(object sender, EventArgs e)
	{
		HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
		HttpContext.Current.Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
		HttpContext.Current.Response.Cache.SetNoStore();
		HttpContext.Current.Response.Cache.SetNoServerCaching();
	}

	protected override void Render(HtmlTextWriter output) {

		// using (HtmlTextWriter htmlwriter = new HtmlTextWriter(new System.IO.StringWriter()))
		// {
		// 	base.Render(htmlwriter);
		// 	string html = htmlwriter.InnerWriter.ToString();
		// 	html = html.Replace("\n\r\n\r", "\n\r"); // This may be redundant
		// 	html = html.Replace("\n\n", "\n");
		// 	html = html.Replace("\t\n", "\n");
		// 	output.Write(html.Trim());
		// }

		base.Render(output);
		if(TraceExecution && beginThemeProcessingTimer != DateTime.MinValue) {
			endThemeProcessingTimer = DateTime.UtcNow;
			Logger.debug("execution: (" + Request.CurrentExecutionFilePath + ") " + (endThemeProcessingTimer - beginThemeProcessingTimer).TotalSeconds);
		}
	}

	protected void Error(object sender, EventArgs e) {
		Logger.debug("SGWebCore ERROR");
		Exception ex = Server.GetLastError();
		ex = ex.InnerException ?? ex;
		Logger.debug(ExceptionInfo(ex));
	}

	public void ClearCaches() {
		
		Logger.debug("<<<< SGWebCore: Clearing Caches >>>>");

		Application["paths-dictionary"] = new ConcurrentDictionary<string, string>();
		Application["basePath"] = null;
		Application["coreThemePath"] = null;
		Application["currentThemePath"] = null;
		Application["home-url"] = null;
		Application["login-url"] = null;
		Application["logout-url"] = null;
		Application["profile-url"] = null;
		Application["api5"] = null;
		Application["is-development"] = null;
		Application["smartletLoggerSGWebCore"] = null;
		Application["showEnumerationErrors"] = null;
		Application["themes-locations"] = null;

		Context.Items["smartlet"] = null;
		Context.Items["smartletName"] = null;
		Context.Items["smartletCode"] = null;
		Context.Items["currentPage"] = null;
		Context.Items["theme"] = null;
		Context.Items["workspace"] = null;
		Context.Items["smartletSubject"] = null;
		Context.Items["showWizard"] = null;
		Context.Items["hideHeader"] = null;
		Context.Items["hideFooter"] = null;
		Context.Items["hideBreadcrumb"] = null;
		Context.Items["hideProgressBar"] = null;
		Context.Items["hideStepNavigation"] = null;
		Context.Items["hideFunelNavigation"] = null;
		Context.Items["hideBottomNavigation"] = null;
		Context.Items["hidePageTitle"] = null;
		Context.Items["pdf"] = null;
		Context.Items["summary"] = null;
		Context.Items["errors-above"] = null;
		Context.Items["renderbare"] = null;

		Session["pages-history"] = null;
		Session["section-primary-page"] = null;
		Session["active-section"] = null;

	}
	public static com.alphinat.interview.si.xml.servlet.environment.Environment GetEnvironment(HttpContext context) {
		com.alphinat.interview.si.xml.servlet.environment.Environment env = new HttpHandlerEnvironment((java.util.Map)null, context);
		string defaultEncodingConfig = null;
		try {
			defaultEncodingConfig = System.Configuration.ConfigurationManager.AppSettings["apn_parameter_encoding"];
		} catch (Exception ex) {
			//If we can't get the apn_parameter_encoding with default to null below.
		}
		
		if (defaultEncodingConfig != null && !defaultEncodingConfig.Trim().Equals("")) {
			env.setDefaultInputEncoding(defaultEncodingConfig);
		} else {
			env.setDefaultInputEncoding(null);
		}
		return env;
	}

	public API5 sg {
		get {
			if(Application["api5"] == null) {
				Application["api5"] = new API5();
			}
			return (API5)Application["api5"];
		}
		set {
			Application["api5"] = value; 
		}
	}

	public bool IsDevelopment {
		get {
			if(Application["is-development"] == null) {
				Application["is-development"] = GetAppSetting("com.alphinat.sgs.environment").Equals("Development");
			}
			return (bool)Application["is-development"];
		}
	}

	public bool TraceExecution {
		get {
			if(Application["trace-execution"] != null) {
				return (bool)Application["trace-execution"];
			}
			return false;
		}
		set {
			Application["trace-execution"] = value;
		}
	}

	public bool ShowEnumerationErrors {
		get {
			if(Application["showEnumerationErrors"] == null) {
				var value = GetAppSetting("com.alphinat.sgs.themes.showEnumerationErrors").ToLower();
				Application["showEnumerationErrors"] = value.Equals("true") || value.Length == 0;
			}
			return (bool)Application["showEnumerationErrors"];
		}
	}

	public ISmartlet Smartlet {
		get {
			if(Context.Items["smartlet"] == null) {
				Context.Items["smartlet"]  = sg.Context.getSmartlet();
			}
			return (ISmartlet)Context.Items["smartlet"];
		}
	}

	public ISmartletLogger Logger {
		get {
			return GetLogger("SGWebCore");
		}
	}

	public ISmartletLogger GetLogger(string name) {
		if(Application["smartletLogger"+name] == null) {
			if(sg.Context != null) {
				Application["smartletLogger"+name] = sg.Context.getLogger(name);
			} else {
				Application["smartletLogger"+name] = null;
			}
		}
		return (ISmartletLogger)Application["smartletLogger"+name];
	}

	//// Smartlet infos Helpers ///
	public string SmartletName {
		get {
			if(Context.Items["smartletName"] == null || ((string)Context.Items["smartletName"]).Equals("")) {
				Context.Items["smartletName"] = Smartlet.getName();
			}
			return (string)Context.Items["smartletName"] ;
		}
	}

	public string SmartletCode {
		get {
			if(Context.Items["smartletCode"] == null || ((string)Context.Items["smartletCode"]).Equals("")) {
				Context.Items["smartletCode"] = Smartlet.getCode();
			}
			return (string)Context.Items["smartletCode"];
		}
	}

	public string CurrentLocale {
		get {
			if(currentLocale.Equals("")) {
				currentLocale = Smartlet.getCurrentLocale();
			}
			return currentLocale;
		}
	}

	public ISmartletPage CurrentPage {
		get {
			if(Context.Items["currentPage"] == null) {
				Context.Items["currentPage"] = Smartlet.getCurrentPage();
			}
			return (ISmartletPage)Context.Items["currentPage"];
		}
	}

	public string Theme {
		get {
			if(Context.Items["theme"] == null || ((string)Context.Items["theme"]).Equals("")) {
				Context.Items["theme"] = sg.Smartlet.getTheme();
			}
			return (string)Context.Items["theme"];
		}
	}

	public string Workspace {
		get {
			if(Context.Items["workspace"] == null || ((string)Context.Items["workspace"]).Equals("")) {
				ClearCaches();
				Context.Items["workspace"] = Smartlet.getWorkspace();
			} else if (Context.Items["workspace"] != null && !Smartlet.getWorkspace().Equals((string)Context.Items["workspace"])) {
				//We're changing workspace, clear the caches.
				Logger.debug("<<<< SGWebCore:Workspace: Changing Workspace, Cleared Caches >>>>");
				ClearCaches();
				Context.Items["workspace"] = Smartlet.getWorkspace();
            }
			return (string)Context.Items["workspace"];
		}
	}

	public string SmartletSubject {
		get {
			if(Context.Items["smartletSubject"] == null || ((string)Context.Items["smartletSubject"]).Equals("")) {
				//using the localized ressource, the API getSubject does not support localization.
				Context.Items["smartletSubject"] = sg.getSmartlet().getSessionSmartlet().getLocalizedResource("smartlet.subject");
				if(Context.Items["smartletSubject"] == null || ((string)Context.Items["smartletSubject"]).Equals("")) {
					//Fallback to theme subject if none specified at the Smartlet level
					Context.Items["smartletSubject"] = sg.getSmartlet().getSessionSmartlet().getLocalizedResource("theme.text.subject");
				}
				if(Context.Items["smartletSubject"] == null ) {
					Context.Items["smartletSubject"] = "";
				}
			}
			return (string)Context.Items["smartletSubject"];
		}
	}

	public string LastModificationDate {
		get {
			if(lastModificationDate.Equals("")) {
				double ticks = double.Parse(CurrentPage.getLastModificationDate());
				TimeSpan time = TimeSpan.FromMilliseconds(ticks * 1000);
				DateTime startdate = new DateTime(1970, 1, 1) + time;
				lastModificationDate = startdate.ToString("yyyy-MM-dd");
			}
			return lastModificationDate;
		}
	}

	//Initialize the hierarchy of themes for asset reference priorities.
	//Provide an array of "theme" names from the Lowest -> Highest.
	//Last theme to have a positive asset hit will be the executed asset.
	//Asset can be any server side processed reference. (*.aspx, *.css, *.js, *.*)
	public string[] ThemesLocations {
		get { return (string[])Application["theme-locations"]; }
		set { Application["theme-locations"] = value; }
	}

	//// Filepaths Helpers ////
	//Will provide the runniing basePath based on the current Workspace name.
	public string BasePath {
		get {
			if (Application["basePath"] == null || ((string)Application["basePath"]).Equals("")) {
				Application["basePath"] = String.Concat(HttpContext.Current.Request.ApplicationPath, "/aspx/", SmartGuideDomain, Workspace, "/");
			}
			return (string)Application["basePath"];
		}
	}

	public string SmartGuideDomain {
		get {
			string domain = Smartlet.getDomain().Replace("default","");
			if(!domain.Equals("")) domain = domain + "/";
			return domain;
		}
	}

	//deprecated
	public string CoreThemePath {
		get {
			if (Application["coreThemePath"] == null || ((string)Application["coreThemePath"]).Equals("")) {
				Application["coreThemePath"] = BasePath + "Default";
			}
			return (string)Application["coreThemePath"];
		}
		set {
			Application["coreThemePath"] = value;
		}
	}

	//deprecated
	public string CurrentThemePath {
		get {
			if (Application["currentThemePath"] == null || ((string)Application["currentThemePath"]).Equals("")) {
				Application["currentThemePath"] = BasePath + Theme;
			}
			return (string)Application["currentThemePath"];
		}
		set {
			Application["currentThemePath"] = value;
		}
	}

	//Will return an empty string if the searched "asset" is not found at this Theme Location
	public string GetThemePathForAsset(string themeLocation, string asset) {
		string path = String.Concat(BasePath, themeLocation, asset);
		if(FileExists(path)){
			return path;
		}
		return "";
	}

	//This is the main helper to use to obtain the path to the asset in function of the configured theme locations.
	public string ResolvePath(string path) {
		if(Application["paths-dictionary"] == null) {
			Application["paths-dictionary"] = new ConcurrentDictionary<string, string>();
		}
		ConcurrentDictionary<string, string> pathsDictionary = (ConcurrentDictionary<string, string>) Application["paths-dictionary"];
		
		string filePath = "";
		string pathParams = "";
		
		string key = path + "-" + String.Join("-",ThemesLocations);

		if(path.Contains("?")) {
			pathParams = path.Split('?')[1];
			path = path.Split('?')[0];
		}

		Boolean found = false;
		if (!pathsDictionary.ContainsKey(key)) {
			foreach(string themeLocation in ThemesLocations) {
				string themePath = GetThemePathForAsset(themeLocation, path);
				if(themePath != "") {
					filePath = themePath;
					found = true;
				}
			}
			if(found) {
				found = pathsDictionary.TryAdd(key, filePath);

				if(filePath.Equals("")) {
					if (Logger != null) Logger.debug(String.Concat(Theme, ": path not found for ", path));
				}
			}
		} else {
			found = pathsDictionary.TryGetValue(key, out filePath);
		}

		if(found) {
			if(pathParams.Length > 0) filePath = String.Concat(filePath, "?", pathParams);
			if(IsDevelopment) {
				if (Logger != null) Logger.trace(String.Concat("ResolvePath end: ", filePath));
			}
			return filePath;
		} else {
			return "";
		}
	}

	public void ExecutePath(string path) {
		string target = ResolvePath(path);
		if(!target.Equals("")) {
			Server.Execute(target);
		} else {
			if(IsDevelopment) {
				if (Logger != null) Logger.error(String.Concat("File not found: ", path));
			}
		}
	}

	//This help will build a path to the asset and append a CacheBreak computed with a SHA-256 of the file content.
	//Usage is for links to ressources that will be loaded from the front-end. (*.css, *.js)
	public string CacheBreak(string url) {
		//if (Logger != null) Logger.trace(String.Concat("CacheBreak start: ", url));
		string pathParams = "";
		if(url.Contains("?")) {
			pathParams = url.Split('?')[1];
			url = url.Split('?')[0];
		}
		StringBuilder filePath = new StringBuilder("");
		filePath.Append(ResolvePath(url));
		if(!filePath.ToString().Equals("")) {
			try { 
				DateTime dt = System.IO.File.GetLastWriteTime(Server.MapPath(filePath.ToString()));
				string filehash = Utils.hashString(dt.ToString(),"SHA-256");
				//Utils.hashFile(Server.MapPath(filePath.ToString()), "SHA-256");
				filePath.Append("?cache=");
				filePath.Append(filehash);
			} catch (Exception e) {
				if (Logger != null) Logger.error(String.Concat("File not found: ", filePath.ToString(), ", ", e.ToString()));
			}
		}
		if(pathParams.Length > 0) filePath.Append("?").Append(pathParams);
		//if (Logger != null) Logger.trace(String.Concat("CacheBreak end: ", filePath.ToString()));
		return filePath.ToString();
	}

	//Check if file actually exists on disk.
	public bool FileExists(string path) {
		return System.IO.File.Exists(Server.MapPath(path));
	}

	//// Referencing other smartlets helpers ////
	public string GetURLForSmartlet(string smartletName, string urlParams) {
		StringBuilder smartletUrl = new StringBuilder("do.aspx?interviewID=").Append(smartletName).Append("&workspace=").Append(Workspace).Append("&lang=").Append(CurrentLocale);
		if (!urlParams.Equals("")) {
			smartletUrl.Append("&").Append(urlParams);
		}
		return smartletUrl.ToString();
	}

	public string GetURLForSmartlet(string smartletName) {
		return GetURLForSmartlet(smartletName, "");
	}

	public string GetURLForSmartletReset(string smartletName) {
		return GetURLForSmartlet(smartletName, "reset=true");
	}

	public string GetURLForPage(ISmartletPage page) {
		string pageId = "t_g" + page.getId() + "=1";
		return GetURLForSmartlet(page.getSmartlet().getCode(), pageId);
	}

	public string GetRequestURI() {
		return Request.Url.AbsolutePath;
	}

	//// Authentication Helpers ////
	public bool IsLogged() {
		if(!Username.Equals("")) {
			return true;
		} else {
			Logger.debug("<<<< SGWebCore:IsLogged: Cleared [userid, roles] >>>>");
			Session["userid"] = "";
			Session["username"] = "";
			Session["fullname"] = "";
			Session["roles"] = "";
			return false;
		}
	}

	// public void Logout() {

	// 	Session["userid"] = "";
	// 	Session["roles"] = "";

	// 	Session.Clear();
	// 	Session.Abandon();
	// 	Session.RemoveAll();

	// 	if (Request.Cookies["ASP.NET_SessionId"] != null)
	// 	{
	// 		Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
	// 		Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
	// 	}
	// }
	public string Username { 
		get {
			return (Session["username"] != null) ? (string) Session["username"] : "";
		}
	}

	public string Fullname { 
		get {
			return (Session["fullname"] != null) ? (string) Session["fullname"] : "";
		}
	}

	public string UserId {
		get {
			return (Session["userid"] != null) ? (string) Session["userid"] : "";
		}
	}

	//Roles are retreive and set on the Session for ex.: in the /smartprofile/dashboard smartlet, welcome page, actions
	public string UserRoles {
		get {
			string result = "";
			if(Session["roles"] != null && !((string)Session["roles"]).Equals("")) {
				result = ((string)Session["roles"]);
			}
			return result;
		}
	}

	public string HomeURL {
		get {
			if(Application["home-url"] == null || ((string)Application["home-url"]).Equals("")) {
				Application["home-url"] = GetURLForSmartlet("home");
			}
			return (string)Application["home-url"];
		}
		set {
			Application["home-url"] = value;
		}
	}

	public string LoginURL {
		get {
			if(Application["login-url"] == null || ((string)Application["login-url"]).Equals("")) {
				Application["login-url"] = GetURLForSmartlet("login");
			}
			return (string)Application["login-url"];
		}
		set {
			Application["login-url"] = value;
		}
	}

	public string LogoutURL {
		get {
			if(Application["logout-url"] == null || ((string)Application["logout-url"]).Equals("")) {
				Application["logout-url"] = GetURLForSmartlet("logout");
			}
			if(IsLogged()) {
				return (string)Application["logout-url"];
			} else {
				return HomeURL;
			}
		}
		set {
			Application["logout-url"] = value;
		}
	}

	public string ProfileURL {
		get {
			if(Application["profile-url"] == null || ((string)Application["profile-url"]).Equals("")) {
				Application["profile-url"] = GetURLForSmartlet("profile");
			}
			return (string)Application["profile-url"];
		}
		set {
			Application["profile-url"] = value;
		}
	}

	public string getLogoutURL(string urlParams) {
		return String.Concat(LogoutURL, "&", urlParams);
	}

	//// Smartlet Features Helpers ////
	public string CurrentPageCSS {
		get {
			if(Context.Items["pageCSS"] == null) {
				Context.Items["pageCSS"] = (string)CurrentPage.getCSSClass();
			}
			return (string)Context.Items["pageCSS"];
		}
	}

	public string GetLocalizedResource(string key) {
		if(Application["localized-"+key] == null) {
			Application["localized-"+key] = Smartlet.getLocalizedResource(key);
		}
		return (string)Application["localized-"+key];
	}

	public string GetVariableByName(string key) {
		string smartVal = "";
		ISmartletVariable smartVar = Smartlet.findVariableByName(key);
		
		if(smartVar != null) {
			smartVal = (string) smartVar.getValue(); 
			if(smartVal == null) smartVal = "";
		}
		return smartVal;
	}

	public string GetAppSetting(string key) {
		if(Application["app-setting-"+key] == null) {
			if(System.Configuration.ConfigurationManager.AppSettings[key] != null) {
				Application["app-setting-"+key] = (string)System.Configuration.ConfigurationManager.AppSettings[key];
			} else {
				Application["app-setting-"+key] = "";
			}
		}
		
		return (string)Application["app-setting-"+key];
	}

	public ISmartletPage SectionPrimaryPage {
		get {
			if(Session["section-primary-page"] != null && CurrentPageSection.Equals(CurrentActiveSection)) {
				return ((ISmartletPage)Session["section-primary-page"]);
			}
			return null;
		}
		set {
			Session["section-primary-page"] = value;
		}
	}

	public string SectionPrimaryPageURL {
		get {
			ISmartletPage page = SectionPrimaryPage;
			if(page != null && !page.Equals("") && CurrentPageSection.Equals(CurrentActiveSection)) {
				return GetURLForPage(page);
			}
			return "#";
		}
	}

	public ISmartletPage PreviousPage {
		get {
			ISmartletPage[] pages = History;
			if(pages != null && pages.Length > 1 && pages[pages.Length-2] != CurrentPage) {
				Session["previous-page"] = pages[pages.Length-2];
				return pages[pages.Length-2];
			} else {
				Session["previous-page"] = null;
				return null;
			}
		}
	}

	public string PreviousPageURL {
		get {
			ISmartletPage page = PreviousPage;
			if(page != null) {
				Session["previous-page-url"] = GetURLForPage(page);
				return (string)Session["previous-page-url"];
			} else {
				Session["previous-page-url"] = "#";
				return "#";
			}
		}
	}

	public bool IsPageSectionPrimary {
		get {
			string currentPageSection = CurrentPageSection;
			string currentActiveSection = CurrentActiveSection;

			if (CurrentPageCSS.Contains("section-primary-page")) {
				currentActiveSection = currentPageSection;
				SectionPrimaryPage = CurrentPage;
				return true;
			} else if (currentPageSection != currentActiveSection) {
				currentActiveSection = currentPageSection;
			}
			return false;
		}
	}

	public bool IsPageMemberOfCurrentSection {
		get {
			string currentPageSection = CurrentPageSection;
			string currentActiveSection = CurrentActiveSection;
			return (
				!IsPageSectionPrimary && 
				!currentPageSection.Equals("") && 
				!currentActiveSection.Equals("") &&
				currentPageSection.Equals(currentActiveSection)
			);
		}
	}

	public string CurrentActiveSection {
		get {
			if(Session["active-section"] != null) {
				return (string)Session["active-section"];
			}
			return "";
		}
		set {
			Session["active-section"] = value;
		}
	}

	public string CurrentPageSection {
		get {
			return ((SessionPage)CurrentPage).getSection(CurrentLocale);
		}
	}

	public ISmartletPage[] History {
		get {
			if(Session["pages-history"] != null) {
				return (ISmartletPage[])Session["pages-history"];
			} else {
				return null;
			}
		}
		set {
			Session["pages-history"] = value;
		}
	}

	public ISmartletPage[] AddPageToHistory(ISmartletPage page) {
		List<ISmartletPage> pages = new List<ISmartletPage>();
		ISmartletPage[] pagesInHistory = History;
		
		if (pagesInHistory != null && pagesInHistory.Length > 0)
		{
			for (int i = 0; i < pagesInHistory.Length; i++)
			{
				//Only keep up to ourselve if the history (to limit the size of the object)
				if (pagesInHistory[i].getId() != page.getId())
				{
					pages.Add(pagesInHistory[i]);
				}
				else
				{
					break;
				}
			}

		}

		if(!pages.Contains(page))
		{
			pages.Add(page);
		}

		pagesInHistory = pages.ToArray();
		History = pagesInHistory;
		return pagesInHistory;
	}

	public ISmartletPage[] Breadcrumbs() {
		//This breadcrumbs is history based.
		ISmartletPage[] pages = Smartlet.getHistory();
		List<ISmartletPage> breadcrumbsList = new List<ISmartletPage>();
		string currentPageSection = CurrentPageSection;
		ISmartletPage currentPage = CurrentPage;

		//Add our currentPage to the list fist
		breadcrumbsList.Add(currentPage);

		//Read History in Reverse
		for (int i = pages.Length - 1; i >= 0; i--) {
			//Check if we are in a section
			if(!currentPageSection.Equals("")) {
				//Otherwise we only keep members of our section
				if(currentPageSection == ((SessionPage)pages[i]).getSection(CurrentLocale)) {
					if (pages[i] != currentPage && (pages[i] != pages[0] || i == 0)) {
						breadcrumbsList.Add(pages[i]); 
					} else {
						break;
					}
				} else {
					//Once we see we're no longer in the  section, we stop.
					break;
				}
			//Not in a section,
			} else {
				if (pages[i] != currentPage && (pages[i] != pages[0] || i == 0)) {
					breadcrumbsList.Add(pages[i]); 
				} else {
					//If we see ourselves in the history, we stop.
					break;
				}
			}
		}
		ISmartletPage[] breadcrumbs = breadcrumbsList.ToArray();
		Array.Reverse(breadcrumbs);
		return breadcrumbs;
	}

	//deprecated

	public bool ShowWizard {
		get {
			if(Context.Items["showWizard"] == null) {
				Context.Items["showWizard"] = (bool?)CurrentPageCSS.Contains("");
			}
			return (bool)Context.Items["showWizard"];
		}
	}

	public bool HideHeader {
		get {
			if(Context.Items["hideHeader"] == null) {
				Context.Items["hideHeader"] = (bool?)CurrentPageCSS.Contains("hide-header");
			}
			return (bool)Context.Items["hideHeader"];
		}
	}

	public bool HideFooter {
		get {
			if(Context.Items["hideFooter"] == null) {
				Context.Items["hideFooter"] = (bool?)CurrentPageCSS.Contains("hide-footer");
			}
			return (bool)Context.Items["hideFooter"];
		}
	}

	public bool HideBreadcrumb {
		get {
			if(Context.Items["hideBreadcrumb"] == null) {
				Context.Items["hideBreadcrumb"] = (bool?)CurrentPageCSS.Contains("hide-breadcrumb");
			}
			return (bool)Context.Items["hideBreadcrumb"];
		}
	}

	public bool HideProgressBar {
		get {
			if(Context.Items["hideProgressBar"] == null) {
				Context.Items["hideProgressBar"] = (bool?)CurrentPageCSS.Contains("hide-progress-bar");
			}
			return (bool)Context.Items["hideProgressBar"];
		}
	}

	public bool HideStepNavigation {
		get {
			if(Context.Items["hideStepNavigation"] == null) {
				Context.Items["hideStepNavigation"] = (bool?)CurrentPageCSS.Contains("hide-step-navigation");
			}
			return (bool)Context.Items["hideStepNavigation"];
		}
	}

	//deprecated
	public bool HideFunelNavigation {
		get {
			if(Context.Items["hideFunelNavigation"] == null) {
				Context.Items["hideFunelNavigation"] = (bool?)CurrentPageCSS.Contains("hide-funel-navigation");
			}
			return (bool)Context.Items["hideFunelNavigation"];
		}
	}

	public bool HideBottomNavigation {
		get {
			if(Context.Items["hideBottomNavigation"] == null) {
				Context.Items["hideBottomNavigation"] = (bool?)CurrentPageCSS.Contains("hide-bottom-navigation");
			}
			return (bool)Context.Items["hideBottomNavigation"];
		}
	}

	public bool HidePageTitle {
		get {
			if(Context.Items["hidePageTitle"] == null) {
				Context.Items["hidePageTitle"] = (bool?)CurrentPageCSS.Contains("hide-label");
			}
			return (bool)Context.Items["hidePageTitle"];
		}
	}

	public bool IsPdf {
		get {
			bool flag = false;
			bool isPdfRequest = false;
			bool isPdfContext = false;

			isPdfRequest = (Request["pdf"] != null && !"".Equals(Request["pdf"]));
			isPdfContext = (Context.Items["pdf"] != null && (
			(Context.Items["pdf"] is String && "true".Equals((string)Context.Items["pdf"])) ||
			(Context.Items["pdf"] is bool && (bool)Context.Items["pdf"])
			) );

			return (isPdfRequest || isPdfContext);
		}
		set {
			Context.Items["pdf"] = value;
		}
	}

	public bool IsSummary {
		get {
			if(Context.Items["summary"] == null) {
				Context.Items["summary"] = false;
			}
			return (bool)Context.Items["summary"];
		}
		set {
			Context.Items["summary"] = value;
		}
	}

	public bool ShowErrorsAbove {
		get {
			if(Context.Items["errors-above"] == null) {
				Context.Items["errors-above"] = false;
			}
			return (bool)Context.Items["errors-above"];
		}
		set {
			Context.Items["errors-above"] = value;
		}
	}

	public bool BareRender {
		get {
			if(Context.Items["renderbare"] == null) {
				Context.Items["renderbare"] = false;
			}
			return (bool)Context.Items["renderbare"];
		}
		set {
			Context.Items["renderbare"] = value;
		}
	}

	public int ErrorIndex {
		get {
			if(Context.Items["errorIndex"] == null) {
				Context.Items["errorIndex"] = 0;
			}
			return (int)Context.Items["errorIndex"];
		}
		set {
			Context.Items["errorIndex"] = value;
		}
	}

	public string GetPageTitle(string pageName) {
		string currentPageSection = CurrentPageSection;
		StringBuilder sb = new StringBuilder();
		if(!currentPageSection.Equals("") && !CurrentPageCSS.Contains("hide-section-label")) sb.Append(currentPageSection);
		if(!pageName.Equals("")) {
			if(!currentPageSection.Equals("") && !CurrentPageCSS.Contains("hide-section-label")) sb.Append(" - ");
			if(currentPageSection != pageName || CurrentPageCSS.Contains("hide-section-label")){
				sb.Append(pageName);
			}
			
		};
		return sb.ToString();
	}

	//// Field Helpers ////
	public bool IsUnderRepeat(ISmartletField f) {
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

	public ISmartletField FindFieldByName(string name) {
		return CurrentPage.findFieldByName(name);
	}

	public ISmartletField FindFieldByNameUnderRepeat(string name, int repeatIndex) {
		ISmartletField fieldUnderRepeat = CurrentPage.findFieldByName(name);

		if (fieldUnderRepeat == null)
			return null;

		ISmartletField parent = fieldUnderRepeat.getParent();

		while(parent.getTypeConst() != DotnetConstants.ElementType.REPEAT) {
			parent = parent.getParent();
		}

		ISmartletRepeat rpt = (ISmartletRepeat)parent;

		return rpt.getGroups()[repeatIndex].findFieldByName(name);
	}

	public ISmartletField FindFieldById(string id) {

		return CurrentPage.findFieldById(id);
	}

	public ISmartletField GetFieldFromControlInfo(ControlInfo ctrl) {
		return FindFieldById(ctrl.getFieldId());
	}

	public string GetCustomControlPathForCurrentControl(String customControl){
		StringBuilder path = new StringBuilder("");
		if(customControl != null && !customControl.Equals("")) {
			string controlsPath = String.Concat("/controls/", customControl, ".aspx");
			controlsPath = ResolvePath(controlsPath);
			Logger.trace(controlsPath);
			if (!customControl.Equals("") && !controlsPath.Equals("")) {
				path.Append(controlsPath);
			}
		}
		return path.ToString();
	}

	public string JavascriptEncode(string value) {
		return value.Replace("'","&#39").Replace("\"","&quot;");
	}

	public string GetLabel(ControlInfo ctrl) {
		return ctrl.getLabel();
	}

	public string GetLabel(ISmartletField ctrl) {
		return ctrl.getLabel();
	}

	public string GetLabel(SessionField ctrl) {
		return ctrl.getLabel();
	}
	public string GetLabel(Alphinat.SmartGuideServer.Controls.Control ctrl) {
		return GetLabel(ctrl.Current);
	}

	public string GetTooltip(ControlInfo ctrl) {
		return ctrl.getTooltip();
	}

	public string GetTooltip(ISmartletField ctrl) {
		return ctrl.getTooltip();
	}

	public string GetTooltip(SessionField ctrl) {
		return ctrl.getTooltip();
	}

	public string GetTooltip(Alphinat.SmartGuideServer.Controls.Control ctrl) {
		return GetTooltip(ctrl.Current);
	}

	public string GetCleanCSSClass(ControlInfo ctrl) {
		return RemoveBehaviourFlags(ctrl.getCSSClass());
	}

	public string GetCleanCSSClass(ISmartletField ctrl) {
		return RemoveBehaviourFlags(ctrl.getCSSClass());
	}

	public string GetCleanCSSClass(SessionField ctrl) {
		return RemoveBehaviourFlags(ctrl.getCSSClass());
	}

	public string GetCleanCSSClass(Alphinat.SmartGuideServer.Controls.Control ctrl) {
		return GetCleanCSSClass(ctrl.Current);
	}

	public string GetCSSStyle(ControlInfo ctrl) {
		return ctrl.getCSSStyle();
	}

	public string GetCSSStyle(ISmartletField ctrl) {
		return ctrl.getCSSStyle();
	}

	public string GetCSSStyle(SessionField ctrl) {
		return ctrl.getCSSStyle();
	}

	public string GetCSSStyle(Alphinat.SmartGuideServer.Controls.Control ctrl) {
		return GetCSSStyle(ctrl.Current);
	}

	public string GetMetaDataValue(ControlInfo ctrl, string key) {
		return (ctrl.getMetaDataValue(key) != null && !ctrl.getMetaDataValue(key).Equals("")) ? ctrl.getMetaDataValue(key) : "";
	}

	public string GetMetaDataValue(Alphinat.SmartGuideServer.Controls.Control ctrl, string key) {
		return GetMetaDataValue(ctrl.Current, key);
	}

	public string GetAttribute(ControlInfo ctrl, string attribute) {
		return ctrl.getAttribute(attribute);
	}

	public string GetAttribute(Alphinat.SmartGuideServer.Controls.Control ctrl, string attribute) {
		return GetAttribute(ctrl.Current, attribute);
	}

	public string GetAttribute(ControlInfo ctrl, string attribute, bool tohtml) {
		if(tohtml) {
			return HttpUtility.HtmlEncode(ctrl.getAttribute(attribute));
		} else {
			return ctrl.getAttribute(attribute);
		} 
	}

	public string GetAttribute(Alphinat.SmartGuideServer.Controls.Control ctrl, string attribute, bool tohtml) {
		return GetAttribute(ctrl.Current, attribute, tohtml);
	}

	public string RemoveBehaviourFlags(string value) {

		string result = value.Replace("proxy","")
		.Replace("hide-column-label","")
		.Replace("hide-label","")
		.Replace("hide-sort","")
		.Replace("nonsearchable", "")
		.Replace("plain-group","")
		.Replace("collapsible","")
		.Replace("open","")
		.Replace("table-render","")
		.Replace("table-view","")
		.Replace("grid-render","")
		.Replace("grid-view","")
		.Replace("block-render","")
		.Replace("block-view","")
		.Replace("datatables-view","")
		.Replace("datatable-editable","")
		.Replace("select-all","")
		.Replace("signature","")
		.Replace("tinymce","");

		return result;
	}

	public SessionField GetProxyControl(string key, ref string eventTargets) { 
		SessionField ctrl = (SessionField)FindFieldByName(key);
		if(ctrl != null) {
			ISmartletField[] targets = ctrl.getEventTarget();
			if(targets != null) {
				foreach(ISmartletField targetField in targets) {
					if(targetField != null) {
						eventTargets += "\"" + targetField.getHtmlName() + "\",";
					}
				}
			}
		}
		return ctrl;
	}

	public SessionField GetProxyButton(string key, ref string eventTargets) {
		return GetProxyControl(key, ref eventTargets);
	}

	public SessionField GetProxyControl(string key, int repeatIndex, ref string eventTargets) {
		SessionField ctrl = null;

		if(repeatIndex > -1) {
			ctrl = (SessionField)FindFieldByNameUnderRepeat(key, repeatIndex);
		} else {
			ctrl = (SessionField)FindFieldByName(key);
		}
		if(ctrl != null) {
			ISmartletField[] targets = ctrl.getEventTarget();
			if(targets != null) {
				foreach(ISmartletField targetField in targets) {
					if(targetField != null) {
						eventTargets += "\"" + targetField.getHtmlName() + "\",";
					}
				}
			}
		}
		return ctrl;
	}

	public SessionField GetProxyButton(string key, int repeatIndex, ref string eventTargets) {
		return GetProxyButton(key, repeatIndex, ref eventTargets);
	}

	public long GetSortableDate(ControlInfo ctrl) {

		long staticvalue = 0;
		DateTime dt;

		String format = ctrl.getAttribute("format");
		if(!format.Equals("")){
			format = format.Replace("mois","MM").Replace("month","MM").Replace("mmm", "M").Replace("mm", "MM").Replace("jj","dd").Replace("aaaa","yyyy").Replace("aa","yy");
		} else {
			 format = "yyyy-MM-dd";
		}

		Boolean result = DateTime.TryParseExact(ctrl.getValue(), format, System.Globalization.CultureInfo.InvariantCulture, DateTimeStyles.None, out dt);
		//If this failed, try again without specifying the culture.
		if(!result) {
			result = DateTime.TryParse(ctrl.getValue(), out dt); 
		}

		if(result) {
			staticvalue = dt.Ticks;
		}

		return staticvalue;
	}

	public string GetHTMLDate(ControlInfo ctrl) {
		
		if (ctrl.getValue() != null && !ctrl.getValue().Equals("")) {
			DateTime dt = new DateTime();
			String format = ctrl.getAttribute("format");
			Boolean result = DateTime.TryParseExact(ctrl.getValue(), format, System.Globalization.CultureInfo.InvariantCulture, DateTimeStyles.None, out dt);
			if(!result) {
				result = DateTime.TryParse(ctrl.getValue(), out dt); 
			}
			return dt.ToString("yyyy-MM-dd");
		}
		return "";
	}

	public long GetSortableDate(Alphinat.SmartGuideServer.Controls.Control ctrl) {
		return GetSortableDate(ctrl.Current);
	}

	//// Utilities ///
	public void TimerTraceStart(string key) {
		Context.Items["timer-" + key] = DateTime.UtcNow;
	}

	public void TimerTraceStop(string key) {
		DateTime timerstart = (DateTime) Context.Items["timer-" + key];
		if(timerstart != null) {
			sg.Context.getLogger(key).debug(String.Concat("Trace timer for :", key, ", duration = ", (DateTime.UtcNow - timerstart).TotalSeconds));
		} else {
			sg.Context.getLogger(key).debug(String.Concat("Missing timer start for :", key));
		}
	}

	///Cookies
	private readonly Regex rgx = new Regex("[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+");

	// public void ClearCookie(IServiceContext context, string cookieName)
	// {
	// 	lLogger.debug("Cookie - Start clearing " + cookieName);

	// 	try
	// 	{
	// 		string secureValue = (string)context.getEnvironment().getAttribute(Constants.Scope.CONFIGURATION, "SP.Smartlets.Cookie.Secure");
	// 		if (String.IsNullOrEmpty(secureValue))
	// 		{
	// 			secureValue = "false";
	// 		}

	// 		HttpRequest req = (HttpRequest)context.getEnvironment().getRequest();

	// 		string baseURL = req.Url.ToString();

	// 		Logger.debug("BaseURL is " + baseURL);

	// 		string fullDomain = Between(baseURL, "://", "/");

	// 		if (fullDomain.IndexOf(":") > -1)
	// 		{
	// 			fullDomain = Before(fullDomain, ":");
	// 		}

	// 		Logger.debug("Full domain is " + fullDomain);

	// 		string domain = "";

	// 		// is it an IP address
	// 		if (rgx.Match(fullDomain).Success)
	// 		{
	// 			domain = fullDomain;
	// 		}
	// 		else
	// 		{
	// 			string[] parts = fullDomain.Split('.');
	// 			int nbrparts = parts.Length;
	// 			domain = fullDomain;
	// 			if (nbrparts > 2)
	// 			{
	// 				int indexDot = domain.IndexOf(".");
	// 				if (indexDot > -1)
	// 				{
	// 					domain = domain.Substring(indexDot);
	// 				}
	// 			}
	// 		}

	// 		int index = domain.IndexOf(".");
	// 		if (index == 0)
	// 		{
	// 			domain = domain.Substring(1);
	// 		}

	// 		Logger.debug("Final domain is " + domain);

	// 		context.getEnvironment().addHttpCookie(cookieName, "", "0", domain, "/", secureValue, "true");
	// 	}
	// 	catch (Exception e)
	// 	{
	// 		Logger.error("An exception occured trying to clear cookie " + cookieName + ".  The exception is " + e.Message);
	// 	}

	// 	Logger.debug("Done clearing " + cookieName);
	// }

	public string Before(string value, string a)
	{
		int posA = value.IndexOf(a);
		if (posA == -1)
		{
			return "";
		}
		return value.Substring(0, posA);
	}

	public string After(string value, string a)
	{
		int posA = value.LastIndexOf(a);
		if (posA == -1)
		{
			return "";
		}
		int adjustedPosA = posA + a.Length;
		if (adjustedPosA >= value.Length)
		{
			return "";
		}
		return value.Substring(adjustedPosA);
	}

	public string Between(string value, string a, string b)
	{
		int posA = value.IndexOf(a);
		if (posA == -1)
		{
			return "";
		}
		int adjustedPosA = posA + a.Length;

		int posB = value.Substring(adjustedPosA).IndexOf(b)+ adjustedPosA;
		if (posB == -1)
		{
			return "";
		}
		
		if (adjustedPosA >= posB)
		{
			return "";
		}
		return value.Substring(adjustedPosA, posB - adjustedPosA);
	}

	public int GetLineNumber(Exception ex)
	{
		var lineNumber = 0;
		const string lineSearch = ":line ";
		var index = ex.StackTrace.LastIndexOf(lineSearch);
		if (index != -1)
		{
			var lineNumberText = ex.StackTrace.Substring(index + lineSearch.Length);
			if (int.TryParse(lineNumberText, out lineNumber)) { }
		}
		return lineNumber;
	}

	public string ExceptionInfo(Exception ex)
	{
		StackFrame stackFrame = (new StackTrace(ex, true)).GetFrame(0);
		return string.Format("At line {0} column {1} in {2}: {3} {4}{3}{5}  ",
			GetLineNumber(ex), stackFrame.GetFileColumnNumber(),
			stackFrame.GetMethod(), System.Environment.NewLine, stackFrame.GetFileName(),
			ex.Message);
	}
}
