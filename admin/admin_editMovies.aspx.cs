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

public partial class admin_admin_addmovies : System.Web.UI.Page
{
    public string id = "";
    public string mop = "";
    public string name = "";
    public string maker = "";
    public string tid = "";
    public string imgUrl="";
    public string rec = "";
    public string mUrl="";
    public string brief = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["id"] == null || Request["id"] == "") {
           Response.Redirect("admin_moviesList.aspx");
        
        }
    id = Request["id"];
    string sql = "select * from movielist where [id]=" + id ;
    DataSet ds = DBHelper.exeSql(sql);
    string sqlt= "select * from types";
    DataSet dst = DBHelper.exeSql(sqlt);
    for (int i = 0; i < dst.Tables[0].Rows.Count; i++)
    {
        int b = i + 1;
        string aa = i + "";
        if (aa== ds.Tables[0].Rows[0]["tid"].ToString())
        {
            mop += "<option value=" + b +"  selected  >" + dst.Tables[0].Rows[i]["tname"].ToString() + "</option>";
        }
        else {
            mop += "<option value=" + b + ">" + dst.Tables[0].Rows[i]["tname"].ToString() + "</option>";
        
        }
       
    }
    if (ds.Tables[0].Rows[0]["isrecommend"].ToString()== "0" || ds.Tables[0].Rows[0]["isrecommend"].ToString()== "False" || ds.Tables[0].Rows[0]["isrecommend"].ToString() == "false")
    {
        rec = "<input type=\"radio\" name=\"recRd\" id=\"rd2\" value=\"0\"  checked  >";
    }
    else
    {
        rec = "<input type=\"radio\" name=\"recRd\" id=\"rd2\" value=\"0\" >";
    }

    imgUrl = "<img id='picImg' style=\"width: 100%;height: auto;max-height: 140px;\" src=\"../" + ds.Tables[0].Rows[0]["img"].ToString() + "\" alt=\"\" />";
    mUrl = "<input class=\"form-control\"  id=\"banInp\" type=\"text\" placeholder=\"请上传视频\" readonly  style=\"width:400px;\" value=\""+ds.Tables[0].Rows[0]["url"].ToString()+"\">";
    name = ds.Tables[0].Rows[0]["mname"].ToString();
    maker = ds.Tables[0].Rows[0]["maker"].ToString();
    brief = ds.Tables[0].Rows[0]["brief"].ToString();
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
         
    }

}
