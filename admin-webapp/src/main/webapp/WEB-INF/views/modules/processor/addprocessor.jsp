<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>标签列表</title>
</head>

<body>
<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">添加前置机</a></li>
	</ul>
	<c:if test="${not empty hospitalConf.hospitalId}">
		<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/processor/update" method="POST">
	</c:if>
	<c:if test="${empty hospitalConf.hospitalId}">
		<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/processor/save" method="POST">
	</c:if>
<%-- 	<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/processor/save" method="POST"> --%>
    	<div class="form-group">
			<label for="hospitalId" class="col-sm-2 control-label"><span style="color:red;">*</span>前&nbsp; &nbsp;置&nbsp; &nbsp;机 &nbsp; &nbsp;ID：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospitalId" name="hospitalId" placeholder="前置机ID" datatype="*1-30"
					nullmsg="请输入前置机ID！" errormsg="前置机ID至少1个字符,最多30个字符！" value="${hospitalConf.hospitalId}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="groupKey" class="col-sm-2 control-label"><span style="color:red;">*</span>处&nbsp; &nbsp;理&nbsp; &nbsp;方 &nbsp; &nbsp;式：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="groupKey" name="groupKey" placeholder="处理方式" datatype="*1-30"
					nullmsg="请输入处理方式！" errormsg="处理方式至少1个字符,最多30个字符！" value="${hospitalConf.groupKey}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="interfaceType" class="col-sm-2 control-label"><span style="color:red;">*</span>接口接入类型 ：</label>
			<div class="col-sm-4">
				<select class="lSelect"  id="interfaceType" name="interfaceType">
				 <c:if test="${hospitalConf.interfaceType==null||hospitalConf.interfaceType==0}">
				 <option value="0" selected="selected">第三方医院调用pavo接口</option>
				 <option value="1">pavo调用第三方接口</option>
				 <option value="2">前置机</option>
				 </c:if>
				 <c:if test="${hospitalConf.interfaceType==1}">
				 <option value="0">第三方医院调用pavo接口</option>
				 <option value="1" selected="selected">pavo调用第三方接口</option>
				 <option value="2">前置机</option>
				 </c:if>
				  <c:if test="${hospitalConf.interfaceType==2}">
				 <option value="0">第三方医院调用pavo接口</option>
				 <option value="1">pavo调用第三方接口</option>
				 <option value="2" selected="selected">前置机</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="agentName" class="col-sm-2 control-label"><span style="color:red;">*</span>名&nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospName" name="hospName" placeholder="名称" datatype="*0-256"
					nullmsg="请输入名称！" errormsg="名称至少0个字符！" value="${hospitalConf.hospName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="conf" class="col-sm-2 control-label"><span style="color:red;">*</span>配&nbsp; &nbsp;置&nbsp; &nbsp;信 &nbsp; &nbsp;息：</label>
			<%-- <div class="col-sm-5">
				<input type="text" class="form-control" id="conf" name="conf" placeholder="配置信息" datatype="*1-65536"
					nullmsg="请输入处理方式！" errormsg="处理方式至少1个字符,最多65536个字符！" value="${hospitalConf.conf}">
			</div> --%>
			<div class="col-sm-5">
				<textarea class="form-control" id="conf" name="conf" clos="15" rows="10" >${hospitalConf.conf}</textarea>
			</div>
			<!-- <div class="col-sm-5 help-block Validform_checktip"></div> -->
		</div>
	<%-- 	<div class="form-group">
			<label for="lastModifyDate" class="col-sm-2 control-label"><span style="color:red;">*</span>最后修改时间：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="lastModifyDate" name="lastModifyDate" placeholder="最后修改时间" datatype="*1-100"
					nullmsg="请输入最后修改时间！" errormsg="最后修改时间至少1个字符,取号时间最多100个字符！" value="${hospitalConf.lastModifyDate}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">可以是一段文字描述</div>
		</div> --%>
		
		 <div class="form-group">
			<label for="lastModifyDate" class="col-sm-2 control-label">生&nbsp;效&nbsp;时&nbsp;间：</label>
			<div class="col-sm-5">
				<input id="d424" class="Wdate" type="text" name="lastModifyDate" id="lastModifyDate" 
				onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${hospitalConf.lastModifyDate}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				<%-- onfocus="WdatePicker()" value="${hospitalConf.lastModifyDate}"/> --%>
				<%-- <input class="Wdate" type="text" name="birthday" id="birthday" value="${hospitalConf.lastModifyDate}" onClick="WdatePicker()"> --%>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="beginRegisterTime" class="col-sm-2 control-label"><span style="color:red;">*</span>最&nbsp; &nbsp;早&nbsp; &nbsp;开 &nbsp; &nbsp;始 &nbsp; &nbsp;时 &nbsp; &nbsp;间 ：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="beginRegisterTime" name="beginRegisterTime" placeholder="处理方式" datatype="*1-4"
					nullmsg="请输入最迟开始预约时间！" errormsg="处理方式至少1个字符,最多4个字符！" value="${hospitalConf.beginRegisterTime}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="overRegisterTime" class="col-sm-2 control-label"><span style="color:red;">*</span>最&nbsp; &nbsp;迟&nbsp; &nbsp;开 &nbsp; &nbsp;始 &nbsp; &nbsp;时 &nbsp; &nbsp;间 ：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="overRegisterTime" name="overRegisterTime" placeholder="处理方式" datatype="*1-2"
					nullmsg="请输入最迟开始预约时间！" errormsg="处理方式至少1个字符,最多2个字符！" value="${hospitalConf.overRegisterTime}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="checkRegisterTime" class="col-sm-2 control-label"><span style="color:red;">*</span> 是否检查预约时间：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="checkRegisterTime" name="checkRegisterTime">
				 <option value="0">不检查</option>
				 <option value="1">检查</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="selfAgent" class="col-sm-2 control-label"><span style="color:red;">*</span> 是否接入医院：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="selfAgent" name="selfAgent">
				 <option value="0">不是医院自身接入</option>
				 <option value="1">医院自身接入</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="areaId" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;地&nbsp;区ID：</label>
	    	<input id="areaId" name="areaId" type="hidden" value="${hospitalConf.areaId}"/>
			<div class="col-sm-5">
			    <select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea1(this.value, null)">
			    <option value="0">请选择</option>
			    <c:forEach items="${areaList}" var="area" varStatus="status">
			       <c:if test="${area.parentId==0}">
			         <c:if test="${area.areaId==parAreaId}">
				    	<option value="${area.areaId}" selected="selected">${area.areaName}</option>
				     </c:if>
				     <c:if test="${area.areaId!=parAreaId}">
				    	<option value="${area.areaId}">${area.areaName}</option>
				     </c:if>
				     <c:if test="${hospitalConf.areaId != null && parAreaId== null && hospitalConf.areaId == area.areaId}">
				    	<option value="${area.areaId}" selected="selected">${area.areaName}</option>
				     </c:if>
				   </c:if>
			    </c:forEach>
			    </select>
			    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="selectArea2(this.value);">
			    <c:if test="${hospitalConf.areaId == null}">
			   	    <option>请选择</option>
			    </c:if>
			    </select><!-- <br/><span id="warn" style="color:red;">请选择到二级地区！</span> -->
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
<script>

