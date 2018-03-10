using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// formCheck 的摘要说明
/// </summary>
public class formCheck
{
	public formCheck()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public static bool check(string fstr)
    {
        String[] str = new String[] { "'", "--", "%", "&", "[", "]", ">=", "<=", "<>"," ", ";", "!" };
        for (int i = 0; i < str.Length; i++)
        {
            if (fstr.Contains(str.GetValue(i).ToString()))
            {
                return true; //包含敏感字符
            }
        }

        return false;
    }
}
