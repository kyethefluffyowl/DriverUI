<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testingPage.aspx.cs" Inherits="testingPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>testing page</title>
    <script src="js/jquery.js"></script>
    <script src="js/jquery.session.js"></script>
    <style type="text/css">
        .outerbox {
            width:90%;
            border: 1px solid white;
            box-shadow: #9c9c9c 3px 3px 10px;
            min-height:5em;
            margin:2em auto;
        }
        .innerbox {
            width:90%;
            margin: 1em auto;
            border: 2px solid green;
            min-height:3em;
        }
        .parabox {
            font-size:3em;
            color:#808080;
            margin: 0.5em;
        }
        .displayblock {
            display:block;
        }
        .displayinlineblock{
            display:inline-block;
        }

    </style>

<script type="text/javascript">

function CreateDivElement() {

    var d = document;
    var maindiv = d.getElementById("maindiv");

    //JobID Value
    var jobIDValuebox = d.createElement('p');
    jobIDValuebox.setAttribute("class", "displayinlineblock");
    jobIDValuebox.innerHTML = "Value";

    //JobIDLabel
    var jobIDbox = d.createElement('p');
    jobIDbox.setAttribute("class", "parabox");
    jobIDbox.setAttribute("style", "display:inline-block;");
    jobIDbox.innerHTML = "Job ID:";

    //jobbox
    var jobbox = d.createElement('div');
    jobbox.setAttribute("class", "displayblock")

    // innerbox
    var innerbox = d.createElement('div');
    innerbox.setAttribute("class", "innerbox");

    // Outerbox
    var outerbox = d.createElement('div');
    outerbox.setAttribute("class", "outerbox");

    jobbox.appendChild(jobIDbox); // Put jobIDvalue into jobbox
    jobbox.appendChild(jobIDValuebox); // Put jobIDlabel into jobbox
    innerbox.appendChild(jobbox); // Put jobID into jobbox
    outerbox.appendChild(innerbox); // Put innerbox in outerbox
    maindiv.appendChild(outerbox); // put outerbox to the page

}

</script>
</head>

<body onload="CreateDivElement();">
    <div>
        <input id="myBtn" type="button" value="Click Me" onclick="CreateDivElement();" />
    </div>
    <div id="maindiv">

    </div>
</body>

</html>