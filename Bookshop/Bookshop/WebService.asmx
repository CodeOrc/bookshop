<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    //----------↓↓↓以下購物車用方法↓↓↓--------------------------------------------------------------------------------
    [WebMethod(EnableSession = true)]
    public void addToCart(int id, int amount)
    {
        if (Session["cart"] == null)
        {
            Session["cart"] = new Dictionary<int, int>();
        }

        Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];

        if (amount <= 0)
        {
            amount = 1;
        }

        if (cart.ContainsKey(id))
        {
            cart[id] = amount;
        }
        else
        {
            cart.Add(id, amount);
        }
    }


    [WebMethod(EnableSession = true)]
    public Dictionary<string, int> changeCartAmount(int id, int amount)
    {
        Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];

        cart[id] += amount;
        if (cart[id] <= 1)
        { cart[id] = 1; }
        Dictionary<string, int> total = new Dictionary<string, int>();
        total.Add("subtotal",BookUtility.getBookById(id).Price*cart[id]);
        total.Add("total", getCartTotalPrice());
        return total;
    }

    [WebMethod(EnableSession = true)]
    public int deleteCartItem(int id)
    {
        Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];

        cart.Remove(id);
        return getCartTotalPrice();
    }
    [WebMethod(EnableSession = true)]
    public int getCartTotalPrice()
    {
        if (Session["cart"] == null)
        {
            Session["cart"] = new Dictionary<int, int>();
        }
        Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];
        int total = 0;

        foreach (var item in cart)
        {
            total+=(BookUtility.getBookById(item.Key).Price*item.Value);
        }
        return total;
    }

    //----------↓↓↓以下登入用方法↓↓↓--------------------------------------------------------------------------------
    [WebMethod(EnableSession = true)]
    public bool ifLogin()
    {
        if (Session["LoginInfo"] != null)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    [WebMethod(EnableSession = true)]
    public string userLogin(string id, string password)
    {
        Member m = MemberUtility.userLogin(id);
        if (m is null)
        {
            return "登入失敗,請檢查帳號與密碼";
        }
        else if (m.Password != password)
        {  return "密碼錯誤，請檢查帳號與密碼"; }
        else
        {
            Session["LoginInfo"] = m;
            return"登入成功";

        }
    }

    [WebMethod(EnableSession = true)]
    public void userLogout()
    {
        Session["LoginInfo"] = null;

    }
    //---------------------------↓↓↓以下產品管理用方法↓↓↓---------------------------------------------

    [WebMethod]
    public Book getBookById(int id)
    {
        return  BookUtility.getBookById(id);
    }

    [WebMethod]
    public List<Book> getBookByName(string name)
    {
        return  BookUtility.getBookByName(name);
    }
    [WebMethod]
    public string UpdateBookById()
    {
        return "123";
    }
}