<%@ WebHandler Language="C#" Class="moviesList" %>

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Newtonsoft.Json;

public class moviesList : System.Web.UI.Page
{
   protected void Page_Load(object sender, EventArgs e)
    {
        string cz = Request.Form["cz"];
        if (!formCheck.check(cz)) {
            switch (cz)
            {
                case "fcx":   //查询
                    fcx();
                    break;
                case "del":   //删除
                    del();
                    break;
            }
        
        
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public void fcx()
    {
        string pag = Request.Form["page"].ToString();
        string type = Request.Form["type"].ToString();
        string name = Request.Form["name"].ToString();
        ArrayList arr = new ArrayList();
        if (name !="" || type != "")
        {
            string sql = "SELECT TOP 5 * FROM movielist WHERE 1=1";
            string sqlc = "SELECT TOP 5 COUNT(*) FROM movielist WHERE 1=1";
            if (type != "0" )
            {
                sql = sql + " and tid='" + type + "'";
                sqlc= sqlc + " and tid='" + type + "'"; 
            }
            if (name != "")
            {
                sql = sql + " and [mname] like  '%"+name+"%'";
                sqlc = sqlc + " and [mname] like  '%" + name + "%'";
            }
            DataSet ds = DBHelper.exeSql(sql);
            string sqlt = "select * from types";
            DataSet dst = DBHelper.exeSql(sqlt);
            string len = ys(sqlc);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string a = ds.Tables[0].Rows[i]["tid"].ToString();
                int c = int.Parse(a) - 1;
                string ty = dst.Tables[0].Rows[c]["tname"].ToString();
                movies w = new movies(ds.Tables[0].Rows[i]["id"].ToString(), ds.Tables[0].Rows[i]["mname"].ToString(), ty, ds.Tables[0].Rows[i]["img"].ToString(), ds.Tables[0].Rows[i]["maker"].ToString(), ds.Tables[0].Rows[i]["playtimes"].ToString(), ds.Tables[0].Rows[i]["onlinetime"].ToString(), ds.Tables[0].Rows[i]["brief"].ToString(), len);
                arr.Add(w);

            }
            string result = JsonConvert.SerializeObject(arr);
            Response.Write(result);
        }
        else
        {
            int page = int.Parse(pag);
            page = page - 1;
            page = page * 5;
            string sql = "SELECT TOP 5 * FROM movielist WHERE id NOT IN (SELECT TOP " + page + " id FROM movielist order by id desc) order by id desc"; 
            DataSet ds = DBHelper.exeSql(sql);
            string sqlt = "select * from types";
            DataSet dst = DBHelper.exeSql(sqlt);
            string sqlc = "select COUNT(*) from movielist";
            string len = ys(sqlc);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string a = ds.Tables[0].Rows[i]["tid"].ToString();
                int c = int.Parse(a) - 1;
                string ty = dst.Tables[0].Rows[c]["tname"].ToString();
                movies w = new movies(ds.Tables[0].Rows[i]["id"].ToString(),ds.Tables[0].Rows[i]["mname"].ToString(), ty, ds.Tables[0].Rows[i]["img"].ToString(), ds.Tables[0].Rows[i]["maker"].ToString(), ds.Tables[0].Rows[i]["playtimes"].ToString(), ds.Tables[0].Rows[i]["onlinetime"].ToString(), ds.Tables[0].Rows[i]["brief"].ToString(),len);
                arr.Add(w);

            }
            string result = JsonConvert.SerializeObject(arr);
            Response.Write(result);
        }
      
      
    }
     
    public string ys(string sql) {
        DataSet ds = DBHelper.exeSql(sql);
        string i = ds.Tables[0].Rows[0][0].ToString();
        return i;
    }
    public void del()
    {
           string name= Request.Form["name"].ToString();
           string sql = "DELETE FROM movielist WHERE [mname] in (" + name + ")";
           int i = DBHelper.exeNonSql(sql);


           //string user = Session["userName"].ToString(); 
           //DateTime time = DateTime.Now;//获取当前时间
           //string strTime = time.ToString();//转化成字符串
           //string uip = other.GetIp();
           //addlog(user, uip, strTime, "删除了一部电影", name);//执行添加系统日志方法
        
        
        
           Response.Write(i);
    }


    private void addlog(string user, string adminIp, string strTime, string adminTip, string adminMovies)
    {
        //添加语句
        string sql = "insert into mH_admin_log values('" + user + "','" + adminIp + "','" + strTime + "','" + adminTip + "','" + adminMovies + "');";
        int i = DBHelper.exeNonSql(sql);//执行sql语句

    }   
}



   
        

/// <summary>
///   构筑成json 格式
/// </summary>
class movies
{
    public string id;
    public string name;
    public string  type;
    public string img;
    public string maker;
    public string play;
    public string time;
    public string brief;
    public string len; 
    public movies(string id,string name, string type, string img,string maker,string play,string time,string brief,string len)
    {
        this.id = id; 
        this.name = name;
        this.type = type;
        this.img = img;
        this.maker = maker;
        this.play = play;
        this.time = time;
        this.brief = brief;
        this.len = len;
    }
}