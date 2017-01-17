using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void releaseVehicleButton_Click(object sender, EventArgs e)
    {
        SqlConnection releaseVehicle = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

        using (releaseVehicle)
        {
            releaseVehicle.Open();
            SqlCommand cmdRelease = new SqlCommand("UPDATE Equipment SET Equipment.EAvailability = 'yes' FROM Equipment INNER JOIN JobItems ON Equipment.EquipID = JobItems.JItemEquipID WHERE JobItems.JItemjobID = @jobID", releaseVehicle);
            cmdRelease.Parameters.AddWithValue("@jobID", Session["jobID"]);
            cmdRelease.ExecuteNonQuery();

            releaseVehicle.Close();
        }
        ClientScript.RegisterStartupScript(GetType(), "Refreshing Parent", "window.parent.location.href = window.parent.location.href;", true);

    }
}