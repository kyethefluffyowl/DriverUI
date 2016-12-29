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

    }

    protected void jobHistoryGridview_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        SqlConnection updateDriverHistoryView = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

        //hides the column but does not affect data extraction
        e.Row.Cells[0].Visible = false; // selecting row in case you wanna do anything with it
        e.Row.Cells[1].Visible = false; 
        e.Row.Cells[3].Visible = false;
        e.Row.Cells[5].Visible = false;
        e.Row.Cells[6].Visible = false;
        e.Row.Cells[8].Visible = false;
        e.Row.Cells[9].Visible = false;
        e.Row.Cells[10].Visible = false;
        e.Row.Cells[11].Visible = false;
        e.Row.Cells[12].Visible = false;
        e.Row.Cells[14].Visible = false;
        e.Row.Cells[15].Visible = false;

        using (updateDriverHistoryView)
        {
            updateDriverHistoryView.Open();
            //calculating total duration worked
            SqlCommand cmdDurationTotal = new SqlCommand("SELECT SUM(JDriverDuration) FROM Jobs WHERE JDriverID = @sDriverID AND JStatus = @sStatus;", updateDriverHistoryView);
            cmdDurationTotal.Parameters.AddWithValue("@sDriverID", (string)Session["driverID"]);
            cmdDurationTotal.Parameters.AddWithValue("@sStatus", "Completed");
            string sDriverDuration = cmdDurationTotal.ExecuteScalar().ToString();
            totalDuration.Text = sDriverDuration.ToString();

            //calculating total pay
            SqlCommand cmdDriverWage = new SqlCommand("SELECT DriverHourWage FROM Drivers WHERE DriverID = @sDriverID;", updateDriverHistoryView);
            cmdDriverWage.Parameters.AddWithValue("@sDriverID", (string)Session["driverID"]);
            string sDriverWage = cmdDriverWage.ExecuteScalar().ToString();
            decimal iDriverWage = Convert.ToDecimal(sDriverWage);
            int iDuration = Convert.ToInt32(sDriverDuration);
            decimal iTotalPay = iDriverWage * iDuration;
            totalPay.Text = String.Format("{0:0.00}", iTotalPay); //shows only 2dp

            updateDriverHistoryView.Close();
        }

    }

    protected void jobHistoryGridview_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string testingSession = jobHistoryGridview.SelectedRow.Cells[2].Text;
        //Session["testingSession"] = testingSession.ToString();
        ClientScript.RegisterStartupScript(GetType(), "sessionTest", "alert('Session yolobolo .'); ", true);

    }
}