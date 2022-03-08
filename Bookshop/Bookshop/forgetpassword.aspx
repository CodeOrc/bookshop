<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void ForgetpasswordBtn_Click(object sender, EventArgs e)
    {
        bool IdExist = MemberUtility.MemberExist(IdBox.Text);
        if (IdExist == true)
        {
            bool EmailExist = MemberUtility.ifEmailExist(IdBox.Text);
            if (EmailExist == true)
            {
                ScriptManager.RegisterStartupScript(this.ForgetpasswordBtn, this.GetType(), "alert",
                       "alert('新密碼已寄送至帳戶聯絡信箱');location.href='login.aspx';", true);
            }
            else { Label1.Text = "帳戶聯絡信箱與帳戶資料不符"; }
        }
        else
        {
             Label1.Text = "帳戶不存在，請確認帳戶資料";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <div class="well">
        <h2>忘記密碼</h2>
        <div>
            <div class="control-group">
                <label class="control-label" for="Idinput">請輸入帳戶名稱</label>
                <div class="controls">
                    <asp:TextBox ID="IdBox" class="span3" onkeydown="onEnterDown(event)" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputPassword">請輸入帳戶聯絡信箱</label>
                <div class="controls">
                    <asp:TextBox ID="emailBox" class="span3" onkeydown="onEnterDown2(event)" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">

                    <asp:Button ID="ForgetpasswordBtn" runat="server" Text="Button" OnClick="ForgetpasswordBtn_Click" />

                    <asp:Label ID="Label1" CssClass="text-error" runat="server"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptHolder" runat="Server">
    <script>
        function onEnterDown(e) {
            if (e.keyCode == 13) {
                document.getElementById("ContentPlaceHolder1_emailBox").focus();
                event.preventDefault();
            };
        }
        function onEnterDown2(e) {
            if (e.keyCode == 13) {
                $("#ContentPlaceHolder1_ForgetpasswordBtn").focus();
                event.preventDefault();
            };
        }
    </script>
</asp:Content>

