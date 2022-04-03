using System;
using System.Web;
using System.Web.UI;

using SG.Theme.Core;

public partial class _Default : WebPage
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