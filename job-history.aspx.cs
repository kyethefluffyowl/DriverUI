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
        if(!IsPostBack) //Prevents both gridviews from showing up on page refresh
        {
            jobHistoryDateGridview.Visible = false;
            jobHistoryGridview.Visible = true;
        }
    }

    protected void jobHistoryGridview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SqlConnection updateDriverHistoryView = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

        //hides the column but does not affect data extraction
        e.Row.Cells[0].Visible = false; // selecting row in case you wanna do anything with it
        e.Row.Cells[2].Visible = false; 
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

                try
                {
                    //calculating total pay
                    SqlCommand cmdDriverWage = new SqlCommand("SELECT DriverHourWage FROM Drivers WHERE DriverID = @sDriverID;", updateDriverHistoryView);
                    cmdDriverWage.Parameters.AddWithValue("@sDriverID", (string)Session["driverID"]);
                    string sDriverWage = cmdDriverWage.ExecuteScalar().ToString();
                    decimal iDriverWage = Convert.ToDecimal(sDriverWage);
                    int iDuration = Convert.ToInt32(sDriverDuration);
                    decimal iTotalPay = iDriverWage * iDuration;
                    totalPay.Text = String.Format("{0:0.00}", iTotalPay); //shows only 2dp
                }
                catch {ClientScript.RegisterStartupScript(GetType(), "noPay", "alert('There is nothing to show'); ", true); }
                updateDriverHistoryView.Close();

            }
        }
        if ((string)Session["driverID"] == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "DriverID Error", "alert('No driver id detected. Please login again.'); ", true);
        }

    }


    protected void dateSelectSubmit_Click(object sender, EventArgs e)
    {

        string sDateStart = dateStartText.Text;
        string sDateEnd = dateEndText.Text;

        if (sDateStart == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "dateStartEmpty","alert('Please input a start date');", true);
        }
        else if (sDateEnd == "")
        {
            ClientScript.RegisterStartupScript(GetType(), "dateEndEmpty", "alert('Please input a end date');", true);
        }
        else
        {
            DateTime dateStart = Convert.ToDateTime(sDateStart);
            DateTime dateEnd = Convert.ToDateTime(sDateEnd);

            if (dateEnd < dateStart) //If the end date is before the start date, throw error
            {
                ClientScript.RegisterStartupScript(GetType(), "dateValidation", "alert('End date is before start date.');", true);
            }
            if (dateEnd > dateStart) //If the end date is after the start date, run code
            {
                SqlConnection updateDriverHistoryView = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
                using (updateDriverHistoryView)
                {
                    updateDriverHistoryView.Open();

                    Session["dateStartSession"] = dateStart;
                    Session["dateEndSession"] = dateEnd;
                    jobHistoryDateGridview.DataBind();
                    updateDriverHistoryView.Close();
                }
                jobHistoryGridview.Visible = false;
                jobHistoryDateGridview.Visible = true;

                try
                {
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
                }
                catch { ClientScript.RegisterStartupScript(GetType(), "zero", "There is nothing here", true); }
                if ((string)Session["driverID"] == "")
                {
                    ClientScript.RegisterStartupScript(GetType(), "DriverID Error", "alert('There is no driver ID'); ", true);
                }
            }
        }

       
    }

    protected void jobHistoryDateGridview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SqlConnection updateDriverHistoryView2 = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        e.Row.Cells[0].Visible = false; // selecting row in case you wanna do anything with it
        e.Row.Cells[2].Visible = false;
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

