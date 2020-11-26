using System;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using com.alphinat.sg5;
public partial class _Default : System.Web.UI.Page 
{
    public void InitSG() {
        HttpBrowserCapabilities browser = Request.Browser;

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

        Context.Items["BrowserVersion"] = browser.Version;
        Context.Items["BrowserType"] = browser.Type;
        //Response.Headers.Add("Cache-Control", "no-store");
        //Response.Headers.Add("Pragma","no-cache");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
	private void Page_Error(object sender, EventArgs e)
	{
		ISmartletLogger log = sg5.Context.getLogger("default.aspx");
		log.debug("Application ERROR");
		Exception ex = Server.GetLastError();

		// The original error may have been wrapped in a HttpUnhandledException,
		// so we need to log the details of the InnerException.
		ex = ex.InnerException ?? ex;
		log.debug(ExceptionInfo(ex));

		Server.ClearError();
	}
    public int GetLineNumber(Exception ex)
    {
        var lineNumber = 0;
        const string lineSearch = ":line ";
        var index = ex.StackTrace.LastIndexOf(lineSearch);
        if (index != -1)
        {
            var lineNumberText = ex.StackTrace.Substring(index + lineSearch.Length);
            if (int.TryParse(lineNumberText, out lineNumber))
            {
            }
        }
        return lineNumber;
    }

    public string ExceptionInfo(Exception ex)
    {
        StackFrame stackFrame = (new StackTrace(ex, true)).GetFrame(0);
        return string.Format("At line {0} column {1} in {2}: {3} {4}{3}{5}  ",
           GetLineNumber(ex), stackFrame.GetFileColumnNumber(),
           stackFrame.GetMethod(), Environment.NewLine, stackFrame.GetFileName(),
           ex.Message);
	}
}