<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Adminlogin"] != null)
        {

            Response.Redirect("~/productsList.aspx");

        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        admin tempAdmin=adminUtinity.Adminlogin(Id: TextBox1.Text, Password: TextBox2.Text);
        if (tempAdmin is null)
        {
            Label1.Text = "登入失敗,請檢查帳號與密碼";
        }

        else
        {
            Session["Adminlogin"] = tempAdmin;
            Label1.Text = "登入成功";

            Response.Redirect("~/productsList.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>管理登入</h2>
    <hr />
    <table>
        <tr>
            <td>管理者帳號: </td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server">admin</asp:TextBox></td>
        </tr>
        <tr>
            <td>管理者密碼: </td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" TextMode="Password">123</asp:TextBox>
        </tr>
    </table>
    <asp:Button ID="Button1" runat="server" Text="登入" OnClick="Button1_Click" />
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
</asp:Content>



