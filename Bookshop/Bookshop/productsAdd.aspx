<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">

    protected void addBtn_Click(object sender, EventArgs e)
    {

        Book book = new Book()
        {
            BookName =BookNameBox.Text,
            Author =AuthorBox.Text,
            Publisher =PublisherBox.Text,
            PublicationDate =PublicationDateBox.Text,
            Price = int.Parse(PriceBox.Text),
            Category = int.Parse(CategoryBox.SelectedItem.Value),

        };
        int imgcount = 0;
        string categorypath = "";
        switch (int.Parse(CategoryBox.SelectedItem.Value))
        {
            case 1:
                categorypath = "art";
                break;
            case 2:
                categorypath = "cook";
                break;
            case 3:
                categorypath = "language";
                break;
            case 4:
                categorypath = "life";
                break;
            case 5:
                categorypath = "literature";
                break;
            case 6:
                categorypath = "story";
                break;
            case 7:
                categorypath = "demo";
                break;
        }

        if (FileUpload1.HasFiles)
        {
            foreach (HttpPostedFile File in FileUpload1.PostedFiles)
            {
                string fileName = PreviewImgBox.Text + "_" + imgcount.ToString("00");
                imgcount += 1;
                string subname = "." + File.FileName.Split('.')[1];
                File.SaveAs(Server.MapPath("Images/Books/" + categorypath + "/" + fileName + subname));
            }
            book.PreviewImg = "Books/" + categorypath + "/" + PreviewImgBox.Text + "_00.jpg";
            book.PreviewCount = imgcount;
            BookUtility.insertBook(book);
            Response.Redirect("~/productsList.aspx");
        }

    }

    protected void demoBtn_Click(object sender, EventArgs e)
    {
        BookNameBox.Text = "威利在哪裡? ";
        AuthorBox.Text = "馬丁．韓福特";
        PublisherBox.Text = "親子天下出版社";
        PublicationDateBox.Text = "2021/04/15";
        PriceBox.Text="350";
        CategoryBox.SelectedIndex=6;
        PreviewImgBox.Text = "威利在哪裡";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

 <h5 style="background-color:cadetblue">新增產品資料</h5>
            
    <table style="border-collapse:collapse; padding:5px;">

       
                
            <tr>
                <td>書名:</td>
                <td>
                    <asp:TextBox ID="BookNameBox" runat="server"></asp:TextBox>
                </td>
            </tr>
        <tr>
            <td>作者:</td>
            <td>
                <asp:TextBox ID="AuthorBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>出版社:</td>
            <td>
                <asp:TextBox ID="PublisherBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>出版日期:</td>
            <td>
                <asp:TextBox ID="PublicationDateBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>價格:</td>
            <td>
                <asp:TextBox ID="PriceBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>類別:</td>
            <td>
                <asp:DropDownList ID="CategoryBox" runat="server">
                    <asp:ListItem Selected="True" Value="1">美術設計</asp:ListItem>
                    <asp:ListItem Value="2">料理，食譜</asp:ListItem>
                    <asp:ListItem Value="3">語言學習</asp:ListItem>
                    <asp:ListItem Value="4">生活，手工藝</asp:ListItem>
                    <asp:ListItem Value="5">文學</asp:ListItem>
                    <asp:ListItem Value="6">圖畫書，繪本</asp:ListItem>
                    <asp:ListItem Value="7">上傳測試用</asp:ListItem>
                </asp:DropDownList>

            </td>
        </tr>
        <tr>
            <td>預覽圖:</td>
            <td>
                <asp:TextBox ID="PreviewImgBox" runat="server" placeholder="請輸入指定名稱，以進行檔名統一化"></asp:TextBox>
               <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True" />
            </td>
        </tr>
        <%--<tr><td>預覽圖數量:</td><td> <asp:TextBox ID="PreviewCountBox" runat="server"></asp:TextBox> </td></tr>--%>
        <tr>
            <td>
                <asp:Button ID="demoBtn" runat="server" Text="Demo測試資料" onclick="demoBtn_Click"/>
                <asp:Button ID="addBtn" runat="server" Text="新增" OnClick="addBtn_Click" />
            </td>
        </tr>
    </table>
    
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
    <script>


</script>
</asp:Content>

