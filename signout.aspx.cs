using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class signout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["jobID"] = "";
        Session["custID"] = "";
        Session["driverID"] = "";
        Session["locationCol"] = "";
        Session["taskCol"] = "";
        Session["jobDescCol"] = "";
        Session["locationCol"] = "";
        Session["driverDateEndCol"] = "";
        Session["custDateStartCol"] = "";
        Session["custDateEndCol"] = "";
        Session["statusCol"] = "";
        Session["paymentCol"] = "";
        Session["driverDurationCol"] = "";
        Session["custDurationCol"] = "";

        Session["intmary"] = "";
        Session["sflag"] = "out";

        Response.Redirect("login.aspx");
    }
}