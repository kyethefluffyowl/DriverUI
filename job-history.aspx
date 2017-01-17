<%@ Page Language="C#" AutoEventWireup="true" CodeFile="job-history.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Job History</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="css/simple-sidebar.css" rel="stylesheet"/>
    <link href="css/login-signup.css" rel="stylesheet" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
        .dateSelect {
            display:inline-block;
            border:none;
            border-bottom:3px solid #c6c6c6;
            border-radius:1px;
            font-size:1.2em;
            background-color:#efefef;
            color:#808080;
            -webkit-transition: 0.2s; /* Safari */
            transition: 0.2s;
            display:inline-block;
        }
        .dateSelect:focus {
            border-bottom:3px solid #008385;
        }

        .filterButton {
            background-color:#008385;
            color:white;
            border:none;    
            font-size:1.3em;
            padding:0.5em;
            -webkit-transition: 0.2s; /* Safari */
            transition: 0.2s;
        }
        .filterButton:hover {
            background-color:#00B9BC;
            border-radius:5px;
        }
        .filterButton:active {
            background-color:#00b9bc;
        }
        .labelDurationPrice {
            font-size:1.2em;
        }
    </style>

</head>

<body onload="autoDate">

    <form id="form1" runat="server">

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
                        <a href="#menu-toggle" id="menu-toggle"><img src="images/hamburger_menu.svg" /></a> <!--class="btn btn-default"-->

                        <h1>Job History</h1>
                        <!-- Date Selection -->
                        <div style="display:block; margin-bottom:2em;">
                            <div style="display:inline-block; margin-right: 1em;">
                                <p style="color:#008385; font-size:1.2em; font-weight:bold; margin:0;">Start Date</p>
                                <input type="date" id="dateStart" title="Start Date" class="dateSelect"/>
                            </div>
                            <div style="display:inline-block; margin-right: 1em;">
                                <p style="color:#008385; font-size:1.2em; font-weight:bold; margin:0;">End Date</p>
                                <input type="date" id="dateEnd" title="End Date" class="dateSelect"/>
                            </div>
                            <div style="display:inline-block;">
                                <asp:Button runat="server" ID="dateSelectSubmit" OnClick="dateSelectSubmit_Click" Text="Filter" CssClass="filterButton"/>
                            </div>
                        </div>

                        <asp:SqlDataSource ID="jobHistorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:fypdbConnectionStringJOBS %>" SelectCommand="SELECT * FROM [Jobs] WHERE ([JStatus] = @JStatus) AND ([JDriverID] = @driverID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="Completed" Name="JStatus" Type="String" />
                            <asp:SessionParameter Name="driverID" SessionField="driverID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                        <asp:SqlDataSource ID="jobHistoryWithDate" runat="server" ConnectionString="<%$ ConnectionStrings:fypdbConnectionStringJOBS %>" SelectCommand="SELECT * FROM Jobs WHERE ([JStatus] = 'Completed') AND (JDriverDateStart BETWEEN @mStartDate AND @mEndDate) AND ([JDriverID] = @driverID)">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="" Name="mStartDate" SessionField="dateStartSession" />
                                <asp:SessionParameter Name="mEndDate" SessionField="dateEndSession" />
                                <asp:SessionParameter Name="driverID" SessionField="driverID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="jobHistoryGridview" runat="server" DataSourceID="jobHistorySQL" OnRowDataBound="jobHistoryGridview_RowDataBound" AutoGenerateColumns="False" DataKeyNames="JobID" BorderStyle="None" GridLines="Horizontal" Width="100%" Font-Size="1em">
                        <AlternatingRowStyle BorderStyle="None" Font-Bold="False" Font-Size="1.3em" Height="1.5em" VerticalAlign="Middle" />
                            <Columns>
                            <asp:ButtonField Text="Select" CommandName="Select" ItemStyle-Width="" />
                            <asp:BoundField DataField="JobID" HeaderText="Job ID" InsertVisible="False" ReadOnly="True" SortExpression="JobID" />
                            <asp:BoundField DataField="JCustID" HeaderText="JCustID" SortExpression="JCustID" />
                            <asp:BoundField DataField="JDriverID" HeaderText="JDriverID" SortExpression="JDriverID" />
                            <asp:BoundField DataField="JDestination" HeaderText="Destination" SortExpression="JDestination" />
                            <asp:BoundField DataField="JTask" HeaderText="JTask" SortExpression="JTask" />
                            <asp:BoundField DataField="JDescription" HeaderText="JDescription" SortExpression="JDescription" />
                            <asp:BoundField DataField="JDriverDateStart" HeaderText="Start D/T" SortExpression="JDriverDateStart" />
                            <asp:BoundField DataField="JDriverDateEnd" HeaderText="JDriverDateEnd" SortExpression="JDriverDateEnd" />
                            <asp:BoundField DataField="JCustDateStart" HeaderText="JCustDateStart" SortExpression="JCustDateStart" />
                            <asp:BoundField DataField="JCustDateEnd" HeaderText="JCustDateEnd" SortExpression="JCustDateEnd" />
                            <asp:BoundField DataField="JStatus" HeaderText="JStatus" SortExpression="JStatus" />
                            <asp:BoundField DataField="JPayment" HeaderText="JPayment" SortExpression="JPayment" />
                            <asp:BoundField DataField="JDriverDuration" HeaderText="Job Hours" SortExpression="JDriverDuration" />
                            <asp:BoundField DataField="JCustDuration" HeaderText="JCustDuration" SortExpression="JCustDuration" />
                            <asp:BoundField DataField="JDriverActualCT" HeaderText="JDriverActualCT" SortExpression="JDriverActualCT" />
                            <asp:BoundField DataField="JCustPayPrice" HeaderText="JCustPayPrice" SortExpression="JCustPayPrice" />
                            <asp:BoundField DataField="JQR" HeaderText="JQR" SortExpression="JQR" />
                        </Columns>
                            <RowStyle BorderColor="#C1E1E1" BorderStyle="None" Font-Size="1.3em" Height="1.5em" VerticalAlign="Middle" />
                    </asp:GridView>
                        <asp:GridView ID="jobHistoryDateGridview" runat="server" AutoGenerateColumns="False" DataKeyNames="JobID" DataSourceID="jobHistoryWithDate" OnRowDataBound="jobHistoryDateGridview_RowDataBound" BorderStyle="None" GridLines="Horizontal" Width="100%" Font-Size="1em">
                <AlternatingRowStyle BorderStyle="None" Font-Bold="False" Font-Size="1.3em" Height="1.5em" VerticalAlign="Middle" />
                         <Columns>
                    <asp:ButtonField Text="Select" CommandName="Select" ItemStyle-Width="" />
                    <asp:BoundField DataField="JobID" HeaderText="Job ID" InsertVisible="False" ReadOnly="True" SortExpression="JobID" />
                    <asp:BoundField DataField="JCustID" HeaderText="JCustID" SortExpression="JCustID" />
                    <asp:BoundField DataField="JDriverID" HeaderText="JDriverID" SortExpression="JDriverID" />
                    <asp:BoundField DataField="JDestination" HeaderText="Destination" SortExpression="JDestination" />
                    <asp:BoundField DataField="JTask" HeaderText="JTask" SortExpression="JTask" />
                    <asp:BoundField DataField="JDescription" HeaderText="JDescription" SortExpression="JDescription" />
                    <asp:BoundField DataField="JDriverDateStart" HeaderText="Start D/T" SortExpression="JDriverDateStart" />
                    <asp:BoundField DataField="JDriverDateEnd" HeaderText="JDriverDateEnd" SortExpression="JDriverDateEnd" />
                    <asp:BoundField DataField="JCustDateStart" HeaderText="JCustDateStart" SortExpression="JCustDateStart" />
                    <asp:BoundField DataField="JCustDateEnd" HeaderText="JCustDateEnd" SortExpression="JCustDateEnd" />
                    <asp:BoundField DataField="JStatus" HeaderText="JStatus" SortExpression="JStatus" />
                    <asp:BoundField DataField="JPayment" HeaderText="JPayment" SortExpression="JPayment" />
                    <asp:BoundField DataField="JDriverDuration" HeaderText="Job Hours" SortExpression="JDriverDuration" />
                    <asp:BoundField DataField="JCustDuration" HeaderText="JCustDuration" SortExpression="JCustDuration" />
                    <asp:BoundField DataField="JDriverActualCT" HeaderText="JDriverActualCT" SortExpression="JDriverActualCT" />
                    <asp:BoundField DataField="JCustPayPrice" HeaderText="JCustPayPrice" SortExpression="JCustPayPrice" />
                    <asp:BoundField DataField="JQR" HeaderText="JQR" SortExpression="JQR" />
                </Columns>
                <RowStyle BorderColor="#C1E1E1" BorderStyle="None" Font-Size="1.3em" Height="1.5em" VerticalAlign="Middle" />
            </asp:GridView>

                        <!-- Total Duration and Pay -->
                        <div style="width:100%;">
                            <div style="margin: 2em auto; width:100%;">
                                <p style="text-align:left;"><span style="font-weight:bold; font-size:1.2em;">Hours Worked: </span><asp:Label runat="server" ID="totalDuration" CssClass="labelDurationPrice"></asp:Label> </p>
                                <p style="text-align:left;"><span style="font-weight:bold; font-size:1.2em;">Pay: $</span><asp:Label runat="server" ID="totalPay" CssClass="labelDurationPrice"></asp:Label></p>
                            </div>
                        </div>


                        <!--Transfer from the input field to c#-->
                        <div style="display:none;">
                            <asp:TextBox runat="server" id="dateStartText"></asp:TextBox>
                            <asp:TextBox runat="server" id="dateEndText" ></asp:TextBox>
                        </div>
                    </div>

                </div>
            </div>
            
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <script>
        var dateApp = {};
        var d, e, f;
        dateApp.dateSelectStart = d;
        dateApp.dateSelectEnd = e;

        document.getElementById('dateStart').onblur = function (e) {
            if (this.value != dateApp.dateSelectStart) {
                //set last value to current value
                dateApp.dateSelectStart = this.value;
                d = new Date(dateApp.dateSelectStart);
                d.setHours(12);
                //alert(d.toLocaleString());
                document.getElementById("<%=dateStartText.ClientID%>").value = d.toISOString();
            }
        };

        document.getElementById('dateEnd').onblur = function (e) {
            if (this.value != dateApp.dateSelectEnd) {
                //set last value to current value
                dateApp.dateSelectEnd = this.value;
                e = new Date(dateApp.dateSelectEnd);
                e.setHours(12);
                //alert(e.toLocaleString());
                document.getElementById("<%=dateEndText.ClientID%>").value = e.toISOString();
            }
        };

        //Menu Toggle Script
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });
    </script>

    </form>

</body>
</html>
