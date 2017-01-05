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
        e.Row.Cells[16].Visible = false;
        e.Row.Cells[17].Visible = false;
        if ((string)Session["driverID"] != "")
        {
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
        if ((string)Session["driverID"] == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "DriverID Error", "alert('There is no driver ID'); ", true);
        }

    }

    protected void jobHistoryGridview_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string testingSession = jobHistoryGridview.SelectedRow.Cells[2].Text;
        //Session["testingSession"] = testingSession.ToString();
        //ClientScript.RegisterStartupScript(GetType(), "sessionTest", "alert('Session yolobolo .'); ", true);
    }


    protected void dateSelectSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection updateDriverHistoryView = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        using (updateDriverHistoryView)
        {
            updateDriverHistoryView.Open();

            string sDateStart = dateStartText.Text;
            string sDateEnd = dateEndText.Text;
            DateTime dateStart = Convert.ToDateTime(sDateStart);
            DateTime dateEnd = Convert.ToDateTime(sDateEnd);

            Session["dateStartSession"] = dateStart;
            Session["dateEndSession"] = dateEnd;
            jobHistoryDateGridview.DataBind();
            updateDriverHistoryView.Close();
        }
        jobHistoryGridview.Visible = false;


        if ((string)Session["driverID"] != "")
        {
            SqlConnection updateDriverHistoryView1 = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            using (updateDriverHistoryView1)
            {
                updateDriverHistoryView1.Open();
                //calculating total duration worked
                SqlCommand cmdDurationTotal = new SqlCommand("SELECT SUM(JDriverDuration) FROM Jobs WHERE JDriverID = @sDriverID AND JStatus = @sStatus AND (JDriverDateStart BETWEEN @mStartDate AND @mEndDate)", updateDriverHistoryView1);
                cmdDurationTotal.Parameters.AddWithValue("@sDriverID", (string)Session["driverID"]);
                cmdDurationTotal.Parameters.AddWithValue("@sStatus", "Completed");
                cmdDurationTotal.Parameters.AddWithValue("@mStartDate", (DateTime)Session["dateStartSession"]);
                cmdDurationTotal.Parameters.AddWithValue("@mEndDate", (DateTime)Session["dateEndSession"]);
                string sDriverDuration = cmdDurationTotal.ExecuteScalar().ToString();
                totalDuration.Text = sDriverDuration.ToString();

                //calculating total pay
                SqlCommand cmdDriverWage = new SqlCommand("SELECT DriverHourWage FROM Drivers WHERE DriverID = @sDriverID;", updateDriverHistoryView1);
                cmdDriverWage.Parameters.AddWithValue("@sDriverID", (string)Session["driverID"]);
                string sDriverWage = cmdDriverWage.ExecuteScalar().ToString();
                decimal iDriverWage = Convert.ToDecimal(sDriverWage);
                int iDuration = Convert.ToInt32(sDriverDuration);
                decimal iTotalPay = iDriverWage * iDuration;
                totalPay.Text = String.Format("{0:0.00}", iTotalPay); //shows only 2dp

                updateDriverHistoryView1.Close();

            }
        }
        if ((string)Session["driverID"] == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "DriverID Error", "alert('There is no driver ID'); ", true);
        }

    }

    protected void jobHistoryDateGridview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SqlConnection updateDriverHistoryView2 = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
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
        e.Row.Cells[16].Visible = false;
        e.Row.Cells[17].Visible = false;
    }
}

