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

public partial class admin_MasterPage : System.Web.UI.MasterPage
{
    public string status = "";
   public string user="";
    protected void Page_Load(object sender, EventArgs e)
    {
        string level = "";
        if (!IsPostBack) {
            if (Session["level"] == null || Session["level"]=="")
            {
                Response.Write("<script>alert('尚未登陆，请先登录!');window.location.href=\"../Login.aspx\"</script>");
            }
            else {
                level = Session["level"].ToString();
            }

            if (Session["userName"] == null || Session["userName"]=="")
            {
                Response.Write("<script>alert('尚未登陆，请先登录!');window.location.href=\"../Login.aspx\"</script>");
            }
            else {
                user = Session["userName"].ToString();
            }

        
            if (level == "1")
            {
                status = "<div class=\"sBox\"><div class=\"subNav sublist-down\"><span class=\"title-icon glyphicon glyphicon-chevron-down\"></span><span class=\"sublist-title\">分类管理</span>"+
        "</div><ul class=\"navContent\" style=\"display:block\"><li class=\"active\"><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />视频分类</div>"+
            "<a href=\"#\" class=\"tac1\"><span class=\"sub-title\" >视频分类</span></a> </li>"+
        "</ul></div><div class=\"sBox \"><div class=\"subNav sublist-up\"><span class=\"title-icon glyphicon glyphicon-chevron-up\"></span><span class=\"sublist-title\">信息管理  </span></div>"+
      "<ul class=\"navContent\" style=\"display:none\"><li><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />查看视频</div>" +
               "<a href=\"admin_moviesList.aspx\" class=\"tac1\"><span class=\"sub-title\">查看视频</span></a></li><li><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />添加视频</div> <a href=\"admin_addMovies.aspx\" class=\"tac1\"><span class=\"sub-title\">添加视频</span></a></li>" +
           "</ul></div><div class=\"sBox\"><div class=\"subNav sublist-up\"><span class=\"title-icon glyphicon glyphicon-chevron-up\"></span><span class=\"sublist-title\">网站信息 </span></div>" +
           "<ul class=\"navContent\" style=\"display:none\"><li><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />权限更改</div><a href=\"#\" class=\"tac1\"><span class=\"sub-title\">权限更改</span></a></li>" +
            " <li><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />网站日志</div><a href=\"admin_log.aspx\" class=\"tac1\"><span class=\"sub-title\">网站日志</span></a></li> </ul></div>";
            }
            else {
                status = "<div class=\"sBox \"><div class=\"subNav sublist-up\"><span class=\"title-icon glyphicon glyphicon-chevron-up\"></span><span class=\"sublist-title\">信息管理  </span></div>"+
      "<ul class=\"navContent\" style=\"display:none\"><li><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />查看视频</div>" +
                 "<a href=\"admin_moviesList.aspx\" class=\"tac1\"><span class=\"sub-title\">查看视频</span></a></li>" +
             "</ul></div><div class=\"sBox\"><div class=\"subNav sublist-up\"><span class=\"title-icon glyphicon glyphicon-chevron-up\"></span><span class=\"sublist-title\">网站信息 </span></div>" +
             "<ul class=\"navContent\" style=\"display:none\"><li><div class=\"showtitle\" style=\"width:100px;\"><img src=\"img/leftimg.png\" />网站日志</div><a href=\"admin_log.aspx\" class=\"tac1\"><span class=\"sub-title\">网站日志</span></a></li> </ul></div>";

            }
           
        
        
        
        
        }
    }
}
