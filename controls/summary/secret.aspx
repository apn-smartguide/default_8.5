<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
  <apn:ifnotcontrolvalid runat="server">
    <%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
    %>
    <a id='error_index_<%=Context.Items["errorIndex"]%>'></a>
  </apn:ifnotcontrolvalid>
  <div class='<apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
    <span><strong><apn:label runat="server" /></strong><br/>
    <% if ((!control.Current.getValue().Equals(""))  && (control.Current.getValue() != null)) { %> ******* <% } %> &nbsp;
    </span>
  </div>

</apn:control>