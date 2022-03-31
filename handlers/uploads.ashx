<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Net;
using System.Web;
using System.IO;
using System.Web.Script.Serialization;

public class Upload : IHttpHandler {

	public void ProcessRequest (HttpContext context) {
		string json = "";
		context.Response.ContentType = "text/plain";
		foreach (string file in context.Request.Files)
		{
			var FileDataContent = context.Request.Files[file];
			if (FileDataContent != null && FileDataContent.ContentLength > 0)
			{
				// take the input stream, and save it to a temp folder using the original file.part name posted
				var stream = FileDataContent.InputStream;
				var fileName = Path.GetFileName(FileDataContent.FileName);
				var UploadPath = context.Server.MapPath("~/uploads");
				Directory.CreateDirectory(UploadPath);
				string path = Path.Combine(UploadPath, fileName);
				try
				{
					if (System.IO.File.Exists(path)) System.IO.File.Delete(path);
					using (var fileStream = System.IO.File.Create(path))
					{
						stream.CopyTo(fileStream);
					}

					//Send File details in a JSON Response.
					json = new JavaScriptSerializer().Serialize(new { name = fileName });
					context.Response.Write(json);
				}
				catch (IOException ex)
				{
					// handle
				}
			}
		}
		context.Response.StatusCode = (int)HttpStatusCode.OK;
		context.Response.ContentType = "text/json";
		context.Response.End();
	}

	public bool IsReusable {
		get {
			return false;
		}
	}
}