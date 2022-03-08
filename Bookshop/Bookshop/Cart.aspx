<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginInfo"] == null)
        {
            Response.Redirect("~/login.aspx?from=cart");
        }
        if (!Page.IsPostBack)
        {
            if (Session["cart"] != null)
            {
                Dictionary<int, int> cart = (Dictionary<int, int>)Session["cart"];
                List<Cart> cartlist = new List<Cart>();
                //int total=0;
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
                    //total += tempC.subtotal;
                    cartlist.Add(tempC);
                }
                Repeater1.DataSource = cartlist;
                Repeater1.DataBind();


                //Label1.Text = total.ToString();
            }

           

        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <h3>購物車 </h3>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    <hr class="soft">
    <%--<table class="table table-bordered">
		<tbody><tr><th> I AM ALREADY REGISTERED  </th></tr>
		 <tr> 
		 <td>
			<form class="form-horizontal">
				<div class="control-group">
				  <label class="control-label" for="inputUsername">Username</label>
				  <div class="controls">
					<input type="text" id="inputUsername" placeholder="Username">
				  </div>
				</div>
				<div class="control-group">
				  <label class="control-label" for="inputPassword1">Password</label>
				  <div class="controls">
					<input type="password" id="inputPassword1" placeholder="Password">
				  </div>
				</div>
				<div class="control-group">
				  <div class="controls">
					<button type="submit" class="btn">Sign in</button> OR <a href="register.html" class="btn">Register Now!</a>
				  </div>
				</div>
				<div class="control-group">
					<div class="controls">
					  <a href="forgetpass.html" style="text-decoration:underline">Forgot password ?</a>
					</div>
				</div>
			</form>
		  </td>
		  </tr>
	</tbody></table>--%>

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
                            <img width="150" src="<%# Eval("PreviewImg","Images/{0}") %>" alt=""></td>
                        <td><%# Eval("BookName") %></td>
                        <td>
                            <div class="input-append">
                                <input class="span1 qty" style="max-width: 34px" value="<%# Eval("Amount") %>"
                                    id="appendedInputButtons" size="16" type="text" readonly="readonly">
                                <button class="btn minusbtn" type="button" value="-1">
                                    <i class="icon-minus"></i>
                                </button>
                                <button class="btn plusbtn" type="button" value="1">
                                    <i class="icon-plus"></i>
                                </button>
                                <button class="btn btn-danger removebtn" type="button">
                                    <i class="icon-remove icon-white"></i>
                                </button>

                                <input type="hidden" value="<%# Eval("Id") %>" />

                            </div>
                        </td>
                        <td><%# Eval("Price") %></td>

                        <td class="subtotal"><%# Eval("subtotal") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate></FooterTemplate>

            </asp:Repeater>

            <tr>
                <td colspan="4" style="text-align: right">Total Price:	</td>
                <td id="total">
                    <%-- <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
                </td>
            </tr>

        </tbody>
    </table>


    <a href="products.aspx" class="btn btn-large"><i class="icon-arrow-left"></i>繼續購物</a>
    <a href="checkout.aspx" class="btn btn-large pull-right">結帳 <i class="icon-arrow-right"></i></a>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
    <script>
        $(function () {
            $(".minusbtn,.plusbtn ").click(function () {
                //alert($(this).parent().find('[type=hidden]').val())
                var _id = $(this).parent().find('[type=hidden]').val();
                var qty = parseInt($(this).parent().find('.qty').val());
                var _amount = parseInt($(this).val());
                var myData = { id: _id, amount: _amount };
                var subtotal=0;
                $.ajax({
                    type: "Post",
                    async:false,
                    url: "/WebService.asmx/changeCartAmount",
                    contentType: "application/json;utf-8",
                    dataType: "json",
                    data: JSON.stringify(myData),
                    success: function (data) {
                        subtotal=subtotal+data.d["subtotal"];
                        $("#total").text(data.d["total"]);
                        }
                    //});
                });
                //alert($(this).parent().find('.qty').val());
                $(this).parents("tr").find('.subtotal').text(subtotal);
                
                $(this).parent().find('.qty').val(qty + _amount);
                if ($(this).parent().find('.qty').val() < 1)
                {
                    $(this).parent().find('.qty').val(1);
                }
               
            })
        });

        $(function () {
            $(".removebtn").click(function () {
                //alert($(this).parent().find('[type=hidden]').val())
                var _id = $(this).parent().find('[type=hidden]').val();
                var myData = { id: _id };

                $.ajax({
                    type: "Post",
                    url: "/WebService.asmx/deleteCartItem",
                    contentType: "application/json;utf-8",
                    dataType: "json",
                    data: JSON.stringify(myData),
                    success: function (data) { $("#total").text(data.d); }
                });

                $(this).parents("tr").remove();
            })
        });
        $(function () {
            $.ajax({
                type: "POST",
                url: "/WebService.asmx/getCartTotalPrice",
                contentType: "application/json;utf-8",

                success: function (data) { $("#total").text(data.d); }
            });


        });
    </script>

</asp:Content>
