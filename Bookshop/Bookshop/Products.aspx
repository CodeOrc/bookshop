<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["Category"] != null)
            {
                string category = Request.QueryString["Category"];
                List<Book> Books = BookUtility.getBooksByCategory(int.Parse(category));
                Repeater1.DataSource = Books;
                Repeater1.DataBind();
                Repeater2.DataSource = Books;
                Repeater2.DataBind();
            }
            else if(Request.QueryString["search"] != null)
            {
                string search = Request.QueryString["search"];
                List<Book> Books = BookUtility.getBookByName(search);
                if (Books == null) { srchResult.Text = "查無結果"; }
                else
                {
                    Repeater1.DataSource = Books;
                    Repeater1.DataBind();
                    Repeater2.DataSource = Books;
                    Repeater2.DataBind();
                }
            }
            else
            {
                List<Book> Books = BookUtility.getAllBooks();
                Repeater1.DataSource = Books;
                Repeater1.DataBind();
                Repeater2.DataSource = Books;
                Repeater2.DataBind();
            }

        }
    }

    //public static string ChangeString(object o)
    //{
    //    return o.ToString() + "123";

    //}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--<ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Products Name</li>
    </ul>--%>
    <h3>產品項目 </h3>

    <div class="form-horizontal span6">
        <div class="control-group">
            <%--<label class="control-label alignL">Sort By </label>--%>
         <%--   <select>
                <option>Priduct name A - Z</option>
                <option>Priduct name Z - A</option>
                <option>Priduct Stoke</option>
                <option>Price Lowest first</option>
            </select>--%>
        </div>
    </div>

    <div id="myTab" class="pull-right">
        <a href="#listView" data-toggle="tab"><span class="btn btn-large"><i class="icon-list"></i></span></a>
        <a href="#blockView" data-toggle="tab"><span class="btn btn-large btn-primary"><i class="icon-th-large"></i></span></a>
    </div>
    <br class="clr">
    <h1>
        <asp:Label ID="srchResult" runat="server" Text=""></asp:Label>

    </h1>
    <div class="tab-content">

        <div class="tab-pane active" id="listView">
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="row">
                        <div class="span3">
                            <a href="<%# Eval("Id","Product_details.aspx?id={0}") %>">
                                <img src="<%# Eval("PreviewImg","Images/{0}") %>" alt="" style="width: 250px" />
                            </a>
                        </div>
                        <div class="span4">
                            <a href="<%# Eval("Id","Product_details.aspx?id={0}") %>"><h3><%#  Eval("BookName") %></h3></a>
                            <hr class="soft">
                            <h5>
                                <p>
                                    作者: <%# Eval("Author") %>
                                    <br />
                                    出版社: <%# Eval("Publisher") %>
                                    <br />
                                    出版日期: <%# Eval("PublicationDate") %>
                                </p>
                            </h5>
                            
                            <br class="clr">
                        </div>
                        <div class="span2 alignR">
                            <div class="form-horizontal qtyFrm">
                                <h3>$<%# Eval("Price") %></h3>
                                <button id="cartbtn" type="button" class="btn cartbtn" value="<%# Eval("Id") %>">加入購物車 <i class=" icon-shopping-cart"></i></button>

                            </div>
                        </div>
                    </div>
                    <hr class="soft">
                </ItemTemplate>
                <FooterTemplate></FooterTemplate>
            </asp:Repeater>
        </div>

        <div class="tab-pane" id="blockView">
            <asp:Repeater ID="Repeater2" runat="server">
                <HeaderTemplate>
                    <ul class="thumbnails span9" style="display:flex; align-content:center">
                </HeaderTemplate>
                <ItemTemplate>

                    <li class="span3" >
                        <div class="thumbnail span3">
                            
                                <a href="<%# Eval("Id","Product_details.aspx?id={0}") %>">
                                    <img src="<%# Eval("PreviewImg","Images/{0}") %>" alt="" style="width: 160px" /></a>
                       
                            <div class="caption">
                                <h5 style="text-align: center">
                                    <%# Eval("BookName") %>
                                </h5>
                                <p>
                                    作者: <%# Eval("Author") %>
                                    <br />
                                    出版社: <%# Eval("Publisher") %>
                                    <br />
                                    $<%# Eval("Price") %>
                                    <br />
                                </p>
                                <h4 style="text-align: center; vertical-align: bottom">
                                   <button id="cartbtn" type="button" class="btn cartbtn" value="<%# Eval("Id") %>" >Add to <i class="icon-shopping-cart"></i></a></button>
                                   

                                </h4>
                            </div>
                        </div>
                    </li>



                </ItemTemplate>
                <FooterTemplate></ul></FooterTemplate>
            </asp:Repeater>
            <hr class="soft">
        </div>

        
    </div>


    <%--<div class="pagination">
        <ul>
            <li><a href="#">‹</a></li>
            <li><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">...</a></li>
            <li><a href="#">›</a></li>
        </ul>
    </div>--%>
    <br class="clr">
    
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" Runat="Server">
 <script>
        $(function(){
            $(".cartbtn").click(function () {
                //alert($(this).val())
                
                var myData = {id:$(this).val(),amount:1}
           
               
                $.ajax({
                    type: "Post",
                    url: "/WebService.asmx/addToCart",
                    contentType: "application/json;utf-8",
                    dataType: "json",
                    data: JSON.stringify(myData),
                     success: function () {
                         alert("加入購物車成功");
                                }
                   
                });
            });
        });

    </script>

</asp:Content>
