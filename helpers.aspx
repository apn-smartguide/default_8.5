<%@ Import Namespace="com.alphinat.xmlengine.interview.tag" %>
<script runat="server" language="c#">

	//Initialize the hierarchy of themes for asset reference priorities.
	//Provide an array of "theme" names from the Lowest -> Highest.
	//Last theme to have a positive asset hit will be the executed asset.
	//Asset can be any server side processed reference. (*.aspx, *.css, *.js, *.*)
	public void setThemeLocations(string[] locations) {
		Context.Items["theme-locations"] = locations;
		Context.Items["paths-dictionary"] = new Dictionary<string,string>();
	}
	
	//// Filepaths Helpers ////
	
	//Will provide the runniing basePath based on the current Workspace name.
	public string getBasePath() {
		return HttpContext.Current.Request.ApplicationPath + "/aspx/" + sg5.Smartlet.getWorkspace() + "/";
	}

	//Will return an empty string if the searched "asset" is not found at this Theme Location
	public string getThemePathForAsset(string themeLocation, string asset) {
		string path = getBasePath() + themeLocation + asset;
		//log.debug("checking for core path at: " + path);
		if(fileExists(path)){
			return path;
		}
		return "";
	}

	//This is the main helper to use to obtain the path to the asset in function of the configured theme locations.
	public string resolvePath(string asset) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		//log.debug("start resolvePath for: " + asset);
		Dictionary<string, string> pathsDictionary = (Dictionary<string, string>)Context.Items["paths-dictionary"];
		
		string filePath = "";
		string pathParams = "";

		if (!pathsDictionary.ContainsKey(asset)) {
			if(asset.Contains("?")) {
				pathParams = asset.Split('?')[1];
				asset = asset.Split('?')[0];
			}
			foreach(string themeLocation in (string[])Context.Items["theme-locations"]) {
				string path = getThemePathForAsset(themeLocation, asset);
				if(path != "") {
					filePath = path;
				}
			}
			pathsDictionary.Add(asset,filePath);

			if(filePath.Equals("")) {
				log.debug(getTheme() + ": path not found for " + asset);
			}
			if(pathParams.Length > 0) filePath = filePath + "?" + pathParams;
			log.trace(getTheme() + ": " + filePath);
		} else {
			pathsDictionary.TryGetValue(asset, out filePath);
		}
		return filePath;
	}

	//This help will build a path to the asset and append a cachebreak computed with a SHA-256 of the file content.
	//Usage is for links to ressources that will be loaded from the front-end. (*.css, *.js)
	public string cacheBreak(string url) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		if(Context.Items["cachebreak-dictionary"] == null) {
            Context.Items["cachebreak-dictionary"] = new Dictionary<string,string>();
		}
		string filePath = "";
        Dictionary<string, string> cacheBreakDictionary = (Dictionary<string, string>) Context.Items["cachebreak-dictionary"];
		if(!cacheBreakDictionary.ContainsKey(url)){
			filePath = resolvePath(url);
			if(!filePath.Equals("")) {
				try { 
					return filePath + "?cache=" + Utils.hashFile(Server.MapPath(filePath), "SHA-256");
				} catch (Exception e) {
					log.error("File not found: " + filePath + ", " + e.ToString());
				}
			}
			cacheBreakDictionary.Add(url, filePath);
		} else {
			cacheBreakDictionary.TryGetValue(url, out filePath);
		}
		return filePath;
	}

	//Check if file actually exists on disk.
	public Boolean fileExists(string path) {
		return System.IO.File.Exists(Server.MapPath(path));
	}

	//// Referencing other smartlets helpers ////
	public string getURLForSmartlet(string smartletName, string urlParams) {
		string smartletUrl = "do.aspx?interviewID=" + smartletName + "&workspace=" + getWorkspace() + "&lang=" + getCurrentLocale();
		if (!urlParams.Equals("")) {
			smartletUrl = smartletUrl + "&" + urlParams;
		}
		return smartletUrl;
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
		return sg5.Context.getSmartlet().getName();
	}

	public string getSmartletCode() {
		return sg5.Context.getSmartlet().getCode();
	}

	public string getCurrentLocale() {
		return sg5.Context.getSmartlet().getCurrentLocale();
	}

	public string getTheme() {
		return sg5.Smartlet.getTheme();
	}

	public string getWorkspace() {
		return sg5.Context.getSmartlet().getWorkspace();
	}

	//// Authentication Helpers ////
	public bool isLogged() {
		return (!getUsername().Equals(""));
	}
	
	public string getUsername() {
		return (Session["username"] != null) ? (string)Session["username"] : "";
	}

	public string getUserId() {
		return (Session["userid"] != null) ? (string)Session["userid"] : "";
	}

	public void setLogoutURL(string logoutURL) {
		Context.Items["logout-url"] = logoutURL; 
	}

	public string getLogoutURL() {
		return (string) Context.Items["logout-url"];
	}

	public string getLogoutURL(string urlParams) {
		return (string) Context.Items["logout-url"] + "&" + urlParams;
	}

	//// Smartlet Features Helpers ////
	public bool showWizard() {
		return sg5.Context.getSmartlet().getCurrentPage().getCSSClass().Contains("show-wizard");
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
		if(Context.Items["custom-control-dictionary"] == null) {
            Context.Items["custom-control-dictionary"] = new Dictionary<string,string>();
		}
		Dictionary<string, string> customControlDictionary = (Dictionary<string, string>) Context.Items["cachebreak-dictionary"];
		string code = ctrl.getFieldId();
		string path = "";
		if(!customControlDictionary.ContainsKey(code)){
			ISmartletField field = getFieldFromControlInfo(ctrl);
			string customControl = field.getNonLocalizedMetaData("Controls");
			string controlsPath = "/controls/" + customControl + ".aspx";
			if (!customControl.Equals("") && !resolvePath(controlsPath).Equals("")) {
				path = resolvePath(controlsPath);
			}
			customControlDictionary.Add(code, path);
		} else {
			customControlDictionary.TryGetValue(code, out path);
		}
		return path;
	}

	//// Utilities ///
	public void TimerTraceStart(string key) {
		Context.Items["timer-" + key] = DateTime.UtcNow;
	}

	public void TimerTraceStop(string key) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		var timerstart = (DateTime) Context.Items["timer-" + key];
		if(timerstart != null) {
			log.debug("Trace timer for :" + key + ", duration = " + (DateTime.UtcNow - timerstart).TotalSeconds);
		} else {
			log.debug("Missing timer start for :" + key);
		}
	}

</script>