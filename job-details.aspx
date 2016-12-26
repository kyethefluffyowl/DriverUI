<%@ Page Language="C#" AutoEventWireup="true" CodeFile="job-details.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Job Details</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="css/simple-sidebar.css" rel="stylesheet"/>
    <link href="css/job-details.css" rel="stylesheet" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body onload="init">

    <div id="wrapper">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="#">
                        HupLeck Driver
                    </a>
                </li>
                <li>
                    <a href="jobs.aspx">Jobs</a>
                </li>
                <li>
                    <a href="job-history.aspx">History</a>
                </li>
                <li>
                    <a href="#">Emergency Contact</a>
                </li>
                <li>
                    <a href="#">Sign Out</a>
                </li>
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
        <div class="container-fluid">
        <div class="row">
        <div class="col-lg-12">
            <a href="#menu-toggle" id="menu-toggle"><img src="images/hamburger_menu.svg" /></a> <!--class="btn btn-default"-->
                <div class="form">
                    <ul class="tab">
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'JobDesc')" id="defaultOpen">Job Description</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Location')">Location</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'ETC')">ETC</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'QR')">QR</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Maintenance')">Maintenance</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Status')">Status</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Duration')">Duration</a></li>       
                    </ul>

                    <div id="JobDesc" class="tabcontent">
                      <h3>Job Description</h3>
                      <p>Who to meet.</p>
                    </div>
                    <div id="Location" class="tabcontent">
                      <h3>Location</h3>
                      <p>Location goes here</p>
                      <p>Google Map API goes here.</p>
                    </div>
                    <div id="ETC" class="tabcontent">
                      <h3>ETC</h3>
                      <p>Estimated Time of Completion</p>
                    </div>
                    <div id="QR" class="tabcontent">
                      <h3>Scan your QR Code</h3>
                      <p>QR Code thing goes here</p>
                    </div>
                    <div id="Maintenance" class="tabcontent">
                      <h3>Maintenance</h3>
                        <form runat="server" style="">
                           <div><asp:RadioButton runat="server" style="width:auto; display:inline-block;" id="noMaintenance" onclick="checkbox0()"/> 
                                <div style="display:inline-block"><asp:Label ForeColor="white" runat="server">No Maintenance</asp:Label></div></div>
                           <div><div><asp:RadioButton runat="server" style="width:auto; display:inline-block;" id="selfMaintenance" onclick="checkbox1()"/>
                                <div style="display:inline-block"><asp:Label ForeColor="white" runat="server">Self Maintenance</asp:Label></div></div>
                               <div style="display:block;">
                                   <div id="selfType" style="display:inline-block"><asp:DropDownList runat="server">
                                       <asp:ListItem>I001 Tyre</asp:ListItem>
                                       <asp:ListItem>I002 Battery</asp:ListItem>
                                       <asp:ListItem>I003 I'm supposed to get the data from the database</asp:ListItem>
                                   </asp:DropDownList></div>
                                   <div id="selfQty" style="display:inline-block"><asp:DropDownList runat="server">
                                       <asp:ListItem>1</asp:ListItem>
                                       <asp:ListItem>2</asp:ListItem>
                                       <asp:ListItem>3</asp:ListItem>
                                       <asp:ListItem>4</asp:ListItem>
                                   </asp:DropDownList></div>
                               </div>
                               <div id="selfDesc" style="display:block; width:100%;"><asp:TextBox runat="server" Width="100%" Height="3em"></asp:TextBox></div>
                            </div>
                           <div><div><asp:RadioButton runat="server" style="width:auto; display:inline-block;" id="outsourceMaintenance" onclick="checkbox2()"/>
                                <div style="display:inline-block"><asp:Label ForeColor="white" runat="server">Outsource Maintenance</asp:Label></div></div>
                               <asp:TextBox ID="outsourceText" runat="server" Width="100%" Height="3em"></asp:TextBox>
                           </div>
                            <asp:Button runat="server" /> <!--Need to find a way to just send data that is selected, not the entire thing-->
                        </form>
                    </div>
                    <div id="Status" class="tabcontent">
                      <h3>Status</h3>
                      <p>Status of job: Complete/ Incomplete</p>
                    </div>
                    <div id="Duration" class="tabcontent">
                      <h3>Duration</h3>
                      <p>Total Elapsed Time:</p>
                    </div>
                </div>
            </div></div></div></div>
        <!-- /#page-content-wrapper -->

        <script>
            var noMaintenance, self, selfType, selfQty, selfDesc, outsource, outsourceText;
            noMaintenance = document.getElementById("noMaintenance");
            self = document.getElementById("selfMaintenance");
            selfType = document.getElementById("selfType");
            selfQty = document.getElementById("selfQty");
            selfDesc = document.getElementById("selfDesc");
            outsource = document.getElementById("outsourceMaintenance");
            outsourceText = document.getElementById("outsourceText");

            function checkbox0() {
                    self.checked = false;
                    outsource.checked = false;
                    outsourceText.style.display = "none";
                    selfType.style.display = "none";
                    selfQty.style.display = "none";
                    selfDesc.style.display = "none";
            }
            function checkbox1() {
                    noMaintenance.checked = false;
                    outsource.checked = false;
                    outsourceText.style.display = "none";
                    selfType.style.display = "inline-block";
                    selfQty.style.display = "inline-block";
                    selfDesc.style.display = "block";
            }
            function checkbox2() {
                    noMaintenance.checked = false;
                    self.checked = false;
                    outsourceText.style.display = "block";
                    selfType.style.display = "none";
                    selfQty.style.display = "none";
                    selfDesc.style.display = "none";

            }

            function openTab(evt, tabName) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(tabName).style.display = "block";
                evt.currentTarget.className += " active";
            }

            // Get the element with id="defaultOpen" and click on it
            document.getElementById("defaultOpen").click();
            outsourceText.style.display = "none";
            selfType.style.display = "none";
            selfQty.style.display = "none";
            selfDesc.style.display = "none";

        </script>

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
      $("#menu-toggle").click(function(e) {
          e.preventDefault();
          $("#wrapper").toggleClass("toggled");
      });
      </script>
</body>
</html>
