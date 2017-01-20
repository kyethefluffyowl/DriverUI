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

<body onload="resumeTab();">

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
                    <ul class="tab">
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'JobDesc')" id="JobDescTab">Job Description</a></li>
                      <!--<asp:Label runat="server" id="testLabel" AssociatedControlID="testLabel" >No Session ):</asp:Label> -->
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Location')" id="LocationTab">Location</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'ETC')" id="ETCTab">ETC</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'QR')" id="QRTab">QR</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Maintenance')" id="MaintenanceTab">Maintenance</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Status');" id="StatusTab">Status</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'EqReturn')" id="EqReturnTab">Equipment Return</a></li>      
                    </ul>

                    <div id="JobDesc" class="tabcontent">
                      <h3>Job Description</h3>
                      <asp:Label runat="server" ID="JobDescPara" AssociatedControlID="JobDescPara"></asp:Label>                       
                    </div>
                    <div id="Location" class="tabcontent">
                      <h3>Location</h3>
                      <asp:Label runat="server" ID="LocationPara" AssociatedControlID="LocationPara"></asp:Label>
                    </div>
                    <div id="ETC" class="tabcontent">
                      <h3>ETC</h3>
                      <asp:Label runat="server" ID="ETCPara" AssociatedControlID="ETCPara">Estimated Time of Completion</asp:Label>
                    </div>
                    <div id="QR" class="tabcontent">
                      <h3>Scan your QR Code</h3>
                        <iframe id="iframeQR" src="QR_Decode.aspx" frameborder="0" style="width:100%; height:15em; overflow:hidden; "></iframe>
                        <asp:Label runat="server" ID="QRStatus" BackColor="White"></asp:Label>
                    </div>
                    <div id="Maintenance" class="tabcontent">
                      <h3>Maintenance</h3>
                        
                        <asp:label runat="server" ID="maintainCompletedLabel" Text="You have successfully submitted the report." BackColor="White"></asp:label>
                        <form runat="server" id="maintainForm" style="">
                            <!-- Linking the dropdownlist to the database and grabbing out what relates to the job -->
                            <asp:SqlDataSource ID="dropDownMaintenanceSQL" runat="server" ConnectionString="<%$ ConnectionStrings:fypdbConnectionStringJOBS %>" SelectCommand="SELECT EquipID, EName FROM Equipment INNER JOIN JobItems ON Equipment.EquipID = JobItems.JItemEquipID WHERE (JobItems.JItemjobID = @jobID)" >
                            <SelectParameters>
                                <asp:SessionParameter Name="jobID" SessionField="jobID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:DropDownList Enabled="false" runat="server" ID="dropDownMaintenance" DataSourceID="dropDownMaintenanceSQL" DataTextField="EName" DataValueField="EquipID" OnDataBound="dropDownMaintenance_DataBound"></asp:DropDownList>
                            

                           <div class="button" style="background-color:#008b8b; font-variant:normal;" onclick="checkbox0();" id="noMaintenanceButton">
                               <!--NO MAINTENANCE-->
                               <div style="display:none;"><asp:RadioButton runat="server" ID="noMaintenance" GroupName="maintainGrp" Checked="true"/></div>
                                <div style="display:inline-block"><asp:Label ForeColor="white" runat="server">No Maintenance</asp:Label></div></div>
                           <div>
                               <div class="button" style="background-color:#008b8b; font-variant:normal;" onclick="checkbox1();" id="selfMaintenanceButton">
                                   <!--SELF MAINTENANCE-->
                                   <div style="display:none;"><asp:RadioButton runat="server" ID="selfMaintenance" GroupName="maintainGrp"/></div>
                                   <div style="display:inline-block">
                                       <asp:Label ForeColor="white" runat="server">Self Maintenance</asp:Label>
                                   </div>
                               </div>
                               <div id="selfDetailsDIV" style="display:inline-block; margin-bottom:1em;">
                                   <div style="display:block;">
                                       <div style="display:inline-block; font-size:1.2em; padding:0.3em;"><asp:DropDownList ID="selfType" runat="server">
                                           <asp:ListItem Selected="True" Value="selectTypeError">Select the item needed for maintenance.</asp:ListItem>
                                           <asp:ListItem Value="1">Industrial Engine</asp:ListItem>
                                           <asp:ListItem Value="7">Industrial Wire</asp:ListItem>
                                       </asp:DropDownList></div>
                                       <div style="display:inline-block; font-size:1.2em; padding:0.3em;"><asp:DropDownList ID="selfQty" runat="server">
                                           <asp:ListItem Selected="True" Value="1" >1</asp:ListItem>
                                           <asp:ListItem Value="2" >2</asp:ListItem>
                                           <asp:ListItem Value="3" >3</asp:ListItem>
                                           <asp:ListItem Value="4" >4</asp:ListItem>
                                           <asp:ListItem Value="5" >5</asp:ListItem>
                                           <asp:ListItem Value="6" >6</asp:ListItem>
                                       </asp:DropDownList></div>
                                   </div>
                                   <div style="display:block; width:100%; margin-bottom:1em;"><asp:TextBox runat="server" ID="selfDesc" Width="100%" Height="3em" ForeColor="DarkCyan"></asp:TextBox></div>
                               </div>
                           </div>
                           <div>
                               <div class="button" style="background-color:#008b8b; font-variant:normal;" onclick="checkbox2();" id="osMaintenanceButton">
                                   <!--OS MAINTENANCE-->
                                    <div style="display:none;"><asp:RadioButton runat="server" ID="outsourceMaintenance" GroupName="maintainGrp"/></div>
                                    <div style="display:inline-block">
                                        <asp:Label ForeColor="white" runat="server">Outsource Maintenance</asp:Label>
                                    </div>
                               </div>
                               <asp:TextBox runat="server" ID="outsourceText" Width="100%" Height="3em" ForeColor="DarkCyan"></asp:TextBox>
                           </div>
                            <div style="float:right; font-size:0.5em; background-color:#008b8b; margin:1.2em 0; ">
                                <asp:Button runat="server" Text="Submit" ID="valSubMaint" OnClick="valSubMaint_Click"/>
                            </div>
                        </form>
                    </div>
                    <div id="Status" class="tabcontent">
                        <h3>Status</h3>
                        <p><asp:Label runat="server" ID="StatusPara"  AssociatedControlID="StatusPara"></asp:Label></p>
                    </div>
                    <div id="EqReturn" class="tabcontent">
                      <h3>Equipment Return</h3>
                      <p>Click the button to release the vehicle back into inventory.</p>
                        <iframe id="iframeEquipment" src="equipment-return.aspx" frameborder="0" style="width:100%; height:5em; overflow:hidden;"></iframe>
                        <asp:Label runat="server" ID="equipmentCompleteLabel" BackColor="White" Text="no"></asp:Label>
                    </div>
                </div>
        </div>
        </div>
        </div>
        </div>
        <!-- /#page-content-wrapper -->

        <script>
            var noMaintenance, self, selfTypeDIV, selfQtyDIV, selfDescDIV, outsource, outsourceText;
            noMaintenance = document.getElementById("noMaintenance");
            self = document.getElementById("selfMaintenance");
            selfTypeDIV = document.getElementById("selfTypeDiv");
            selfQtyDIV = document.getElementById("selfQtyDIV");
            selfDescDIV = document.getElementById("selfDescDIV");
            outsource = document.getElementById("outsourceMaintenance");
            outsourceText = document.getElementById("outsourceText");

            function checkbox0() { //No Maintenance
                document.getElementById('noMaintenance').checked = true;
                document.getElementById('noMaintenanceButton').style.backgroundColor = "#005555 ";
                document.getElementById('selfMaintenanceButton').style.backgroundColor = "#008b8b ";
                document.getElementById('osMaintenanceButton').style.backgroundColor = "#008b8b ";
                outsourceText.style.display = "none";
                selfDetailsDIV.style.display = "none";
            }
            function checkbox1() {//Self Maintenance
                document.getElementById('selfMaintenance').checked = true;
                document.getElementById('noMaintenanceButton').style.backgroundColor = "#008b8b ";
                document.getElementById('selfMaintenanceButton').style.backgroundColor = "#005555 ";
                document.getElementById('osMaintenanceButton').style.backgroundColor = "#008b8b ";
                outsourceText.style.display = "none";
                selfDetailsDIV.style.display = "block";
            }
            function checkbox2() {//OS Maintenance
                document.getElementById('outsourceMaintenance').checked = true;
                document.getElementById('noMaintenanceButton').style.backgroundColor = "#008b8b ";
                document.getElementById('selfMaintenanceButton').style.backgroundColor = "#008b8b ";
                document.getElementById('osMaintenanceButton').style.backgroundColor = "#005555 ";
                outsourceText.style.display = "block";
                selfDetailsDIV.style.display = "none";
            }

            var lastOpenedTab = $.session.set("NameofSession", "");

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

                lastOpenedTab = tabName;
                $.session.set("NameofSession", lastOpenedTab + "Tab");
                
            }

            function resumeTab() {
                var delay = 1000;
                if (lastOpenedTab == "")
                { document.getElementById("JobDescTab").click(), delay; }
                if (lastOpenedTab != "") {
                document.getElementById($.session.get("NameofSession")).click();
                    //alert($.session.get("NameofSession"))
                }
                document.getElementById("noMaintenance").click(), delay;
            }

            // Get the element with id="JobDescTab" and click on it
            //document.getElementById("JobDescTab").click();
            outsourceText.style.display = "none";
            selfDetailsDIV.style.display = "none";


        </script>

    </div>
    <!-- /#wrapper -->

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
