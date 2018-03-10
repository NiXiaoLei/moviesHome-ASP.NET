using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.Text;
/// <summary>
/// GETMD5 的摘要说明
/// </summary>
public class other
{
	public other()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    /// <summary>
    /// 返回一个md5加密后的字符串
    /// </summary>
    /// <param name="str">输入要加密的字符串</param>
    /// <returns>输入加密后字符串</returns>
    public static  string strMD5(string str)
    { 
        MD5 md5 = new MD5CryptoServiceProvider();
        string pwd = "";
        //实例化一个md5对象
        byte[] md5Data = md5.ComputeHash(Encoding.Default.GetBytes(str));
        md5.Clear();
        //加密后是一个字节类型发数组，这里注意编码UTF-8/Unicoded选择
        
        //通过循环使用，转换为字符串
        for (int i = 0; i < md5Data.Length - 1; i++)
        {
            pwd += md5Data[i].ToString("X").PadLeft(2,'0');//只取MD5码的一部分
        }   
        return pwd;
    }


    public static string GetIp()
    {
        //可以透过代理服务器
        string userIP = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (userIP == null || userIP == "")
        {
            //没有代理服务器,如果有代理服务器获取的是代理服务器的IP
            userIP = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        return userIP;
    }


}
