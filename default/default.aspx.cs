using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using com.alphinat.sg5;
using com.alphinat.sgs;
using com.alphinat.sgs.smartlet;
using com.alphinat.sgs.smartlet.display;

public partial class _Default : SGWebCore
{
    protected void Page_Load(object sender, EventArgs e) {
        if(Request.QueryString["cache"] != null && Request.QueryString["cache"].Equals("reset")){
            ClearCaches();
        }

        HttpBrowserCapabilities browser = Request.Browser;
        
        Context.Items["optionIndex"] = "";
        Context.Items["javascript"] = ""; // injected javascript via designer using custom javascript control, rendered at end of page

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

        Context.Items["BrowserVersion"] = browser.Version;
        Context.Items["BrowserType"] = browser.Type;

    }

	private void Page_Error(object sender, EventArgs e)
	{
		ISmartletLogger log = sg5.Context.getLogger("Page_Error");
		//log.debug("Application ERROR");
		//Exception ex = Server.GetLastError();

		// The original error may have been wrapped in a HttpUnhandledException,
		// so we need to log the details of the InnerException.
		//ex = ex.InnerException ?? ex;
		//log.debug(ExceptionInfo(ex));
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