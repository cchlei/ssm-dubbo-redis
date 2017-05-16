<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>管理员编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">管理员编辑</a></li>
	</ul>
	<br />
	
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/manager/save" method="POST">
		<input id="hosptalId" name="hosptalId" type="hidden" value="${hosptalId}"/>
		<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
		<input id="areaIdParentName" name="areaIdParentName" type="hidden" value="${areaIdParentName}"/>
		<input id="areaName" name="areaName" type="hidden" value="${areaName}"/>
		
	    <c:if test="${userInfo!=null}">
			<input id="uid" name="uid" type="hidden" value="${userInfo.uid}"/>
			<input id="roleId" name="roleId" type="hidden" value="${userInfo.roleId}"/>
			<input id="salt" name="salt" type="hidden" value="${userInfo.salt}"/>
			<input id="username" name="username" type="hidden" value="${userInfo.username}"/>
	    </c:if>
		<div class="form-group">
			<label for="username" class="col-sm-2 control-label">管&nbsp; &nbsp;理&nbsp; &nbsp;员 &nbsp; &nbsp;名&nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
			<c:if test="${userInfo!=null}">
				${userInfo.username}
			</c:if>
			<c:if test="${userInfo==null}">
				<input type="text" class="form-control" id="username" name="username" placeholder="管理员名称" datatype="*2-50"
					nullmsg="请输入管理员名称！" errormsg="管理员名称至少2个字符,最多50个字符！" value="${userInfo.username}">
			</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="password" class="col-sm-2 control-label">管&nbsp;&nbsp;理&nbsp;&nbsp;员&nbsp;&nbsp;密&nbsp;&nbsp;码：</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="password" name="password" placeholder="密码" datatype="*2-30"
					nullmsg="请输入密码！" errormsg="密码至少2个字符！" value="${userInfo.password}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="roleId" class="col-sm-2 control-label">角色 ：</label>
			<div class="col-sm-4">
				<c:if test="${userInfo.roleId==null}">
					<select class="mSelect"  class="mSelect"  id="roleId" name="roleId" onchange="selectHosp(this.value)">
					<c:forEach items="${roles}" var="role">
						<option value="${role.rid}">${roleMap[role.rid]}</option>
					</c:forEach>
					</select>
				</c:if>
				<c:if test="${userInfo.roleId!=null}">${roleMap[userInfo.roleId]}</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		<div id="selecthosp" >
		<c:if test="${hosptalId==null && areaId==null}">
		<div class="form-group">
			<label for="doctorCode" class="col-sm-2 control-label">所属地区或医院：</label>
			<div class="col-sm-5">
				所在地：  
			<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this)">
		    <option value="0">请选择</option>
		    <c:forEach items="${areaList}" var="area" varStatus="status">
		       <c:if test="${area.parentId==0}">
			    	<option value="${area.areaId}">${area.areaName}</option>
			   </c:if>
		    </c:forEach>
		    </select>&nbsp;&nbsp;&nbsp;
		    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this,null);">
		   	    <c:if test="${areaId!=null}">
		    	<option>${areaMap[areaId]}</option>
			    </c:if>
			    <c:if test="${areaId==null}">
			   	    <option value="0">请选择</option>
			    </c:if>
		    </select><br/>
		    医院：<select class="mSelect"  class="mSelect"  id="hospital" name="hospital" onchange="selectHospId(this.value);">
		    <c:if test="${hospId!=null}">
		    	<option>${hospName}</option>
		    </c:if>
		    <c:if test="${hospId==null}">
		    	<option value="0">请选择</option>
		    </c:if>
		    </select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		</c:if>
		<c:if test="${hosptalId!=null|| areaId!=null}">
		<div class="form-group">
			<label for="doctorCode" class="col-sm-2 control-label">所属地区或医院：</label>
			<div class="col-sm-5">
				<c:if test="${areaId!=null}">
				所在地：${areaMap[areaId]}&nbsp;&nbsp;
					<c:if test="${hosptalId!=null}">医院：${hospName}</c:if>
				</c:if>
			</div>
		</div>	
		</c:if>		
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
		var tag = "${userInfo}";
		var ctx = "${ctx}";
		var rid = "${userInfo.roleId}";
		if(rid==3){
			document.getElementById("selecthosp").style.display="";
		}
		if(tag!=""){
			document.form1.action=ctx+"/manager/update"; 
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
				var roleid =  $("#roleId").val();
				if(roleid==3){
					if($("#hosptalId").val()==""){
						alert("请选择医院！");
						return false;
					}
				}
				$("#password").val(hex_encrypt($("#password").val()));
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						window.location.href = '${ctx}/manager/list';
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
	
	function selectHosp(roleId){
		if(roleId==0){
			return;
		}
		
		//if(roleId==3){
		//	document.getElementById("selecthosp").style.display="";
		//}else{
		//	document.getElementById("selecthosp").style.display="none";
		//}
	}
	
	  //地区下拉联动
    function searchArea(obj){
    	var areaId = obj.options[obj.selectedIndex].value;
		var areaName = obj.options[obj.selectedIndex].text;
		
    	if(areaId==0){
    		//清空二级地区
    		$("#areaIdChild").empty(); 
    		var option = "";
  	        option = $("<option>").val(0).text("请选择");
  	        $("#areaIdChild").append(option); 
  	        //清空医院
  	        $("#hospital").empty(); 
	        var option = "";
	        option = $("<option>").val(0).text("请选择");
	        $("#hospital").append(option); 
    		return;
    	}
    	var ctx = "${ctx}";
    	var url = ctx+"/doctor/searchArea";
    	$.post(url,{'areaId':areaId},function (data){
    		json = eval(data);
    		  // 先清空第二个 
    	      $("#areaIdChild").empty(); 
    	      var option = "";
    	      option = $("<option>").val(0).text("请选择");
    	      $("#areaIdChild").append(option); 
    		for(var i=0; i<json.length; i++) 
    		{ 
    			option = $("<option>").val(json[i].areaId).text(json[i].areaName);
    		    //alert(json[i].areaId+" " + json[i].areaName) 
    		    $("#areaIdChild").append(option); 
    		} 
    	});
    	 if(areaName!=""){
    		 $("#areaIdParentName").val(areaName); 
    	 }
    	 searchHosp(null,areaId);//根据父级地区查询医院
    	
    }

    //医院下拉联动
    function searchHosp(obj,areaId){
    	var areaName = "";
    	if(areaId==null){
    	     areaId = obj.options[obj.selectedIndex].value;
    	     areaName = obj.options[obj.selectedIndex].text;
    	}
    	if(areaId==0){
    		$("#hospital").empty(); 
  	      	var option = "";
  	      	option = $("<option>").val(0).text("请选择");
  	      	$("#hospital").append(option); 
    		return;
    	}
    	var ctx = "${ctx}";
    	var url = ctx+"/doctor/searchHosp";
    	$.post(url,{'areaId':areaId},function (data){
    		json = eval(data);
    		  // 先清空第二个 
    	      $("#hospital").empty(); 
    	      var option = "";
    	      option = $("<option>").val(0).text("请选择");
    	      $("#hospital").append(option); 
    		for(var i=0; i<json.length; i++) 
    		{ 
    			option = $("<option>").val(json[i].hospId).text(json[i].hospName).attr('isthirdparty',json[i].isThirdparty);
    		    //alert(json[i].areaId+" " + json[i].areaName) 
    		    $("#hospital").append(option); 
    		} 
    	});
    	 if(areaId!=0 && obj!=null){
    		   $("#areaId").val(areaId);
    		 } 
    	 if(areaName!=""){
    		 $("#areaName").val(areaName); 
    	 }
    }	
    
    function selectHospId(hospId){
    	if(hospId==0){
    		return;
    	}
    	if(hospId!=0){
 		   $("#hosptalId").val(hospId);
 		 } 
    }
</script>
</html>