<%@ WebHandler Language="C#" Class="login" %>

using System;
using System.Web;
using System.Data;
using System.Web.SessionState;

public class login : IHttpHandler, IRequiresSessionState{

    public void ProcessRequest(HttpContext context)
    {
        //1:接收用户的输入
        string user = context.Request.Form["user"];
        string pwd = context.Request.Form["password"];
        //防止注入式攻击
        if(user==null||pwd==null||user.Equals("")||pwd.Equals(""))//判断用户输入是否为空
        {
            context.Response.Redirect("../../login.aspx");
        }
        if (formCheck.check(user) ||formCheck.check(pwd))
        {  //调用防止注入式攻击，查看用户是否输入非法字符串

            context.Response.Write("<script>alert('输入含非法字符！');window.open('../../Login.aspx','_self');</script>");
            return;
        
        }
        //2:查询数据库
        pwd = other.strMD5(pwd);
        DataSet ds = DBHelper.exeSql("select * from mH_admin where username='" + user + "' and userpwd='" + pwd + "'");
  
        int i = ds.Tables[0].Rows.Count;//获取数据行数
        if (i==0)//判断是否有数据如果没有的话登录失败
        {
            //失败的话
            context.Response.Write("<script>alert('登录失败！用户名或密码有误，请重新输入!');window.location.href=\"../../Login.aspx\"</script>");
        }
        else
        {
            //将用户名、id、密码、权限、存进session
            context.Session["userId"] = ds.Tables[0].Rows[0]["id"].ToString();
            context.Session["userName"] =user;
            context.Session["userPwd"] = pwd;
            string level=ds.Tables[0].Rows[0]["userlevel"].ToString();
            context.Session["level"] = level;
            string userName = user;//获取当前登录用户名
          
            DateTime time = DateTime.Now;//获取当前时间
            string strTime = time.ToString();//转化成字符串
            string uip = other.GetIp();
            addlog(user, uip, strTime,"登录视频之家后台管理中心","无");//执行添加系统日志方法
            context.Response.Redirect("../index.aspx");//跳转到index
           
            
        }
    }
    //添加系统日志方法
    private void addlog(string user, string adminIp, string strTime, string adminTip,string adminMovies)
    {
        //添加语句
        string sql = "insert into mH_admin_log values('" + user + "','" + adminIp + "','" + strTime + "','" + adminTip + "','" +adminMovies+"');";
        int i = DBHelper.exeNonSql(sql);//执行sql语句

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}


