using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class driverprofile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        }

    protected void btnpw_Click(object sender, EventArgs e)
    {

        SqlConnection newpw3 = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        using (newpw3)
        {
            newpw3.Open();
            SqlCommand cmd10 = new SqlCommand("SELECT DPassword FROM Drivers Update Drivers SET DPassword = @DriverPassword WHERE DriverID =@DriverID", newpw3);
            cmd10.Parameters.AddWithValue("@DriverPassword", tbpw.Text);
            cmd10.Parameters.AddWithValue("@DriverID", (string)Session["JDriverID"]);
            cmd10.ExecuteNonQuery();

            ClientScript.RegisterStartupScript(GetType(), "pw", "alert('Password Update Successful'); ", true);
            tbpw.Text = "";
            newpw3.Close();
        }
    }
}


