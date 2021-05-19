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

using com.alphinat.sg;
using com.alphinat.sg5;
using com.alphinat.sgs;
using com.alphinat.sgs.smartlet;
using com.alphinat.sgs.smartlet.display;

public partial class _Default : SGWebCore
{
	protected void Page_Load(object sender, EventArgs e) {
		base.Load(sender, e);
	}

	protected void Page_Init(object sender, EventArgs e) {
		base.Init(sender,e);
	}

	protected void PreRender(object sender, EventArgs e) {
		base.PreRender(sender,e);
	}

	protected override void Render(HtmlTextWriter output) {
		base.Render(output);
	}

	private void Page_Error(object sender, EventArgs e)
	{
		base.Error(sender, e);
	}
}