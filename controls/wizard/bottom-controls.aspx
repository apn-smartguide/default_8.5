<%@ Page Language="C#" autoeventwireup="true" CodeFile="../../SGWebCore.cs" Inherits="SGWebCore" Trace="false"%>
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
            <apn:control type="previous" runat="server" id="previous">
                <button type='submit' name='<apn:name runat="server"/>' class='btn btn-default'><%=GetAttribute(previous.Current, "label")%></button>
            </apn:control>
            <% } %>
        </div>
        <div class='pull-right'>
            <apn:control type="summary" runat="server" id="summary">
                <button type='submit' name='<apn:name runat="server"/>' class='btn btn-default'>
                    <%=GetAttribute(summary.Current, "label")%>
                </button>
            </apn:control>
            <apn:control type="return-save" runat="server" id="save">
                <button type='submit' name='<apn:name runat="server"/>' class='next btn btn-primary'>
                    <%=GetAttribute(save.Current, "label")%>
                </button>
            </apn:control>
            <apn:control type="return-cancel" runat="server" id="cancel">
                <button type='submit' name='<apn:name runat="server"/>' class='btn btn-default'>
                    <%=GetAttribute(cancel.Current, "label")%>
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
            <apn:control type="next" runat="server" id="next">
                <button type='submit' name='<apn:name runat="server"/>' class='next btn btn-primary'><%=GetAttribute(next.Current, "label")%></button>
            </apn:control>
            <% } %>
        </div>
    </div>
</div>