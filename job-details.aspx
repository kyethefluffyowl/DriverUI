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


    <!-- QR CODE STUFF -->
    <script type="text/javascript" src="QR_Assets/llqrcode.js"></script>
    <script type="text/javascript" src="QR_Assets/webqr.js"></script>
    <script type="text/javascript" src="QR_Assets/jquery-2.2.4.min.js"></script>

     <script type="text/javascript">
         function setLabelText(e) {
             e.preventDefault();  // To prevent postback
             var txtValue = $('#<%=result.ClientID%>').html();
         } //MAKE SURE ITS .HTML NOT .VAL

        //GETTING THE VALUE FROM RESULTS --> POPUP ONE
        function getLabelText(e) {
            e.preventDefault(); // To prevent postback
            alert($('#<%=result.ClientID%>').html());
            document.write("txtvalue");
        }
    </script>

    <style>
        .alignInputPicture {width: auto; height:auto;}
        .custom-file-upload {height:128px; width:auto; padding-bottom:1em;}
    </style>

    <!--[END QR CODE HEADER STUFF]-->

</head>

<body onload="resumeTab(); load(); setimg();" style="overflow:hidden;">
    
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
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'JobDesc')" id="JobDescTab">Job Description</a></li>
                      <!--<asp:Label runat="server" id="testLabel" AssociatedControlID="testLabel" >No Session ):</asp:Label> -->
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'Location')" id="LocationTab">Location</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'ETC')" id="ETCTab">ETC</a></li>
                      <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'QR');" id="QRTab">QR</a></li>
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
                      <p>Google Map API goes here.</p>
                    </div>
                    <div id="ETC" class="tabcontent">
                      <h3>ETC</h3>
                      <asp:Label runat="server" ID="ETCPara" AssociatedControlID="ETCPara">Estimated Time of Completion</asp:Label>
                    </div>
                    <div id="QR" class="tabcontent">
                      <h3>Scan your QR Code</h3>
                        <!-- iFRAME IN CASE IT DOEST WORK -->
                        <!--
                        <iframe id="iframeQR" src="QR_Decode.aspx" style="width:100%; height:15em; overflow:hidden;"></iframe>
                        -->
                        <asp:Label runat="server" ID="QRStatus" BackColor="White"></asp:Label>

<!-- QR DECODE LIVES HERE NOW-->
                        <form id="Form1">
                            <div id="main" >
                                <div id="mainbody" >
                                        <div style="display:inline-block;">
                                            <!--Selecting a file-->
                                            <img id="file-upload-picture" class="custom-file-upload" src="http://image.flaticon.com/icons/svg/179/179436.svg" onclick="launchInput(); return false;"/>
                                            <input id="file-upload" type="file" onchange="handleFiles(this.files); readURL(this); parseToText();" style="display:none;"/> <!--Clicking on the image activates to choose a photo-->     
                                            <!--Parsing the data from the canvas (below) to the text box-->
                                            <div style="display:block;">
                                                <textbox runat="server" ID="textboxResult" Enabled="false" AutoPostBack="true"></textbox></div>
                                            <div style="display:block">
                                                <button runat="server" id="sendQRinfo" OnClick="sendQRinfo_Click" Text="COMPLETE JOB"/>
                                                <label runat="server" id="labelCompleteJob"></label>
                                            </div>
                                        </div>
                                        <!--The image taken/ uploaded displays here-->
                                        <img id="showUploadImage" src="#" alt="Uploaded Image"/>
                                        <!--The Canvas Image Data Lives Here | These 3 lines are vvvvvv impt thx-->
                                        <div id="outdiv" style="display:none; height:auto;"></div> <!--Actual Canvas will be Drawn here in JS-->
                                        <asp:HiddenField runat="server" ID="result"/> <!--Where the decoded result actually stays to parse to Canvas.-->
                                        <canvas id="qr-canvas"  style="display:none;" width="10" height="10" ></canvas> <!--Canvas to draw image in HTML-->
                                </div>
                            </div>
    
                            </form>
