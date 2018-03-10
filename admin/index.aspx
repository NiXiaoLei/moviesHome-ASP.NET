<%@ Page Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="admin_index" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="right-product my-index right-full" style="margin-left:120px;margin-top:50px;">
     <div class="container-fluid">
	   <div class="info-center">
       
       <!---title----->
            <div class="info-title">
              <div class="pull-left">
                <h4><strong>Administrator，</strong></h4>
                <p>欢迎登录管理系统！ <a href="http://www.mycodes.net/" target="_blank">视频之家</a></p>
              </div>
              <div class="time-title pull-right">
                  <div class="year-month pull-left">
                    <p id="wek"></p>
                    <p><span id="year"></span ><span id="day"></span> </p>
                  </div>
                  <div class="hour-minute pull-right">
                     <strong id="ntime"></strong>
                  </div>
              </div>
              <div class="clearfix"></div>
            </div>
           <!----content-list----> 
            <div class="content-list">
               <div class="row">
               
               </div>
               <!-------信息列表------->
               <div class="row newslist" style="margin-top:20px;">
                 <div class="col-md-8">
                   <div class="panel panel-default">
                      <div class="panel-heading">
                       近期访客<div class="caret"></div>
                       <a href="#" class="pull-right"><span class="glyphicon glyphicon-refresh"></span></a>
                      </div>    
                     
                       <%=log %>
                     <%-- <div class="panel-body">
                           <div class="w15 pull-left">
                             <img src="img/noavatar_middle.gif" width="25" height="25" alt="图片" class="img-circle">
                             安妮
                           </div>
                           <div class="w55 pull-left">ip</div>
                           <div class="w20 pull-left text-center">2016年8月23日</div>
                          <div class="w10 pull-left text-center"><span class="text-green-main">处理中</span></div>
                      </div>--%>
                       <%--
                      <div class="panel-body">
                           <div class="w15 pull-left">
                             <img src="img/noavatar_middle.gif" width="25" height="25" alt="图片" class="img-circle">
                             安妮
                           </div>
                           <div class="w55 pull-left">系统需要升级</div>
                           <div class="w20 pull-left text-center">2016年8月23日</div>
                          <div class="w10 pull-left text-center"><span class="text-green-main">处理中</span></div>
                      </div>
                     
                      <div class="panel-body">
                           <div class="w15 pull-left">
                             <img src="img/noavatar_middle.gif" width="25" height="25" alt="图片" class="img-circle">
                             安妮
                           </div>
                           <div class="w55 pull-left">系统需要升级</div>
                           <div class="w20 pull-left text-center">2016年8月23日</div>
                           <div class="w10 pull-left text-center"><span class="text-gray">已关闭</span></div>
                      </div>
                      
                      <div class="panel-body">
                           <div class="w15 pull-left">
                             <img src="img/noavatar_middle.gif" width="25" height="25" alt="图片" class="img-circle">
                             安妮
                           </div>
                           <div class="w55 pull-left">系统需要升级</div>
                           <div class="w20 pull-left text-center">2016年8月23日</div>
                           <div class="w10 pull-left text-center"><span>处理中</span></div>
                      </div>
                      <div class="panel-body">
                           <div class="w15 pull-left">
                             <img src="img/noavatar_middle.gif" width="25" height="25" alt="图片" class="img-circle">
                             安妮
                           </div>
                           <div class="w55 pull-left">系统需要升级</div>
                           <div class="w20 pull-left text-center">2016年8月23日</div>
                           <div class="w10 pull-left text-center"><span>处理中</span></div>
                      </div>
                      <div class="panel-body">
                           <div class="w15 pull-left">
                             <img src="img/noavatar_middle.gif" width="25" height="25" alt="图片" class="img-circle">
                             安妮
                           </div>
                           <div class="w55 pull-left">系统需要升级</div>
                           <div class="w20 pull-left text-center">2016年8月23日</div>
                           <div class="w10 pull-left text-center"><span>处理中</span></div>
                      </div>--%>
                      
                      <div class="panel-body text-center">
                          <a href="admin_log.aspx" style="color:#5297d6;">查看全部</a>
                      </div>
                      
                    </div>
                 </div>
                 
                 <div class="col-md-4">
                     <div class="panel panel-default">
                      <div class="panel-heading">
                       我的事务统计
                       <a href="#" class="pull-right"><span class="glyphicon glyphicon-refresh"></span></a>
                      </div>     
                      <div class="panel-body">
                          
                      </div>
                    </div>
                    
                 </div>
               </div>
            </div>
            
       </div>			
	 </div>
  </div>
  
  <script>


  function week(){
    var str = "星期";
var d = new Date();
switch (d.getDay()){ 
    case 0:
        str=str+"日";
        break;
    case 1:
        str=str+"一";
        break;
    case 2:
        str=str+"二";
        break;
    case 3:
        str=str+"三";
        break;
    case 4:
        str=str+"四";
        break;
    case 5:
        str=str+"五";
        break;
    case 6:
        str=str+"六";
        break; 
}

$("#wek").html(str)
var myDate = new Date();

$("#year").html(myDate.getFullYear());
$('#day').html("年"+myDate.getMonth()+"月"+myDate.getDate()+"日")
$("#ntime").html(myDate.toLocaleTimeString())

  }
  
  
setInterval(week,1000)
 
  
  </script>

</asp:Content>

