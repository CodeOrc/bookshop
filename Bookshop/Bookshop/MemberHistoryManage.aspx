<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">


    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Receipe r = (Receipe)e.Item.DataItem;
        Dictionary<int, int> cart = ReceipeUtility.getOrderDetail(r.OrderDetail);

        List<Cart> cartlist = new List<Cart>();
        int total = 0;
        foreach (var item in cart)
        {
            Book tempB = BookUtility.getBookById(item.Key);
            Cart tempC = new Cart()
            {
                Id = tempB.Id,
                BookName = tempB.BookName,
                Price = tempB.Price,
                PreviewImg = tempB.PreviewImg,
                Amount = item.Value,
                subtotal = tempB.Price * item.Value
            };
            total += tempC.subtotal;
            cartlist.Add(tempC);
        }
        Repeater tempRep = (Repeater)e.Item.FindControl("InnerRepeater");
        tempRep.DataSource = cartlist;
        tempRep.DataBind();
        Label tempL = (Label)e.Item.FindControl("Label1");
        tempL.Text = total.ToString();
    }

    protected void schBtn_Click(object sender, EventArgs e)
    {
        Repeater1.DataSource=ReceipeUtility.getReceipeByUserId(TextBox1.Text);
        Repeater1.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["userId"] != null)
            {
                string str = Request.QueryString["userId"];
                Repeater1.DataSource=ReceipeUtility.getReceipeByUserId(str);
                Repeater1.DataBind();
            }

        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
    請輸入會員名稱: <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br/>
    <asp:Button ID="schBtn" runat="server" Text="查詢" onclick="schBtn_Click"/><br/>
    <hr/>
    
        <div>
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                      <table id="customers" class="table w3-table">
                <thead>
                    <tr>
                        <th colspan="4"style="background-color: cadetblue; text-align:center;"><%# Eval("OrderDate") %></th>
                    </tr>
                    <tr>
                        <th>產品</th>
                        <th>書名</th>
                        <th>價格</th>
                        <th>數量</th>

                    </tr>
                </thead>
                <tbody >

                    <asp:Repeater ID="InnerRepeater" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <img width="150" src="<%# Eval("PreviewImg","Images/{0}") %>" alt="">

                                </td>
                                <td><%# Eval("BookName") %></td>
                                <td><%# Eval("Price") %></td>
                                <td><%# Eval("Amount") %></td>

                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td colspan="2" style="text-align: right">總價:	</td>
                        <td colspan="2" >
                           <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                </tbody>
            </table>
                </ItemTemplate>
            </asp:Repeater>
        </div>
  </ContentTemplate></asp:UpdatePanel>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" Runat="Server">
</asp:Content>

