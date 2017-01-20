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
        if ((string)Session["sflag"] != "in")
        {
            Response.Redirect("login.aspx");
        }

        //Tabs
        JobDescPara.Text = (string)Session["jobDescCol"];
        LocationPara.Text = (string)Session["locationCol"];
        ETCPara.Text = (string)Session["driverDateEndCol"];
        StatusPara.Text = (string)Session["statusCol"];
        equipmentCompleteLabel.Text = (string)Session["equipReturn"];

        //Marking Status as complete
        if ((string)Session["statusCol"] == "Completed")
        {
            ClientScript.RegisterStartupScript(GetType(), "hidingiframe", "document.getElementById('iframeQR').style.display = 'none';", true);
            QRStatus.Text = "Job Completed!";
        }

        
        //Equipment button invible when submitted
        try
        {
            SqlConnection checkEqp = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            using (checkEqp)
            {
                checkEqp.Open();
                SqlCommand checkEqpcmd = new SqlCommand("SELECT Equipment.EAvailability FROM Equipment INNER JOIN JobItems ON Equipment.EquipID = JobItems.JItemEquipID INNER JOIN Jobs ON JobItems.JItemjobID = Jobs.JobID WHERE Jobs.JobID = @jobID", checkEqp);
                checkEqpcmd.Parameters.AddWithValue("@jobID", Session["jobID"]);
                Session["equipReturn"] = checkEqpcmd.ExecuteScalar().ToString();
                checkEqp.Close();
            }
            if ((string)Session["equipReturn"] == "yes")
            {
                equipmentCompleteLabel.Text = "equipment submitted";
            }
            else if ((string)Session["equipReturn"] == "no")
            {
                equipmentCompleteLabel.Visible = false;
            }
        }
        catch
        {
            ClientScript.RegisterStartupScript(GetType(), "noequip", "alert('The equipment has been returned!');", true);
        }

        //Checking Maintenace if got fields or not. If not, means show the thing. If have, means hide the thing.
        try
        {
            SqlConnection checkMaint = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            using (checkMaint)
            {
                checkMaint.Open();
                SqlCommand checkMaintCmd = new SqlCommand("SELECT COUNT(JItemjobID) FROM JobItems WHERE JItemjobID = @jobID", checkMaint);
                checkMaintCmd.Parameters.AddWithValue("@jobID", Session["jobID"]);
                Session["MainCount"] = checkMaintCmd.ExecuteScalar().ToString();
                checkMaint.Close();
                //ClientScript.RegisterStartupScript(GetType(), "countMaint", "alert('Number of equipment --> "+(string)Session["MainCount"]+"');", true);
            }
        }
        catch
        {
            ClientScript.RegisterStartupScript(GetType(), "nomaint", "alert('Somehow crash');", true);
        }
        
        try
        {
            if (!IsPostBack)
            {
                //First Time
                dropDownMaintenance.DataBind();
                int i = dropDownMaintenance.Items.Count;
                Session["intmary"] = i; //2
                if (i == 0) //No equipments for this job
                {
                    ClientScript.RegisterStartupScript(GetType(), "nonononon", "alert('This job does not have any equipment to maintain.');", true);
                }
            }
            else if (IsPostBack)
            {
                int f = (int)Session["intmary"];
                int finalint = f - 1; //1
                Session["intmary"] = finalint;
                try
                {
                    dropDownMaintenance.SelectedIndex = finalint;
                }
                catch
                {
                    ClientScript.RegisterStartupScript(GetType(), "selectSelfMain", "alert('Please select a part to replace.');", true);
                    return;
                }
                dropDownMaintenance.SelectedIndex = finalint;

            }
            if ((int)Session["intmary"] == 0)
            {
                maintainForm.Visible = false;
            }
        }
        catch
        {
            ClientScript.RegisterStartupScript(GetType(), "selectSelfMain", "alert('Crash2.');", true);
        }
        /*
        */
    }

    protected void dropDownMaintenance_DataBound(object sender, EventArgs e)
    {
        
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //try { string testEmpty = GridView1.Rows[0].Cells[0].Text.ToString(); if (testEmpty != "") { ClientScript.RegisterStartupScript(GetType(), "yay", "alert('its empty');", true); } }
        //catch { ClientScript.RegisterStartupScript(GetType(), "nay", "alert('not empty');", true); }
    }


    protected void valSubMaint_Click(object sender, EventArgs e)
    {
        SqlConnection updateMaintenance = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

        //Selecting the value for the Vehicles being used
        string equipID = dropDownMaintenance.SelectedValue.ToString();

        //No Maintenance
        if (noMaintenance.Checked == true)
        {
            //ClientScript.RegisterStartupScript(GetType(), "SelfSelectTrue0", "alert('YOU SELECTED NO');", true);
            using (updateMaintenance)
            {
                updateMaintenance.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Maintenance (MEquipID, MInventID, MQtyUsed, MRemarks) VALUES(@mEquipID, @mInventID, @mQtyUsed, @mRemarks)", updateMaintenance);
                cmd.Parameters.AddWithValue("@mEquipID", equipID.ToString());
                cmd.Parameters.AddWithValue("@mInventID", "0");
                cmd.Parameters.AddWithValue("@mQtyUsed", "0");
                cmd.Parameters.AddWithValue("@mRemarks", "N.A.");

                int result = cmd.ExecuteNonQuery();
                updateMaintenance.Close();
            }
        }
        //Self Maintenance
        if (selfMaintenance.Checked == true)
        {
           // ClientScript.RegisterStartupScript(GetType(), "SelfSelectTrue1", "alert('YOU SELECTED SELF');", true);
            if (selfDesc.Text != "" && selfType.SelectedValue.ToString() != "selectTypeError")
            {
                string selfTypePost = selfType.SelectedValue.ToString();
                string selfQtyPost = selfQty.SelectedValue.ToString();
                string selfTextPost = selfDesc.Text.ToString();

                using (updateMaintenance)
                {
                    updateMaintenance.Open();

                    //Inserting new row into maintenance
                    SqlCommand cmdNewEntry = new SqlCommand("INSERT INTO Maintenance (MEquipID, MInventID, MQtyUsed, MRemarks) VALUES(@mEquipID, @mInventID, @mQtyUsed, @mRemarks)", updateMaintenance);
                    cmdNewEntry.Parameters.AddWithValue("@mEquipID", equipID.ToString());
                    cmdNewEntry.Parameters.AddWithValue("@mInventID", selfTypePost.ToString());
                    cmdNewEntry.Parameters.AddWithValue("@mQtyUsed", selfQtyPost.ToString());
                    cmdNewEntry.Parameters.AddWithValue("@mRemarks", selfTextPost.ToString());

                    //Deleting the inventory amount from Inventory Table
                    SqlCommand cmdInventoryManagement = new SqlCommand("SELECT IQty FROM Inventory WHERE InventoryID = @mInventID", updateMaintenance);
                    cmdInventoryManagement.Parameters.AddWithValue("@mInventID", selfTypePost.ToString());
                    string inventoryQuantity = cmdInventoryManagement.ExecuteScalar().ToString();
                    int intInventoryQuantity = Convert.ToInt32(inventoryQuantity);
                    int intQuantityUsed = Convert.ToInt32(selfQtyPost);
                    int remainingQty = intInventoryQuantity - intQuantityUsed;
                    SqlCommand cmdInventoryQtyUpdate = new SqlCommand("UPDATE Inventory SET IQty = @mRemainQty WHERE InventoryID = @mInventID", updateMaintenance);
                    cmdInventoryQtyUpdate.Parameters.AddWithValue("@mRemainQty", remainingQty);
                    cmdInventoryQtyUpdate.Parameters.AddWithValue("@mInventID", selfTypePost.ToString());

                    //Executing everything
                    int result3 = cmdInventoryQtyUpdate.ExecuteNonQuery();
                    int result4 = cmdNewEntry.ExecuteNonQuery();

                    updateMaintenance.Close();
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "MissingFieldAlert", "alert('There are missing fields. Please try again.'); ", true);
                ClientScript.RegisterStartupScript(GetType(), "MaintenanceTab", "document.getElementById('MaintenanceTab').click();", true);
            }
        }
        //Outsource Maintenance
        if (outsourceMaintenance.Checked == true)
        {
            //ClientScript.RegisterStartupScript(GetType(), "SelfSelectTrue2", "alert('YOU SELECTED OUT');", true);
            string OSTxt = outsourceText.Text.ToString();
            if (OSTxt != "")
            {
                using (updateMaintenance)
                {
                    updateMaintenance.Open();
                    SqlCommand cmdOS = new SqlCommand("INSERT INTO Maintenance (MEquipID, MInventID, MQtyUsed, MRemarks) VALUES(@mEquipID, @mInventID, @mQtyUsed, @mRemarks)", updateMaintenance);
                    cmdOS.Parameters.AddWithValue("@mEquipID", equipID);
                    cmdOS.Parameters.AddWithValue("@mInventID", "0");
                    cmdOS.Parameters.AddWithValue("@mQtyUsed", "0");
                    cmdOS.Parameters.AddWithValue("@mRemarks", "OS:" + OSTxt);

                    int result5 = cmdOS.ExecuteNonQuery();
                    updateMaintenance.Close();
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "MissingFieldAlert", "alert('Please state the issue for outsource repair.'); ", true);
            }
        }

    }

    protected void noMaintenance_CheckedChanged1(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(GetType(), "FRAN", "alert('Fran pls work'); ", true);
        maintainCompletedLabel.Text = "awretyuiyyytrs";
    }
}