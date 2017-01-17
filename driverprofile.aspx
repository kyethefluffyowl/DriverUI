<%@ Page Language="C#" AutoEventWireup="true" CodeFile="driverprofile.aspx.cs" Inherits="driverprofile" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="css/simple-sidebar.css" rel="stylesheet"/>
    <link href="css/job-details.css" rel="stylesheet" />
     
</head>
<body>
		<div id="wrapper" class="toggled">

            <!-- Sidebar -->
            <div id="sidebar-wrapper">
                <ul class="sidebar-nav">
                    <li class="sidebar-brand">
                        <a href="#">HupLeck Driver</a>
                    </li>
                    <li>
                        <a href="jobs.aspx">Jobs</a>
                    </li>
                    <li>
                        <a href="job-history.aspx">History</a>
                    </li>
                    <li>
                        <a href="tel:97235397">Emergency Contact</a>
                    </li>
                    <li>
                        <a href="driverprofile.aspx">Profile</a>
                    </li>
                    <li>
                        <a href="signout.aspx">Sign Out</a>
                    </li>
                </ul>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
             <div id="page-content-wrapper">
                <div class="container-fluid">
                <div class="row">
                <div class="col-lg-12">
                    <a href="#menu-toggle" id="menu-toggle"><img src="images/hamburger_menu.svg" style="-webkit-filter:invert(1);" /></a> <!--class="btn btn-default"-->
                        <div class="form">
                            <form id="form1" runat="server">
                                <!-- Search for jobs table -->
		                        <div class="row">
			                        <div class="col-lg-12">
				                        <div class="panel panel-default">
					                        <div class="panel-heading">Change Password</div>
					                            <div class="panel-body">
						                        <!--insert table here --> 
                                                <!--end of insert table -->
					                            Enter new password :
                                                <asp:TextBox ID="tbpw" class="form-control" runat="server"></asp:TextBox>
                                                <br />
                                                <asp:Button ID="btnpw" class="form-control" runat="server" Text="Update Password" OnClick="btnpw_Click" />
                                                <br />
					                        </div>
				                        </div>
			                        </div>
		                        </div>
                            </form>
                        </div>
                    </div>
                </div>
                </div>
        </div>
        </div>
		

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:fypdbConnectionStringJOBS %>" SelectCommand="SELECT [StaffID], [SName], [SContact], [SAddress], [SEmail] FROM [Staff] WHERE ([StaffID] = @StaffID)" UpdateCommand="UPDATE Staff SET SName=@SName, SContact=@SContact, SAddress=@SAddress, SEmail=@SEmail WHERE ([StaffID] = @StaffID)">
        <SelectParameters>
            <asp:SessionParameter Name="StaffID" SessionField="StaffIDSession" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="SName" />
            <asp:Parameter Name="SContact" />
            <asp:Parameter Name="SAddress" />
            <asp:Parameter Name="SEmail" />
            <asp:Parameter Name="StaffID" />
        </UpdateParameters>
    </asp:SqlDataSource>

     <!-- jQuery -->
    <script src="js/jquery.js"></script>
    <script src="js/jquery.session.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
      $("#menu-toggle").click(function(e) {
          e.preventDefault();
          $("#wrapper").toggleClass("toggled");
      });

        // If job status says "Job completed", it'll hide the iframe
        if (document.getElementById('QRStatus').innerText != ""){
            document.getElementById('iframeQR').style.display = 'none';
        }



      var mq = window.matchMedia("(min-width: 768px)");

          if (mq.matches) {
              // if it's more than 768px
          }
          else {
              $("#wrapper").toggleClass("toggled");
          }
      </script>
</body>
</html>