var ctx = "${ctx}";

$(document).ready(function() { 
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
			if($("#cont").val()==""){
				alert("请输入正确的描述！");
				return false;
			}
			if($("#hospName").val()==""){
				alert("请填写名称！");
				return false;
			}
			if($("#areaId").val()==""){
				alert("请填写所属地区ID！");
				return false;
			}
			$('#fat-btn').button('loading');
		},
		callback : function(json, statusText) {
			if (json.success) {
				$.alert(json.message, function(){
					json.message
					window.location.href = ctx + '/processor/list';
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



	function searchArea1(areaId, areaIdChild) {
		var url = ctx + "/hospital/searchArea";
		$.post(url, {
			'areaId' : areaId
		}, function(data) {
			json = eval(data);
			// 先清空第二个 
			$("#areaIdChild").empty();
			var option = $("<option>").val(0).text("请选择");
			$("#areaIdChild").append(option);
			for (var i = 0; i < json.length; i++) {
				if (areaIdChild != null && areaIdChild == json[i].areaId) {
					option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected", true);
				} else {
					option = $("<option>").val(json[i].areaId).text(json[i].areaName);
				}
				$("#areaIdChild").append(option);
			}
		});
		if (areaId && areaId != 0) {
			$("#areaId").val(areaId);
		}
	}

	function selectArea2(areaIdC) {
		if (areaId && areaId != 0) {
			$("#areaId").val(areaIdC);
		}
	}
</script>

</body>
</html>