<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<%string test = "<strong>test-123'</strong>"; %>
text=<%=JavascriptEncode(test)%><br>
label=<label data-toggle="tooltip" data-html="true" title='<%=JavascriptEncode(test)%>'>label</label><br>
label=<label data-toggle="tooltip"  title='<strong>test&quot;</strong>'>label</label><br>
label=<label data-toggle="tooltip" data-html="true" title='<%=HttpUtility.HtmlEncode(test)%>'>label</label><br>

<button type="button" class="btn btn-secondary" data-toggle="tooltip" data-html="true" title="<em>Tooltip</em> <u>with</u> <b>HTML</b>">
	Tooltip with HTML
  </button>