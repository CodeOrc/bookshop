<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {
            List<Book> Books = BookUtility.getAllBooks();
            GridView1.DataSource = Books;
            GridView1.DataBind();

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
         if (Session["LoginInfo"] != null)
        { Session["LoginInfo"] = null; }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
<asp:GridView ID="GridView1" runat="server"></asp:GridView>
</asp:Content>


