<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">


    protected void del_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            int id = int.Parse(e.CommandArgument.ToString());
            MemberUtility.delMember(id);
            List<Member> m = MemberUtility.getAllMembers();
            Repeater1.DataSource = m;
            Repeater1.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            List<Member> m = MemberUtility.getAllMembers();
            Repeater1.DataSource = m;
            Repeater1.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Repeater ID="Repeater1" runat="server">

        <HeaderTemplate>
            <table id="customers" style="border-collapse: collapse;">
                <thead style="background-color: cadetblue">
                    <tr>
                        <th>Id </th>
                        <th>UserId </th>                        
                        <th>UserImg </th>
                        <th>Email</th>
                         <th></th>
                        <th></th>
                    </tr>
                </thead><tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
            <td><%# Eval("Id") %></td>
            <td><%# Eval("UserId") %></td>
            <td><%# Eval("UserImg") %></td>
            <td><%# Eval("Email") %></td>
                <td><a href="<%# Eval("UserId","MemberHistoryManage.aspx?userId={0}") %>"><span class="w3-text-blue">購買紀錄</span></a></td>
            <td><asp:Button runat="server" Text="刪除" OnCommand="del_Command" CommandArgument='<%# Eval("Id") %>' CommandName="del" />

            </td></tr>
            
        </ItemTemplate>

        <FooterTemplate>
            </tbody></table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
</asp:Content>

