<%@ Page Language="C#" AutoEventWireup="true" CodeFile="equipment-return.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Return Equipment</title>

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

    <style>
        .equipmentReturn {
            color: #fff;
            background-color: #058989;
            font-size: 1.5em;
            padding:1em;
            border-radius:3px;
        }
    </style>

</head>


<body style="background-color:#fff;">
    <form runat="server">
        <asp:Button runat="server" text="Release Vehicle" ID="releaseVehicleButton" OnClick="releaseVehicleButton_Click" CssClass="equipmentReturn"/>
    </form>
</body>
</html>
