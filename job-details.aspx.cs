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
        
        //Need to select the actual EquipID being used; Forcing no 3 atm
        string equidID = "3"; 

        //No Maintenance
        if (noMaintenance.Checked == true)
        {
            using (updateMaintenance)
            {
                updateMaintenance.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Maintenance SET MRemarks = @mRemarks WHERE MEquipID = @mEquipID", updateMaintenance);
                cmd.Parameters.AddWithValue("@mRemarks", "N.A.");
                cmd.Parameters.AddWithValue("@mEquipID", equidID.ToString());
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

                    //Item needed for maintenance
                    SqlCommand cmdItem = new SqlCommand("UPDATE Maintenance SET MInventID = @mInventID WHERE MEquipID = @mEquipID", updateMaintenance);
                    cmdItem.Parameters.AddWithValue("@mInventID", selfTypePost.ToString());
                    cmdItem.Parameters.AddWithValue("@mEquipID", equidID.ToString());

                    //Quantity of selected item
                    SqlCommand cmdQty = new SqlCommand("UPDATE Maintenance SET MQtyUsed = @mQtyUsed WHERE MEquipID = @mEquipID", updateMaintenance);
                    cmdQty.Parameters.AddWithValue("@mQtyUsed", selfQtyPost.ToString());
                    cmdQty.Parameters.AddWithValue("@mEquipID", equidID.ToString());

                    //Details from textbox
                    SqlCommand cmdTxt = new SqlCommand("UPDATE Maintenance SET MRemarks = @mRemarks WHERE MEquipID = @mEquipID", updateMaintenance);
                    cmdTxt.Parameters.AddWithValue("@mRemarks", selfTextPost.ToString());
                    cmdTxt.Parameters.AddWithValue("@mEquipID", equidID.ToString());

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
                    int result0 = cmdItem.ExecuteNonQuery();
                    int result1 = cmdQty.ExecuteNonQuery();
                    int result2 = cmdTxt.ExecuteNonQuery();
                    int result3 = cmdInventoryQtyUpdate.ExecuteNonQuery();

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
                    SqlCommand cmdOS = new SqlCommand("UPDATE Maintenance SET MRemarks = @mRemarks WHERE MEquipID = @mEquipID", updateMaintenance);
                    cmdOS.Parameters.AddWithValue("@mRemarks", OSTxt);
                    cmdOS.Parameters.AddWithValue("@mEquipID", equidID.ToString());
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
}