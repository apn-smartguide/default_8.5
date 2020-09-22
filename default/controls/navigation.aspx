<%@ Page Language="C#" %>
<%@ Register Tagprefix="Apn" Namespace="Alphinat.SmartGuideServer.Controls" Assembly="apnsgscontrols" %>
<div class="row">
	<div class="col-xs-3">
		<apn:control type="previous" runat='server'>
            <input type="submit" name="<apn:name runat='server'/>" value="<apn:label runat='server'/>" class="pull-left btn btn-default" />
        </apn:control>
        &nbsp;
	</div>
    <div class="col-xs-6">
	<apn:control type="summary" runat='server'>
                <button type="submit" name="<apn:name runat='server'/>" class="btn btn-default">
                    <apn:label runat='server'/>
                </button>
            </apn:control>
	<apn:control type="return-save" runat='server'>
                <button type="submit" name="<apn:name runat='server'/>" class="next btn btn-primary">
                    <apn:label runat='server'/>
                </button>
            </apn:control>
	<apn:control type="return-cancel" runat='server'>
                <button type="submit" name="<apn:name runat='server'/>" class="btn btn-default">
                    <apn:label runat='server'/>
                </button>
            </apn:control>
    </div>	
	<div class="col-xs-3">
		<apn:control type="next" runat='server'>
            <input type="submit" name="<apn:name runat='server'/>" value="<apn:label runat='server'/>" class="next pull-right btn btn-primary" />
        </apn:control>
    </div>
</div>