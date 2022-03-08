using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for connectstring
/// </summary>
public class connect
{
    public static string connectstring
    {

        get { return System.Configuration.ConfigurationManager.ConnectionStrings["BookShop"].ConnectionString; }

    }
}