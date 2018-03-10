<%@ Page Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="admin_moviesList.aspx.cs" Inherits="admin_admin_moviesList" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="margin-left:140px;margin-top:70px;">
<div class="center-back right-back stretch" style="left: 10%; right: 0%;width:1740px;">
        <div class="container-fluid">
          <div class="info-center">
                    <div class="page-header">
                      <div class="pull-left">
						<h4>查看电影</h4>      
					</div>
                    
                    </div>
				    <div class="search-box row">
                       <div class="col-md-8">
                       
                           <div class="form-group">
                              <span class="pull-left form-span">电影搜索:</span>
                              <select class="form-control" id="typ">
                              <option value="0">全部</option>
                              <%=type %>
                               <%-- <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>--%>
                              </select>
                           </div>
                        <div class="form-group">
                          <input type="text" id="mName" class="form-control" placeholder="电影名称">                    
                       </div>
                       
                       
                       
                            <input type="button" class="btn btn-default" id="sele"  value="搜索"/>
                        
                        </div>
                        <div class="col-md-4">
                         <div class="btn-group pull-right" role="group" aria-label="...">
                        
                           <div class="btn-group" role="group">
                          
                           
                          </div>
               
                         <input type="button" class="btn btn-default" value="批量删除" id="batchDel"> 
                        </div>
                        </div>
                        
                    </div>
                    <div class="clearfix"></div>
                      <div class="table-margin">
                      <table class="table table-bordered table-header">
                      <thead>
                         <tr>
                           <td><input type="checkbox" id="allc"></td>
                           <td style="width:180px;text-align:center">名称</td>
                           <td style="width:150px;text-align:center">类别</td>
                           <td style="width:320px;text-align:center">封面</td>
                            <td style="width:180px;text-align:center">执导人</td>
                           <td style="width:180px;text-align:center">点击次数</td>
                           <td style="width:180px;text-align:center">时间</td>
                           <td style="width:400px;text-align:center">简介</td>
                            <td style="width:170px;text-align:center">操作</td>
                         </tr>
                         </thead>
                         <tbody id="tbd">
                      
                        <%-- <tr style="height:130px;">
                          <td><input type="checkbox"></td>
                          <td  style="vertical-align:middle">2</td>
                          <td  style="vertical-align:middle">2</td>
                           <td  style="vertical-align:middle">2</td> 
                           <td  style="vertical-align:middle">2</td>
                            <td  style="vertical-align:middle">2</td> 
                            <td  style="vertical-align:middle">2</td>
                             <td  style="vertical-align:middle">2</td>
                         </tr>
                         <tr style="height:130px;">
                          <td><input type="checkbox"></td>
                          <td  style="vertical-align:middle">2</td>
                          <td  style="vertical-align:middle">2</td>
                           <td  style="vertical-align:middle">2</td> 
                           <td  style="vertical-align:middle">2</td>
                            <td  style="vertical-align:middle">2</td> 
                            <td  style="vertical-align:middle">2</td>
                             <td  style="vertical-align:middle">2</td>
                         </tr>
                          <tr style="height:130px;">
                          <td><input type="checkbox"></td>
                    <td  style="vertical-align:middle">2</td>
                          <td  style="vertical-align:middle">2</td>
                           <td  style="vertical-align:middle">2</td> 
                           <td  style="vertical-align:middle">2</td>
                            <td  style="vertical-align:middle">2</td> 
                            <td  style="vertical-align:middle">2</td>
                             <td  style="vertical-align:middle">2</td>
                         </tr>
                          <tr style="height:130px;">
                          <td><input type="checkbox"></td>
                          <td  style="vertical-align:middle">2</td>
                          <td  style="vertical-align:middle">2</td>
                           <td  style="vertical-align:middle">2</td> 
                           <td  style="vertical-align:middle">2</td>
                            <td  style="vertical-align:middle">2</td> 
                            <td  style="vertical-align:middle">2</td>
                             <td  style="vertical-align:middle">2</td>
                         </tr>--%>
                         </tbody>
                         <tfoot>
                          <tr>
                            <td colspan="9">
                              <div class="pull-right">
                                  <nav>
                                      <ul class="pagination" id="pageto">
                                       <%-- <li>
                                          <a href="#" aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                          </a>
                                        </li>
                                        <li><a href="#">1</a></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">……</a></li>
                                        <li><a href="#">5</a></li>
                                        <li>
                                          <a href="#" aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                          </a>
                                        </li>--%>
                                      </ul>
                                    </nav>
                              </div>
                            </td>
                          </tr>
                         </tfoot>
                      </table>
                    </div>
                    </div>
          </div>
        </div>


