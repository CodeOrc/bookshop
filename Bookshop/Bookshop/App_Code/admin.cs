using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for admin
/// </summary>
public class admin
{
    public int Id { get; set; }
    public string adminId { get; set; }
    public string adminPassword { get; set; }
}
    public class adminUtinity
    {
    public static List<admin> getAllAdmins()
    {
        List<admin> admins = new List<admin>();
        SqlDataAdapter da = new SqlDataAdapter("select * From Admin", connect.connectstring);
        DataTable dt = new DataTable();
        da.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            admin tempA = new admin();
            tempA.Id = Convert.ToInt32(row["Id"]);
            tempA.adminId = row["adminId"].ToString();
            tempA.adminPassword = row["adminPassword"].ToString();
            admins.Add(tempA);
        }
        return admins;
    }

    public static void addAdmin(string id ,string password)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("Insert into [Admin] ([adminId],[adminPassword]) Values(@adminId,@adminPassword)", cn);
        cmd.Parameters.AddWithValue("@adminId", id);
        cmd.Parameters.AddWithValue("@adminPassword", password);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }


    public static void delAdmin(int Id)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("DELETE [Admin] WHERE[Id]=@Id"
            , cn);
        cmd.Parameters.AddWithValue("@Id", Id);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }



    public static admin Adminlogin(string Id, string Password)
        {

            SqlDataAdapter da = new SqlDataAdapter("select * From Admin Where adminId= @adminId and adminPassword=@adminPassword ", connect.connectstring);
            da.SelectCommand.Parameters.AddWithValue("@adminId", Id);
            da.SelectCommand.Parameters.AddWithValue("@adminPassword", Password);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            { return null; }
            else
            {
                DataRow row = dt.Rows[0];

                admin a = new admin()
                {
                    Id = Convert.ToInt32(row["Id"]),
                    adminId = row["adminId"].ToString(),
                    adminPassword = row["adminPassword"].ToString()

                };
                return a;

            }

        }

    }
