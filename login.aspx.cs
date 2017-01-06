using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class login_signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["sflag"] = "";
    }

    protected void Login_Click(object sender, EventArgs e)
    {
            SqlConnection DriverLogin = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            using (DriverLogin)
            {

                SqlCommand cmd = new SqlCommand("Select * from Drivers where DEmail= @DEmail and DPassword = @DPassword", DriverLogin);
                cmd.Parameters.AddWithValue("@DEmail", loginEmail.Text);
                cmd.Parameters.AddWithValue("@DPassword", loginPassword.Text);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                DriverLogin.Open();
                int i = cmd.ExecuteNonQuery();
                if (dt.Rows.Count > 0)
                {
                    SqlCommand cmd2 = new SqlCommand("SELECT DriverID FROM Drivers WHERE DEmail = @DEmail and DPassword = @DPassword", DriverLogin);
                    cmd2.Parameters.AddWithValue("@DEmail", loginEmail.Text);
                    cmd2.Parameters.AddWithValue("@DPassword", loginPassword.Text);
                    string driverSelectID = cmd2.ExecuteScalar().ToString();
                    DriverLogin.Close();

                    Session["driverID"] = driverSelectID;

                    Session["sflag"] = "in";
                    Response.Redirect("jobs.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "logintest", "alert('Please Try Again.'); ", true);
                }
            }
    }
}