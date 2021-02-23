using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Globalization;
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
	private string currentLocale = "";
	private string lastModificationDate = "";

	public void ClearCaches() {
		Session["paths-dictionary"] = new Dictionary<string, string>();
		Session["CacheBreak-dictionary"] = new Dictionary<string, string>();
		Context.Items["api5"] = null;
		Context.Items["smartlet"] = null;
		Context.Items["smartletLogger"] = null;
		Context.Items["smartletName"] = null;
		Context.Items["smartletCode"] = null;
		Context.Items["theme"] = null;
		Context.Items["workspace"] = null;
		Context.Items["smartletSubject"] = null;
		Context.Items["basePath"] = null;
		Context.Items["coreThemePath"] = null;
		Context.Items["currentThemePath"] = null;
		Context.Items["logout-url"] = null;
		Context.Items["showWizard"] = null;
	}

	public API5 sg {
		get {
			if(Context.Items["api5"] == null) {
				Context.Items["api5"] = new API5();
			}
			return (API5)Context.Items["api5"];
		}
		set { 
			Context.Items["api5"] = value; 
		}
	}

	public bool IsDevelopment {
		get {
			return GetAppSetting("com.alphinat.sgs.environment").Equals("Development");
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
		if(Context.Items["smartletLogger"+name] == null) {
			if(sg.Context != null) {
				Context.Items["smartletLogger"+name] = sg.Context.getLogger(name); 
			} else {
				Context.Items["smartletLogger"+name] = null;
			}
		}
		return (ISmartletLogger)Context.Items["smartletLogger"+name];
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
		get { return (string[])Context.Items["theme-locations"]; }
		set { Context.Items["theme-locations"] = value; }
	}
	
	//// Filepaths Helpers ////
	
	//Will provide the runniing basePath based on the current Workspace name.
	public string BasePath {
		get {
			if (Context.Items["basePath"] == null || ((string)Context.Items["basePath"]).Equals("")) {
				Context.Items["basePath"] = String.Concat(HttpContext.Current.Request.ApplicationPath, "/aspx/", Workspace, "/");
			}
			return (string)Context.Items["basePath"];
		}
	}

	public string CoreThemePath {
		get {
			if (Context.Items["coreThemePath"] == null || ((string)Context.Items["coreThemePath"]).Equals("")) {
				Context.Items["coreThemePath"] = BasePath + "Default";
			}
			return (string)Context.Items["coreThemePath"];
		}
		set {
			Context.Items["coreThemePath"] = value;
		}
	}

	public string CurrentThemePath {
		get {
			if (Context.Items["currentThemePath"] == null || ((string)Context.Items["currentThemePath"]).Equals("")) {
				Context.Items["currentThemePath"] = BasePath + Theme;
			}
			return (string)Context.Items["currentThemePath"];
		}
		set {
			Context.Items["currentThemePath"] = value;
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
		if (Logger != null) Logger.trace(String.Concat("ResolvePath start: ", path));
		if(Session["paths-dictionary"] == null) {
			Session["paths-dictionary"] = new Dictionary<string, string>();
		}
		Dictionary<string, string> pathsDictionary = (Dictionary<string, string>) Session["paths-dictionary"];
		
		string filePath = "";
		string pathParams = "";
		
		string key = path + String.Join("-",ThemesLocations);

		if(path.Contains("?")) {
			pathParams = path.Split('?')[1];
			path = path.Split('?')[0];
		}
		if (!pathsDictionary.ContainsKey(key)) {
			foreach(string themeLocation in ThemesLocations) {
				string themePath = GetThemePathForAsset(themeLocation, path);
				if(themePath != "") {
					filePath = themePath;
				}
			}
			pathsDictionary.Add(key, filePath);

			if(filePath.Equals("")) {
				if (Logger != null) Logger.debug(String.Concat(Theme, ": path not found for ", path));
			}
		} else {
			pathsDictionary.TryGetValue(key, out filePath);
		}

		if(pathParams.Length > 0) filePath = String.Concat(filePath, "?", pathParams);
		if (Logger != null) Logger.trace(String.Concat("ResolvePath end: ", filePath));
		return filePath;
	}

	public void ExecutePath(string path) {
		Server.Execute(ResolvePath(path));
	}

	//This help will build a path to the asset and append a CacheBreak computed with a SHA-256 of the file content.
	//Usage is for links to ressources that will be loaded from the front-end. (*.css, *.js)
	public string CacheBreak(string url) {
		if (Logger != null) Logger.trace(String.Concat("CacheBreak start: ", url));
		string pathParams = "";
		if(url.Contains("?")) {
			pathParams = url.Split('?')[1];
			url = url.Split('?')[0];
		}
		StringBuilder filePath = new StringBuilder("");
		filePath.Append(ResolvePath(url));
		if(!filePath.ToString().Equals("")) {
			try { 
				string filehash = Utils.hashFile(Server.MapPath(filePath.ToString()), "SHA-256");
				filePath.Append("?cache=");
				filePath.Append(filehash);
			} catch (Exception e) {
				if (Logger != null) Logger.error(String.Concat("File not found: ", filePath.ToString(), ", ", e.ToString()));
			}
		}
		if(pathParams.Length > 0) filePath.Append("?").Append(pathParams);
		if (Logger != null) Logger.trace(String.Concat("CacheBreak end: ", filePath.ToString()));
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
		return GetURLForSmartlet(SmartletCode, pageId);
	}

	public string GetRequestURI() {
		return Request.Url.AbsolutePath;
	}

	//// Authentication Helpers ////
	public bool IsLogged() {
		return (!Username.Equals(""));
	}
	
	public string Username { 
		get {
			return (Session["username"] != null) ? (string) Session["username"] : "";
		}
	}

	public string UserId {
		get {
			return (Session["userid"] != null) ? (string) Session["userid"] : "";
		}
	}

	//Roles are retreive and set on ther Session in the /smartprofile/dashboard smartlet, welcome page, actions
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
			if(Context.Items["home-url"] == null || ((string)Context.Items["home-url"]).Equals("")) {
				Context.Items["home-url"] = GetURLForSmartlet("home");
			}
			return (string)Context.Items["home-url"];
		}
		set {
			Context.Items["home-url"] = value;
		}
	}

	public string LoginURL {
		get {
			if(Context.Items["login-url"] == null || ((string)Context.Items["login-url"]).Equals("")) {
				Context.Items["login-url"] = GetURLForSmartlet("login");
			}
			return (string)Context.Items["login-url"];
		}
		set {
			Context.Items["login-url"] = value;
		}
	}

	public string LogoutURL {
		get {
			if(Context.Items["logout-url"] == null || ((string)Context.Items["logout-url"]).Equals("")) {
				Context.Items["logout-url"] = GetURLForSmartlet("logout");
			}
			return (string)Context.Items["logout-url"];
		}
		set {
			Context.Items["logout-url"] = value;
		}
	}

	public string ProfileURL {
		get {
			if(Context.Items["profile-url"] == null || ((string)Context.Items["profile-url"]).Equals("")) {
				Context.Items["profile-url"] = GetURLForSmartlet("profile");
			}
			return (string)Context.Items["profile-url"];
		}
		set {
			Context.Items["profile-url"] = value;
		}
	}

	public string getLogoutURL(string urlParams) {
		return String.Concat(LogoutURL, "&", urlParams);
	}

	//// Smartlet Features Helpers ////
	public string CurrentPageCSS {
		get {
			return (string)CurrentPage.getCSSClass();
		}
	}

	public string GetLocalizedResource(string key) {
		return Smartlet.getLocalizedResource(key);
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
		if(System.Configuration.ConfigurationManager.AppSettings[key] != null) {
			return (string)System.Configuration.ConfigurationManager.AppSettings[key];
		}
		return "";
	}


	public string SectionPrimaryPageURL {
		get {
			if(Session["section-primary-page"] != null && CurrentPageSection.Equals(CurrentActiveSection)) {
				return ((string)Session["section-primary-page"]);
			}
			return "";
		}
		set {
			Session["section-primary-page"] = value;
		}
	}

	public bool IsPageSectionPrimary {
		get {
			if(CurrentPageCSS.Contains("section-primary-page")) {
				CurrentActiveSection = CurrentPageSection;
				SectionPrimaryPageURL = GetURLForPage(CurrentPage);
				return true;
			} else if (CurrentPageSection != CurrentActiveSection) {
				CurrentActiveSection = CurrentPageSection;
			}
			return false;
		}
	}
	public bool IsPageMemberOfCurrentSection {
		get {
			return (
				!IsPageSectionPrimary && 
				!CurrentPageSection.Equals("") && 
				!CurrentActiveSection.Equals("") && 
				CurrentPageSection.Equals(CurrentActiveSection)
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

	public bool ShowWizard {
		get {
			if(Context.Items["showWizard"] == null) {
				Context.Items["showWizard"] = (bool?)CurrentPageCSS.Contains("show-wizard");
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

	public bool HideFunelNavigation {
		get {
			if(Context.Items["hideFunelNavigation"] == null) {
				Context.Items["hideFunelNavigation"] = (bool?)CurrentPageCSS.Contains("hide-funel-navigation");
			}
			return (bool)Context.Items["hideFunelNavigation"];
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
		return JavascriptEncode(ctrl.getLabel());
	}

	public string GetTooltip(ControlInfo ctrl) {
		return JavascriptEncode(ctrl.getTooltip());
	}

	public string GetTooltip(ISmartletField ctrl) {
		return JavascriptEncode(ctrl.getTooltip());
	}

	public string GetTooltip(SessionField ctrl) {
		return JavascriptEncode(ctrl.getTooltip());
	}

	public string GetAttribute(ControlInfo ctrl, string attribute) {
		return JavascriptEncode(ctrl.getAttribute(attribute));
	}

	public string GetMetaDataValue(ControlInfo ctrl, string key) {
		return (ctrl.getMetaDataValue(key).Equals("")) ? "" : ctrl.getMetaDataValue(key);
	}

	public string GetAttribute(ControlInfo ctrl, string attribute, bool tohtml) {
		if(tohtml) {
			return HttpUtility.HtmlEncode(JavascriptEncode(ctrl.getAttribute(attribute)));
		} else {
			return JavascriptEncode(ctrl.getAttribute(attribute));
		} 
	}

	public SessionField GetProxyButton(string key, ref string eventTargets) {
        SessionField btn = (SessionField)FindFieldByName(key);
        if(btn != null) {
            ISmartletField[] targets = btn.getEventTarget();
            if(targets != null) {
                foreach(ISmartletField targetField in targets) {
                    if(targetField != null) {
                        eventTargets += targetField.getId() + ",";
                    }
                }
            }
        }
        return btn;
    }

	//// Utilities ///
	public void TimerTraceStart(string key) {
		Context.Items["timer-" + key] = DateTime.UtcNow;
	}

	public void TimerTraceStop(string key) {
		DateTime timerstart = (DateTime) Context.Items["timer-" + key];
		if(timerstart != null) {
			if (Logger != null) Logger.debug(String.Concat("Trace timer for :", key, ", duration = ", (DateTime.UtcNow - timerstart).TotalSeconds));
		} else {
			if (Logger != null) Logger.debug(String.Concat("Missing timer start for :", key));
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
}