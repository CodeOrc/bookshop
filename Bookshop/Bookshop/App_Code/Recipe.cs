using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for Recipe
/// </summary>
public class Receipe
{
    public int Id { get; set; }
    public string ReceiptId { get; set; }
    public DateTime OrderDate { get; set; }
    public string OrderDetail { get; set; }
    public string userID { get; set; }

}
public class ReceipeUtility
{
    public static Dictionary<int, int> getOrderDetail(string orederDetail)
    {
        Dictionary<int, int> tempD = new Dictionary<int, int>();
        foreach (string item in orederDetail.Split(';'))
        {
            tempD.Add(Convert.ToInt32(item.Split(',')[0]), Convert.ToInt32(item.Split(',')[1]));
        }
        return tempD;
    }
    public static string orderDetailToString(Dictionary<int, int> cart)
    {
        string orderDetail = "";
        foreach (KeyValuePair<int,int> item in cart)
        {
            orderDetail += $"{item.Key.ToString()},{item.Value.ToString()};";
        }
     
        return orderDetail.Remove(orderDetail.LastIndexOf(';'), 1);
    }

    public static List<Receipe> getAllReceipe()
    {
        List<Receipe> receipes = new List<Receipe>();
        SqlDataAdapter da = new SqlDataAdapter("Select * FROM RECEIPT", connect.connectstring);
        DataTable dt = new DataTable();
        da.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            Receipe tempR = new Receipe()
            {
                Id = Convert.ToInt32(row["Id"]),
                ReceiptId = row["ReceiptId"].ToString(),
                OrderDate = Convert.ToDateTime(row["OrderDate"]),
                OrderDetail = row["OrderDetail"].ToString(),
                userID = row["userID"].ToString()
            };
            receipes.Add(tempR);
        }    
        return receipes;
    }

    public static List<Receipe> getReceipeByUserId(string userId)
    {
        List<Receipe> receipes = new List<Receipe>();
        SqlDataAdapter da = new SqlDataAdapter("Select * FROM RECEIPT Where userID=@userID", connect.connectstring);
        da.SelectCommand.Parameters.AddWithValue("@userID", userId);
        DataTable dt = new DataTable();
        da.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            Receipe tempR = new Receipe()
            {
                Id = Convert.ToInt32(row["Id"]),
                ReceiptId = row["ReceiptId"].ToString(),
                OrderDate = Convert.ToDateTime(row["OrderDate"]),
                OrderDetail = row["OrderDetail"].ToString(),
                userID = row["userID"].ToString()
            };
            receipes.Add(tempR);
        }
        return receipes;
    }


    public static void insertReceipe(Dictionary<int, int> cart, string userId )
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("INSERT INTO [RECEIPT]" +
             "([ReceiptId],[OrderDate],[OrderDetail],[userID])" +
             "VALUES(@ReceiptId,@OrderDate,@OrderDetail,@userID)", cn);
        //ReceiptId 
        //  OrderDate
        //OrderDetail
        //userID 
        
        cmd.Parameters.AddWithValue("@ReceiptId", $"{userId}{DateTime.Now.ToString("yyyyMMddHHmm")}");
        cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
        cmd.Parameters.AddWithValue("@OrderDetail", orderDetailToString(cart));
        cmd.Parameters.AddWithValue("@userID", userId);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }




}