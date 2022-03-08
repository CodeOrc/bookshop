<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">

    protected void del_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            int id = int.Parse(e.CommandArgument.ToString());
            adminUtinity.delAdmin(id);
            List<admin> a = adminUtinity.getAllAdmins();
            Repeater1.DataSource = a;
            Repeater1.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            List<admin> a = adminUtinity.getAllAdmins();
            Repeater1.DataSource = a;
            Repeater1.DataBind();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        adminUtinity.addAdmin(AdminBox1.Text, AdminBox2.Text);
        Response.Redirect(Request.Url.LocalPath);
    }
</script>
<%--Id 
adminId 
adminPassword--%>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Repeater ID="Repeater1" runat="server">
      <HeaderTemplate>
            <table id="customers" style="border-collapse: collapse;">
                <thead style="background-color: cadetblue">
                    <tr>
                        <th>Id </th>
                        <th>adminId </th>                        
                        <th>adminPassword </th>
                      
                        <th></th>
                    </tr>
                </thead><tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
            <td><%# Eval("Id") %></td>
            <td><%# Eval("adminId") %></td>
            <td><%# Eval("adminPassword") %></td>
          
            <td><asp:Button runat="server" Text="刪除" OnCommand="del_Command" CommandArgument='<%# Eval("Id") %>' CommandName="del" />

            </td></tr>
            
        </ItemTemplate>

        <FooterTemplate>
            </tbody></table>
        </FooterTemplate>
    </asp:Repeater>

    <hr/>
    <h2>新增管理者</h2>
    管理者名稱: <asp:TextBox ID="AdminBox1" runat="server"></asp:TextBox><br/>
    管理者密碼: <asp:TextBox ID="AdminBox2" runat="server"></asp:TextBox><br />
    <asp:Button ID="Button1" runat="server" Text="新增" onclick="Button1_Click"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" Runat="Server">
</asp:Content>

