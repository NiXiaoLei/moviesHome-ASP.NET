<%@ WebHandler Language="C#" Class="saveas" %>

using System;
using System.Web;
using System.IO;
using System.Data;
public class saveas : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        //string user = context.Session["userName"].ToString(); 
        string mName = context.Request.Form["name"];
        string mMaker = context.Request.Form["maker"];
        string rec = context.Request.Form["recRd"];
        string brief = context.Request.Form["brief"];
        string mType = context.Request.Form["type"];
        string imgUrl="";
        string mUrl="";
        context.Response.ContentType = "text/html";
        //context.Response.Write("Hello World");

            string sqln = "select * from movielist where mname='" + mName + "' and maker='" + mMaker + "'";
            DataSet ds = DBHelper.exeSql(sqln);
            if (ds.Tables[0].Rows.Count != 0)
            {


                context.Response.Write("该电影已存在，请勿重复插入!");

            }
            else {
                 //后台拿到上传来的图片（拿到名为imgFile的input标签的文件）
        try
        {
            HttpPostedFile file = context.Request.Files["pic"];

            //后台也要对拿到的数据是否为图片进行校验（因为前台可以通过浏览器改代码，前台校验完了需要后台再拦截一下）
            string ext = Path.GetExtension(file.FileName);
            if (!(ext == ".jpeg" || ext == ".jpg" || ext == ".png" || ext == ".gif"))
            {
                      context.Response.Write("请上传图片");
                context.Response.End();
                return;
            }else
            {
                //上传的文件保存到目录(为了保证文件名不重复，加个Guid)
                imgUrl = Guid.NewGuid().ToString() + file.FileName;
                string path = "~/images/movies/" + imgUrl;
                file.SaveAs(context.Request.MapPath(path));//必须得是相对路径
                imgUrl = "images/movies/" + imgUrl;

                //把图片显示到前端让用户看得到
                //string str = string.Format("<html><head></head><body><img src='{0}'/></body></html>",
                //    path);//必须得是绝对路径！！！！
                //context.Response.Write("保存成功");


          
                
                
                      //视频上传
                HttpPostedFile files = context.Request.Files["movie"];
                if (files != null)
                {
                    if (files.ContentLength > 0)
                    {
                        string filePath = files.FileName;      //获得文件的完整路径名  

                        string filename = filePath.Substring(filePath.LastIndexOf('.'), filePath.Length - filePath.LastIndexOf('.'));
                        //设定上传路径（绝对路径） 
                        mUrl = Guid.NewGuid().ToString() + files.FileName;
                        string upPath = "~/movies/" + mUrl;
                        mUrl = "movies/" + mUrl;
                        //必须得是相对路径                
                        files.SaveAs(context.Request.MapPath(upPath));//必须得是相对路径
                        //设定数据库的存储路径  
                        //string savePath = "\\Uploads\\" + filename;
                        //下面是把相对路径保存到数据库表中  
                        //Information info = new Information();
                        //files = Request.Files["files"];
                        //info.title = files.FileName;
                        //info.content = savePath;
                        //db.Information.Add(info);
                        //db.SaveChanges();
                    }
                }

                string nowTime = DateTime.Now.ToLocalTime().ToString();
                string sql = "insert into movielist values('" + mName + "','" + mMaker + "','" + mUrl + "','" + imgUrl + "','0'," + rec + ",'" + nowTime + "','" + brief + "','" + mType + "')";
                int i = DBHelper.exeNonSql(sql);
                if (i != 0)
                {

                    //DateTime time = DateTime.Now;//获取当前时间
                    //string strTime = time.ToString();//转化成字符串
                    //string uip = other.GetIp();
                    //addlog(user, uip, strTime, "新增了一部电影", mName);//执行添加系统日志方法
                    context.Response.Write("添加成功");

                }
                else
                {

                    context.Response.Write("系统错误,添加失败!");

                }

            }
            }
            catch
            {
                context.Response.Write("系统错误,添加失败!");
            }
        }
        }


    private void addlog(string user, string adminIp, string strTime, string adminTip, string adminMovies)
    {
        //添加语句
        string sql = "insert into mH_admin_log values('" + user + "','" + adminIp + "','" + strTime + "','" + adminTip + "','" + adminMovies + "');";
        int i = DBHelper.exeNonSql(sql);//执行sql语句

    }
        



 
    public bool IsReusable {
        get {
            return false;
        }
    }

}