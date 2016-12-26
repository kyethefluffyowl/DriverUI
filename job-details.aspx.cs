using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Description Tab
        JobDescPara.Text = (string)Session["jobDescCol"];

        //Respective Tabs
        LocationPara.Text = (string)Session["locationCol"];
        ETCPara.Text = (string)Session["driverDateEndCol"];
        StatusPara.Text = (string)Session["statusCol"];

        //Marking Status as complete
        if ((string)Session["statusCol"] == "Completed")
        {
            ClientScript.RegisterStartupScript(GetType(), "Hidingiframe", "document.getElementById('iframeQR').style.display = 'none';", true);
            QRStatus.Text = "Job Completed!";
        }
    }

    protected void SubmitMaint_Click(object sender, EventArgs e)
    {

        SqlConnection updateMaintenance = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            if (noMaintenance.Checked == true)
        {
            //send message to database saying no maintenance needed
        }
        if (selfMaintenance.Checked == true)
        {
            if (selfDesc.Text != "")
            { 
                string selfTextPost = selfDesc.Text.ToString();
                string equipID = "3"; //Need to select the actual EquipID being used

                using (updateMaintenance)
                {
                    updateMaintenance.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE Maintenance SET MRemarks = @mRemarks WHERE MEquipID = @mEquipID", updateMaintenance);
                    cmd.Parameters.AddWithValue("@mRemarks", selfTextPost.ToString());
                    cmd.Parameters.AddWithValue("@mEquipID", equipID.ToString());
                    int result = cmd.ExecuteNonQuery();
                    updateMaintenance.Close();
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "MissingFieldAlert", "alert('MissingField'); ", true);
                ClientScript.RegisterStartupScript(GetType(), "MaintenanceTab", "document.getElementById('MaintenanceTab').click();", true);
            }


        }
        if (outsourceMaintenance.Checked == true)
        {
            string selfTypePost = selfType.SelectedValue.ToString();
            string selfQtyPost = selfQty.SelectedValue.ToString();
            string selfDescPost = selfDesc.Text.ToString();
            //send the stuff to the database
        }
    }
}