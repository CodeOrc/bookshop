using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Member
/// </summary>
public class Member
{
    public int    Id { get; set; }
    public string UserId { get; set; }
    public string Password { get; set; }
    public string UserImg { get; set; }
    public string Email { get; set; }
    
}
public class MemberUtility
    {
    public static List<Member> getAllMembers()
    {
        List<Member> members = new List<Member>();
        SqlDataAdapter da = new SqlDataAdapter("select * From Members",connect.connectstring);
        DataTable dt = new DataTable();
        da.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            Member tempM = new Member();
            tempM.Id = Convert.ToInt32(row["Id"]);
            tempM.UserId = row["UserId"].ToString();
            tempM.Password = row["Password"].ToString();
            tempM.UserImg = row["UserImg"].ToString();
          
            tempM.Email = row["Email"].ToString();
             members.Add(tempM);
        }
        return members;
    }
    public static Member userLogin(string userID)
    {
        SqlDataAdapter da = new SqlDataAdapter("select * From Members Where userID= @userID ", connect.connectstring);
        da.SelectCommand.Parameters.AddWithValue("@userID", userID);
        
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        { return null; }
        else
        {
            DataRow row = dt.Rows[0];
           
                Member m = new Member()
                {
                    Id = Convert.ToInt32(row["Id"]),
                    UserId = row["UserId"].ToString(),
                    Password = row["Password"].ToString(),
                    UserImg = row["UserImg"].ToString(),
                    Email=row["Email"].ToString()
                };
            return m;
            
        }
    }
    public static bool MemberExist(string userID)
    {
        bool ifExist;
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("SELECT [UserId] FROM [Members] WHERE UserId=@UserId"
            , cn);
        cmd.Parameters.AddWithValue("@UserId", userID);
        cn.Open();
        SqlDataReader dr= cmd.ExecuteReader();
        if (dr.HasRows)
        { ifExist = true; }
        else { ifExist = false; }
        cn.Close();
        return ifExist;
    }

    public static void addMember(Member m)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("Insert into [Members] ([UserId],[Password],[UserImg],[Email]) Values(@UserId,@Password,@UserImg,@Email)"
            , cn);
        cmd.Parameters.AddWithValue("@UserId",m.UserId );
        cmd.Parameters.AddWithValue("@Password",m.Password);
        if (m.UserImg is null)
        {
            cmd.Parameters.AddWithValue("@UserImg", DBNull.Value);
        }
        else
        {
            cmd.Parameters.AddWithValue("@UserImg", m.UserImg);
        }
       
        cmd.Parameters.AddWithValue("@Email",m.Email);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static bool ifEmailExist(string userID)
    {
        bool EmailExist;
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("SELECT [Email] FROM [Members] WHERE UserId=@UserId"
            , cn);
        cmd.Parameters.AddWithValue("@UserId", userID);
        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        { EmailExist = true; }
        else { EmailExist = false; }
        cn.Close();
        return EmailExist;
        
    }
   public static void delMember(int Id)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("DELETE [Members] WHERE[Id]=@Id"
            , cn);
        cmd.Parameters.AddWithValue("@Id", Id);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void updateMemberinfo(Member m)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("UPDATE [Members] SET[UserImg]=@UserImg,[Email]=@Email Where [Id]=@Id"
            , cn);
        cmd.Parameters.AddWithValue("@Id", m.Id);
        cmd.Parameters.AddWithValue("@UserId", m.UserId);
        cmd.Parameters.AddWithValue("@UserImg", m.UserImg);
        cmd.Parameters.AddWithValue("@Email", m.Email);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

 


    public static void updateMemberpassword(string userID ,string oldpassword,string newpassword)
    {
        Member m =userLogin(userID);
        if (m.Password == oldpassword)
        {
            SqlConnection cn = new SqlConnection(connect.connectstring);
            SqlCommand cmd = new SqlCommand
                ("UPDATE [Members] SET[Password]=@Password Where [Id]=@Id", cn);
            cmd.Parameters.AddWithValue("@Id", m.Id);
            cmd.Parameters.AddWithValue("@Password", newpassword);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
    }

    //-------------------------↓↓↓使用者專屬購物車↓↓↓-----------------------

    }
