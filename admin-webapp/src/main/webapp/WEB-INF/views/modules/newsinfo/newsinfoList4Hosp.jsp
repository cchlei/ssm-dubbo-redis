<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>资讯新闻列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">资讯新闻列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/news/list4Hosp" method="GET">
	标题：<input type="text"  id="title" name="title"  value="<c:out value='${newsInfo.title}'/>"/>&nbsp;&nbsp;&nbsp;
	权重：<input type="text"  id="weight" name="weight"   value="${newsInfo.weight}"/>&nbsp;&nbsp;&nbsp;
	<%-- 是否推荐到首页：<select class="mSelect"  class="mSelect"  id="ifHomePage" name="ifHomePage">
				 <c:if test="${newsInfo.ifHomePage==2}">
				 <option value="2" selected="selected">否</option>
				 <option value="1">是</option>
				 </c:if>
				 <c:if test="${newsInfo.ifHomePage==1}">
				 <option value="2">否</option>
				 <option value="1" selected="selected">是</option>
				 </c:if>
				 <c:if test="${newsInfo.ifHomePage=='0'}">
				 <option value="0">请选择</option>
				 <option value="2">否</option>
				 <option value="1">是</option>
				 </c:if>
				</select>
	&nbsp;&nbsp;&nbsp; --%>
	所属标签：
	<select class="mSelect"  class="mSelect"  id="tag" name="tag">
	<option value="0">请选择</option>
	<c:forEach items="${newsTags}" var="tags" varStatus="index">
		<c:if test="${newsInfo.tag==tags.tagId}">
			<option value="${tags.tagId}" selected="selected">${tags.tagName}</option>
		</c:if>
	    <c:if test="${newsInfo.tag!=tags.tagId}">
			<option value="${tags.tagId}">${tags.tagName}</option>
		</c:if>
	</c:forEach>
	</select>
	&nbsp;&nbsp;&nbsp;<input type="button"  onclick="searchBut();" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="${ctx}/news/toAddorEdit4Hosp">添加资讯</a>
	</form>
	
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 资 讯 列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">编号</th>
			    <th class="text-center">封面</th>
			    <th class="text-center">关键词</th>
				<th class="text-center">标题</th>
				<!-- <th class="text-center">关键字</th> -->
				<th class="text-center">摘要</th>
				<!-- <th class="text-center">是否推荐到首页</th> -->
				<th class="text-center">权重</th>
				<th class="text-center">发布人</th>
				<th class="text-center">修改时间</th>
				<th class="text-center">发布时间</th>
				<th class="text-center">是否发布</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${newsList}" var="news" varStatus="status">
			
			<tr>
			    
				<td class="text-center">${status.count}<div id="content" style="display:none">${news.content}</div></td>
				<td class="text-center"><img src="${ctx}/showImage/showImg?path=${news.conImgUrl}" id="img1" width="100px" height="100px" /></td>
				<td class="text-center">${news.keywords}</td>
				<td>${news.title} </td>
				<%-- <td>${news.keywords}</td> --%>
				<td>${news.abstracts}...</td>
				<%-- <td>
				<c:if test="${news.ifHomePage=='2'}">否</c:if>
				<c:if test="${news.ifHomePage=='1'}">是</c:if>
				</td> --%>
				<td>${news.weight}</td>
				<td>${news.userId}</td>
				<td><fmt:formatDate value="${news.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${news.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			    <td class="text-center">
				<c:if test="${news.isPublish=='0'}">否</c:if>
				<c:if test="${news.isPublish=='1'}"><span style="color:red">是</span></c:if>
				</td>
				
				<td>
				<a href="${ctx}/news/toAddorEdit4Hosp?newsId=${news.newsId}">修改</a>&nbsp;
				<a href="#" del_id="${news.newsId}">删除</a>&nbsp;
				<a href="#" publish_id="${news.newsId}">发布</a>
				</td>
			</tr>
			</c:forEach>
		</table>
		
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/news/list4Hosp?title=${params.title}&weight=${params.weight}&tag=${params.tag}"/>
<script type="text/javascript">
$(document).ready(function() {
	var weight = $("#weight").val();
	if(weight==0){
		$("#weight").val("");
	}
	$(".table-bordered td a").bind("click", function(){
		if ($(this).attr('del_id')) {
			var id = $(this).attr('del_id'); 
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get("${ctx}/news/delete/"+id, function(json) {
					var msg = "";
					if (json.message) {
						msg = json.message;
					}
					$.alert(msg, function() {
						window.location.reload();
					});
				}, "json");
			});
		}
	});
	
 	$(".table-bordered td a").bind("click", function(){
 		if ($(this).attr('publish_id'))
 		{

		    var Articles =1;//图文消息，一个图文消息支持1到8条图文
 		    var author ="导医通";

		    var title =$(this).parent().parent().children('td').eq(3).text();//标题
 		    var content_source_url = "${weixinPrefix}/news/toWeixinArticle/" + $(this).attr('publish_id');
 		    //var content_source_url="http://hao.daoyitong.com/admin/news/toWeixinArticle/1453276489883060";
		    		    //${weixinPrefix}+"/"+$(this).parent().parent().children('td').eq(1).find("img")[0].src;//在图文消息页面点击“阅读原文”后的页面 
		    var filePath=$(this).parent().parent().children('td').eq(1).find("img")[0].src;//缩略图
		    //var filePath="http://hao.daoyitong.com/admin/showImage/showImg?path=14707249006174cfb6658-8645-484d-91a1-dbe0d2becad8.jpg";
		    var content=$(this).parent().parent().children('td').eq(0).find('div').html();
		    content=content.replace('/admin/showImage/showImg','${weixinPrefix}/showImage/showImg');
		    content=content.replace(/\"/g,"'");
		    content=escapeHtml(content);
 		    var digest = $(this).parent().parent().children('td').eq(4).text();
 		    var show_cover_pic =0;
 		    var publish_id = $(this).attr('publish_id');
 		    var hospId = ${hospId};//上线之后打开
 		    //var hospId=1459144385691736;
 		    //var url="http://mgr.daoyitong.com/admin/weixin/QRCode/sendNewsByGroupId";
 		    //var url ="http://192.168.99.92:8080/admin//weixin/QRCode/sendNewsByGroupId";
 		    var url="${weixinPrefix}/weixin/QRCode/sendNewsByGroupId";
			$.confirm("确定要发布此条数据吗？", function() {
				$.post(url,{"hospId":hospId,"Articles":Articles,"author":author,"title":title,"contentSourceUrl":content_source_url,"content":content,"digest":digest,"showCoverPic":show_cover_pic,"filePath":filePath},function (data){
					var msg = "";
					json =eval(data);
					if (json.code ==1) {
						$.get("${ctx}/news/isPublish/"+publish_id, function(json) {
							var msg = "";
							if (json.message) {
								msg = json.message;
							}
							$.alert(msg, function() {
								window.location.reload();
							});
						}, "json");
					}else
					{
						$.alert("发布失败："+json.message);
					}
				}, "json"); 

				
			}); 
 		}
 
		
	}); 
	
});

function escapeHtml(string) {
    var entityMap = {
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        '"': '&quot;',
        "'": '&#39;',
        "/": '&#x2F;'
    };
    return String(string).replace(/[&<>"'\/]/g, function (s) {
        return entityMap[s];
    });
}
function mao(a,b)
{
	alert(a);
	alert(b);
}
function searchBut(){
	var weight = $("#weight").val();
	if(weight!="" && !checkRate(weight)){
		   alert("查询条件“权重”请输入整数！");
		   return;
		}
	if(weight==""||weight==null){
		$("#weight").val(0);
	}
	var title = $("#title").val();
	$("#title").val($.trim(title));
	this.form.submit();
}

//判断正整数  
function checkRate(value)  
{  
     var re = /^[1-9]+[0-9]*]*$/;
  
     if (!re.test(value))  
    {  
        return false;  
     }else{
    	return true; 
     }
}  
</script>
</body>
</html>