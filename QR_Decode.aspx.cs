using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.SessionState;

public partial class QR_Decode_Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(GetType(), "HidingImageUpload", "document.getElementById('file-upload-picture').style.display = 'block';", true);
        ClientScript.RegisterStartupScript(GetType(), "HidingInputUpload", "document.getElementById('file-upload').style.display = 'block';", true);
        ClientScript.RegisterStartupScript(GetType(), "HidingImagePreviewPlaceholder", "document.getElementById('showUploadImage').style.display = 'block';", true);
        sendQRinfo.Visible = true;
        textboxResult.Visible = true;
        textboxResult.Attributes.Add("readonly", "readonly");
        labelCompleteJob.Text = "";
    }

    protected void button2_Click(object sender, EventArgs e)
    {
        //set the session variable to see if it'll keep it after postback
        Session["sQRMessageHi"] = labelUpdate.Text; //it's supposed to store "HI
        Response.Redirect("sesson_Test.aspx");

        //string QRData = labelUpdate.Text.ToString();
        //Session["sQRData"] = QRData.ToString();
        //labelUpdateTwice.Text = Session["sQRData"].ToString();

        //Doesnt work; Need to store it in session variable because of postback (which reloads the page)
        //string QRData = labelUpdate.Text.ToString();
        //labelUpdateTwice.Text = QRData.ToString();
    }

    protected void sendQRinfo_Click(object sender, EventArgs e)
    {
        if (textboxResult.Text == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "No QR Detected", "alert('No QR code was detected. Please try again.'); ", true);
        }
        if (textboxResult.Text != "")
        {
            
            Session["sQRResult"] = textboxResult.Text.ToString();
            SqlConnection updateJobCompletion = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            using (updateJobCompletion)
            {
                updateJobCompletion.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Jobs SET JStatus = @sStatus WHERE JobID = @sJobID" /*AND where QRResult equals to the QR sent?*/, updateJobCompletion);
                cmd.Parameters.AddWithValue("@sStatus", "Completed");
                cmd.Parameters.AddWithValue("@sJobID", (string)Session["jobID"]);
                int result = cmd.ExecuteNonQuery();
                updateJobCompletion.Close();
                Session["statusCol"] = "Completed";
            }
            if ((string)Session["statusCol"] == "Completed")
            {
                ClientScript.RegisterStartupScript(GetType(), "HidingImageUpload", "document.getElementById('file-upload-picture').style.display = 'none';", true);
                ClientScript.RegisterStartupScript(GetType(), "HidingInputUpload", "document.getElementById('file-upload').style.display = 'none';", true);
                ClientScript.RegisterStartupScript(GetType(), "HidingImagePreviewPlaceholder", "document.getElementById('showUploadImage').style.display = 'none';", true);
                sendQRinfo.Visible = false;
                textboxResult.Visible = false;
                labelCompleteJob.Text = "Job Completed";
            }
            if ((string)Session["statusCol"] != "Completed")
            {
                ClientScript.RegisterStartupScript(GetType(), "Error", "alert('Something went wrong while sending the information to the server. - 'sendQRinfo'); ", true);
            }
        }
    }
}