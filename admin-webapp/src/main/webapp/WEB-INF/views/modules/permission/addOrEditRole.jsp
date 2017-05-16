<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">角色编辑</a></li>
	</ul>
	<br />
	
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/role/save" method="POST">
	    <c:if test="${roleInfo!=null}">
			<input id="rid" name="rid" type="hidden" value="${roleInfo.rid}"/>
	    </c:if>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">角&nbsp; &nbsp;色&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="name" name="name" placeholder="角色名称" datatype="*2-50"
					nullmsg="请输入角色名称！" errormsg="角色名称至少2个字符,最多50个字符！" value="${roleInfo.name}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="identity" class="col-sm-2 control-label">角&nbsp;&nbsp;色&nbsp;&nbsp;标&nbsp;&nbsp;识：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="identity" name="identity" placeholder="角色标识" datatype="*2-30"
					nullmsg="请输入角色标识编码！" errormsg="角色标识编码至少2个字符！" value="${roleInfo.identity}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="show" class="col-sm-2 control-label">是否显示 ：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="show" name="show">
				 <c:if test="${roleInfo.show==false || roleInfo.show==null}">
				 <option value="0" selected="selected">否</option>
				 <option value="1">是</option>
				 </c:if>
				 <c:if test="${roleInfo.show==true}">
				 <option value="1" selected="selected">是</option>
				 <option value="0">否</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">权 &nbsp; &nbsp;限：</label>
			<div class="col-sm-5">
				<table border="1">
			    <c:forEach items="${resources}" var="resource" varStatus="status">
			   		<tr>
			   			<td width="400">
				   			<c:if test="${selectedResources[resource.rid]!=null}">
				    			<input type="checkbox" id="tag" name="tag" checked="checked" value="${resource.rid}"/>${resource.name}&nbsp; &nbsp;
				    		</c:if>
				    		<c:if test="${selectedResources[resource.rid]==null}">
				    			<input type="checkbox" id="tag" name="tag" value="${resource.rid}"/>${resource.name}&nbsp; &nbsp;
				    		</c:if>
			    		</td>
			    		<td width="1000">
			    			<c:forEach items="${resource.submenus}" var="submenu" >
					   			<c:if test="${selectedResources[submenu.rid]!=null}">
					    			<input type="checkbox" id="tag" name="tag" checked="checked" value="${submenu.rid}"/>${submenu.name}&nbsp; &nbsp;
					    		</c:if>
					    		<c:if test="${selectedResources[submenu.rid]==null}">
					    			<input type="checkbox" id="tag" name="tag" value="${submenu.rid}"/>${submenu.name}&nbsp; &nbsp;
					    		</c:if>
					    	</c:forEach>
			    		</td>
			   		 </tr>
			    
			 <%--    <c:if test="${status.count%3==0}"><br/></c:if>
			    <c:if test="${selectedResources[resource.rid]!=null}">
			    <input type="checkbox" id="tag" name="tag" checked="checked" value="${resource.rid}"/>${resource.name}&nbsp; &nbsp;
			    </c:if>
			    <c:if test="${selectedResources[resource.rid]==null}">
			    <input type="checkbox" id="tag" name="tag" value="${resource.rid}"/>${resource.name}&nbsp; &nbsp;
			    </c:if> --%>
			    </c:forEach>
			    </table>
			    <br/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
	$(document).ready(function() {
		var tag = "${roleInfo}";
		var ctx = "${ctx}";
		if(tag!=""){
			document.form1.action=ctx+"/role/update"; 
		}
		$(".form-input").Validform({
			showAllError : true,
			tiptype : function(msg, o, cssctl) {
				if (!o.obj.is("form")) {
					//alert($(o.obj.parent().parent().find(".Validform_checktip")).html());
					var objtip = o.obj.parent().parent().find(".Validform_checktip");
					cssctl(objtip, o.type);
					objtip.text(msg);
				} else {
					var objtip = o.obj.find("#msg-info");
					cssctl(objtip, o.type);
					objtip.text(msg);
				};
			},
			postonce : true,
			ajaxPost : true,
			beforeSubmit:function(curform){
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						window.location.href = '${ctx}/role/list';
					});
				} else {
					errorValidate("msg-info", '');
					if (json.data.title) {
						errorValidate('title', json.message + ',' + json.data.title);
					}
				}
				$('#fat-btn').button('reset');
			}
		});

	});
</script>
</html>