</div>
<script>

function doajax(cz,name,dtype,page,type){
   $.ajax({
	    url:"ashx/moviesList.ashx",
	    type:'POST',
	    dataType:dtype,
	    async:false,
	    data:{cz:cz,name:name,page:page,type:type},
	    success:function(data){
	    if(dtype=="json"){
	    $("#tbd").empty();
	    addpage(data[0].len);
	    for(i=0;i<data.length;i++){
	       var htm="<tr style=\"height:130px;\"><td style=\"vertical-align:middle;\"><input type=\"checkbox\" data-name="+data[i].name+"></td><td  style=\"vertical-align:middle;text-align:center\">" + data[i].name + "</td><td  style=\"vertical-align:middle;text-align:center\">" + data[i].type + "</td>" +
            "<td  style=\"vertical-align:middle;text-align:center\"> <img style=\"width:250px;height:120px\" src=../" + data[i].img+ " alt=\"\" /></td><td  style=\"vertical-align:middle;text-align:center\">" + data[i].maker + "</td><td  style=\"vertical-align:middle;text-align:center\">" + data[i].play+ "</td> <td  style=\"vertical-align:middle;text-align:center\">" +data[i].time + "</td><td  style=\"vertical-align:middle;text-align:center\">" + data[i].brief + "</td><td  style=\"vertical-align:middle;text-align:center\"><a href=\"admin_editMovies.aspx?id="+data[i].id+"\"><button type=\"button\" class=\"btn btn-primary btn-sm\" >修改</button></a>&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-default bnn-del btn-sm\" data-name="+data[i].name+">删除</button></td></tr>";
	    $("#tbd").append(htm);
	    }
	       return
	       }
	     if(dtype=="text"){
	      alert("成功删除"+data+"部电影")
	     $("#allc").attr("checked",false)
	      return
	       }
	    }
	   }) 


}


function addpage(num){
$("#pageto").empty();
var htm="<li data-num=\"1\"><a href=\"javascript:void(0);\" aria-label=\"Previous\"><span aria-hidden=\"true\">首页</span></a></li>";
$("#pageto").append(htm)
var p=Math.ceil(parseInt(num)/5)                         
for(var i=1;i<=p;i++){
    var htm="<li data-num="+i+"><a  href=\"javascript:void(0);\">"+i+"</a></li>";
    $("#pageto").append(htm);
    if(i==p){
    var htm="<li data-num="+i+"><a href=\"javascript:void(0);\" aria-label=\"Next\"><span aria-hidden=\"true\">末页</span></a></li>";
     $("#pageto").append(htm)
    }
}


}


doajax("fcx","","json","1","");



//页码跳转
function pagego(){
var num=$(this).attr("data-num");

doajax("fcx","","json",num,"");
}
//事件委托
$("#pageto").on("click","li",pagego);

$("#sele").on("click",likecz)
function likecz(){
  var type=$('#typ option:selected') .val();
  var mName=$("#mName").val();
  doajax("fcx",mName,"json","",type)
}



$("#allc").on("click",allc)
function allc(){
      var ck=$("#tbd input[type='checkbox']")
      var cklen =$('#tbd input[type=checkbox]:checked')
      if(ck.length==cklen.length){
                for(var i in ck){
          if(ck[i].checked){
                ck[i].checked =false;
          }
    }
      
      }else{
      
       for(var i in ck){
          if(!ck[i].checked){
                ck[i].checked = true;
          }
    }
      
 }
   
}


function batchDel(){
  var cklen =$('#tbd input[type=checkbox]:checked')
  if(cklen.length<1){
  alert("没有选中任何电影!")
  return false;
  }
if(confirm("确认是否删除(删除后电影将无法恢复)")){
   var nameList="";
   var len=parseInt($('#tbd input[type=checkbox]:checked').length)
   var len1=len-1
           for(i=0;i<len;i++){
           var aa=$(cklen[i]).attr("data-name");
            nameList+="'"+aa+"',";
            if(i==len1){
              nameList=nameList.substr(0,nameList.length-1)
            }
    }
   doajax("del",nameList,"text","","");
   doajax("fcx","","json","1","");
   }
}

$("#batchDel").on("click",batchDel)
//事件委托
$("#tbd").on("click",".bnn-del",del)

function del(){
if(confirm("确认是否删除(删除后电影将无法恢复)")){
        var name=$(this).attr("data-name");
        name="'"+name+"'";
         doajax("del",name,"text","","");
         doajax("fcx","","json","1","");
}
}



</script>
</asp:Content>

