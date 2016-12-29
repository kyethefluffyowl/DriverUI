<%@ Page Language="C#" AutoEventWireup="true" CodeFile="job-history.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Simple Sidebar - Start Bootstrap Template</title>

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

</head>

<body>

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

                        <h1>Job History</h1>
                        <p>Total Duration: <asp:Label runat="server" ID="totalDuration"></asp:Label> </p>
                        <p>Total Pay: <asp:Label runat="server" ID="totalPay"></asp:Label></p>


                    </div>
                    <asp:SqlDataSource ID="jobHistorySQL" runat="server" ConnectionString="<%$ ConnectionStrings:fypdbConnectionStringJOBS %>" SelectCommand="SELECT * FROM [Jobs] WHERE ([JStatus] = @JStatus)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="Completed" Name="JStatus" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="jobHistoryGridview" runat="server" DataSourceID="jobHistorySQL" OnRowDataBound="jobHistoryGridview_RowDataBound" OnSelectedIndexChanged="jobHistoryGridview_SelectedIndexChanged" AutoGenerateColumns="False" DataKeyNames="JobID">
                        <Columns>
                            <asp:ButtonField Text="Select" CommandName="Select" ItemStyle-Width="" />
                            <asp:BoundField DataField="JobID" HeaderText="JobID" InsertVisible="False" ReadOnly="True" SortExpression="JobID" />
                            <asp:BoundField DataField="JCustID" HeaderText="JCustID" SortExpression="JCustID" />
                            <asp:BoundField DataField="JDriverID" HeaderText="JDriverID" SortExpression="JDriverID" />
                            <asp:BoundField DataField="JDestination" HeaderText="JDestination" SortExpression="JDestination" />
                            <asp:BoundField DataField="JTask" HeaderText="JTask" SortExpression="JTask" />
                            <asp:BoundField DataField="JDescription" HeaderText="JDescription" SortExpression="JDescription" />
                            <asp:BoundField DataField="JDriverDateStart" HeaderText="JDriverDateStart" SortExpression="JDriverDateStart" />
                            <asp:BoundField DataField="JDriverDateEnd" HeaderText="JDriverDateEnd" SortExpression="JDriverDateEnd" />
                            <asp:BoundField DataField="JCustDateStart" HeaderText="JCustDateStart" SortExpression="JCustDateStart" />
                            <asp:BoundField DataField="JCustDateEnd" HeaderText="JCustDateEnd" SortExpression="JCustDateEnd" />
                            <asp:BoundField DataField="JStatus" HeaderText="JStatus" SortExpression="JStatus" />
                            <asp:BoundField DataField="JPayment" HeaderText="JPayment" SortExpression="JPayment" />
                            <asp:BoundField DataField="JDriverDuration" HeaderText="JDriverDuration" SortExpression="JDriverDuration" />
                            <asp:BoundField DataField="JCustDuration" HeaderText="JCustDuration" SortExpression="JCustDuration" />
                            <asp:BoundField DataField="JDriverActualCT" HeaderText="JDriverActualCT" SortExpression="JDriverActualCT" />
                        </Columns>
                    </asp:GridView>
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

    <!-- Menu Toggle Script -->
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    </script>

    </form>

</body>
</html>
