<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["LoginInfo"] != null)
            {

                Response.Redirect("~/Products.aspx");
            }
        }
    }


    protected void Register_Click(object sender, EventArgs e)
    {
        if (userIdBox.Text != ""
             && passwordBox1.Text != ""
             && passwordBox2.Text != ""
             && emailBox.Text != ""
             && passwordBox1.Text == passwordBox2.Text)
        {
            Label1.Text = MemberUtility.MemberExist(userIdBox.Text).ToString();
            if (MemberUtility.MemberExist(userIdBox.Text) == false)
            {
                Member m = new Member()
                {
                    UserId = userIdBox.Text,
                    Password = passwordBox2.Text,
                    Email = emailBox.Text
                };
                if (FileUpload1.HasFile)
                {
                    FileUpload1.SaveAs(Server.MapPath("Images/users/" + FileUpload1.FileName));
                    m.UserImg = FileUpload1.FileName;
                }
                else
                { m.UserImg = "user.png"; }
                MemberUtility.addMember(m);
                ScriptManager.RegisterStartupScript(this.Register, this.GetType(), "alert",
            "alert('註冊成功');location.href='login.aspx';", true);
                //Response.Redirect("~/login.aspx");
            }
            else { userLabel.Text = "此帳號名稱已有人使用"; }
        }
        else
        {
            if (userIdBox.Text == "")
            {
                userLabel.Text = "*請輸入帳號";
            }

            if (passwordBox1.Text == "")
            {
                passwordLabel.Text = "*請輸入密碼";
            }
            else
            {
                if (passwordBox2.Text == "")
                {
                    passwordLabel2.Text = "*請再次輸入密碼";
                }
                else if (passwordBox1.Text != passwordBox2.Text)
                {
                    passwordLabel2.Text = "密碼不相符";
                }
            }

            if (emailBox.Text == "")
            {
                emailLabel.Text = "*請輸入電子信箱";
            }

        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        userIdBox.Text = "tony";
        passwordBox1.Text = "111";
        passwordBox2.Text = "111";
        emailBox.Text = "test@test.com";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
        <%-- <Triggers>
            <asp:PostBackTrigger ControlID="Register" />
        </Triggers>--%>
        <%--<ContentTemplate>--%>

            <h3>註冊帳號</h3>
            <div class="well">
                <div class="form-horizontal">
                    <h4>個人資訊</h4>
                    <div class="control-group">
                        <label class="control-label" for="inputFname1">帳戶名稱: <sup>*</sup></label>
                        <div class="controls">
                            
                            <asp:TextBox ID="userIdBox" runat="server"></asp:TextBox>
                            <asp:Label ID="userLabel" runat="server" class="text-error" Text="" EnableViewState="False"></asp:Label>
                            
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputPassword1">密碼 <sup>*</sup></label>
                        <div class="controls">
                            
                            <asp:TextBox ID="passwordBox1" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:Label ID="passwordLabel" class="text-error" runat="server" Text="" EnableViewState="False"></asp:Label>
                           
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputPassword1">確認密碼 <sup>*</sup></label>
                        <div class="controls">
                           
                            <asp:TextBox ID="passwordBox2" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:Label ID="passwordLabel2" runat="server" class="text-error" Text="" EnableViewState="False"></asp:Label>
                          
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="input_email">電子信箱 <sup>*</sup></label>
                        <div class="controls">
                           
                            <asp:TextBox ID="emailBox" runat="server"></asp:TextBox>
                            <asp:Label ID="emailLabel" runat="server" class="text-error" Text="" EnableViewState="False"></asp:Label>
                           
                        </div>

                    </div>
                    <div class="control-group">
                        <label class="control-label">用戶圖片 </label>
                        <div class="controls">
                            <asp:FileUpload ID="FileUpload1" runat="server" />

                        </div>
                    </div>
                    <p><sup>*</sup>Required field	</p>
                    <div class="control-group">
                        <div class="controls">

                            <asp:Button ID="Button1" runat="server" Text="Demo" OnClick="Button1_Click" />
                            <asp:Button ID="Register" class="btn btn-large btn-success" OnClick="Register_Click"
                                OnClientClick="infocheck()" runat="server" Text="註冊" />
                            <asp:Label ID="Label1" runat="server" Text="用戶是否存在" Enabled="False"></asp:Label>

                        </div>
                    </div>
                </div>
            </div>


      <%--  </ContentTemplate>
    </asp:UpdatePanel>--%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
    <script>
        function infocheck() {
            if ($("#ContentPlaceHolder1_userIdBox").val() != "" &&
                $("#ContentPlaceHolder1_passwordBox1").val() != "" &&
                $("#ContentPlaceHolder1_passwordBox2").val() != "" &&
                $("#ContentPlaceHolder1_passwordBox1").val() == $("#ContentPlaceHolder1_passwordBox2").val() &&
                $("#ContentPlaceHolder1_emailBox").val() != ""
            )
            { }
            else {
                $("#ContentPlaceHolder1_userLabel").text("");
                $("#ContentPlaceHolder1_passwordLabel").text("");
                $("#ContentPlaceHolder1_passwordLabel2").text("");
                $("#ContentPlaceHolder1_emailLabel").text("");

                if ($("#ContentPlaceHolder1_userIdBox").val() == "") { $("#ContentPlaceHolder1_userLabel").text("*請輸入帳號") }

                if ($("#ContentPlaceHolder1_passwordBox1").val() == "") { $("#ContentPlaceHolder1_passwordLabel").text("*請輸入密碼") }
                else {
                    if ($("#ContentPlaceHolder1_passwordBox2").val() == "") { $("#ContentPlaceHolder1_passwordLabel2").text("*請再次輸入密碼") }
                    else if ($("#ContentPlaceHolder1_passwordBox1").val() != $("#ContentPlaceHolder1_passwordBox2").val()) { $("#ContentPlaceHolder1_passwordLabel2").text("密碼不相符") }
                }
                if ($("#ContentPlaceHolder1_emailBox").val() == "") { $("#ContentPlaceHolder1_emailLabel").text("*請輸入電子信箱") }
               

                event.preventDefault();
            }
        }

    </script>
</asp:Content>

