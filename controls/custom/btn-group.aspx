<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% if (control.Current.getAttribute("visible").Equals("false")) { %>
<!-- #include file="../hidden.inc" -->
<% } else if(IsPdf && control.Current.getCSSClass().Contains("hide-pdf")) { %>
<% } else { %>
<% Context.Items["btn-group"] = true; %>
<% string textAlignmentCSSClasses = GetTextAlignmentCSSClasses(control.Current.getCSSClass()); %>
<% string btnGroupClasses = textAlignmentCSSClasses.Length > 0 ? control.Current.getCSSClass().Replace(textAlignmentCSSClasses, "") : control.Current.getCSSClass(); %>
<% if (textAlignmentCSSClasses.Length > 0) { %>
<div class='<%=textAlignmentCSSClasses%>'>
<% } %>
<div id='div_<apn:name runat="server"/>' class="btn-group <%=btnGroupClasses%>" style='<apn:cssstyle runat="server"/>' role="group">
<% ExecutePath("/controls/custom/buttons.aspx"); %>
</div>
<% if (textAlignmentCSSClasses.Length > 0) { %>
</div>
<% } %>
<% Context.Items["btn-group"] = false; %>
<% } %>
</apn:control>

<script runat="server" lang="c#">
public string GetTextAlignmentCSSClasses(string ctrlCSSClasses) 
	{
		string result = "";

		string[] alignmentClasses = new string[] { "text-center", "text-left", "text-right"};

		// there can only be one type of text alignment so we take the last one
		foreach(string item in alignmentClasses) {
			if (ctrlCSSClasses.Contains(item))
				result = item;
		}

		return result;
	}
</script>