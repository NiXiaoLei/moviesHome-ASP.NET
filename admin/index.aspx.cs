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

public partial class admin_index : System.Web.UI.Page
{
    public string log = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = "select top 8 * from mH_admin_log order by admintime desc";
        DataSet ds=DBHelper.exeSql(sql);
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++) {
            log+="  <div class=\"panel-body\"><div class=\"w15 pull-left\"><img src=\"img/noavatar_middle.gif\" width=\"25\" height=\"25\" alt=\"图片\" class=\"img-circle\">" + ds.Tables[0].Rows[i]["adminname"].ToString() + "</div><div class=\"w55 pull-left\">" + ds.Tables[0].Rows[i]["adminip"].ToString() + "</div><div class=\"w20 pull-left text-center\">" + ds.Tables[0].Rows[i]["admintime"].ToString() + "</div><div class=\"w10 pull-left text-center\"><span class=\"text-green-main\">" + ds.Tables[0].Rows[i]["admintip"].ToString() +"----"+ ds.Tables[0].Rows[i]["adminmovies"].ToString() + "</span></div></div>";
        }

    }
}
