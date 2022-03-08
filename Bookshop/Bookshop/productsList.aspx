<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (int.Parse(CategoryBox.SelectedItem.Value) == 0)
            {
                Repeater1.DataSource = BookUtility.getAllBooks();
                Repeater1.DataBind();
            }
            else
            {
                Repeater1.DataSource = BookUtility.getBooksByCategory(int.Parse(CategoryBox.SelectedItem.Value));
                Repeater1.DataBind();
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (int.Parse(CategoryBox.SelectedItem.Value) == 0)
        {
            Repeater1.DataSource = BookUtility.getAllBooks();
            Repeater1.DataBind();
        }
        else
        {
            Repeater1.DataSource = BookUtility.getBooksByCategory(int.Parse(CategoryBox.SelectedItem.Value));
            Repeater1.DataBind();
        }
    }



    protected void del_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            int id = int.Parse(e.CommandArgument.ToString());
            BookUtility.deleteBookById(id);
            Button1_Click(sender, e);
            Label1.Text = "刪除成功";

        }
    }

    protected void searchBtn_Click(object sender, EventArgs e)
    {
        Repeater1.DataSource = BookUtility.getBookByName(bookNameBox.Text);
        Repeater1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table>
                <tr>
                    <td>依類別查詢: </td>
                    <td>
                        <asp:DropDownList ID="CategoryBox" runat="server">
                            <asp:ListItem Value="0">所有書目</asp:ListItem>
                            <asp:ListItem Selected="True" Value="1">美術設計</asp:ListItem>
                            <asp:ListItem Value="2">料理，食譜</asp:ListItem>
                            <asp:ListItem Value="3">語言學習</asp:ListItem>
                            <asp:ListItem Value="4">生活，手工藝</asp:ListItem>
                            <asp:ListItem Value="5">文學</asp:ListItem>
                            <asp:ListItem Value="6">圖畫書，繪本</asp:ListItem>
                            <asp:ListItem Value="7">上傳測試用</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="Button1" runat="server" Text="指定類別" OnClick="Button1_Click" />
                        <asp:Label ID="Label1" runat="server" Text="" ForeColor="#FF6666"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>依書名查詢: </td>
                    <td><asp:TextBox ID="bookNameBox" runat="server"></asp:TextBox>
                        <asp:Button ID="searchBtn" runat="server" Text="查詢" OnClick="searchBtn_Click" />
                    </td>
                </tr>
            </table>
            <hr/>
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table id= "customers" style="border-collapse:collapse;">
                        <thead style="background-color:cadetblue">
                            <tr>
                                <th style="width: 50px">產品ID</th>
                                <th style="width: 250px">書名</th>
                                <th style="width: 200px">作者</th>
                                <%-- <th>出版社</th>
                                <th>出版日期</th>--%>
                                <th>價格</th>
                                <th style="width: 40px">類別</th>
                                <%-- <th>預覽圖</th>
                                <th>預覽圖數量</th>--%>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Id") %> </td>
                        <td><%# Eval("BookName") %> </td>
                        <td><%# Eval("Author") %> </td>
                        <%--<td><%# Eval("Publisher") %> </td>
                        <td><%# Eval("PublicationDate") %> </td>--%>
                        <td><%# Eval("Price") %> </td>
                        <td><%# Eval("Category") %> </td>
                        <%--  <td><%# Eval("PreviewImg") %> </td>
                        <td><%# Eval("PreviewCount") %> </td>--%>
                        <td>
                            <asp:HyperLink ID="HyperLink1" runat="server"
                                NavigateUrl='<%# Eval("Id","updateProduct.aspx?id={0}") %>'><span class="w3-text-blue">編輯</span></asp:HyperLink>
                            <asp:Button runat="server" Text="刪除" OnCommand="del_Command" CommandArgument='<%# Eval("Id") %>' CommandName="del" />
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br/>
    <a href="products.aspx"><span class="w3-text-blue">至商品頁面確認</span></a>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
</asp:Content>

