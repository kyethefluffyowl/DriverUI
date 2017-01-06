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

    protected void sendQRinfo_Click(object sender, EventArgs e)
    {
        if (textboxResult.Text == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "No QR Detected", "alert('No QR code was detected. Please try again.'); ", true);
        }
        if (textboxResult.Text != "")
        {
            DateTime currentDateTime = DateTime.Now;
            Session["sQRResult"] = textboxResult.Text.ToString();
            SqlConnection updateJobCompletion = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            using (updateJobCompletion)
            {
                updateJobCompletion.Open();

                //Taking our JQR 
                SqlCommand selectcmd = new SqlCommand("SELECT JQR FROM [Jobs] WHERE ([JobID] = @JobID)", updateJobCompletion);
                selectcmd.Parameters.AddWithValue("@JobID", (string)Session["jobID"]);
                string JQRString = selectcmd.ExecuteScalar().ToString();

                if ((string)Session["sQRResult"] == JQRString)
                {
                    //Updating Status to complete
                    SqlCommand cmd = new SqlCommand("UPDATE Jobs SET JStatus = @sStatus, JDriverActualCT = @mCurrentDateTime WHERE [JobID] = @sJobID;", updateJobCompletion);
                    cmd.Parameters.AddWithValue("@sStatus", "Completed");
                    cmd.Parameters.AddWithValue("@mCurrentDateTime", currentDateTime);
                    cmd.Parameters.AddWithValue("@sJobID", (string)Session["jobID"]);

                    //Calculating Duration driver took
                    SqlCommand cmdDriverDuration = new SqlCommand("SELECT JDriverDateStart FROM Jobs WHERE JobID = @sJobID", updateJobCompletion);
                    cmdDriverDuration.Parameters.AddWithValue("@sJobID", (string)Session["jobID"]);
                    string sDriverStartDate = cmdDriverDuration.ExecuteScalar().ToString();
                    DateTime driverStartDate = Convert.ToDateTime(sDriverStartDate);
                    double dDriverDuration = (currentDateTime - driverStartDate).TotalMinutes;
                    int driverDuration = Convert.ToInt32(dDriverDuration);
                    int roundingUpMins = driverDuration + 40; //Job rounds up when worker works 20mins OT
                    int roundingUpHours = roundingUpMins / 60;

                    SqlCommand cmdUpdateDriverDuration = new SqlCommand("UPDATE Jobs SET JDriverDuration = @mDuration WHERE JobID = @sJobID", updateJobCompletion);
                    cmdUpdateDriverDuration.Parameters.AddWithValue("@mDuration", roundingUpHours);
                    cmdUpdateDriverDuration.Parameters.AddWithValue("@sJobID", (string)Session["jobID"]);

                    //Executing all things
                    int QRresult0 = cmd.ExecuteNonQuery();
                    int QRresult1 = cmdUpdateDriverDuration.ExecuteNonQuery();
                    Session["statusCol"] = "Completed";

                } 
                else if ((string)Session["sQRResult"] != JQRString)
                {
                    Session["statusCol"] = "NotCompleted";
                }
                updateJobCompletion.Close();

            }
            if ((string)Session["statusCol"] == "Completed")
            {
                ClientScript.RegisterStartupScript(GetType(), "Refreshing Parent", "window.parent.location.href = window.parent.location.href;", true);
            }
            if ((string)Session["statusCol"] != "Completed")
            {
                ClientScript.RegisterStartupScript(GetType(), "Error", "alert('The QR data does not match with the database. Please try again or contact an admin.'); ", true);
            }
        }
    }
}