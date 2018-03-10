<%@ Page Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="admin_log.aspx.cs" Inherits="admin_admin_log" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div style="margin-left:140px;margin-top:70px;">

<table class="table table-bordered table-header" style="width:1100px;">
                      <thead >
                         <tr >
                           <td style="width:200px;">用户</td>
                           <td style="width:200px;">ip</td>
                           <td style="width:200px;">时间</td>
                           <td style="width:300px;">操作</td>
                           <td style="width:200px;">电影</td>
                         </tr>
                         </thead>
                         <tbody>
                       <%=log %>
                      
                         </tbody>
                      </table>
                     
                     
            </div>          
</asp:Content>

