<%@ Import Namespace="com.alphinat.sg5" %>
<script runat="server">
	public string getBasePath() {
		return HttpContext.Current.Request.ApplicationPath + "/aspx/" + sg5.Smartlet.getWorkspace() + "/";
	}
	public string resolvePath(string asset) {
		ISmartletLogger log = sg5.Context.getLogger("helpers.aspx");
		//log.debug("start resolvePath for: " + asset);
		string filePath = "";
		string path = "";
		string pathParams = "";

		if(asset.Contains("?")) {
			pathParams = asset.Split('?')[1];
			asset = asset.Split('?')[0];
		}

		//try getting ressource from CORE 1st.
		path = getBasePath() + "default_8.5" + asset;
		//log.debug("checking for core path at: " + path);
		if(fileExists(path)){
			filePath = path;
		}
		//Then try relative from current page, if it exist, it will override.
		path = Page.TemplateSourceDirectory + "/.." + asset;
		//log.debug("checking for relative path at: " + path);
		if(fileExists(path)){
			filePath = path;
		}
		//Then try relative to workspace/theme running (i.e. theme override)
		path = getBasePath() + sg5.Smartlet.getTheme() + asset;
		//log.debug("checking for theme path at: " + path);
		if(fileExists(path)){
			filePath = path;
		} 
		if(filePath.Equals("")) {
			log.debug("path not found for " + asset);
		}
		if(pathParams.Length > 0) filePath = filePath + "?" + pathParams;
		return filePath;
	}

	public Boolean fileExists(string path) {
		return System.IO.File.Exists(Server.MapPath(path));
	}
	public string cacheBreak(string url) {
		string filePath = resolvePath(url);
		if(!filePath.Equals("")) {
			return filePath + "?cache=" + Utils.hashFile(Server.MapPath(filePath), "SHA-256");
		}
		return "";
	}
</script>