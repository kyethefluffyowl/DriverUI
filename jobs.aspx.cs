using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["sflag"] != "in")
        {
            Response.Redirect("login.aspx");
        }
        Session["intmary"] = ""; //Used for calculating if the maintenance thing is done

        //jobGridView.Rows[0].Visible = false;

    }

    protected void jobGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        //http://www.aspsnippets.com/Articles/How-to-get-Selected-Row-cell-value-from-GridView-in-ASPNet.aspx
        //testserverupdate

        string jobID = jobGridView.SelectedRow.Cells[1].Text;               Session["jobID"] = jobID.ToString();
        string custID = jobGridView.SelectedRow.Cells[2].Text;              Session["custID"] = custID.ToString();
        //string driverID = jobGridView.SelectedRow.Cells[3].Text;            Session["driverID"] = driverID.ToString();
        string location = jobGridView.SelectedRow.Cells[4].Text;            Session["locationCol"] = location.ToString();
        string task = jobGridView.SelectedRow.Cells[5].Text;                Session["taskCol"] = task.ToString();
        string jobDesc = jobGridView.SelectedRow.Cells[6].Text;             Session["jobDescCol"] = jobDesc.ToString();
        string driverDateStart = jobGridView.SelectedRow.Cells[7].Text;     Session["locationCol"] = location.ToString();
        string driverDateEnd = jobGridView.SelectedRow.Cells[8].Text;       Session["driverDateEndCol"] = driverDateEnd.ToString();
        string custDateStart = jobGridView.SelectedRow.Cells[9].Text;       Session["custDateStartCol"] = custDateStart.ToString();
        string custDateEnd = jobGridView.SelectedRow.Cells[10].Text;        Session["custDateEndCol"] = custDateEnd.ToString();
        string status = jobGridView.SelectedRow.Cells[11].Text;             Session["statusCol"] = status.ToString();
        string payment = jobGridView.SelectedRow.Cells[12].Text;            Session["paymentCol"] = payment.ToString();
        string driverDuration = jobGridView.SelectedRow.Cells[13].Text;     Session["driverDurationCol"] = driverDuration.ToString();
        string custDuration = jobGridView.SelectedRow.Cells[14].Text;       Session["custDurationCol"] = custDuration.ToString();

        Response.Redirect("job-details.aspx");

    }

    protected void jobGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //hides the column but does not affect data extraction
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
        e.Row.Cells[4].Visible = false;
        e.Row.Cells[6].Visible = false;
        e.Row.Cells[8].Visible = false;
        e.Row.Cells[9].Visible = false;
        e.Row.Cells[10].Visible = false;
        e.Row.Cells[12].Visible = false;
        e.Row.Cells[13].Visible = false;
        e.Row.Cells[14].Visible = false;
        e.Row.Cells[15].Visible = false;
    }
}