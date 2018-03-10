<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="admin_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>Login Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="admin/css/style1.css" rel='stylesheet' type='text/css' />
</head>
<div class="main">
		<div class="login">
			<h1>视频之家管理系统</h1>
			<div class="inset">
				<!--start-main-->
				<form id="form1" method="post" action="admin/ashx/Login.ashx">
			         <div>
			         	<h2>管理登录</h2>
						<span><label>用户名</label></span>
						<span><input type="text" class="textbox" name="user" ></span>
					 </div>
					 <div>
						<span><label>密码</label></span>
					    <span><input type="password" class="password" name="password"></span>
					 </div>
					<div class="sign">
                        <input type="submit" value="登录" class="submit" />
					</div>
					</form>
				</div>
			</div>
		<!--//end-main-->
		</div>

<div class="copy-right">
	<p>&copy; 2018 Ethos Login Form. All Rights Reserved</p>

</div>
<div style="text-align:center;">
<p>最终解释权归属:</p>
</div>
</body>
</html>
