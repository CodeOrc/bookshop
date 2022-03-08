using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Book
/// </summary>
public class Book
{
    public int Id { get; set; }
    public string BookName { get; set; }
    public string Author { get; set; }
    public string Publisher { get; set; }
    public string PublicationDate { get; set; }
    public int Price { get; set; }
    public int Category { get; set; }
    public string PreviewImg { get; set; }
    public int PreviewCount { get; set; }
}

public class BookCategory
{
    public int Category { get; set; }
    public string CategoryName { get; set; }
}
public class BookUtility
{
    public static List<Book> getAllBooks()
    {
        List<Book> books = new List<Book>();
        SqlDataAdapter da = new SqlDataAdapter("select* From Books", connect.connectstring);
        DataTable dt = new DataTable();
        da.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            Book tempB = new Book();
            tempB.Id = Convert.ToInt32(row["Id"]);
            tempB.BookName = row["BookName"].ToString();
            tempB.Author = row["Author"].ToString();
            tempB.Publisher = row["Publisher"].ToString();
            tempB.PublicationDate = row["PublicationDate"].ToString();
            tempB.Price = Convert.ToInt32(row["Price"]);
            tempB.Category = Convert.ToInt32(row["Category"]);
            tempB.PreviewImg = row["PreviewImg"].ToString();
            tempB.PreviewCount = Convert.ToInt32(row["PreviewCount"]);

            books.Add(tempB);
        }

        return books;
    }

    public static List<Book> getBooksByCategory(int category)
    {
        List<Book> books = new List<Book>();
        SqlDataAdapter da = new SqlDataAdapter("select* From Books Where Category=@Category", connect.connectstring);
        da.SelectCommand.Parameters.AddWithValue("@Category", category);
        DataTable dt = new DataTable();
        da.Fill(dt);
        foreach (DataRow row in dt.Rows)
        {
            Book tempB = new Book();
            tempB.Id = Convert.ToInt32(row["Id"]);
            tempB.BookName = row["BookName"].ToString();
            tempB.Author = row["Author"].ToString();
            tempB.Publisher = row["Publisher"].ToString();
            tempB.PublicationDate = row["PublicationDate"].ToString();
            tempB.Price = Convert.ToInt32(row["Price"]);
            tempB.Category = Convert.ToInt32(row["Category"]);
            tempB.PreviewImg = row["PreviewImg"].ToString();
            tempB.PreviewCount = Convert.ToInt32(row["PreviewCount"]);

            books.Add(tempB);
        }

        return books;
    }
    public static Book getBookById(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter("select* From Books Where Id = @Id", connect.connectstring);
        da.SelectCommand.Parameters.AddWithValue("@Id", id);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];
        Book book = new Book();
        book.Id = Convert.ToInt32(row["Id"]);
        book.BookName = row["BookName"].ToString();
        book.Author = row["Author"].ToString();
        book.Publisher = row["Publisher"].ToString();
        book.PublicationDate = row["PublicationDate"].ToString();
        book.Price = Convert.ToInt32(row["Price"]);
        book.Category = Convert.ToInt32(row["Category"]);
        book.PreviewImg = row["PreviewImg"].ToString();
        book.PreviewCount = Convert.ToInt32(row["PreviewCount"]);

        return book;
    }
    public static List<Book> getBookByName(string bookName)
    {
        List<Book> books = new List<Book>();
        SqlDataAdapter da = new SqlDataAdapter("select* From Books Where BookName Like '%'+@BookName+'%'", connect.connectstring);
        da.SelectCommand.Parameters.AddWithValue("@BookName", bookName);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count == 0)
        { return null; }

        else
        {
            foreach (DataRow row in dt.Rows)
            {
                Book book = new Book();
                book.Id = Convert.ToInt32(row["Id"]);
                book.BookName = row["BookName"].ToString();
                book.Author = row["Author"].ToString();
                book.Publisher = row["Publisher"].ToString();
                book.PublicationDate = row["PublicationDate"].ToString();
                book.Price = Convert.ToInt32(row["Price"]);
                book.Category = Convert.ToInt32(row["Category"]);
                book.PreviewImg = row["PreviewImg"].ToString();
                book.PreviewCount = Convert.ToInt32(row["PreviewCount"]);
                books.Add(book);
            }
            return books;
        }
    }

    public static void insertBook(Book book)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("INSERT INTO [Books]" +
             "([BookName],[Author],[Publisher],[PublicationDate],[Price],[Category],[PreviewImg],[PreviewCount])"+
             "VALUES(@BookName,@Author,@Publisher,@PublicationDate,@Price,@Category,@PreviewImg,@PreviewCount)",cn);
       
        cmd.Parameters.AddWithValue("@BookName",book.BookName);
        cmd.Parameters.AddWithValue("@Author",book.Author);
        cmd.Parameters.AddWithValue("@Publisher",book.Publisher);
        cmd.Parameters.AddWithValue("@PublicationDate",book.PublicationDate);
        cmd.Parameters.AddWithValue("@Price",book.Price);
        cmd.Parameters.AddWithValue("@Category",book.Category);
        cmd.Parameters.AddWithValue("@PreviewImg",book.PreviewImg);
        cmd.Parameters.AddWithValue("@PreviewCount",book.PreviewCount);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void updateBookById(Book book)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand
            ("UPDATE [Books] " +
             "SET" +
             "[BookName]= @BookName," +
             "[Author]= @Author," +
             "[Publisher]= @Publisher," +
             "[PublicationDate]= @PublicationDate," +
             "[Price]= @Price," +
             "[Category]= @Category," +
             "[PreviewImg]= @PreviewImg," +
             "[PreviewCount] = @PreviewCount" +
             " WHERE [Id] = @Id", cn);
        cmd.Parameters.AddWithValue("@Id",book.Id);
        cmd.Parameters.AddWithValue("@BookName",book.BookName);
        cmd.Parameters.AddWithValue("@Author",book.Author);
        cmd.Parameters.AddWithValue("@Publisher",book.Publisher);
        cmd.Parameters.AddWithValue("@PublicationDate",book.PublicationDate);
        cmd.Parameters.AddWithValue("@Price",book.Price);
        cmd.Parameters.AddWithValue("@Category", book.Category);
        cmd.Parameters.AddWithValue("@PreviewImg",book.PreviewImg);
        cmd.Parameters.AddWithValue("@PreviewCount",book.PreviewCount);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void deleteBookById(int id)
    {
        SqlConnection cn = new SqlConnection(connect.connectstring);
        SqlCommand cmd = new SqlCommand("DELETE [Books]  WHERE [Id] = @Id", cn);
        cmd.Parameters.AddWithValue("@Id", id);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }




    //--------------------------↓↓↓書本簡介用↓↓↓------------------------------------------
    public static string getBookContentById(int id)
    {
        string content;
        SqlDataAdapter da = new SqlDataAdapter("select replace (Content,CHAR(13),'<br/>' )From BookContent Where Id = @Id", connect.connectstring);
        da.SelectCommand.Parameters.AddWithValue("@Id", id);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            DataRow row = dt.Rows[0];
            content = row[0].ToString();
            return content;
        }
    }


}
