<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:forEach id="control2" runat="server">
  <% if (control2.Current.getType() == com.alphinat.xmlengine.interview.tag.ControlInfo.GROUP) { %>
    <apn:ifnotcontrolvalid runat="server">
      <%
          int index = (int)Context.Items["errorIndex"];
          Context.Items["errorIndex"] = ++index;
          %>
      <a id='error_index_<%=Context.Items["errorIndex"]%>' />
    </apn:ifnotcontrolvalid>
    <div class='sgSummary <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
      <h4><apn:label runat="server" /><% if (!(control2.getCount() == 1 && control2.Last)) { %><%= control2.getCount() %><% } %></h4>
    </div>
    <% ExecutePath("/controls/summary/controls.aspx"); %>
  <% } %>
</apn:forEach>