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
        /*SqlConnection checkMaintenance = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        using (checkMaintenance)
        {
            checkMaintenance.Open();
            SqlCommand cmd = new SqlCommand("SELECT EquipID, EName FROM Equipment INNER JOIN JobItems ON Equipment.EquipID = JobItems.JItemEquipID WHERE (JobItems.JItemjobID = @jobID) AND (MEquipID NULL)", checkMaintenance);
            cmd.Parameters.AddWithValue("@jobID", Session["jobID"]);
            int result = cmd.ExecuteNonQuery();
            
            checkMaintenance.Close();
        }*/
        //Description Tab
        JobDescPara.Text = (string)Session["jobDescCol"];

        //Respective Tabs
        LocationPara.Text = (string)Session["locationCol"];
        ETCPara.Text = (string)Session["driverDateEndCol"];
        StatusPara.Text = (string)Session["statusCol"];

        //Marking Status as complete
        if ((string)Session["statusCol"] == "Completed")
        {
            ClientScript.RegisterStartupScript(GetType(), "hidingiframe", "document.getElementById('iframeQR').style.display = 'none';", true);
            QRStatus.Text = "Job Completed!";
        }

        if (!IsPostBack)
        {
            //First Time
            dropDownMaintenance.DataBind();
            int i = dropDownMaintenance.Items.Count;
            Session["intmary"] = i; //2
           // ClientScript.RegisterStartupScript(GetType(), "count", "alert('" + (int)Session["intmary"] + "');", true);
        }
        else if(IsPostBack)
        {
            int f = (int)Session["intmary"];
            int finalint = f - 1; //1
            Session["intmary"] = finalint;
            dropDownMaintenance.SelectedIndex = finalint;
            //ClientScript.RegisterStartupScript(GetType(), "count", "alert('wobololo " + (int)Session["intmary"] + "');", true);
        }
        if ((int)Session["intmary"] == 0)
        {
            maintainForm.Visible = false;
        }
    }

    protected void dropDownMaintenance_DataBound(object sender, EventArgs e)
    {
        
    }

    protected void SubmitMaint_Click(object sender, EventArgs e)
    {
        SqlConnection updateMaintenance = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

        //Selecting the value for the Vehicles being used
        string equipID = dropDownMaintenance.SelectedValue.ToString();

        //No Maintenance
        if (noMaintenance.Checked == true)
        {
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

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //try { string testEmpty = GridView1.Rows[0].Cells[0].Text.ToString(); if (testEmpty != "") { ClientScript.RegisterStartupScript(GetType(), "yay", "alert('its empty');", true); } }
        //catch { ClientScript.RegisterStartupScript(GetType(), "nay", "alert('not empty');", true); }
    }

}