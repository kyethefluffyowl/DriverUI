using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["driverID"] = "1"; //Parse the driverID from the login page actual

        Session["intmary"] = ""; //Used for calculating if the maintenance thing is done
    }

    protected void jobGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        //http://www.aspsnippets.com/Articles/How-to-get-Selected-Row-cell-value-from-GridView-in-ASPNet.aspx

        string jobID = jobGridView.SelectedRow.Cells[1].Text;               Session["jobID"] = jobID.ToString();
        string custID = jobGridView.SelectedRow.Cells[2].Text;              Session["custID"] = custID.ToString();
        string driverID = jobGridView.SelectedRow.Cells[3].Text;            Session["driverID"] = driverID.ToString();
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
}