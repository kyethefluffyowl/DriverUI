using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class testingPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void submitButton_Click(object sender, EventArgs e)
    {
        if (noMain.Checked == true)
        {
            ClientScript.RegisterStartupScript(GetType(), "nomainclick", "alert('You clicked no main');", true);
        }
        if (selfMain.Checked == true)
        {
            ClientScript.RegisterStartupScript(GetType(), "nomainclick", "alert('You clicked self main');", true);
        }
        if (OSMain.Checked == true)
        {
            ClientScript.RegisterStartupScript(GetType(), "nomainclick", "alert('You clicked os main');", true);
        }
    }
}