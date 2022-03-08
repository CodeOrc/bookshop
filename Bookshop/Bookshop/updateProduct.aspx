<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string id = Request.QueryString["id"];
            Book book = BookUtility.getBookById(int.Parse(id));
            Label1.Text = book.Id.ToString();
            BookNameBox.Text = book.BookName;
            AuthorBox.Text = book.Author;
            PublisherBox.Text = book.Publisher;
            PublicationDateBox.Text = book.PublicationDate;
            PriceBox.Text = book.Price.ToString();
            DropDownList1.Items.FindByValue(book.Category.ToString()).Selected = true;
            PreviewImgBox.Text = book.PreviewImg;
            PreviewCountBox.Text = book.PreviewCount.ToString();

            string[] previews = new string[book.PreviewCount];
            for (int i = 0; i < book.PreviewCount; i++)
            {
                previews[i] = book.PreviewImg.Replace("_00.jpg", $"_0{i.ToString()}.jpg");
            }
            ImgRepeat.DataSource = previews;
            ImgRepeat.DataBind();

        }
    }

    protected void editBtn_Click(object sender, EventArgs e)
    {
        Book tempB = new Book()
        {
            Id = int.Parse(Label1.Text),
            BookName = BookNameBox.Text,
            Author = AuthorBox.Text,
            Publisher = PublisherBox.Text,
            PublicationDate = PublicationDateBox.Text,
            Price = int.Parse(PriceBox.Text),
            Category = int.Parse(DropDownList1.SelectedItem.Value),
            //PreviewImg = PreviewImgBox.Text,
            //PreviewCount = int.Parse(PreviewCountBox.Text)
        };
        int imgcount = 0;
        string fileName = PreviewImgBox.Text.Split('/')[2].Split('_')[0];
        string categorypath = "";
        switch (int.Parse(DropDownList1.SelectedItem.Value))
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
                string tempfileName = fileName + "_" + imgcount.ToString("00");
                imgcount += 1;
                string subname = "." + File.FileName.Split('.')[1];
                File.SaveAs(Server.MapPath("Images/Books/" + categorypath + "/" + tempfileName + subname));
            }
            tempB.PreviewImg = "Books/" + categorypath + "/" + fileName + "_00.jpg";
            tempB.PreviewCount = imgcount;
        }
        else {
            tempB.PreviewImg = PreviewImgBox.Text;
            tempB.PreviewCount = int.Parse(PreviewCountBox.Text);
        }
        BookUtility.updateBookById(tempB);
        Response.Redirect("~/productsList.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <h5 style="background-color:cadetblue">修改產品資料</h5>
        <table style="border-collapse:collapse;">
           
                <tr>
                    <td>產品ID:</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Style="text-align: center"></asp:Label>
                    </td>
                </tr>
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

                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem Value="1">美術設計</asp:ListItem>
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
                    
                    <asp:Repeater ID="ImgRepeat" runat="server"><ItemTemplate>
                        <img alt=""  style="width:100px" src="Images/<%# Container.DataItem%>" />
                        </ItemTemplate></asp:Repeater>


                   
                </td>
            </tr>
             <tr>
                <td>新預覽圖上傳:</td>
                <td>
                    <asp:Label ID="PreviewImgBox" runat="server"></asp:Label><br/>
                    <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True" />
                </td>
            </tr>
            <tr>
                <td>預覽圖數量:</td>
                <td>
                    <asp:Label ID="PreviewCountBox" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="editBtn" runat="server" Text="編輯" OnClick="editBtn_Click" />
                </td>
            </tr>
        </table>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
</asp:Content>

