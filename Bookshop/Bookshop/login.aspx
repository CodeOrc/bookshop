<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["LoginInfo"] != null)
            {
                if (Request.QueryString["from"] == null)
                {
                    Response.Redirect("~/Products.aspx");
                }
                else
                {
                    string from = Request.QueryString["from"];
                    Response.Redirect($"~/{from}.aspx");
                }
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        if (IdBox.Text == "")
        {
            Label1.Text = "請輸入帳號";
        }
        else if (PasswordBox.Text == "") { Label1.Text = "請輸入密碼"; }
        else
        {
            Member m = MemberUtility.userLogin(IdBox.Text);
            if (m is null)
            {
                Label1.Text = "登入失敗,請檢查帳號與密碼";
            }
            else if (m.Password != PasswordBox.Text)
            { Label1.Text = "密碼錯誤，請檢查帳號與密碼"; }
            else
            {
                Session["LoginInfo"] = m;
                Label1.Text = "登入成功";
                if (Request.QueryString["from"] == null)
                {
                    Response.Redirect("~/Products.aspx");
                }
                else
                { string from = Request.QueryString["from"];
                    Response.Redirect($"~/{from}.aspx");
                }
            }
        }
    }



</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="span9">
        <h3>Login</h3>
        <hr class="soft">


        <div class="row">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <div class="span4">
                        <div class="well">
                            <h5>使用者登入</h5>
                            <div>
                                <div class="control-group">
                                    <label class="control-label" for="Idinput">帳號</label>
                                    <div class="controls">
                                        <asp:TextBox ID="IdBox" class="span3" onkeydown="onEnterDown(event)" runat="server">Tony</asp:TextBox>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputPassword">密碼</label>
                                    <div class="controls">
                                        <asp:TextBox ID="PasswordBox" class="span3" onkeydown="onEnterDown2(event)" runat="server" >tony123</asp:TextBox>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                       
                                        <asp:Button ID="Button1" runat="server" Text="登入" OnClick="Button1_Click" />
                                        <a href="forgetpassword.aspx" class="text-info">忘記密碼?</a><br />
                                        <asp:Label ID="Label1" CssClass="text-error" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="span1">&nbsp;</div>
            <div class="span4">
                <div class="well">
                    <h5>註冊帳號</h5>
                    <br>
                    <%--Enter your e-mail address to create an account.<br><br><br>--%>
                    <div>
                        <%-- <div class="control-group">
				<label class="control-label" for="inputEmail0">E-mail address</label>
				<div class="controls">
				  <input class="span3" type="text" id="inputEmail0" placeholder="Email">
				</div>
			  </div>--%>
                        <div class="controls">
                           <button type="button" class="btn block" onclick="location.href='Register.aspx'" >創建帳號</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
    <script>

        function onEnterDown(e) {
            if (e.keyCode == 13) {
                document.getElementById("ContentPlaceHolder1_PasswordBox").focus();
                event.preventDefault();
            };
        }
        function onEnterDown2(e) {
            if (e.keyCode == 13) {
                $("#ContentPlaceHolder1_Button1").focus();
                event.preventDefault();
            };
        }

       
    </script>
</asp:Content>

