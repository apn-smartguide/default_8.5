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

namespace SG
{
	public partial class Page : System.Web.UI.Page 
	{	
		private string currentLocale = "";
		private string lastModificationDate = "";

		public void ClearCaches() {
			Context.Items["paths-dictionary"] = new Dictionary<string, string>();
			Context.Items["cachebreak-dictionary"] = new Dictionary<string, string>();
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
					return null;
				}
				return (API5)Context.Items["api5"];
			}
			set { 
				Context.Items["api5"] = value; 
			}
		}
		
		public ISmartlet Smartlet {
			get {
				if(Context.Items["smartlet"] == null) {
					Context.Items["smartlet"]  = sg.Context.getSmartlet();
				}
				return (ISmartlet)Context.Items["smartlet"] ;
			}
		}
		public ISmartletLogger log {
			get { 
				if(Context.Items["smartletLogger"] == null) {
					Context.Items["smartletLogger"] = sg.Context.getLogger("SG.Page"); 
				}
				return (ISmartletLogger)Context.Items["smartletLogger"];
			}
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
		public string getThemePathForAsset(string themeLocation, string asset) {
			string path = String.Concat(BasePath, themeLocation, asset);
			if(fileExists(path)){
				return path;
			}
			return "";
		}

		//This is the main helper to use to obtain the path to the asset in function of the configured theme locations.
		public string resolvePath(string path) {
			log.trace(String.Concat("resolvePath start: ", path));
			if(Context.Items["paths-dictionary"] == null) {
				Context.Items["paths-dictionary"] = new Dictionary<string, string>();
			}
			Dictionary<string, string> pathsDictionary = (Dictionary<string, string>) Context.Items["paths-dictionary"];
			
			string filePath = "";
			string pathParams = "";
			
			if(path.Contains("?")) {
				pathParams = path.Split('?')[1];
				path = path.Split('?')[0];
			}
			if (!pathsDictionary.ContainsKey(path)) {
				foreach(string themeLocation in ThemesLocations) {
					string themePath = getThemePathForAsset(themeLocation, path);
					if(themePath != "") {
						filePath = themePath;
					}
				}
				pathsDictionary.Add(path, filePath);

				if(filePath.Equals("")) {
					log.debug(String.Concat(Theme, ": path not found for ", path));
				}
			} else {
				pathsDictionary.TryGetValue(path, out filePath);
			}

			if(pathParams.Length > 0) filePath = String.Concat(filePath, "?", pathParams);
			log.trace(String.Concat("resolvePath end: ", filePath));
			return filePath;
		}

		//This help will build a path to the asset and append a cachebreak computed with a SHA-256 of the file content.
		//Usage is for links to ressources that will be loaded from the front-end. (*.css, *.js)
		public string cacheBreak(string url) {
			log.trace(String.Concat("cacheBreak start: ", url));
			if(Context.Items["cachebreak-dictionary"] == null) {
				Context.Items["cachebreak-dictionary"] = new Dictionary<string, string>();
			}
			string pathParams = "";
			if(url.Contains("?")) {
				pathParams = url.Split('?')[1];
				url = url.Split('?')[0];
			}
			StringBuilder filePath = new StringBuilder("");
			Dictionary<string, string> cacheBreakDictionary = (Dictionary<string, string>) Context.Items["cachebreak-dictionary"];
			if(!cacheBreakDictionary.ContainsKey(url)){
				filePath.Append(resolvePath(url));
				if(!filePath.ToString().Equals("")) {
					try { 
						string filehash = Utils.hashFile(Server.MapPath(filePath.ToString()), "SHA-256");
						filePath.Append("?cache=");
						filePath.Append(filehash);
					} catch (Exception e) {
						log.error(String.Concat("File not found: ", filePath.ToString(), ", ", e.ToString()));
					}
				}
				cacheBreakDictionary.Add(url, filePath.ToString());
			} else {
				string newPath = "";
				cacheBreakDictionary.TryGetValue(url, out newPath);
				filePath.Append(newPath);
			}
			if(pathParams.Length > 0) filePath.Append("?").Append(pathParams);
			log.trace(String.Concat("cacheBreak end: ", filePath.ToString()));
			return filePath.ToString();
		}

		//Check if file actually exists on disk.
		public bool fileExists(string path) {
			return System.IO.File.Exists(Server.MapPath(path));
		}

		//// Referencing other smartlets helpers ////
		public string getURLForSmartlet(string smartletName, string urlParams) {
			StringBuilder smartletUrl = new StringBuilder("do.aspx?interviewID=").Append(smartletName).Append("&workspace=").Append(Workspace).Append("&lang=").Append(CurrentLocale);
			if (!urlParams.Equals("")) {
				smartletUrl.Append("&").Append(urlParams);
			}
			return smartletUrl.ToString();
		}
		
		public string getURLForSmartlet(string smartletName) {
			return getURLForSmartlet(smartletName, "");
		}

		public string getURLForSmartletReset(string smartletName) {
			return getURLForSmartlet(smartletName, "reset=true");
		}

		public string getRequestURI() {
			return Request.Url.AbsolutePath;
		}

		//// Authentication Helpers ////
		public bool isLogged() {
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

		public string HomeURL {
			get {
				if(Context.Items["home-url"] == null || ((string)Context.Items["home-url"]).Equals("")) {
					Context.Items["home-url"] = getURLForSmartlet("home");
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
					Context.Items["login-url"] = getURLForSmartlet("login");
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
					Context.Items["logout-url"] = getURLForSmartlet("logout");
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
					Context.Items["profile-url"] = getURLForSmartlet("profile");
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
		public bool ShowWizard {
			get {
				if(Context.Items["showWizard"] == null) {
					Context.Items["showWizard"] = (bool?)CurrentPage.getCSSClass().Contains("show-wizard");
				}
				return (bool)Context.Items["showWizard"];
			}
		}

		public bool HideHeader {
			get {
				if(Context.Items["hideHeader"] == null) {
					Context.Items["hideHeader"] = (bool?)CurrentPage.getCSSClass().Contains("hide-header");
				}
				return (bool)Context.Items["hideHeader"];
			}
		}

		public bool HideFooter {
			get {
				if(Context.Items["hideFooter"] == null) {
					Context.Items["hideFooter"] = (bool?)CurrentPage.getCSSClass().Contains("hide-footer");
				}
				return (bool)Context.Items["hideFooter"];
			}
		}

		public bool HideBreadcrumb {
			get {
				if(Context.Items["hideBreadcrumb"] == null) {
					Context.Items["hideBreadcrumb"] = (bool?)CurrentPage.getCSSClass().Contains("hide-breadcrumb");
				}
				return (bool)Context.Items["hideBreadcrumb"];
			}
		}

		public bool HideProgressBar {
			get {
				if(Context.Items["hideProgressBar"] == null) {
					Context.Items["hideProgressBar"] = (bool?)CurrentPage.getCSSClass().Contains("hide-progress-bar");
				}
				return (bool)Context.Items["hideProgressBar"];
			}
		}

		public bool HideStepNavigation {
			get {
				if(Context.Items["hideStepNavigation"] == null) {
					Context.Items["hideStepNavigation"] = (bool?)CurrentPage.getCSSClass().Contains("hide-step-navigation");
				}
				return (bool)Context.Items["hideStepNavigation"];
			}
		}

		public bool HideFunelNavigation {
			get {
				if(Context.Items["hideFunelNavigation"] == null) {
					Context.Items["hideFunelNavigation"] = (bool?)CurrentPage.getCSSClass().Contains("hide-funel-navigation");
				}
				return (bool)Context.Items["hideFunelNavigation"];
			}
		}

		//// Field Helpers ////
		public bool isUnderRepeat(ISmartletField f) { 
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

		public ISmartletField getFieldFromControlInfo(ControlInfo ctrl) {
			return CurrentPage.findFieldById(ctrl.getFieldId());
		}
		public string getCustomControlPathForCurrentControl(String customControl){
			StringBuilder path = new StringBuilder("");
			if(customControl != null && !customControl.Equals("")) {
				string controlsPath = String.Concat("/controls/", customControl, ".aspx");
				controlsPath = resolvePath(controlsPath);
				log.trace(controlsPath);
				if (!customControl.Equals("") && !controlsPath.Equals("")) {
					path.Append(controlsPath);
				}
			}
			return path.ToString();
		}

		//// Utilities ///
		public void TimerTraceStart(string key) {
			Context.Items["timer-" + key] = DateTime.UtcNow;
		}

		public void TimerTraceStop(string key) {
			DateTime timerstart = (DateTime) Context.Items["timer-" + key];
			if(timerstart != null) {
				log.debug(String.Concat("Trace timer for :", key, ", duration = ", (DateTime.UtcNow - timerstart).TotalSeconds));
			} else {
				log.debug(String.Concat("Missing timer start for :", key));
			}
		}
	}
}