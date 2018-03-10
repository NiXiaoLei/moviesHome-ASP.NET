<%@ Page Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="admin_addMovies.aspx.cs" Inherits="admin_admin_addmovies" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="css/bootstrap-fileinput.css" rel="stylesheet" />
<style>
.file {
    position: relative;
    display: inline-block;
    background: #337ab7;
    border: 1px solid #2e6da4;
    border-radius: 4px;
    padding: 4px 12px;
    overflow: hidden;
    color: #fff;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #286090;
    border-color: #2e6da4;
    color: #fff;
    text-decoration: none;
}


</style>
<div style="margin-left:140px;margin-top:70px;">
    
<div class="form-group">
 
<form  method="post" id="my" action="ashx/saveas.ashx">
  <div class="form-group" id="uploadForm"  enctype='multipart/form-data'>
                  <p>名称</p>
  
<input type="text" class="form-control" name="name" id="mName" placeholder="限1~10个字符" style="width:200px;">
   <p></p>
    <div class="form-group" id="Div1" enctype='multipart/form-data'>
                  <p>执导人</p>
  
<input type="text" class="form-control" name="maker"  id="mMaker" placeholder="限1~10个字符" style="width:200px;">
     <p>类型</p>
    <div class="form-group">
                              <select class="form-control" id="typ" style="width:80px;" name="type">
                              <%=mop %>
                               <%-- <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>--%>
                              </select>
                           </div>
                <div class="h4">封面</div>
                <div class="fileinput fileinput-new" data-provides="fileinput"  id="exampleInputUpload">
                    <div class="fileinput-new thumbnail" style="width: 200px;height: auto;max-height:150px;">
                        <img id='picImg' style="width: 100%;height: auto;max-height: 140px;" src="../images/noimage.png" alt="" />
                    </div>
                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                    <div>
                        <span class="btn btn-primary btn-file">
                            <span class="fileinput-new">选择图片</span>
                            <span class="fileinput-exists">选择图片</span>
                            <input type="file" name="pic" id="picID" accept="image/gif,image/jpeg,image/x-png,image/jpg">
                        </span>
                    </div>
                </div>
            </div>
            <p>视频文件</p>
            <input class="form-control"  id="banInp" type="text" placeholder="请上传视频" readonly  style="width:400px;">
          <p></p>
            <a href="javascript:;" class="file">选择文件
     <input type="file" name="movie"  id="movID"  accept="video/*" onchange="movUrl()" />
</a>
<p></p>
<p>是否推荐</p>
               <input type="radio" name="recRd" id="rd1" value="1" > 是
               <input type="radio" name="recRd" id="rd2" value="0" checked>  否
               <p></p>
         <p>简介</p>
         <textarea class="form-control" rows="3"  name="brief" style="width:400px;height:120px;"></textarea>
      <p></p>
            <button type="button" class="btn btn-primary" onclick="sbt()">添加</button>
             <button type="button" class="btn btn-primary" id="clear">清空</button>
</form>
<%-- <div id="preview"></div>
  <input type="file" onchange="preview(this)" />
<script>
  function preview(file) {
    var prevDiv = document.getElementById('preview');
   console.log(file)  
   console.log(file.files) 
   console.log(file.files[0]) 
    if (file.files && file.files[0]) {
      var reader = new FileReader();
      reader.onload = function(evt) {
        prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
      }
      reader.readAsDataURL(file.files[0]);
    } else {
      prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
    }
  }

</script>--%>


 </div>

</div>
<script src="script/bootstrap-fileinput.js"></script>
<script>


function movUrl(){
$("#banInp").val($("#movID").val())


}




// $(function () {
        //比较简洁，细节可自行完善
//        $('#uploadSubmit').click(function () {
//            var data = new FormData($('#uploadForm')[0]);
//            $.ajax({
//                url: 'xxx/xxx',
//                type: 'POST',
//                data: data,
//                async: false,
//                cache: false,
//                contentType: false,
//                processData: false,
//                success: function (data) {
//                    console.log(data);
//                    if(data.status){
//                        console.log('upload success');
//                    }else{
//                        console.log(data.message);
//                    }
//                },
//                error: function (data) {
//                    console.log(data.status);
//                }
//            });
//        });

//    })






function file(){
var form=new FormData(document.getElementById("my"))
      $.ajax({
      url:"ashx/saveas.ashx",
      type:"post",
      data:form,
      processData: false,  // 告诉jQuery不要去处理发送的数据
       contentType: false,   // 告诉jQuery不要去设置Content-Type请求头
           success: function(data){
           alert(data)
           clear();
          }
      })
}

function clear(){
$("input[type='text']").val("")
$("input[type='file']").val("")
$("img").attr("src","../images/noimage.png")
$("textarea").val("")
}
$("#clear").on("click",clear)
function sbt(){
var name=document.getElementById("mName").value
var maker=document.getElementById("mMaker").value
if(name.length<1||name.length>10){
alert("电影名称长度不规范")
return false
}
if(maker.length<1||maker.length>10){
alert("执导人长度不规范")
return false
}
function check(){
var tlen=$("input[type='text']").length;
for( i=0;i<tlen;i++){
        if($("input[type='text']:eq("+i+")").val()==""){
                  return true      //有空的没填返回true
        }
}
for(var i=0;i<$("input[type='file']").length;i++){
        if($("input[type='file']:eq("+i+")").val()==""){
                  return true      //有空的没填返回true
        }
}
if($("textarea").val()==""){
   return
}

}

if(check()){
alert("信息不完整")
}else{
file()
}
}




</script>

</asp:Content>

