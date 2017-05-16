<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>集中平台编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">集中平台信息编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form" role="form" action="${ctx}/agent/save" method="POST">
	    <c:if test="${agentHospital!=null}">
			<input id="agentId" name="agentId" type="hidden" value="${agentHospital.agentId}"/>
	    </c:if>
	    <input id="areaId" name="areaId" type="hidden" value="${agentHospital.areaId}"/>
		<div class="form-group">
			<label for="groupKey" class="col-sm-2 control-label"><span style="color:red;">*</span>医院处理方式的实现类：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="groupKey" name="groupKey" placeholder="医院处理方式的实现类" datatype="*1-30"
					nullmsg="请输入医院处理方式的实现类！" errormsg="医院处理方式的实现类至少1个字符！" value="${agentHospital.groupKey}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		<div class="form-group">
			<label for="interfaceType" class="col-sm-2 control-label"><span style="color:red;">*</span>接口接入类型 ：</label>
			<div class="col-sm-4">
				<select class="lSelect"  id="interfaceType" name="interfaceType">
				 <c:if test="${agentHospital.interfaceType==null||agentHospital.interfaceType==0}">
				 <option value="0" selected="selected">第三方医院调用pavo接口</option>
				 <option value="1">pavo调用第三方接口</option>
				 </c:if>
				 <c:if test="${agentHospital.interfaceType==1}">
				 <option value="0">第三方医院调用pavo接口</option>
				 <option value="1" selected="selected">pavo调用第三方接口</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="conf" class="col-sm-2 control-label"><span style="color:red;">*</span>配&nbsp;置&nbsp;信&nbsp;息：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="conf" name="conf" clos="15" rows="10"></textarea>
			</div>
		</div>
		
		<%-- <div class="form-group">
			<label for="birthday" class="col-sm-2 control-label">最后修改时间：</label>
			<div class="col-sm-5">
			    <input class="Wdate" type="text" name="lastModifyDate" id="lastModifyDate" value="<fmt:formatDate value="${agentHospital.lastModifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div> --%>
		
		<div class="form-group">
			<label for="agentName" class="col-sm-2 control-label"><span style="color:red;">*</span>代&nbsp;理&nbsp;名&nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="agentName" name="agentName" placeholder="代理名称" datatype="*0-256"
					nullmsg="请输入代理名称！" errormsg="代理名称至少0个字符！" value="${agentHospital.agentName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="agentDesc" class="col-sm-2 control-label">描&nbsp;述&nbsp;信&nbsp;息：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="agentDesc" name="agentDesc" clos="15" rows="10"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="status" class="col-sm-2 control-label">状 &nbsp;&nbsp;态 ：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="status" name="status">
				 <c:if test="${agentHospital.status==1||agentHospital.status==null}">
				 <option value="1" selected="selected">开通</option>
				 <option value="0">禁用</option>
				 </c:if>
				 <c:if test="${agentHospital.status==0}">
				 <option value="1">开通</option>
				 <option value="0" selected="selected">禁用</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="areaId" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;地&nbsp;区ID：</label>
			<div class="col-sm-5">
			    <select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
			    <option value="0">请选择</option>
			    <c:forEach items="${areaList}" var="area" varStatus="status">
			       <c:if test="${area.parentId==0}">
			         <c:if test="${area.areaId==parAreaId}">
				    	<option value="${area.areaId}" selected="selected">${area.areaName}</option>
				     </c:if>
				     <c:if test="${area.areaId!=parAreaId}">
				    	<option value="${area.areaId}">${area.areaName}</option>
				     </c:if>
				     <c:if test="${agentHospital.areaId!=null && parAreaId==null && agentHospital.areaId==area.areaId}">
				    	<option value="${area.areaId}" selected="selected">${area.areaName}</option>
				     </c:if>
				   </c:if>
			    </c:forEach>
			    </select>
			    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="selectArea(this.value);">
			   <%--  <c:if test="${agentHospital.areaId!=null && parAreaId!=null}">
			    	<option>${areaMap[hosInfo.areaId]}</option>
			    </c:if> --%>
			    <c:if test="${agentHospital.areaId==null}">
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
	<br />
<%-- </div> --%>
<script type="text/javascript">
		var ctx = "${ctx}";
	$(document).ready(function() {
		var agentHospital = "${agentHospital}";
		if(agentHospital!=""&&agentHospital!=null){
			document.form.action=ctx+"/agent/update"; 
			//给配置和描述赋值
			var conf =  "${agentHospital.conf}";
			if(conf!=""){
				  $("#conf").val(conf); 
			}
			var agentDesc =  "${agentHospital.agentDesc}";
			if(agentDesc!=""){
				  $("#agentDesc").val(agentDesc); 
			}
			
		}
		
		//查询条件赋值
		var parAreaId = "${parAreaId}";
		var areaId = "${agentHospital.areaId}";
		if(parAreaId=="" && areaId!=""){
			searchArea(areaId,null);
		}else if(parAreaId!="" && areaId!=""){
			searchArea(parAreaId,areaId);
		}
		
		//去掉配置里的换行符
		$("#conf").blur(function (){
			var a = $("#conf").val().replace(/\n/g, "");
			$("#conf").val(a);
		});
		//去掉描述里的换行符
		$("#agentDesc").blur(function (){
			var a = $("#agentDesc").val().replace(/\n/g, "");
			$("#agentDesc").val(a);
		});
		
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
				/* if(($("#areaIdParent").val()!=""&&$("#areaIdParent").val()!=0) && $("#areaId").val()==""){
					alert("请确认选择了二级地区或者不选择地区！");
					return false;
				} */
				if($("#conf").val()==""){
					alert("请填写配置信息！");
					return false;
				}
				if($("#agentName").val()==""){
					alert("请填写代理名称！");
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
					if(json.message!="添加成功！"){
						$.alert(json.message, function(){
						});
					}else{
						$.alert(json.message, function(){
							//window.location.reload();
							window.location.href = '${ctx}/agent/list';
						});
					}
				} else {
					errorValidate('msg-info', json.message + ',' + "");
					
				}
				$('#fat-btn').button('reset');
			}
		});

	});
	
	
	function searchArea(areaId,areaIdChild){
		var url = ctx+"/hospital/searchArea";
		$.post(url,{'areaId':areaId},function (data){
			json = eval(data);
			  // 先清空第二个 
		      $("#areaIdChild").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#areaIdChild").append(option); 
			for(var i=0; i<json.length; i++) 
			{ 
				if(areaIdChild!=null && areaIdChild == json[i].areaId){
					option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].areaId).text(json[i].areaName);
				}
				
			    //alert(json[i].areaId+" " + json[i].areaName) 
			    $("#areaIdChild").append(option); 
			} 
		});
		 if(areaId!=0){
		   $("#areaId").val(areaId);
		} 
		
	}
	
	function selectArea(areaIdC){
		//alert($("#areaIdParent").val());
		//alert(areaIdC);
		if(areaId!=0){
			   $("#areaId").val(areaIdC);
			}
	}
</script>
</html>