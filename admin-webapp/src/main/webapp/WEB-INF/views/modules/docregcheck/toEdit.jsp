<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生信息编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医生信息编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/docregcheck/patdoc2regdoc" method="POST">
	    <c:if test="${userDoctor!=null}">
			<input id="userId" name="userId" type="hidden" value="${userDoctor.userId}"/>
	    </c:if>
	    <input id="hospId" name="hospId" type="hidden" value="${userDoctor.hospId}"/>
	    <input id="deptId" name="deptId" type="hidden" value="${userDoctor.deptId}"/>
	    <input id="regDoctorId" name="regDoctorId" type="hidden" value="${userDoctor.regDoctorId}"/>
	    <input id="doctorHeadImage" name="doctorHeadImage" type="hidden" value="${userDoctor.doctorHeadImage}"/>
	    <input id="areaId" name="areaId" type="hidden" value="${userDoctor.areaId}"/>
	    <input id="standDeptId" name="standDeptId" type="hidden" value="${userDoctor.standDeptId}"/>
	    <input id="gradeText" name="gradeText" type="hidden" value="${userDoctor.gradeText}"/>
	    <input id="areaName" name="areaName" type="hidden" value="${userDoctor.areaName}"/>
	    <input id="standDeptName" name="standDeptName" type="hidden" value="${userDoctor.standDeptName}"/>
	    <input id="auditStatus" name="auditStatus" type="hidden" value="${userDoctor.auditStatus}"/>
		<div class="form-group">
			<label for="areaName" class="col-sm-2 control-label">姓&nbsp; &nbsp;名 ：</label>
			<div class="col-sm-5">
			<c:if test="${flag!=1}">
				<input type="text" class="form-control" id="name" name="name" placeholder="姓名" datatype="*2-100"
					nullmsg="请输入姓名！" errormsg="姓名至少2个字符,最多100个字符！" value="${userDoctor.name}">
			</c:if>
			<c:if test="${flag==1}">${userDoctor.name}</c:if>		
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" >
			<label for="doctorCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;地 &nbsp;区：</label>
			<div class="col-sm-5">
			<c:if test="${flag!=1}">
				<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value)">
			    <option value="0">请选择</option>
			    <c:forEach items="${areaList}" var="area" varStatus="status">
			       <c:if test="${area.parentId==0}">
			       <c:if test="${parAreaId!=''&& parAreaId!=null}">
			         <c:if test="${area.areaId==parAreaId}">
				    	<option value="${area.areaId}" selected="selected">${area.areaName}</option>
				     </c:if>
				      
				     <c:if test="${area.areaId!=parAreaId}">
				    	<option value="${area.areaId}">${area.areaName}</option>
				     </c:if>
				    </c:if>
				    <c:if test="${parAreaId==''|| parAreaId==null}">
				    <c:if test="${area.areaId==userDoctor.areaId}">
				    	<option value="${area.areaId}" selected="selected">${area.areaName}</option>
				     </c:if>
				     <c:if test="${area.areaId!=userDoctor.areaId}">
				    	<option value="${area.areaId}">${area.areaName}</option>
				     </c:if>
				    </c:if>
				   </c:if>
			    </c:forEach>
			    </select>
			    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="selectArea(this);">
			    <c:if test="${parAreaId!=''&& parAreaId!=null}">
				    <c:if test="${userDoctor.areaId!=null}">
				    	<option>${areaMap[userDoctor.areaId]}</option>
				    </c:if>
				    <c:if test="${userDoctor.areaId==null}">
				   	    <option>请选择</option>
				    </c:if>
			    </c:if>
			    <c:if test="${parAreaId==''|| parAreaId==null}">
			    	<option>请选择</option>
			    </c:if>
			    </select>
			    </c:if>
		  
			    <c:if test="${flag==1}">
			    ${areaMap[parAreaId]}-${areaMap[userDoctor.areaId]}
			    </c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;医&nbsp;院：</label>
			<div class="col-sm-5">
			<c:if test="${flag!=1}">
				<input type="text" class="form-control" id="hospName" name="hospName" placeholder="所在医院" datatype="*4-100"
					nullmsg="请输入所在医院名称！" errormsg="所在医院至少4个字符！" value="${userDoctor.hospName}">
			</c:if>
			<c:if test="${flag==1}">${userDoctor.hospName}</c:if>	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;科&nbsp;室：</label>
			<div class="col-sm-5">
			<c:if test="${flag!=1}">
				<input type="text" class="form-control" id="deptName" name="deptName" placeholder="所在科室" datatype="*2-100"
					nullmsg="请输入所在科室名称！" errormsg="所在科室至少2个字符！" value="${userDoctor.deptName}">
			</c:if>
			<c:if test="${flag==1}">${userDoctor.deptName}</c:if>	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">标&nbsp;准&nbsp;科&nbsp;室：</label>
			<div class="col-sm-4">
			<c:if test="${flag!=1}">
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
			        <c:if test="${userDoctor.standDeptId==null}">
			   	    	<option>请选择</option>
			   	    </c:if>
			   	    <c:if test="${userDoctor.standDeptId!=null}">
			    		<option>${sdMap[userDoctor.standDeptId]}</option>
			    	</c:if>
			    </select>
			</c:if>
			<c:if test="${flag==1}">${sdMap[parDepartmentId]}-${sdMap[userDoctor.standDeptId]}</c:if>    
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="doctorGrade" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;职 &nbsp;称：</label>
			<div class="col-sm-5">
			<c:if test="${flag!=1}">
			<select class="mSelect"  class="mSelect"  id="grade" name="grade" onchange="setDGText(this);">
			    <option value="">请选择</option>
			    <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==userDoctor.grade}">
				    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
				    </c:if>
				    <c:if test="${dic.dictId!=userDoctor.grade}">
				    	<option value="${dic.dictId}" >${dic.dictName}</option>
				    </c:if>
			    </c:forEach>
			</select>
			</c:if>
			<c:if test="${flag==1}">
            <c:forEach items="${dicList}" var="dic" varStatus="status">
		    <c:if test="${dic.dictId==userDoctor.grade}">
		    	${dic.dictName}
		    </c:if>
			</c:forEach>
            </c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;电 &nbsp;话：</label>
			<div class="col-sm-5">
			<c:if test="${flag!=1}">
				<input type="text" class="form-control" id="phone" name="phone" placeholder="医生电话" datatype="/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/i"
					nullmsg="请输入医生电话！" errormsg="电话格式不正确！" value="${userDoctor.phone}">
			</c:if>
			<c:if test="${flag==1}">${userDoctor.phone}</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		

		<c:if test="${flag!=1}">
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
			<c:if test="${userDoctor.hasRelDoctor==1}">
				<button type="button" id="fat-btn" class="btn btn-primary" onclick="gotoDocsave()" data-loading-text="正在保存...">保存</button>
			</c:if>
			<c:if test="${userDoctor.hasRelDoctor!=1}">
				<button type="button" id="register" class="btn btn-primary" onclick="gotoregister()" data-loading-text="正在注册...">注册</button>
			</c:if>
			</div>
		</div>
		</c:if>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {
		
		var parAreaId = "${parAreaId}";
		var areaIdParm = "${userDoctor.areaId}";
		if(parAreaId==null||parAreaId==""){
			searchArea(areaIdParm);
		}
		
		$(window.parent.document).find("#myModal").remove();
		$(window.parent.document).find('body').append('<div id="myModal" class="modal"><img  width="300px" height="300px" src="" style="cursor: pointer;" /></div>');
		
		var $myModal = $(window.parent.document).find("#myModal");
		$myModal.css({"width": "300px","height": "300px","margin": "auto","display": "none","position": "fixed"});
		$myModal.find("img").css("margin","auto");
		
		$("#img_div img").click(function(){
			var $this = $(this);
			
			$myModal.find("img").attr("src",$this.attr("src"));
			$myModal.show();
			
		});
		
		 $myModal.click(function(){
			$myModal.hide();
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
				var areaId = $("#areaId").val();
				if(areaId==""){
					alert("请选择二级地区！");
					return false;
				}
				var standDeptId = $("#standDeptId").val();
				if(standDeptId==""){
					alert("请选择二级标准科室！");
					return false;
				}
				var grade = $("#grade").val();
				if(grade==""){
					alert("请选择医生职称！");
					return false;
				}
				$("#auditStatus").val(1);
				
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				$.alert(json.message, function(){
						self.location=document.referrer;
					});
				$('#fat-btn').button('reset');
			}
		});

	});
	
	//地区下拉联动
    function searchArea(areaId){
    	if(areaId==0){
    		return;
    	}
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
    	 if(areaId!=0){
    	   $("#areaId").val("");
    	 }
    	
    }
	
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
			   $("#standDeptId").val(sdId);
			   var standDeptName = $("#sdChild1").find("option:selected").text();
			   $("#standDeptName").val(standDeptName);
			}
		}else{
			$("#standDeptId").val("");
		}
		
	} 
    
    function selectArea(obj){
    	var areaId = obj.options[obj.selectedIndex].value;
    	var areaName = obj.options[obj.selectedIndex].text;
		if(areaId!=0){
			$("#areaId").val(areaId);
		}
		if(areaName!=""){
			$("#areaName").val(areaName);
		}
	}
    
    function setDGText(obj){
		var gradeText = obj.options[obj.selectedIndex].text;
		$("#gradeText").val(gradeText);
	}
    
    
    function gotoregister(){
    	$("form").submit();
    }
    
    function gotoDocsave(){
    	var areaId = $("#areaId").val();
    	var areaName = $("#areaName").val();
    	var userId = $("#userId").val();
    	var standDeptId = $("#standDeptId").val();
    	var standDeptName = $("#standDeptName").val();
    	var hospName = $("#hospName").val();
    	var name = $("#name").val();
    	var deptName = $("#deptName").val();
    	var phone = $("#phone").val();
    	var regDoctorId = $("#regDoctorId").val();
    	var url = ctx+"/docregcheck/updateregdoc";
    	$.post(url,{'areaId':areaId,'areaName':areaName,'userId':userId,'standDeptId':standDeptId,'standDeptName':standDeptName,'hospName':hospName,'name':name,'deptName':deptName,'phone':phone,'regDoctorId':regDoctorId},function (data){
    		if(data.success){
    			alert(data.message);
    			self.location=document.referrer;
    		} 
    	});
    	
    }
    	
	

</script>
</html>