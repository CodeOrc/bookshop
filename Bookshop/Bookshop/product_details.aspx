<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            string id = Request.QueryString["Id"];
            Book book = BookUtility.getBookById(int.Parse(id));
            Bookname.Text = book.BookName;
            Author.Text = book.Author;
            Publisher.Text = book.Publisher;
            PublicationDate.Text = book.PublicationDate;
            price.Text = book.Price.ToString();
            HyperLink1.NavigateUrl = $"Images/{book.PreviewImg}";
            Image1.ImageUrl = $"Images/{book.PreviewImg}";
            if (BookUtility.getBookContentById(int.Parse(id)) == null) { content.Text = "無書本簡介"; }
            else{
                content.Text = BookUtility.getBookContentById(int.Parse(id));
            }
            string[] previews = new string[book.PreviewCount - 1];
            for (int i = 1; i < book.PreviewCount; i++)
            {
                previews[i - 1] = book.PreviewImg.Replace("_00.jpg", $"_0{i.ToString()}.jpg");
            }
            Repeater1.DataSource = previews;
            Repeater1.DataBind();

        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div id="gallery" class="span4">

            <asp:HyperLink ID="HyperLink1" runat="server">
                <asp:Image ID="Image1" runat="server" Width="250px" />
            </asp:HyperLink>
            <br />
            <br />
            <div id="differentview" class="moreOptopm carousel slide">
                <div class="carousel-inner">
                    <div class="item active">

                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <a href="Images/<%# Container.DataItem%>">
                                    <img style="width: 29%" src="Images/<%# Container.DataItem%>" alt=""></a>
                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </div>

                <%--  <a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>
              <a class="right carousel-control" href="#myCarousel" data-slide="next">›</a> --%>
            </div>

        </div>
        <div class="span5">

            <h3>
                <asp:Label ID="Bookname" runat="server" Text="Label"></asp:Label>
            </h3>
            <h5>作者:
                <asp:Label ID="Author" runat="server" Text="Label"></asp:Label>
                <br />
                出版社:
                <asp:Label ID="Publisher" runat="server" Text="Label"></asp:Label>
                <br />
                出版日期:<asp:Label ID="PublicationDate" runat="server" Text="Label"></asp:Label>
                <br />
            </h5>
            <hr class="soft">
            <asp:Label ID="content" runat="server" Text="Label"></asp:Label>

            <hr class="soft">

            <div class="form-horizontal qtyFrm">
                <div class="control-group">
                    <label class="control-label">
                        <asp:Label ID="price" class="control-label" runat="server"></asp:Label></label>
                    <div class="controls">
                        <input id="qty" type="number" class="span1" placeholder="1" min="1">
                        <button id="cartbtn" type="button" class="btn btn-large btn-primary pull-right" >加入購物車 <i class=" icon-shopping-cart"></i></button>

                    </div>
                </div>
            </div>
            <br class="clr">
            <hr class="soft">
        </div>

    </div>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" Runat="Server">
 <script>
        $(function(){
            $("#cartbtn").click(function () {
                var query = location.search.split("=")[1];
                var myData = { id: query, amount: $("#qty").val() };
           
                //alert(location.search.split("=")[1])
                $.ajax({
                    type: "Post",
                    url: "/WebService.asmx/addToCart",
                    contentType: "application/json;utf-8",
                    dataType: "json",
                    data: JSON.stringify(myData),
                   success:function () {
                         alert("加入購物車成功");
                                }
                });
            });
        });

    </script>

</asp:Content>