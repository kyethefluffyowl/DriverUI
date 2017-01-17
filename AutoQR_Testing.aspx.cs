using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net.Mail; //INCLUDE THIS OTHERWISE ERRORS AND CANT SEND <3

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void sendEmail_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection updateJobCompletion = new SqlConnection("Server=tcp:hlgroup.database.windows.net;Initial Catalog=fypdb;Persist Security Info=False;User ID=hlgroup;Password=Daphnerocks1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            using (updateJobCompletion)
            {
                //Taking out JQR. For you, you can use parse the value from the page itself without selecting it.
                updateJobCompletion.Open();
                SqlCommand selectcmd = new SqlCommand("SELECT JQR FROM [Jobs] WHERE ([JobID] = @JobID)", updateJobCompletion);
                selectcmd.Parameters.AddWithValue("@JobID", "101");
                string JQRString = selectcmd.ExecuteScalar().ToString();
                updateJobCompletion.Close();

                //This is the link where the QR will stay
                string QRLINK = "http://qrickit.com/api/qr?d=" + JQRString + "&qrsize=300";

                //This is where the customer email comes here. My email is a palceholder. Actually select it from the database!
                string custEmail = "jr.dn@hotmail.com";

                //Receipt Content
                string receiptTitle = "<h1>Your Receipt</h1></br>";
                string receiptBody = "Things they ordered go here"; // You can add your gridview stuff here. Everything in the quotation marks is in HTML format so yeah. 
                string receiptQR = "<p style='font-size:1em;'>Thank you for doing business with us!</p><p>Show this code to our driver upon his arrival.</p><img src='" + QRLINK + "' style='width:auto; display:block;'/>";

                //Mail stuff
                MailMessage mail = new MailMessage("kye_jrdn@hotmail.com", custEmail); //FROM, TO. 
                SmtpClient client = new SmtpClient();
                client.Port = 587; //Hotmail port.
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new System.Net.NetworkCredential("kye_jrdn@hotmail.com", "Daphnerockz"); //Account email, password
                client.Host = "smtp-mail.outlook.com"; //Hotmail SMTP
                client.EnableSsl = true;
                mail.Subject = "Your Receipt for" + "pls remove this one and put the receipt/order ID via string!";
                mail.Body = receiptTitle + receiptBody + receiptQR;
                mail.IsBodyHtml = true;

                client.Send(mail); //Actually sending the mail
                ClientScript.RegisterStartupScript(GetType(), "errorSend", "alert('Successful! Redirecting you back.'); window.location='AutoQR_Testing.aspx';", true);//Once mail is sent, redirect back to your page.
            }
        }
        catch
        {
            ClientScript.RegisterStartupScript(GetType(), "errorSend", "alert('The email failed to send. Please refresh the page and try again.');", true);
        }
    }

}