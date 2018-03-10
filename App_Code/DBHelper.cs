using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
/// <summary>
/// 数据库访问类
/// 用户获取数据库的连接
/// 获取查询结果，执行insert\delete\update语句
/// 执行查询统计
/// </summary>

public class DBHelper
{
	public DBHelper()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    /// <summary>
    ///  通过web.config 获取数据库地址
    /// </summary>
    /// <returns></returns>
    public static SqlConnection getconn(){
        string connstr = ConfigurationManager.ConnectionStrings["addStr"].ConnectionString;  //从webconfig获取 地址的字符串
        SqlConnection conn = new SqlConnection(connstr);    //连接地址
        return conn;
    
    }
    /// <summary>
    ///  执行查询的SQL语句，返回查询到的数据ds
    /// </summary>
    /// <returns></returns>
    public static DataSet exeSql(string sql)
    {
        SqlConnection conn = DBHelper.getconn();  //调用方法获取数据库地址
            conn.Open();
            SqlDataAdapter myda = new SqlDataAdapter(sql,conn);  //执行查询的SQL语句
            DataSet ds = new DataSet(); //创建存储的库
            myda.Fill(ds); //数据存入ds 库
            conn.Close();
            return ds;    
    }
    /// <summary>
    ///  执行增删改语句，根据执行结果返回布尔型
    /// </summary>
    /// <returns></returns>
    public static int exeNonSql(string sql) {
        SqlConnection conn = DBHelper.getconn();//调用方法获取数据库地址
        try
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn); //为执行命令作准备
            int i = cmd.ExecuteNonQuery();   //执行增删改语句
            return i;
        }
        catch (Exception e)
        {
            int i = 0;
            return i;
        }finally {
            if (conn.State == ConnectionState.Open) {  //判断数据库是否打开
                conn.Close();
            }
        }
    }







}
