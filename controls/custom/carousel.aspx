<%@ Page Language="C#" autoeventwireup="true" Inherits="SG.Theme.Core.WebPage" Trace="false"%>
<apn:control runat="server" id="control">
<% 
if (!IsAvailable(control)) {
  Execute("/controls/hidden.aspx");
} else if(IsPdf && control.IsHidePdf()) {
} else {
%>
    <apn:forEach runat="server" id="idkhowtonameit">
    </apn:forEach>

    <div id="demo" class="carousel slide" data-ride="carousel">

        <!-- Indicators -->
        <ul class="carousel-indicators">
            <apn:forEach runat="server" id="testt">
                <li data-target="#demo" data-slide-to='<%= testt.getCount() - 1 %>' <% if(testt.getCount() == 1){%> class="active"<%}%>></li>
            </apn:forEach>
        </ul>
      
        <!-- The slideshow -->
        <div class="carousel-inner">
          <div class="carousel-item active">
            <img src="https://source.unsplash.com/random/900x500">
          </div>
          <div class="carousel-item">
            <img src="https://source.unsplash.com/random/900x301">
          </div>
          <div class="carousel-item">
            <img src="https://source.unsplash.com/random/901x300">
          </div>
        </div>
      
        <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
          <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
          <span class="carousel-control-next-icon"></span>
        </a>
      
      </div>
<% } %>
</apn:control>