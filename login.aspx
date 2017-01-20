<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login_signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Driver Login</title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1"/>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/login.css" rel="stylesheet"/>
    <link href="css/login_signup.css" rel="stylesheet"/>
    <link href="css/supersized.css" rel="stylesheet" />
    <link href="css/font-awesome.css" rel="stylesheet"/>

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

    <style>
        .textboxLoginDriver {
            border-color:#00B9BC;
            color:#006f6f;
        }
        .textboxLoginDriver:focus {
            border-color:#008385;
        }
        .driverLoginButton {
            border:none;
            background-color: #00B9BC;
            -webkit-transition-duration: 0.2s; /* Safari */
            transition-duration: 0.2s;
            border-radius:2px;
        }
        .driverLoginButton:hover {
            background-color:#008385;
            border-radius:0.2em;
        }
    </style>
</head>

<body style="width:100%; height:auto; background-color:#000;">
    
<!--Background-->
    
    <div class="form" style="background-color:#fff;">
        <div class="tab-content">
            <form runat="server">
                <div style="width:100%;">
                    <div style="width:100%; line-height:5em;">
                        <img style="width:5em; height:auto; display:inline-block; padding-top:1em; -webkit-filter:invert(1);" src="images/delivery-man.svg"/>
                        <p style="display:inline-block; color:#00B9BC ; font-size:2.5em; vertical-align:text-top; margin:0; margin-left:0.2em;">Driver login</p>
                    </div>
                </div>
                
                  <div class="">
                        <asp:TextBox ID="loginEmail" runat="server" placeholder="Email Address*" AutoCompleteType="Email" CssClass="textboxLoginDriver" TextMode="Email"></asp:TextBox>
                        <p><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="loginEmail" ErrorMessage="Please Enter Valid Email Address" ForeColor="Red"></asp:RequiredFieldValidator>  </p> 
                    </div>

                    <div class="">
                        <asp:TextBox ID="loginPassword" runat="server" placeholder="Password*" TextMode="Password" AutoCompleteType="None" CssClass="textboxLoginDriver" ></asp:TextBox>
                        <p> <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="loginPassword" ErrorMessage="Please Enter Valid Password" ForeColor="Red"></asp:RequiredFieldValidator>  </p>
                    </div>

                <div style="display:block; width:100%;">
                    <div style="display:block;">
                        <asp:button ID="LoginBtn" runat="server" Text="Login" OnClick="Login_Click" CssClass="driverLoginButton"/>
                    </div>
                </div>
                
                
          </form>

      </div>
  </div>


</body>

</html>
