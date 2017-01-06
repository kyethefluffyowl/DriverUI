<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login_signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Driver Login</title>

<link href="css/bootstrap.min.css" rel="stylesheet"/>
<link href="css/login.css" rel="stylesheet"/>

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body>
  
  <div class="row">
    <div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4">
      <div class="login-panel panel panel-default">
        <div class="panel-heading">Log in</div>
        <div class="panel-body">
          <form runat="server">
            <fieldset>
              <div class="form-group">
                                  <asp:TextBox ID="loginEmail" runat="server" placeholder="Email Address*" AutoCompleteType="Email"></asp:TextBox>
              <p> <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"   
                   ControlToValidate="loginEmail" ErrorMessage="Please Enter Valid Email Address"   
                    ForeColor="Red"></asp:RequiredFieldValidator>  </p> 
                
              </div>
              <div class="form-group">
                  <asp:TextBox ID="loginPassword" runat="server" placeholder="Password*" ></asp:TextBox>
               <p> <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"   
                    ControlToValidate="loginPassword" ErrorMessage="Please Enter Valid Password"   
                    ForeColor="Red"></asp:RequiredFieldValidator>  </p>
              </div>
              
              <asp:button ID="LoginBtn" runat="server" Text="Login" OnClick="Login_Click"/>
            </fieldset>
          </form>
        </div>
      </div>
    </div><!— /.col-->
  </div><!— /.row —>  
  
    

  <script src="js/jquery-1.11.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/chart.min.js"></script>
  <script src="js/chart-data.js"></script>
  <script src="js/easypiechart.js"></script>
  <script src="js/easypiechart-data.js"></script>
  <script src="js/bootstrap-datepicker.js"></script>
  <script>
    !function ($) {
      $(document).on("click","ul.nav li.parent > a > span.icon", function(){      
        $(this).find('em:first').toggleClass("glyphicon-minus");    
      }); 
      $(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
    }(window.jQuery);

    $(window).on('resize', function () {
      if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
    })
    $(window).on('resize', function () {
      if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
    })
  </script>  
</body>

</html>
