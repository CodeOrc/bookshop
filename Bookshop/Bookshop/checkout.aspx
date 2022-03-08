<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginInfo"] == null)
        {
            Response.Redirect("~/login.aspx?from=checkout");
        }
        if (!Page.IsPostBack)
        {
            if (Session["cart"] != null)
            {
                Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];
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
                Repeater1.DataSource = cartlist;
                Repeater1.DataBind();


                Label1.Text = total.ToString();
            }

        }
    }

    protected void CheckBtn_Click(object sender, EventArgs e)
    {
        Member m = (Member)Session["LoginInfo"];
        Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];
        ReceipeUtility.insertReceipe(cart, m.UserId);
        Session.Remove("cart");
          ScriptManager.RegisterStartupScript(this.CheckBtn,this.GetType(),"alert",
            "alert('結帳成功');location.href='memberOrderHistory.aspx';",true);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h3>請確認產品購買明細 </h3>
    <hr />
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>產品</th>
                <th>書名</th>
                <th>數量</th>
                <th>價格</th>
                <th>小計</th>
            </tr>
        </thead>
        <tbody>

            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate></HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <img width="50" src="<%# Eval("PreviewImg","Images/{0}") %>" alt=""></td>
                        <td><%# Eval("BookName") %></td>
                        <td>
                            <%# Eval("Amount") %>

                           
                        </td>
                        <td><%# Eval("Price") %></td>

                        <td><%# Eval("subtotal") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate></FooterTemplate>

            </asp:Repeater>

            <tr>
                <td colspan="4" style="text-align: right">Total Price:	</td>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>

        </tbody>
    </table>
    <hr />
    <h3>付款資訊 </h3>
    <div class="span9">
        <div style="background-color: #f2f2f2; padding: 5px 20px 15px 20px; border: 1px solid lightgrey; border-radius: 3px;">
            <div>

                <div class="row">
                    <div class="span4">
                        <h3>帳單地址</h3>
                        <label for="fname"><i class="fa fa-user"></i>顧客名稱:</label>
                        <input type="text" id="fname" name="firstname" placeholder="John M. Doe">
                        <label for="email"><i class="fa fa-envelope"></i>電子信箱:</label>
                        <input type="text" id="email" name="email" placeholder="john@example.com">
                        <label for="adr"><i class="fa fa-address-card-o"></i>地址:</label>
                        <input type="text" id="adr" name="address" placeholder="542 W. 15th Street">
                    </div>

                    <div class="span4">
                        <h3>付款</h3>
                        <label for="cname">信用卡用戶名:</label>
                        <input type="text" id="cname" name="cardname" placeholder="John More Doe">
                        <label for="ccnum">信用卡卡號:</label>
                        <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
                        <div class="row">
                            <div class="span1">
                                <label for="expmonth">到期月:</label>
                                <input type="text" id="expmonth" name="expmonth" placeholder="01" style="width:50%">
                            </div>
                            <div class="span1">
                                <label for="expyear">到期年:</label>
                                <input type="text" id="expyear" name="expyear" placeholder="2018" style="width: 50%">
                            </div>
                            <div class="span4">
                                <label for="cvv">安全碼</label>
                                <input type="text" id="cvv" name="cvv" placeholder="352" style="width: 50%">
                            </div>
                        </div>
                    </div>

                </div>
                <br/>
                <a href="Cart.aspx" class="btn btn-large btn-success"><i class="icon-arrow-left"></i>回購物車</a>
                <%--<input type="submit" value="確定結帳" class="btn-large btn-primary">--%>
                <asp:Button ID="CheckBtn" class="btn-large btn-primary" runat="server" Text="確定結帳" OnClick="CheckBtn_Click" />
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
</asp:Content>

