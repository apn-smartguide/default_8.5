<%@ Import Namespace="com.alphinat.sg5" %>
<script runat="server">
	public string getBasePath() {
		return HttpContext.Current.Request.ApplicationPath + "/aspx/" + sg5.Smartlet.getWorkspace() + "/";
	}

	public void setThemeLocations(string[] locations) {
		Context.Items["theme-locations"] = locations;
 	}

	//Will return an empty string if the Assest is not found at this Theme Location
	public string getThemePathForAsset(string themeLocation, string asset) {
		string path = getBasePath() + themeLocation + asset;
		//log.debug("checking for core path at: " + path);
		if(fileExists(path)){
			return path;
		}
		return "";
	}

	public string resolvePath(string asset) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		//log.debug("start resolvePath for: " + asset);
		string filePath = "";
		string pathParams = "";

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

		if(filePath.Equals("")) {
			log.debug(getTheme() + ": path not found for " + asset);
		}
		if(pathParams.Length > 0) filePath = filePath + "?" + pathParams;
		log.trace(getTheme() + ": " + filePath);
		return filePath;
	}

	public Boolean fileExists(string path) {
		return System.IO.File.Exists(Server.MapPath(path));
	}
	public string cacheBreak(string url) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		string filePath = resolvePath(url);
		if(!filePath.Equals("")) {
			try { 
				return filePath + "?cache=" + Utils.hashFile(Server.MapPath(filePath), "SHA-256");
			} catch (Exception e) {
				log.error("File not found: " + filePath + ", " + e.ToString());
			}
		}
		return "";
	}

	public bool showWizard() {
		return sg5.Context.getSmartlet().getCurrentPage().getCSSClass().Contains("show-wizard");
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
</script>