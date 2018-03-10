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

public partial class admin_admin_log : System.Web.UI.Page
{
    public string log = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = "select * from mH_admin_log order by  admintime desc";
        DataSet ds = DBHelper.exeSql(sql);
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++) {
            log += "  <tr><td>" + ds.Tables[0].Rows[i]["adminname"].ToString() + "</td><td>" + ds.Tables[0].Rows[i]["adminip"].ToString() + "</td><td>" + ds.Tables[0].Rows[i]["admintime"].ToString() + "</td><td>" + ds.Tables[0].Rows[i]["admintip"].ToString() + "</td><td>" + ds.Tables[0].Rows[i]["adminmovies"].ToString() + "</td></tr> ";
        }





    }
}
