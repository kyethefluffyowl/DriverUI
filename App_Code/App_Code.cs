using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Database
/// </summary>
public class Database
{
    string connectionString = "Server='hlgroup.database.windows.net';Database=fypdb;User ID=hlgroup;Password=Daphnerocks1;";
    public Database()
    {

    }

    public SqlConnection getDBConnection()
    {
        SqlConnection driverConnection = new SqlConnection(connectionString);
        return driverConnection;
    }
}