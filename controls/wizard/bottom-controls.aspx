<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../helpers.cs" Inherits="SGPage" Trace="false"%>
<%@ Import Namespace="com.alphinat.sgs.smartlet.session" %>
<div class="row">
    <div class="col-md-12">
        <div class="pull-left">
            <%
                SessionField previousBtn = (SessionField)sg.getSmartlet().getSessionSmartlet().getCurrentSessionPage().findFieldByName("previous");
                if(previousBtn != null) {
                    ISmartletField[] targets = previousBtn.getEventTarget();
                    string eventTargets = "";
                    if(targets != null) {
                        foreach(ISmartletField targetField in targets) {
                            if(targetField != null) {
                                eventTargets += targetField.getId() + ",";
                            }
                        }
                    }
            %>
            <span id='div_d_<%=previousBtn.getId()%>'>
                <button type='submit' name='d_<%=previousBtn.getId()%>' class='<%=previousBtn.getCSSClass()%>' style='<%=previousBtn.getCSSStyle()%>' data-eventtarget='[<%=eventTargets%>]'>
                    <%=previousBtn.getLabel()%>
                </button>
            </span>
            <% } else { %>
            <apn:control type="previous" runat="server">
                <button type='submit' name='<apn:name runat="server"/>' class='btn btn-default'><apn:label runat="server"/></button>
            </apn:control>
            <% } %>
        </div>
        <div class='pull-right'>
            <apn:control type="summary" runat="server">
                <button type='submit' name='<apn:name runat="server"/>' class='btn btn-default'>
                    <apn:label runat="server"/>
                </button>
            </apn:control>
            <apn:control type="return-save" runat="server">
                <button type='submit' name='<apn:name runat="server"/>' class='next btn btn-primary'>
                    <apn:label runat="server"/>
                </button>
            </apn:control>
            <apn:control type="return-cancel" runat="server">
                <button type='submit' name='<apn:name runat="server"/>' class='btn btn-default'>
                    <apn:label runat="server"/>
                </button>
            </apn:control>
            <%
            SessionField nextBtn = (SessionField)sg.getSmartlet().getSessionSmartlet().getCurrentSessionPage().findFieldByName("next");
            if(nextBtn != null) { 
                ISmartletField[] nextTargets = nextBtn.getEventTarget();
                string nextEventTargets = "";
                if(nextTargets != null) {
                    foreach(ISmartletField nextTargetField in nextTargets) {
                        if(nextTargetField != null) {
                            nextEventTargets += nextTargetField.getId() + ",";
                        }
                    }
                }
                %>
                <span id='div_d_<%=nextBtn.getId()%>'>
                    <button type='submit' name='d_<%=nextBtn.getId()%>' class='<%=nextBtn.getCSSClass()%>' style='<%=nextBtn.getCSSStyle()%>' data-eventtarget='[<%=nextEventTargets%>]'>
                        <%=nextBtn.getLabel()%>
                    </button>
                </span>
            <% } else { %>
            <apn:control type="next" runat="server">
                <button type='submit' name='<apn:name runat="server"/>' class='next btn btn-primary'><apn:label runat="server"/></button>
            </apn:control>
            <% } %>
        </div>
    </div>
</div>