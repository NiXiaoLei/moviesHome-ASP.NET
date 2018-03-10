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
    public string mop = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (IsPostBack) {
        //string name = Request.Form["mName"];
        //string maker = Request.Form["mMaker"];
        //string type = Request.Form["mType"];
        //string txt = Request.Form["mtxt"];
        //if (name== null ||name.Equals("")||name== null ||maker.Equals("")||maker== null ||type.Equals("")||type== null ||txt.Equals("")||txt== null )//判断用户输入是否为空
        //{
        //  Response.Write("<script>alert('电影信息未填写完整！');window.open('./admin_addmovies.aspx','_self');</script>");
        //}
        //if (formCheck.check(name) || formCheck.check(maker) || formCheck.check(type) || formCheck.check(txt))
        //{  //调用防止注入式攻击，查看用户是否输入非法字符串

        //    Response.Write("<script>alert('输入含非法字符！');window.open('./admin_addmovies.aspx','_self');</script>");
        //    return;

        //}
       


        //saveImg(name,maker,txt,type);
    //}

    string sql = "select * from types";
    DataSet ds = DBHelper.exeSql(sql);
    for (int i = 0; i < ds.Tables[0].Rows.Count; i++) { 
             int b=i+1;
             mop += "<option value=" + b + ">" + ds.Tables[0].Rows[i]["tname"].ToString()+ "</option>";
    }


    }


    protected void Button1_Click(object sender, EventArgs e)
    {
         
    }





    //private void saveImg(string name,string maker,string txt,string type)
    //{
    //    bool fileIsValid = false;
    //    //如果确认了上传文件，则判断文件类型是否符合要求
    //    if (this.FileUpload1.HasFile) { 
    //        //获取上传文件的后缀
    //        String fileExtension = System.IO.Path.GetExtension(this.FileUpload1.FileName).ToLower();
    //        String[] restrictExtension ={ ".gif", ".jpg", ".bmp", ".png" };
    //        //判断文件类型是否符合要求
    //        for (int i = 0; i < restrictExtension.Length; i++) {
    //            if (fileExtension == restrictExtension[i]) {
    //                fileIsValid = true;
                
    //            }
            
            
            
    //        }
    //    //如果文件类型符合要求，调用saveAs方法实现上传，并显示相关信息
    //        if (fileIsValid == true) {
    //            try {
    //                string url = "images/" + FileUpload1.FileName;
    //                this.Image1.ImageUrl = "../images/" + FileUpload1.FileName;
    //                this.FileUpload1.SaveAs(Server.MapPath("../images/") + FileUpload1.FileName);
    //                this.Label1.Text+="文件上传成功";
    //                this.Label1.Text += "</Br>";
    //                this.Label1.Text += "<li>" + "原文件路径:" + this.FileUpload1.PostedFile.ContentLength + "字节";
    //                this.Label1.Text+="<Br/>";
    //                this.Label1.Text+="<li>"+"文件类型:"+this.FileUpload1.PostedFile.ContentType;
    //                string nowTime = DateTime.Now.ToLocalTime().ToString();
    //                string sql = "insert into movielist values('" + name + "','" + maker + "','movies/hu.mp4','" + url + "','0','False','" + nowTime + "','" + txt + "','" + type + "')";
    //               int i = DBHelper.exeNonSql(sql);
    //               if (i != 0) {
    //                   Response.Write("<script>alert('添加成功');</script>");
    //               }
                     
                 
    //            }
    //            catch{
    //               this.Label1.Text="文件上传不成功";
    //            }
    //            finally
    //            {
    //            }
    //        }else{
            
    //        this.Label1.Text="只能够上传后缀为.gif,.jpg,.bmp,.png的文件夹";
          
    //        }
            
            
    //        }
    //    }
    


}