<!-- [QR DECODER ENDS HERE] -->

                    </div>
                    <div id="Maintenance" class="tabcontent">
                      <h3>Maintenance</h3>
                        <form id="Form2" runat="server" style="display:block;">
                            <div><asp:RadioButton runat="server" style="width:auto; display:inline-block;" id="noMaintenance" onclick="checkbox0()"/> 
                                <div style="display:inline-block"><asp:Label ForeColor="white" runat="server">No Maintenance</asp:Label></div></div>
                            <div>
                                <div>
                                    <asp:RadioButton runat="server" style="width:auto; display:inline-block;" id="selfMaintenance" onclick="checkbox1()"/>
                                    <div style="display:inline-block">
                                        <asp:Label ForeColor="white" runat="server">Self Maintenance</asp:Label>
                                    </div>
                                </div>
                                <div id="selfDetailsDIV" style="display:inline-block;">
                                     <div style="display:block;">
                                        <div style="display:inline-block"><asp:DropDownList ID="selfType" runat="server">
                                            <asp:ListItem Value="I001">I001 Tyre</asp:ListItem>
                                            <asp:ListItem Value="I002">I002 Battery</asp:ListItem>
                                            <asp:ListItem Value="I003">I003 I'm supposed to get the data from the database</asp:ListItem>
                                        </asp:DropDownList></div>
                                        <div style="display:inline-block"><asp:DropDownList ID="selfQty" runat="server">
                                            <asp:ListItem Value="1" >1</asp:ListItem>
                                            <asp:ListItem Value="2" >2</asp:ListItem>
                                            <asp:ListItem Value="3" >3</asp:ListItem>
                                            <asp:ListItem Value="4" >4</asp:ListItem>
                                            <asp:ListItem Value="5" >5</asp:ListItem>
                                        </asp:DropDownList></div>
                                    </div>
                                    <div style="display:block; width:100%;"><asp:TextBox runat="server" ID="selfDesc" Width="100%" Height="3em"></asp:TextBox></div>
                                </div>
                            </div>
                           <div>
                               <div>
                                    <asp:RadioButton runat="server" id="outsourceMaintenance" onclick="checkbox2()" style="width:auto; display:inline-block;" />
                                    <div style="display:inline-block">
                                        <asp:Label ForeColor="white" runat="server">Outsource Maintenance</asp:Label>
                                    </div>
                               </div>
                               <asp:TextBox ID="outsourceText" runat="server" Width="100%" Height="3em"></asp:TextBox>
                           </div>
                            <div style="float:right; font-size:0.5em; "><asp:Button runat="server" Text="Submit" OnClick="SubmitMaint_Click"/></div><!--Need to find a way to just send data that is selected, not the entire thing-->
                        </form>
                    </div>
                    <div id="Status" class="tabcontent">
                        <h3>Status</h3>
                        <p><asp:Label runat="server" ID="StatusPara"  AssociatedControlID="StatusPara"></asp:Label></p>
                    </div>
                    <div id="EqReturn" class="tabcontent">
                      <h3>Equipment Return</h3>
                      <p>Click the button to release the vehicle back into inventory.</p>
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

            function checkbox0() {
                    self.checked = false;
                    outsource.checked = false;
                    outsourceText.style.display = "none";
                    selfDetailsDIV.style.display = "none";
            }
            function checkbox1() {
                    noMaintenance.checked = false;
                    outsource.checked = false;
                    outsourceText.style.display = "none";
                    selfDetailsDIV.style.display = "initial";
            }
            function checkbox2() {
                    noMaintenance.checked = false;
                    self.checked = false;
                    outsourceText.style.display = "block";
                    selfDetailsDIV.style.display = "none";
            }

            function launchInput() {
                document.getElementById("file-upload").click();
                //alert("hello!");
            }



            var lastOpenedTab = $.session.set("NameofSession", "");

            function openTab(evt, tabName) {
                var i, tabcontent, tablinks, g;
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

                //This will run when a specific tab is clicked
//                if (document.getElementById(lastOpenedTab + 'Tab').id == "QRTab") {
//                    document.getElementById("form2Button").click();
//                }
//                if (document.getElementById(lastOpenedTab + 'Tab').id == "MaintenanceTab") {
//                    document.getElementById("form1Button").click();
//                }

            
            }

            function resumeTab() {

                if (lastOpenedTab == "")
                { document.getElementById("JobDescTab").click(); }
                if (lastOpenedTab != "") {
                document.getElementById($.session.get("NameofSession")).click();
                    //alert($.session.get("NameofSession"))

                }
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
