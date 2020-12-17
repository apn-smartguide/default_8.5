<%@ Import Namespace="com.alphinat.xmlengine.interview.tag" %>
<script runat="server" language="c#">

	public void ClearCaches() {
		Context.Items["paths-dictionary"] = new Dictionary<string, string>();
		Context.Items["cachebreak-dictionary"] = new Dictionary<string, string>();
		Context.Items["custom-control-dictionary"] = new Dictionary<string, string>();
	}
	//Initialize the hierarchy of themes for asset reference priorities.
	//Provide an array of "theme" names from the Lowest -> Highest.
	//Last theme to have a positive asset hit will be the executed asset.
	//Asset can be any server side processed reference. (*.aspx, *.css, *.js, *.*)
	public void setThemeLocations(string[] locations) {
		Context.Items["theme-locations"] = locations;
	}
	
	//// Filepaths Helpers ////
	
	//Will provide the runniing basePath based on the current Workspace name.
	public string getBasePath() {
		if(Context.Items["basepath"] == null) {
			Context.Items["basepath"] = String.Concat(HttpContext.Current.Request.ApplicationPath, "/aspx/", sg5.Smartlet.getWorkspace(), "/");
		}
		return (string)Context.Items["basepath"];
	}

	//Will return an empty string if the searched "asset" is not found at this Theme Location
	public string getThemePathForAsset(string themeLocation, string asset) {
		string path = String.Concat(getBasePath(), themeLocation, asset);
		//log.debug("checking for core path at: " + path);
		if(fileExists(path)){
			return path;
		}
		return "";
	}

	//This is the main helper to use to obtain the path to the asset in function of the configured theme locations.
	public string resolvePath(string path) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
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
			foreach(string themeLocation in (string[])Context.Items["theme-locations"]) {
				string themePath = getThemePathForAsset(themeLocation, path);
				if(themePath != "") {
					filePath = themePath;
				}
			}
			pathsDictionary.Add(path, filePath);

			if(filePath.Equals("")) {
				log.debug(String.Concat(getTheme(), ": path not found for ", path));
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
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
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
		StringBuilder smartletUrl = new StringBuilder("do.aspx?interviewID=").Append(smartletName).Append("&workspace=").Append(getWorkspace()).Append("&lang=").Append(getCurrentLocale());
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

	//// Smartlet infos Helpers ////
	public string getSmartletName() {
		if(Context.Items["smartlet-name"] == null) {
			Context.Items["smartlet-name"] = sg5.Context.getSmartlet().getName();
		}
		return (string)Context.Items["smartlet-name"];
	}

	public string getSmartletCode() {
		if(Context.Items["smartlet-code"] == null) {
			Context.Items["smartlet-code"] = sg5.Context.getSmartlet().getCode();
		}
		return (string)Context.Items["smartlet-code"] ;
	}

	public string getCurrentLocale() {
		if(Context.Items["locale"] == null) {
			Context.Items["locale"] = sg5.Context.getSmartlet().getCurrentLocale();
		}
		return (string)Context.Items["locale"];
	}

	public string getTheme() {
		if(Context.Items["theme"] == null) {
			Context.Items["theme"] = sg5.Smartlet.getTheme();
		}
		return (string)Context.Items["theme"];
	}

	public string getWorkspace() {
		if(Context.Items["workspace"] == null) {
			Context.Items["workspace"] = sg5.Context.getSmartlet().getWorkspace();
		}
		return (string)Context.Items["workspace"];
	}

	public string getSmartletSubject() {
		//using the localized ressource, the API getSubject does not support localization.
		if(Context.Items["subject"] == null) {
			Context.Items["subject"] = sg5.getSmartlet().getSessionSmartlet().getLocalizedResource("smartlet.subject");
		}
		return (string)Context.Items["subject"];
	}

	public string getLastModificationDate() {
		double ticks = double.Parse(sg5.Context.getSmartlet().getCurrentPage().getLastModificationDate());
		TimeSpan time = TimeSpan.FromMilliseconds(ticks * 1000);
		DateTime startdate = new DateTime(1970, 1, 1) + time;
		return startdate.ToString("yyyy-MM-dd");
	}

	//// Authentication Helpers ////
	public bool isLogged() {
		return (!getUsername().Equals(""));
	}
	
	public string getUsername() {
		return (Session["username"] != null) ? (string) Session["username"] : "";
	}

	public string getUserId() {
		return (Session["userid"] != null) ? (string) Session["userid"] : "";
	}

	public void setLogoutURL(string logoutURL) {
		Context.Items["logout-url"] = logoutURL; 
	}

	public string getLogoutURL() {
		return (string) Context.Items["logout-url"];
	}

	public string getLogoutURL(string urlParams) {
		return String.Concat((string) Context.Items["logout-url"], "&", urlParams);
	}

	//// Smartlet Features Helpers ////
	public bool showWizard() {
		if(Context.Items["show-wizard"] == null) {
			Context.Items["show-wizard"] = sg5.Context.getSmartlet().getCurrentPage().getCSSClass().Contains("show-wizard");
		}
		return (bool)Context.Items["show-wizard"];
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
		return sg5.Context.getSmartlet().getCurrentPage().findFieldById(ctrl.getFieldId());
	}

	public string getCustomControlPathForCurrentControl(ControlInfo ctrl){
		string code = ctrl.getFieldId();
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		log.trace(String.Concat("getCustomControlPathForCurrentControl: ", ctrl.getCode()));

		if(Context.Items["custom-control-dictionary"] == null) {
            Context.Items["custom-control-dictionary"] = new Dictionary<string, string>();
		}
		Dictionary<string, string> customControlDictionary = (Dictionary<string, string>) Context.Items["custom-control-dictionary"];
		
		StringBuilder path = new StringBuilder("");
		if(!customControlDictionary.ContainsKey(code)){
			ISmartletField field = getFieldFromControlInfo(ctrl);
			string customControl = field.getNonLocalizedMetaData("Controls");
			string controlsPath = String.Concat("/controls/", customControl, ".aspx");
			if (!customControl.Equals("") && !resolvePath(controlsPath).Equals("")) {
				path.Append(resolvePath(controlsPath));
			}
			customControlDictionary.Add(code, path.ToString());
		} else {
			string newPath = "";
			customControlDictionary.TryGetValue(code, out newPath);
			path.Append(newPath);
			log.trace(String.Concat("getCustomControlPathForCurrentControl: ", ctrl.getCode(), " found in cache."));
		}
		return path.ToString();
	}

	//// Utilities ///
	public void TimerTraceStart(string key) {
		Context.Items["timer-" + key] = DateTime.UtcNow;
	}

	public void TimerTraceStop(string key) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		DateTime timerstart = (DateTime) Context.Items["timer-" + key];
		if(timerstart != null) {
			log.debug(String.Concat("Trace timer for :", key, ", duration = ", (DateTime.UtcNow - timerstart).TotalSeconds));
		} else {
			log.debug(String.Concat("Missing timer start for :", key));
		}
	}

</script>