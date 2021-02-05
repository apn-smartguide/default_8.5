<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
    <apn:ifnotcontrolvalid runat="server">
        <%
        int index = (int)Context.Items["errorIndex"];
        Context.Items["errorIndex"] = ++index;
        %>
        <a id='error_index_<%=Context.Items["errorIndex"]%>'></a>
    </apn:ifnotcontrolvalid>
    <div class='row sgSummary <apn:ifnotcontrolvalid runat="server">has-error</apn:ifnotcontrolvalid>'>
        <div class='col-xs-6 sgLabel'>
            <span>
                <apn:label runat="server" /></span>
        </div>
        <div class='col-xs-6 sgValue'>
            <apn:value runat="server" tohtml="true" /> &nbsp;
        </div>
    </div>
</apn:control>