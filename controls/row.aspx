<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control"><div class="row"><apn:forEach runat="server"><apn:choosecontrol runat="server"><apn:whencontrol type="COL" runat="server"><% ExecutePath("/controls/col.aspx"); %></apn:whencontrol></apn:choosecontrol></apn:forEach></div></apn:control>