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
                    <input id="file-upload" style="display:none; visibility: hidden;" type="file" onchange="handleFiles(this.files); readURL(this); parseToText();" /> <!--Clicking on the image activates to choose a photo-->     
                    <!--Parsing the data from the canvas (below) to the text box-->
                    <div style="display:block;">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="textboxResult" Enabled="true" AutoPostBack="true" Width="5em"></asp:TextBox>
                        <asp:Label runat="server" ClientIDMode="Static" ID="labelResult" Text="" ></asp:Label>
                        <!--Old button-->
                        <!--<button id="resultTXTButton" onclick="document.getElementById('textboxResult').innerText = document.getElementById('result').innerHTML.toString()">Complete Job</button>-->
                    </div>
                    <div style="display:block">
                        <asp:Button runat="server" ID="sendQRinfo" OnClick="sendQRinfo_Click" OnClientClick="parseToText();" Text="COMPLETE JOB"/>
                        <asp:Label runat="server" ID="labelCompleteJob"></asp:Label>
                    </div>
                </div>
                <!--The image taken/ uploaded displays here-->
                <img id="showUploadImage" src="#" alt="Uploaded Image"/>

                <!--The Canvas Image Data Lives Here | These 3 lines are vvvvvv impt thx-->
                <div id="outdiv" style="display:none; height:auto;"></div> <!--Actual Canvas will be Drawn here in JS-->
                <asp:HiddenField runat="server" ID="result" ClientIDMode="Static"/> 
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:fypdbConnectionStringJOBS %>" SelectCommand="SELECT * FROM [Jobs] WHERE (([JQR] = @JQR) AND ([JobID] = @JobID))">
                    <SelectParameters>
                        <asp:SessionParameter Name="JQR" SessionField="sQRResult" Type="String" />
                        <asp:SessionParameter Name="JobID" SessionField="jobID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <!--Where the decoded result actually stays to parse to Canvas.-->
                <canvas id="qr-canvas"  style="display:none;" width="10" height="10" ></canvas> <!--Canvas to draw image in HTML-->
            </div>
        </div>
    </div>
    
    </form>
</body>

</html>
