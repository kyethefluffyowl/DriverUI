<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QR_Decode.aspx.cs" Inherits="QR_Decode_Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>QR DECODE</title>
    <!--Decode From http://www.phpgang.com/how-to-decode-qr-code_344.html -->
    <script type="text/javascript" src="QR_Assets/llqrcode.js"></script>
    <script type="text/javascript" src="QR_Assets/webqr.js"></script>
    <script type="text/javascript" src="QR_Assets/jquery-2.2.4.min.js"></script>
    <!--The following script is fking important-->
    <script type="text/javascript">
        //BLESS THIS SITE: http://www.dotnetodyssey.com/2015/01/18/setget-value-label-control-asp-net-using-jquery/

        //SETTING THE LABEL
        function setLabelText(e) {
            e.preventDefault();  // To prevent postback
            var txtValue = $('#<%=result.ClientID%>').html(); //MAKE SURE ITS .HTML NOT .VAL
            $('#<%=labelUpdate.ClientID%>').html(txtValue);

            //assigning session variable (http://stackoverflow.com/questions/15519454/how-to-access-session-variables-and-set-them-in-javascript)
            '<%Session["sQRMessageHi"] = "' + txtValue '"; %>';


        }

        //GETTING THE VALUE FROM RESULTS --> POPUP ONE
        function getLabelText(e) {
            e.preventDefault(); // To prevent postback
            alert($('#<%=result.ClientID%>').html());
            document.write("txtvalue");
        }
        

    </script>

    <style>
        .alignInputPicture {width: auto; height:auto;}
        .custom-file-upload {background-image: url(http://image.flaticon.com/icons/svg/179/179436.svg); height:128px; width:auto; background-repeat:no-repeat; padding-bottom:1em;}
        /*Image 1: http://image.flaticon.com/icons/svg/164/164422.svg */
        /*Image 2: https://cdn0.iconfinder.com/data/icons/user-interface-49/64/Untitled-2-08-128.png */
        </style>

</head>

<body onload="load(); setimg();" >
    <form id="form1" runat="server">
    <div id="main" >
        <div id="mainbody" >
            <div style="display:flex; justify-content:flex-end; float:left;">
                <div style="display:inline-block;">
                    <!--Selecting a file-->
                    <label id="file-upload-picture" for="file-upload" class="custom-file-upload" style="height: 112px; display: block;"></label> <!--Showing an Image to click on-->
                    <input id="file-upload" type="file" onchange="handleFiles(this.files); readURL(this); parseToText();" style="display:none;"/> <!--Clicking on the image activates to choose a photo-->     
                    <!--Parsing the data from the canvas (below) to the text box-->
                    <div style="display:block;">
                        <asp:TextBox runat="server" ID="textboxResult" Enabled="true" AutoPostBack="true"></asp:TextBox>
                        
                        <!--Old button-->
                        <!--<button id="resultTXTButton" onclick="document.getElementById('textboxResult').innerText = document.getElementById('result').innerHTML.toString()">Complete Job</button>-->
                    </div>
                    <div style="display:block">
                        <asp:Button runat="server" ID="sendQRinfo" OnClick="sendQRinfo_Click" Text="COMPLETE JOB"/>
                        <asp:Label runat="server" ID="labelCompleteJob"></asp:Label>
                    </div>
                </div>
                <!--The image taken/ uploaded displays here-->
                <img id="showUploadImage" src="#" alt="Uploaded Image"/>

                <!--The Canvas Image Data Lives Here | These 3 lines are vvvvvv impt thx-->
                <div id="outdiv" style="display:none; height:auto;"></div> <!--Actual Canvas will be Drawn here in JS-->
                <asp:HiddenField runat="server" ID="result"/> <!--Where the decoded result actually stays to parse to Canvas.-->
                <canvas id="qr-canvas"  style="display:none;" width="10" height="10" ></canvas> <!--Canvas to draw image in HTML-->
            </div>
            

            

            <!--Popup--
            <asp:Button runat="server" ID="buttonClick" Text="PopUp Data" OnClientClick="getLabelText(event); return false;"  />
            -->
            <!--Setting label--
            <asp:Label ID="labelUpdate" runat="server" Text="zaqwxsecrbyhnimokpl"></asp:Label>
            <asp:Button runat="server" ID="button1" Text="Click to set" OnClientClick="setLabelText(event); return false;" />
            -->
            <!--Button 2 testing of session variable-
            <asp:Label ID="labelUpdateTwice" runat="server" Text="TWICE"></asp:Label>
            <asp:Button runat="server" ID="button2" Text="Click to update TWICE label based on update" OnClick="button2_Click" />

            <asp:Label ID="Label3" runat="server" Text="LABEL JAVASCRIPT WRITE PLS"></asp:Label>
            -->


        </div>
    </div>
    
    </form>
</body>

</html>
