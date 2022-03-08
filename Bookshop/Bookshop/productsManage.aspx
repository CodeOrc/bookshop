<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">

</script>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h3>查詢產品</h3>
    <hr />
    <%--    <asp:Label ID="Label1" runat="server" Text="Label">依產品ID查詢</asp:Label>
    <asp:TextBox ID="idSearch" runat="server"></asp:TextBox>
    <asp:Button ID="idSearchBtn" runat="server" Text="Button" />
    <br/>
     <asp:Label ID="Label2" runat="server" Text="Label">依書名查詢</asp:Label>
    <asp:TextBox ID="nameSearch" runat="server"></asp:TextBox>
    <asp:Button ID="nameSearchBtn" runat="server" Text="Button" />
    <br/>--%>
    依產品ID查詢:<input id="idText" type="text" />
    <input id="idSearchBtn" type="button" value="button" /><br />
    依書名查詢:<input id="nameText" type="text" />
    <input id="nameSearchBtn" type="button" value="button" /><br />
    <hr />
 
    <div id="sResult"></div>
    <%--Id 
    BookName
    Author 
    Publisher
    PublicationDate 
    Price 
    Category 
    PreviewImg
    PreviewCount 
    --%>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ScriptHolder" runat="Server">
    <script>
        $(function () {
            $("#nameSearchBtn").click(function search() {
                var _name = $("#nameText").val();
                var mydata = { name: _name };
                $.ajax({
                    type: "Post",
                    url: "/WebService.asmx/getBookByName",
                    contentType: "application/json;utf-8",
                    dataType: "json",
                    data: JSON.stringify(mydata),
                    success: function (data) {
                        $("#sResult").empty();
                        $(data.d).each(function (index,book) {
                            $("#sResult").append(
                            `<div>
                    <table><tr><td>
                    <tr><td>產品ID:</td><td>      <input  type="text" value="${book.Id}"/></td></tr>
                    <tr><td>書名:</td><td>        <input  type="text" value="${book.BookName}"/></td></tr>
                    <tr><td>作者:</td><td>        <input  type="text" value="${book.Author}"/></td></tr>
                    <tr><td>出版社:</td><td>       <input  type="text" value="${book.Publisher}"/></td></tr>
                    <tr><td>出版日期:</td><td>      <input  type="text" value="${book.PublicationDate}"/></td></tr>
                    <tr><td>價格:</td><td>        <input  type="text" value="${book.Price}"/></td></tr>
                    <tr><td>類別:</td><td>        <input  type="text" value="${book.Category}"/></td></tr>
                    <tr><td>預覽圖:</td><td>       <input  type="text" value="${book.PreviewImg}"/></td></tr>
                    <tr><td>預覽圖數量:</td><td>     <input  type="text" value="${book.PreviewCount}"/></td></tr>
                    <tr><td>   <input class="editBtn" type="button" value="編輯" /> 
                               <input class="delBtn" type="button" value="刪除" /></td></tr></table>
                                                   </div>`);});
                        

                        $(".editBtn").click(function () {
                            alert("321");
                        })
                    }
                });
            });


            $("#idSearchBtn").click(function () {
                var _id = parseInt($("#idText").val());
                var mydata = { id: _id };
                $.ajax({
                    type: "Post",
                    url: "/WebService.asmx/getBookById",
                    contentType: "application/json;utf-8",
                    dataType: "json",
                    data: JSON.stringify(mydata),
                    success: function (data) {
                        $("#sResult").empty();
                        alert(data.d.BookName);
                        $("#sResult").append(
                            `<div>
                    <table><tr><td>
                    <tr><td>產品ID:</td><td>      <input  type="text" value="${data.d.Id}"/></td></tr>
                    <tr><td>書名:</td><td>        <input  type="text" value="${data.d.BookName}"/></td></tr>
                    <tr><td>作者:</td><td>        <input  type="text" value="${data.d.Author}"/></td></tr>
                    <tr><td>出版社:</td><td>       <input  type="text" value="${data.d.Publisher}"/></td></tr>
                    <tr><td>出版日期:</td><td>      <input  type="text" value="${data.d.PublicationDate}"/></td></tr>
                    <tr><td>價格:</td><td>        <input  type="text" value="${data.d.Price}"/></td></tr>
                    <tr><td>類別:</td><td>        <input  type="text" value="${data.d.Category}"/></td></tr>
                    <tr><td>預覽圖:</td><td>       <input  type="text" value="${data.d.PreviewImg}"/></td></tr>
                    <tr><td>預覽圖數量:</td><td>     <input  type="text" value="${data.d.PreviewCount}"/></td></tr>
                    <tr><td>   <input class="editBtn" type="button" value="編輯" /> 
                               <input class="delBtn" type="button" value="刪除" /></td></tr></table>
                                                   </div>`);

                        $(".editBtn").click(function () {
                            

                            $.ajax({
                    type: "Post",
                    url: "/WebService.asmx/UpdateBookById",
                    contentType: "application/json;utf-8",
                   
                    success: function (data) { alert(data.d); }
                });



                        })
                    }
                });
            });
            
                //$.ajax({
                //    type: "Post",
                //    url: "/WebService.asmx/UpdateBookById",
                //    contentType: "application/json;utf-8",
                //    success: function (data) { alert(data.d);   }
                //});
                   
            //$("#delBtn").click(function () { });
        });

       


    </script>
</asp:Content>

