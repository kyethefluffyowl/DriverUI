<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AutoQR_Testing.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>autoQR&send</title>

    <!--|| This style is for the loading circle ||-->
    <style>
    #loader {
      position: absolute;
      left: 50%;
      top: 50%;
      z-index: 1;
      width: 150px;
      height: 150px;
      margin: -75px 0 0 -75px;
      border: 16px solid #f3f3f3;
      border-radius: 50%;
      border-top: 16px solid #3498db;
      width: 120px;
      height: 120px;
      -webkit-animation: spin 1s linear infinite;
      animation: spin 1s linear infinite;
    }

    @-webkit-keyframes spin {
      0% { -webkit-transform: rotate(0deg); }
      100% { -webkit-transform: rotate(360deg); }
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }


    #darkPage {
        position:absolute;
        top: 0;
        left: 0;
        z-index:0;
        width:100%;
        height: 100%;
        background-color: #000;
        filter:alpha(opacity=60);
        opacity: 0.6;
        display:none;
        }


    </style>
</head>

<body>

    <form runat="server">

        <!--|| This is the button in your form that submits the JQR. ||-->
        <asp:Button runat="server" Text="Send Email" ID="sendEmail" OnClick="sendEmail_Click" OnClientClick="showPage();"/>     

        <!--|| This is the loading circle and darkening the page ||-->
        <div id="loader" style="display:none;"></div>
        <div id="darkPage"></div>


        <!--|| This is for the loading circle.  ||-->
        <script>
            function showPage() {
                document.getElementById('darkPage').style.display = 'block';
                document.getElementById("loader").style.display = "inline-block";
        }
        </script>

    </form>
</body>
</html>
