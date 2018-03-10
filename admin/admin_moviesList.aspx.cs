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

public partial class admin_admin_moviesList : System.Web.UI.Page
{
    //public string moviesList = "";
    public string type = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //string sqlc = "select COUNT(*) from movielist";
        //string sql = "SELECT TOP 5 * FROM movielist WHERE id NOT IN (SELECT TOP 5 id FROM movielist)";
        string sqlt = "select * from types";
        DataSet dst = DBHelper.exeSql(sqlt);
        //DataSet ds = DBHelper.exeSql(sql);
        for (int j = 0; j < dst.Tables[0].Rows.Count;j++)
        {
            int a = j + 1;
        type += "<option value=" + a + ">" + dst.Tables[0].Rows[j]["tname"] + "</option>";
        }
        //for (int i = 0; i < ds.Tables[0].Rows.Count; i++) {
       
        //   string b = ds.Tables[0].Rows[i]["tid"].ToString();
        //   int c = int.Parse(b);
        //   c = c - 1;
        //   moviesList += " <tr style=\"height:130px;\"><td style=\"vertical-align:middle;\"><input type=\"checkbox\"></td><td  style=\"vertical-align:middle;text-align:center\">" + ds.Tables[0].Rows[i]["mname"].ToString() + "</td><td  style=\"vertical-align:middle;text-align:center\">" + dst.Tables[0].Rows[c]["tname"].ToString() + "</td>" +
        //        "<td  style=\"vertical-align:middle;text-align:center\"> <img style=\"width:250px;height:120px\" src=../" + ds.Tables[0].Rows[i]["img"].ToString() + " alt=\"\" /></td><td  style=\"vertical-align:middle;text-align:center\">" + ds.Tables[0].Rows[i]["maker"].ToString() + "</td><td  style=\"vertical-align:middle;text-align:center\">" + ds.Tables[0].Rows[i]["playtimes"].ToString() + "</td> <td  style=\"vertical-align:middle;text-align:center\">" + ds.Tables[0].Rows[i]["onlinetime"].ToString() + "</td><td  style=\"vertical-align:middle;text-align:center\">" + ds.Tables[0].Rows[i]["brief"].ToString() + "</td><td  style=\"vertical-align:middle;text-align:center\"><button type=\"button\" class=\"btn btn-primary btn-sm\">修改</button>&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-default btn-sm\">删除</button></td></tr>";

        //}
    }



}
///// <summary>
/////   构筑成json 格式
///// </summary>
//class moviesInfo
//{
//    public string ys;
//    public string imgUrl;
//    public string playTimes;
//    public moviesInfo(string mName, string imgUrl, string playTimes)
//    {
//        this.mName = mName;
//        this.imgUrl = imgUrl;
//        this.playTimes = playTimes;
//    }
//}