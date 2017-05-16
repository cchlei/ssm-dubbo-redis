<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院科室编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院科室编辑</a></li>
		<%-- <c:if test="${departmentInfo!=null && departmentInfo.standardDepartmentId!=null}">
			<li><a href="${ctx}/doctor/list?hospId=${departmentInfo.hospId}&departmentId=${departmentInfo.departmentId}&standardDepartmentId=${departmentInfo.standardDepartmentId}">医生编辑</a></li>
		</c:if> --%>
		<%-- <c:if test="${flag=='hierarchy'}"> --%>
		<li><a href="${ctx}/doctor/deplist?hospId=${departmentInfo.hospId}&departmentId=${departmentInfo.departmentId}&standardDepartmentId=${departmentInfo.standardDepartmentId}">科室医生编辑</a></li>
		<li><a href="${ctx}/hospDep/showHisData?departmentId=${departmentInfo.departmentId}">医生his数据</a></li>
		<%-- </c:if> --%>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/hospDep/save" method="POST">
		<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	    <c:if test="${departmentInfo!=null}">
			<input id="departmentId" name="departmentId" type="hidden" value="${departmentInfo.departmentId}"/>
	    </c:if>
	    <c:if test="${departmentName!=null}">
	    <div class="form-group">
			<label for="departmentName" class="col-sm-2 control-label">上&nbsp;级&nbsp;科&nbsp;室：</label>
			<div class="col-sm-5">
				<%-- <span>${departmentName}</span>
				<input id="parentId" name="parentId" type="hidden" value="${parentId}"/> --%>
				<select  class="mSelect"  id="parentId" name="parentId">
				<c:if test="${departmentInfo!=''&& departmentInfo!=null}">
			    <c:forEach items="${deplist}" var="dep" varStatus="status">
			       <c:if test="${dep.parentId==0}">
			            <c:if test="${departmentInfo.parentId==dep.departmentId}">
				    		<option value="${dep.departmentId}" selected="selected">${dep.departmentName}</option>
				    	</c:if>
				    	<c:if test="${departmentInfo.parentId!=dep.departmentId}">
				    		<option value="${dep.departmentId}">${dep.departmentName}</option>
				    	</c:if>
				   </c:if>
			    </c:forEach>
			    </c:if>
			    <c:if test="${departmentInfo==''||departmentInfo==null}">
				    <option value="${parentId}">${departmentName}</option>
				</c:if>
			    </select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="parentIdMessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		</c:if>
		<c:if test="${departmentInfo==null}">
			<c:if test="${departmentName==null}">
			<div class="form-group" >
				<label for="doctorCode" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;医 &nbsp;院：</label>
				<div class="col-sm-5">
					所在地：  
				<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value)">
			    <option value="0">请选择</option>
			    <c:forEach items="${areaList}" var="area" varStatus="status">
			       <c:if test="${area.parentId==0}">
				    	<option value="${area.areaId}">${area.areaName}</option>
				   </c:if>
			    </c:forEach>
			    </select><br/>
			    <span style="margin-left:60px;"><select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
			   	    <c:if test="${areaId!=null}">
			    	<option>${areaMap[areaId]}</option>
				    </c:if>
				    <c:if test="${areaId==null}">
				   	    <option value="0">请选择</option>
				    </c:if>
			    </select></span><br/>
			    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" data-edit-select="1" onchange="selectHosp(this)">
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
		</c:if>
		
		<c:if test="${departmentInfo!=null}">
		<div class="form-group" >
			<label for="doctorCode" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;医 &nbsp;院：</label>
			<div class="col-sm-5">
				<c:if test="${departmentInfo!=null}">
				所在地：${areaMap[areaId]}&nbsp;&nbsp;医院：${hospName}
				</c:if>
			</div>
		</div>	
		</c:if>
		
		<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
		<input id="standardDepartmentId" name="standardDepartmentId" type="hidden" value="${departmentInfo.standardDepartmentId}"/>
		
		<div class="form-group">
			<label for="isThirdparty" class="col-sm-2 control-label"><span style="color:red;">*</span>是否对接第三方医院：</label>
			<div class="col-sm-5">
			<c:if test="${departmentInfo==null}">
				<select class="mSelect" id="isThirdparty" name="isThirdparty" onchange="ifShow(this.value);">
				 <option value="2">非第三方</option>
				 <option value="1">是,第三方直接对接</option>
				 <option value="3">是,第三方对接平台</option>
				 <option value="4">是,2和3两种都是</option>
				</select>
			</c:if>
			<c:if test="${departmentInfo!=null}">
			 <c:if test="${departmentInfo.isThirdparty==1}">是,第三方直接对接</c:if>
			    <c:if test="${departmentInfo.isThirdparty==2}">非第三方</c:if>
			    <c:if test="${departmentInfo.isThirdparty==3}">是,第三方对接平台</c:if>
			    <c:if test="${departmentInfo.isThirdparty==4}">是,1和3两种都是</c:if>
			    <input type="hidden" name="isThirdparty" value="${departmentInfo.isThirdparty}"/>
			</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" id="showDoctCode" style="display:none">
			<label for="departmentCode" class="col-sm-2 control-label">科室第三方编码：</label>
			<div class="col-sm-5">
			<%-- <c:if test="${departmentInfo==null}"> --%>
				<input type="text" class="form-control" id="departmentCode" name="departmentCode" placeholder="科室第三方编码" datatype="*0-20"
					nullmsg="请输入科室第三方编码！" errormsg="最多20个字符！" value="${departmentInfo.departmentCode}">
			<%-- </c:if>
			<c:if test="${departmentInfo!=null}">
			${departmentInfo.departmentCode}
			     <input type="hidden" name="departmentCode" value="${departmentInfo.departmentCode}"/>
			</c:if> --%>
			</div>
			<div class="col-sm-5 help-block Validform_checktip">可以不填</div>
		</div>
		
		<div class="form-group">
			<label for="departmentName" class="col-sm-2 control-label">科&nbsp; &nbsp;室&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="departmentName" name="departmentName" placeholder="科室名称" datatype="*1-20"
					nullmsg="请输入科室名称！" errormsg="科室名称至少1个字符,最多20个字符！" value="${departmentInfo.departmentName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="departmentNum" class="col-sm-2 control-label">科&nbsp; &nbsp;室&nbsp; &nbsp;编 &nbsp; &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="departmentNum" name="departmentNum" value="${departmentInfo.departmentNum}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<c:if test="${departmentName!=null||departmentInfo!=null}">
		<c:if test="${departmentInfo.parentId!=0}">
		<div class="form-group">
			<label for="sdName" class="col-sm-2 control-label">对应标准科室：</label>
			<select class="mSelect"  class="mSelect"  id="sdParent" name="sdParent" onchange="searchSd(this.value,1,null)">
			    <option value="0">请选择</option>
			    <c:forEach items="${sdList}" var="sd" varStatus="status">
			       <c:if test="${sd.parentId==0}">
			            <c:if test="${parDepartmentId==sd.standardDepartmentId}">
				    		<option value="${sd.standardDepartmentId}" selected="selected">${sd.departmentName}</option>
				    	</c:if>
				    	<c:if test="${parDepartmentId!=sd.standardDepartmentId}">
				    		<option value="${sd.standardDepartmentId}">${sd.departmentName}</option>
				    	</c:if>
				   </c:if>
			    </c:forEach>
			    </select>
			    <select class="mSelect"  class="mSelect"  id="sdChild1" name="sdChild1" onchange="searchSd(this.value,2,null);">
			   <%--  <c:if test="${departmentInfo.standardDepartmentId!=null}">
			    	<option>${sdMap[departmentInfo.standardDepartmentId]}</option>
			    </c:if> --%>
			   <%--  <c:if test="${departmentInfo.standardDepartmentId==null}"> --%>
			        <c:if test="${departmentInfo.standardDepartmentId==null}">
			   	    	<option>请选择</option>
			   	    </c:if>
			   	    <c:if test="${departmentInfo.standardDepartmentId!=null}">
			    		<option>${sdMap[departmentInfo.standardDepartmentId]}</option>
			    	</c:if>
			    <%-- </c:if> --%>
			    </select>
			    <%-- <select class="mSelect"  class="mSelect"  id="sdChild2" name="sdChild2" onchange="selectSd(this.value);">
			    <c:if test="${departmentInfo.standardDepartmentId!=null}">
			    	<option>${sdMap[departmentInfo.standardDepartmentId]}</option>
			    </c:if>
			    <c:if test="${departmentInfo.standardDepartmentId==null}">
			   	    <option>请选择</option>
			    </c:if>
			    </select> &nbsp;&nbsp;<span id="warn" style="color:red;">请务必选择对应的标准科室！</span>--%>
		</div>
		
		<div class="form-group">
			<label for="diagAddress" class="col-sm-2 control-label"><span style="color:red;">*</span>就&nbsp;诊 &nbsp;地 &nbsp;点：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="diagAddress" name="diagAddress" placeholder="就诊地点" datatype="*1-100"
					nullmsg="请输入就诊地点！" errormsg="取号时间至少1个字符,就诊地点最多100个字符！" value="${departmentInfo.diagAddress}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		    </div>
		    </c:if>
		</c:if>
		<div class="form-group">
			<label for="hospDesc" class="col-sm-2 control-label">科 &nbsp;室 &nbsp;简 &nbsp;介：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="departmentDesc" name="departmentDesc" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1">最多输入80个字符</div>
		</div>
		
		<div class="form-group">
			<label for="brevityCode" class="col-sm-2 control-label">科&nbsp; &nbsp;室&nbsp; &nbsp;简 &nbsp;&nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="brevityCode" name="brevityCode" placeholder="科室简码" datatype="*1-10"
					nullmsg="请输入科室简码！" errormsg="科室简码至少1个字符,最多10个字符！" value="${departmentInfo.brevityCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<c:if test="${departmentName!=null && departmentInfo.parentId!=0}">
		<div class="form-group">
			<label for="isPrepay" class="col-sm-2 control-label">是否是特色科室：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="isSpecial" name="isSpecial">
				 <c:if test="${departmentInfo.isSpecial==2||departmentInfo.isSpecial==null}">
				 <option value="1">是</option>
				 <option value="2" selected="selected">否</option>
				 </c:if>
				 <c:if test="${departmentInfo.isSpecial==1}">
				 <option value="1" selected="selected">是</option>
				 <option value="2">否</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		</c:if>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">成功挂号人数：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="successfulRegisteredNum" name="successfulRegisteredNum" datatype="n" min="1" 
					nullmsg="请输入一个大于等于0的数字！" errormsg="只能输入数字类型！" value="${departmentInfo.successfulRegisteredNum}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排 &nbsp; &nbsp;序：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="sort" name="sort"  datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${departmentInfo.sort}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<c:if test="${departmentInfo==null}">
			<div class="form-group">
				<label for="isEnabled" class="col-sm-2 control-label">是&nbsp;否&nbsp;启&nbsp;用：</label>
				<div class="col-sm-4">
					<select class="sSelect"  class="sSelect"  id="isEnabled" name="isEnabled">
					 <c:if test="${departmentInfo.isEnabled==1||departmentInfo.isEnabled==null}">
					 <option value="1" selected="selected">启用</option>
					 <option value="2">禁用</option>
					 </c:if>
					 <c:if test="${departmentInfo.isEnabled==2}">
					 <option value="1">启用</option>
					 <option value="2" selected="selected">禁用</option>
					 </c:if>
					</select>
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
		</c:if>
		
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary"   data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script src="${ctxStatic}/js/hospSuggestion.js" type="text/javascript"></script>
<script type="text/javascript">
$.ajaxSetup({
	   async:false
});
var ctx = "${ctx}";
var subflag = 0;
var isThirdpartyFlag=false;
	$(document).ready(function() {
		var tag = "${departmentInfo}";
		var isThirdparty = "${departmentInfo.isThirdparty}";
		if(isThirdparty!=""){
			ifShow(isThirdparty);
		}
		var ctx = "${ctx}";
		if(tag!=""){
			document.form1.action=ctx+"/hospDep/update"; 
			
		}
		
		//给医院描述内容赋值
		$("#departmentDesc").val("${departmentInfo.departmentDesc}");
		//让是否是第三方被选中
		//document.getElementById("isThirdparty").value = "${departmentInfo.isThirdparty}";
		
		//控制描述信息输入字数
		$("#departmentDesc").keyup(function(){
			 var a=80-$("#departmentDesc").val().length;
			 $("#nLength1").html("您还可以输入"+a+"个字符");
			 if($("#nLength1").html()<=0){
			   alert("字数不能超过80");
			 }
		 });
		
		
		//查询条件赋值
		var parDepartmentId = "${parDepartmentId}";
		var standardDepartmentId = "${departmentInfo.standardDepartmentId}";
		searchSd(parDepartmentId,1,standardDepartmentId);
		
		
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
				/* if($("#subflag").val()!=0){
					alert("请选择正确的上级科室！");
					return false;
				} */
				var sdParent = $("#sdParent").val();
				if(sdParent!=""&&sdParent!="0"){
					//alert("${departmentName}");
					//alert("${departmentName}"!="" && $("#standardDepartmentId").val()=="");
					if("${departmentName}"!="" && $("#standardDepartmentId").val()==""){//子级科室才必须选择对应的标准科室
						alert("请选择对应标准科室！");
						return false;
					}
					var dep = "${departmentInfo}";
					if(dep!=""&&"${departmentInfo.parentId}"!=0&&$("#standardDepartmentId").val()==""){
						alert("请选择对应标准科室！");
						return false;
					}
				}else{
					$("#standardDepartmentId").val("");
				}
				
				/* if($("#isThirdparty").val()==1&&$("#departmentCode").val()==""){
					alert("请填写科室编码！");
					return false;
				
				} */
				if(isThirdpartyFlag && $("#departmentCode").val()==""){
					alert("请填写科室编码！");
					return false;
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					 $.alert(json.message, function(){
						 $('#fat-btn').removeAttr("disabled");
						window.location.href = window.location.href;
						//var hospId = "${hospId}";
						//window.location.href = ctx+'/hospDep/list?hospId='+hospId;
						//window.location.href = '${ctx}/link/list';
					}); 
				} else {
					errorValidate('msg-info', json.message + ',' + "");
					
				}
			}
		});

	});
	
	function searchSd(sdId,number,sdId2){
		var url = ctx+"/hospDep/searchSdDep";
		var selPeram = "";
		$.post(url,{'standardDepartmentId':sdId},function (data){
			json = eval(data);
			  if(number==1){
				  selPeram = "#sdChild1";
			  }else{
				  selPeram = "#sdChild2";
			  }
			  //添加前先清空
			  $(selPeram).empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $(selPeram).append(option); 
			for(var i=0; i<json.length; i++) 
			{ 
				if(sdId2!=null && sdId2 == json[i].standardDepartmentId){
					option = $("<option>").val(json[i].standardDepartmentId).text(json[i].departmentName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].standardDepartmentId).text(json[i].departmentName);
				}
				
			    $(selPeram).append(option); 
			} 
		});
		if(number==2){//二级标准科室
			if(sdId!=0){
			   $("#standardDepartmentId").val(sdId);
			}
		}
		
	} 
	
	function selectSd(sdC){
		if(sdC!=0){
			   $("#standardDepartmentId").val(sdC);
			}
	}
	
	 //地区下拉联动
    function searchArea(areaId){
    	if(areaId==0){
    		return;
    	}
    	var url = ctx+"/hospDep/searchArea";
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
    	 searchHosp(areaId);//根据父级地区查询医院
    	 /* if(areaId!=0){
    	   $("#areaId").val(areaId);
    	 }  */
    	
    }

    //医院下拉联动
    function searchHosp(areaId){
    	if(areaId==0){
    		var areaIdParent=$("#areaIdParent").val();
    		searchArea(areaIdParent,null);
    		return;
    	}
    	var url = ctx+"/hospDep/searchHosp";
    	$.post(url,{'areaId':areaId},function (data){
    		json = eval(data);
    		  // 先清空第二个 
    	      $("#hospital").empty(); 
    	      var option = "";
    	      option = $("<option>").val(0).text("请选择");
    	      $("#hospital").append(option); 
    		for(var i=0; i<json.length; i++) 
    		{ 
    			option = $("<option>").val(json[i].hospId).text(json[i].hospName).attr('isthirdparty',json[i].isThirdparty).attr('areaId',json[i].areaId);
    		    //alert(json[i].areaId+" " + json[i].areaName) 
    		    $("#hospital").append(option); 
    		} 
    	});
    	/*  if(areaId!=0){
    		   $("#areaId").val(areaId);
    		 }  */
		$(".m-input").remove();
	    var $select = $("select[data-edit-select]").filterSelect();
		$select.on("change", function(){
			    console.log(this.value)
	    });
    	
    }
    
    function selectHosp(obj){
    	var hospId = obj.options[obj.selectedIndex].value;
    	var istd  = $(obj).find("option:selected").attr("isthirdparty");
    	var areaId  = $(obj).find("option:selected").attr("areaId");
    	if(areaId!=0){
 		   $("#areaId").val(areaId);
 		 }
    	$("#isThirdparty").val(istd);
		ifShow(istd);
		if(istd==1){//是第三方医院
		    alert("该医院是第三方医院，请填写科室编码");
		}
    	if(hospId!=0){
 		   $("#hospId").val(hospId);
 		}
    }
    
    function ifShow(value){
    	if(value==1||value==3||value==4){
			document.getElementById("showDoctCode").style.display="block";
		}else{
			document.getElementById("showDoctCode").style.display="none";
		}
		if(value==1||value==4){
			isThirdpartyFlag=true;
		}else{
			isThirdpartyFlag=false;
		}
	}
	
    //验证是否可以修改该二级科室所对应的一级科室
   /*  function checkIfCan(parentId){
    	var url = ctx+"/hospDep/checkParentId";
    	$.post(url,{'parentId':parentId},function (data){
			if(data.success){
				if(data.message==1){
					$("#subflag").val("1");
					$('#parentIdMessage').text("不可修改！");
					document.getElementById("parentIdMessage").style.display="block";
				}else if(data.message==0){
					$("#subflag").val("0");
					document.getElementById("parentIdMessage").style.display="none";
				}
			}
		});
    } */
	
</script>
</html>