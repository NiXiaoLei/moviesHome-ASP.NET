using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class admin_text : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.Form["name"];
        string maker = Request.Form["maker"];
       
        string txt = Request.Form["txt"];




        //if (name == null || name.Equals("") || name == null || maker.Equals("") || maker == null || type.Equals("") || type == null || txt.Equals("") || txt == null)//判断用户输入是否为空
        //{
        //    context.Response.Write("<script>alert('电影信息未填写完整！');window.open('./admin_addmovies.aspx','_self');</script>");
        //}
        //if (formCheck.check(name) || formCheck.check(maker) || formCheck.check(type) || formCheck.check(txt))
        //{  //调用防止注入式攻击，查看用户是否输入非法字符串

        //    context.Response.Write("<script>alert('输入含非法字符！');window.open('./admin_addmovies.aspx','_self');</script>");
        //    return;

        //}
    }
}
