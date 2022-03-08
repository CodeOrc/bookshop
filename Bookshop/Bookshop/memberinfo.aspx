<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginInfo"] == null)
        {Response.Redirect("~/login.aspx"); }
        if (!Page.IsPostBack)
        {
            if (Session["LoginInfo"] != null)
            {
                Member m = (Member)Session["LoginInfo"];
                userIdLabel.Text = m.UserId;
                userEmailLabel.Text = m.Email;
            }
        }
    }

    protected void editPasswordBtn_Click(object sender, EventArgs e)
    {
        if (Panel1.Visible == false)
        { Panel1.Visible = true;
        }
        else
        { Panel1.Visible = false;
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text != "" && TextBox2.Text != "") {
            Member m = (Member)Session["LoginInfo"];
            if (m.Password == TextBox1.Text) {
                if (TextBox1.Text == TextBox2.Text) {
                    Label1.Text = "新密碼與舊密碼相同";
                }
                else
                {
                    MemberUtility.updateMemberpassword(m.UserId, oldpassword: TextBox1.Text, newpassword: TextBox2.Text);
                    Session.Remove("LoginInfo");
                    ScriptManager.RegisterStartupScript(this.Button1, this.GetType(), "alert",
                "alert('修改密碼成功');location.href='login.aspx';", true);
                }
            }
            else { Label1.Text = "使用者密碼不正確"; }
        }
        else
        {
            Label1.Text = "請勿空白";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>用戶個人資料</h2>
    <hr />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
    <table>
        <thead>
        <tr><th>
            <asp:Image ID="Image1" runat="server" />
            </th></tr>
            </thead>
        <tbody>
        <tr><td>帳戶名稱: </td><td>
            <asp:Label ID="userIdLabel" runat="server" Text=""></asp:Label></td></tr>
        <tr><td>聯絡信箱: </td><td>
            <asp:Label ID="userEmailLabel" runat="server" Text=""></asp:Label></td></tr>
        <tr><td>
            <asp:Button ID="editPasswordBtn" runat="server" Text="修改密碼" OnClick="editPasswordBtn_Click"/>
            <asp:Button ID="editMemInfoBtn" runat="server" Text="編輯個人資料" />

            </td></tr>
            
        </tbody>
    </table>
<asp:Panel ID="Panel1" runat="server" Visible="False">
               請輸入舊密碼: <asp:TextBox ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox><br/>
               請輸入新密碼:   <asp:TextBox ID="TextBox2" runat="server"  TextMode="Password"></asp:TextBox><br />
                <asp:Button ID="Button1" runat="server" Text="修改" OnClick="Button1_Click" />
    <asp:Label ID="Label1" runat="server" Text="" ForeColor="#FF5050"></asp:Label>
            </asp:Panel>

</ContentTemplate></asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" Runat="Server">
</asp:Content>

