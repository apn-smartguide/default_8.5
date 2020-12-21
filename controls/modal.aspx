<%@ Page Language="C#" autoeventwireup="true" CodeFile="../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
<apn:control runat="server" id="control">
  <% if (control.Current.getAttribute("visible").Equals("false")) { %>
  <!-- #include file="hidden.inc" -->
  <%} else {%>
  <% bool noLabel = (Request["bare_control"]!=null && ((string)Request["bare_control"]).Equals("true")); %>
  <% if (!noLabel){ %>
  <div class='modal' role='dialog' id='modal_<apn:name runat="server"/>'>
    <div class='modal-dialog <apn:cssclass runat="server"/>' style='<apn:cssstyle runat="server"/>' role='document'>
      <div class='modal-content'>
        <div class='modal-header'>
          <button type='button' class='close modal-close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
          <h4 class='modal-title'>
            <apn:label runat="server" />
          </h4>
        </div>
        <div class='modal-body'>
          <div id='div_<apn:name runat="server"/>' <% if(!control.Current.getAttribute("eventsource").Equals("")) { %>aria-live="polite" <% } %>>
            <div id="modalAlerts_<apn:name/>">
              <% Server.Execute(resolvePath("/controls/repeats/validation.aspx")); %>
            </div>
            <% Context.Items["context-modal"] = true; %>
            <% Server.Execute(resolvePath("/controls/controls.aspx")); %>
            <% Context.Items["context-modal"] = null; %>
          </div>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
  <% } %>
  <% } %>
</apn:control>