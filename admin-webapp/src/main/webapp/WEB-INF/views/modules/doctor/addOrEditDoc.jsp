<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医生信息编辑</title>
    <style>
        body,html{padding:0;margin:0;width:100%;height:100%;}
    </style>

</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<%-- <li><a href="${ctx}/hospDep/list?hospId=${hospId}">医院科室编辑</a></li> --%>
		<li class="active"><a href="javascript:void(0)">医生编辑</a></li>
		<li><a href="${ctx}/doctor/showHisData?doctorId=${doctorInfo.doctorId}">医生his数据</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1"  id="form" role="form" action="${ctx}/doctor/save" method="POST">
	
	    <c:if test="${doctorInfo!=null}">
			<input id="doctorId" name="doctorId" type="hidden" value="${doctorInfo.doctorId}"/>
	    </c:if>
	        <input id="doctorHeadImage" name="doctorHeadImage" type="hidden" value="${doctorInfo.doctorHeadImage}"/>
	         <input id="ifnameSpellAllow" name="ifnameSpellAllow" type="hidden"/>
	        
	        <c:if test="${doctorInfo.departments!=null}">
				<c:forEach items="${doctorInfo.departments}" var="dep" varStatus="status">
				<c:if test="${status.count==1}">
					<input id="areaId" name="areaId" type="hidden" value="${dep.areaId}"/>
					<input id="hospId" name="hospId" type="hidden" value="${dep.hospId}"/>
				</c:if>
		    	</c:forEach>
		    </c:if>
		     <c:if test="${doctorInfo.departments==null}">
			<input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
			<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
			</c:if>
			
			<input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
			<input id="standardDepartmentId" name="standardDepartmentId" type="hidden" value="${standardDepartmentId}"/>
			
			<input id="doctorGradeText" name="doctorGradeText" type="hidden"/>
			<input id="teachGradeText" name="teachGradeText" type="hidden"/>
	        
	        <input id="doctorDesc1" name="doctorDesc1" value="${doctorInfo.doctorDesc}" type="hidden"/>
	        <input id="specialtydesc1" name="specialtydesc1" value="${doctorInfo.specialtydesc}" type="hidden"/>
	        
	    <div class="form-group">
			<label for="isThirdparty" class="col-sm-2 control-label"><span style="color:red;">*</span>是否对接第三方医院：</label>
			<div class="col-sm-5">
			<c:if test="${doctorInfo==''||doctorInfo==null}">
				<select class="mSelect" id="isThirdparty" name="isThirdparty" onchange="ifShow(this.value);">
				<option value="2">非第三方</option>
				 <option value="1">是,第三方直接对接</option>
				 <option value="3">是,第三方对接平台</option>
				 <option value="4">是,2和3两种都是</option>
				</select>
			</c:if>	
			<c:if test="${doctorInfo!=''&&doctorInfo!=null}">
			    <c:if test="${doctorInfo.isThirdparty==1}">是,第三方直接对接</c:if>
			    <c:if test="${doctorInfo.isThirdparty==2}">非第三方</c:if>
			    <c:if test="${doctorInfo.isThirdparty==3}">是,第三方对接平台</c:if>
			    <c:if test="${doctorInfo.isThirdparty==4}">是,1和3两种都是</c:if>
			    <input type="hidden" name="isThirdparty" value="${doctorInfo.isThirdparty}"/>
			</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" id="showDoctCode" style="display:none">
			<label for="doctorCode" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp;生&nbsp;编 &nbsp;码：</label>
			<div class="col-sm-5">
			    <%-- <c:if test="${doctorInfo==''||doctorInfo==null}"> --%>

				<input type="text" class="form-control" id="doctorCode" name="doctorCode" placeholder="医生编码" datatype="*0-100"
					nullmsg="请输入医生编码！" errormsg="医院编码最多100个字符！" value="${doctorInfo.doctorCode}">
			    <%-- </c:if>
			    <c:if test="${doctorInfo!=''}">
			    ${doctorInfo.doctorCode}
			     <input type="hidden" name="doctorCode" value="${doctorInfo.doctorCode}"/>
			    </c:if> --%>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="isSpecialized" class="col-sm-2 control-label"><span style="color:red;">*</span>是否是专病医生：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="isSpecialized" name="isSpecialized" onchange="ifOneDep(this.value)">
				 <c:if test="${doctorInfo.isSpecialized==1}">
				 <option value="1" selected="selected">是</option>
				 <option value="2">否</option>
				 </c:if>
				 <c:if test="${doctorInfo.isSpecialized==2||doctorInfo.isSpecialized==null}">
				 <option value="1">是</option>
				 <option value="2" selected="selected">否</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<c:if test="${doctorInfo==null}">
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
		    </select>&nbsp;&nbsp;&nbsp;
		    <span style="margin-left:60px;"><select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
		   	    <c:if test="${areaId!=null}">
		    	<option>${areaMap[areaId]}</option>
			    </c:if>
			    <c:if test="${areaId==null}">
			   	    <option value="0">请选择</option>
			    </c:if>
		    </select></span><br/>
		    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" data-edit-select="1" onchange="searchDep(this,'1')">
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
		
		<c:if test="${doctorInfo!=null}">
		<div class="form-group" >
			<label for="doctorCode" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;医 &nbsp;院：</label>
			<div class="col-sm-5">
				<c:if test="${doctorInfo!=null}">
				所在地：${areaMap[areaId]}&nbsp;&nbsp;医院：${hospName}
				</c:if>
			</div>
		</div>	
		</c:if>
		
		<div class="form-group" id="showDep">
			<label for="doctorCode" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;科 &nbsp;室：</label>
			<div class="col-sm-5">
			    <div>
				<select class="mSelect"    id="hdParent" name="hdParent" onchange="searchHd(this,1)"style="vertical-align:top;display:block;">
			    	<option value="0">请选择</option>
			    </select>
				    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1"  style="float:left;"   onchange="selectHd(this);">
					    <c:if test="${doctorInfo.departments!=null&&doctorInfo.isSpecialized==1}">
						    <c:forEach items="${doctorInfo.departments}" var="depList" varStatus="status">
				  				<option value="${depList.departmentId}" sdid="${depList.standardDepartmentId}" selected="selected">${depList.departmentName}</option>
				  			</c:forEach>
						   	<c:if test="${departmentName!=null}">
						    	<option>${departmentName}</option>
						    </c:if>
					    </c:if>
				    </select>
			    	 <div id="showDepS" style="float:left;">
					    <div style="float:left" >
					    <input type="button" id="go" value=">>"/><br/>
			  			<input type="button" id="back" value="<<"/>
			  			</div>
			  			<div style="float:left">
					    <select class="mSelect"  class="mSelect"  name="doctorDep" id='doctorDep' style="width:120px"  multiple='multiple' size='5' >
			  			<c:if test="${doctorInfo.departments!=null&&fn:length(doctorInfo.departments)>0}">
			  				<c:forEach items="${doctorInfo.departments}" var="depList" varStatus="status">
			  				<option value="${depList.departmentId}" areaId="${depList.areaId}" sdid="${depList.standardDepartmentId}" selected="selected">${depList.departmentName}</option>
			  				</c:forEach>
			  			</c:if>
		      			</select>
		      			</div>
	      			</div>
			    </div>
      			<!-- <input type="button" onclick="getData2()" value="getData"/> -->
			</div>
			<div class="col-sm-5 help-block Validform_checktip">此处只可选择已经关联标准科室的医院科室！！！</div>
		</div>
		
		<%-- <div class="form-group" id="showDepS" style="display:none">
			<label for="doctorCode" class="col-sm-2 control-label"><span style="color:red;">*</span>所&nbsp;属&nbsp;科 &nbsp;室：</label>
			<div class="col-sm-5">
			    <select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1)">
			    <option value="0">请选择</option>
			    </select>&nbsp;&nbsp;
			    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
			    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
			   	<c:if test="${departmentName!=null}">
			    	<option>${departmentName}</option>
			    </c:if>
			    <c:if test="${departmentName==null}">
			    	<option value="0">请选择</option>
			    </c:if>
			    </select>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		</div> --%>
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">医生头像图片：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file"/><br/><input type="button" value="上传" onclick="upimg();" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><a href="${doctorInfo.doctorHeadImage}" target="_blank"><img src="${ctx}/showImage/showImg?path=${doctorInfo.doctorHeadImage}" id="img" width="100px" height="100px"  /></a>
		</div>
		
		<div class="form-group">
			<label for="doctorName" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;生 &nbsp;名 &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="doctorName" name="doctorName" placeholder="医生名称" datatype="*1-60"
					nullmsg="请输入医生名称！" errormsg="医生名称至少1个字符,最多60个字符！" value="${doctorInfo.doctorName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="nameSpell" class="col-sm-2 control-label"><span style="color:red;">*</span>姓 &nbsp;名 &nbsp;拼 &nbsp;音：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="nameSpell" name="nameSpell" placeholder="姓名拼音" datatype="*1-60"
					nullmsg="请输入姓名拼音！" errormsg="姓名拼音至少1个字符,最多60个字符！" value="${doctorInfo.nameSpell}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagenameSpell" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="hospDocNum" class="col-sm-2 control-label">医 &nbsp;师 &nbsp;工 &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospDocNum" name="hospDocNum" placeholder="医师工号" datatype="*0-20"
					nullmsg="请输入医师工号！" errormsg="医师工号最多20个字符！" value="${doctorInfo.hospDocNum}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="brevityCode" class="col-sm-2 control-label">简&nbsp;&nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="brevityCode" name="brevityCode" placeholder="简码" datatype="*0-10"
					nullmsg="请输入简码！" errormsg="简码最多10个字符！" value="${doctorInfo.brevityCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		 <div class="form-group">
			<label for="doctorGrade" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;师 &nbsp;职 &nbsp;称：</label>
			<div class="col-sm-5">
			<select class="mSelect"  class="mSelect"  id="doctorGrade" name="doctorGrade" onchange="setDGText(this);">
			    <option value="">请选择</option>
			    <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctorInfo.doctorGrade}">
				    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
				    </c:if>
				    <c:if test="${dic.dictId!=doctorInfo.doctorGrade}">
				    	<option value="${dic.dictId}" >${dic.dictName}</option>
				    </c:if>
			    </c:forEach>
			</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
	
		
		<div class="form-group">
			<label for="teachGrade" class="col-sm-2 control-label">学 &nbsp;历 &nbsp;等 &nbsp;级：</label>
			<div class="col-sm-5">
			<select class="sSelect"  class="sSelect"  id="teachGrade" name="teachGrade"  onchange="setTGText(this);">
			    <option value="">请选择</option>
			    <c:forEach items="${dicList2}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==doctorInfo.teachGrade}">
				    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
				    </c:if>
				    <c:if test="${dic.dictId!=doctorInfo.teachGrade}">
				    	<option value="${dic.dictId}" >${dic.dictName}</option>
				    </c:if>
			    </c:forEach>
			   </select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		
		<div class="form-group">
			<label for="isOpenedRegistration" class="col-sm-2 control-label">性&nbsp;&nbsp;别：</label>
			<div class="col-sm-5">
			<select class="sSelect" id="sex" name="sex">
			    <c:choose>
			      <c:when test="${doctorInfo.sex==1||doctorInfo.sex==null}">
			      	<option value="1" selected="selected">男</option>
				 	<option value="2">女</option>
			      </c:when>
			      <c:when test="${doctorInfo.sex==2}">
			      	<option value="1">男</option>
				 	<option value="2" selected="selected">女</option>
			      </c:when>
			      <c:otherwise>
			      	<option value="1" selected="selected">男</option>
				 	<option value="2">女</option>
			      </c:otherwise>
			    </c:choose>
			 </select>    
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="birthday" class="col-sm-2 control-label">出 &nbsp;生 &nbsp;日 &nbsp;期：</label>
			<div class="col-sm-5">
			    <%-- <input id="d424" class="Wdate" type="text" name="birthday" id="birthday" value="${doctorInfo.birthday}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss'})"/> --%>
				<input class="Wdate" type="text" name="birthday" id="birthday" value="<fmt:formatDate value="${doctorInfo.birthday}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="education" class="col-sm-2 control-label">教 &nbsp;育 &nbsp;机 &nbsp;构：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="education" name="education" placeholder="教育机构" datatype="*0-20"
					nullmsg="请输入教育机构！" errormsg="教育机构最多20个字符！" value="${doctorInfo.education}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="doctorDesc" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;简 &nbsp;介：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="doctorDesc" name="doctorDesc" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="specialtydesc" class="col-sm-2 control-label"><span style="color:red;">*</span>医生专长简介：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="specialtydesc" name="specialtydesc" clos="8" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength2">最多输入500个字符</div>
		</div>
		
	
		
		<div class="form-group">
			<label for="successfulRegisteredNum" class="col-sm-2 control-label">成&nbsp;功&nbsp;挂&nbsp;号&nbsp;人&nbsp;数：</label>
			<div class="col-sm-4">
				<c:if test="${doctorInfo.successfulRegisteredNum==null}">
				<input type="text" class="form-control" id="successfulRegisteredNum" name="successfulRegisteredNum" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
				</c:if>
				<c:if test="${doctorInfo.successfulRegisteredNum!=null}">
				<input type="text" class="form-control" id="successfulRegisteredNum" name="successfulRegisteredNum" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${doctorInfo.successfulRegisteredNum}">
				</c:if>	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		<div class="form-group">
			<label for="resourceReservedNum" class="col-sm-2 control-label">号&nbsp;源&nbsp;预&nbsp;留&nbsp;数&nbsp;目：</label>
			<div class="col-sm-4">
				<c:if test="${doctorInfo.resourceReservedNum==null}">
				<input type="text" class="form-control" id="resourceReservedNum" name="resourceReservedNum" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
				</c:if>
				<c:if test="${doctorInfo.resourceReservedNum!=null}">
				<input type="text" class="form-control" id="resourceReservedNum" name="resourceReservedNum" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${doctorInfo.resourceReservedNum}">
				</c:if>	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		<div class="form-group">
			<label for="backflowTime" class="col-sm-2 control-label">回&nbsp;流&nbsp;时&nbsp;间：</label>
			<div class="col-sm-4">
				<c:if test="${doctorInfo.backflowTime==null}">
				<input type="text" class="form-control" id="backflowTime" name="backflowTime" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
				</c:if>
				<c:if test="${doctorInfo.backflowTime!=null}">
				<input type="text" class="form-control" id="backflowTime" name="backflowTime" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${doctorInfo.backflowTime}">
				</c:if>	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		
		<div class="form-group">
			<label for="medType" class="col-sm-2 control-label"><span style="color:red;">*</span>中西医：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="medType" name="medType">
				 <c:if test="${doctorInfo.medType==1||doctorInfo.medType==null}">
				 <option value="1" selected="selected">中医</option>
				 <option value="2">西医</option>
				 <option value="3">其他</option>
				 </c:if>
				 <c:if test="${doctorInfo.medType==2}">
				 <option value="1">中医</option>
				 <option value="2" selected="selected">西医</option>
				 <option value="3">其他</option>
				 </c:if>
				 <c:if test="${doctorInfo.medType==3}">
				 <option value="1">中医</option>
				 <option value="2">西医</option>
				 <option value="3" selected="selected">其他合</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		
		<div class="form-group">
			<label for="medType" class="col-sm-2 control-label"><span style="color:red;">*</span>初、复诊：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="visitType" name="visitType">
				 <c:if test="${doctorInfo.visitType==1||doctorInfo.visitType==null}">
				 <option value="1" selected="selected">全部</option>
				 <option value="2">复诊</option>
				 </c:if>
				 <c:if test="${doctorInfo.visitType==2}">
				 <option value="1">全部</option>
				 <option value="2" selected="selected">复诊</option>
				 </c:if>
				</select>
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
<script src="${ctxStatic}/js/hospSuggestion.js" type="text/javascript"></script>
<%-- </div> --%>
<script type="text/javascript">
		var ctx = "${ctx}";
		var isThirdpartyFlag=false;
	$(document).ready(function(){
		$.ajaxSetup({
			   async:false
	    });
		var doc = "${doctorInfo}";
		var isThirdparty = "${doctorInfo.isThirdparty}";
		ifShow(isThirdparty);
		var isSpecialized = 2;
		if(doc!=""){
			document.form1.action=ctx+"/doctor/update"; 
			isSpecialized = "${doctorInfo.isSpecialized}";
			if(isSpecialized==1){
				selectHd2($("#hdChild1"));
			}
			//alert("${hospId}");
			searchDep("${hospId}",'2');
		}
		//是否是专科医生，科室多个
		ifOneDep(isSpecialized);
		
		
		//让是否是第三方被选中
		//document.getElementById("isThirdparty").value = "${doctorInfo.isThirdparty}";
		//给医生简介内容赋值
		var doctorDesc1 = $("#doctorDesc1").val();
		$("#doctorDesc").val(doctorDesc1);
		//给医生专长简介内容赋值
		var specialtydesc1 = $("#specialtydesc1").val();
		$("#specialtydesc").val(specialtydesc1);
		
		//控制描述信息输入字数
		$("#doctorDesc").keyup(function(){
			 var a=1000-$("#doctorDesc").val().length;
			 $("#nLength1").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过1000");
			 }
		 });
		
		//控制描述信息输入字数
		$("#specialtydesc").keyup(function(){
			 var a=500-$("#specialtydesc").val().length;
			 $("#nLength2").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过500");
			 }
		 });
		//多选科室
		$('#go').click(function() {
			var options =   $("#hdChild1 option:selected");

			options.clone().prependTo($('#doctorDep'));
			$('#doctorDep option').attr("selected", "selected");

			});
		$('#back').click(function() {
			$.confirm("确定要移除此条数据吗？与该科室对应的号源和挂号记录也会被删除！", function(s) {
				if (s) {
				}else{
					var options =   $("#doctorDep option:selected").remove();
				} 
				
			});

		});
		
		
		
		//验证姓名拼音
		$("input[name='nameSpell']").blur(function (){
			var re = /^[a-zA-Z]{1,}$/;
			if(!re.test(this.value)) {
				$("#ifnameSpellAllow").val("1");
				$('#wmessagenameSpell').text("姓名拼音格式不正确！");
				document.getElementById("wmessagenameSpell").style.display="block";
			}else{
				$("#ifnameSpellAllow").val("0");
				document.getElementById("wmessagenameSpell").style.display="none";
			} 
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
				/* var imgnull=ctx+"/";
				if($("#img").attr("src")==imgnull){
					alert("请上传医生头像图片！");
					return false;
				} */
				if($("#doctorGrade").val()==""||$("#doctorGrade").val()==null){
					alert("请选择医师职称！");
					return false;
				}
				if($("#specialtydesc").val().length<1){
					alert("请填写医生专长！");
					return false;
				}
				/* if($("#isThirdparty").val()==1&&$("#doctorCode").val()==""){
					alert("请填写医生编码！");
					return false;
				
				} */
				
				if(isThirdpartyFlag && $("#doctorCode").val()==""){
					alert("请填写医生编码！");
					return false;
				}
				if($("#ifnameSpellAllow").val()=="1"){
					alert("姓名拼音格式不正确！");
					return false;
				}
				
				//debugger;
				if($("#isSpecialized").val()==2){//非专科医生，科室多选
					getData();
				}else{//专科医生，只能属于一个二级医院科室
					getData2();
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						window.location.reload();
						//var hospId = "${hospId}";
						//var departmentId = "${departmentId}";
						//var standardDepartmentId = "${standardDepartmentId}";
						//window.location.href = ctx+'/doctor/list?hospId='+hospId+'&departmentId='+departmentId+'&standardDepartmentId='+standardDepartmentId;
						//window.location.href = '${ctx}/link/list';
					});
				} else {
					errorValidate('msg-info', json.message + ',' + "");
					
				}
				$('#fat-btn').button('reset');
			}
		});

	});
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
	
	//列表图片上传
	 function upimg(){
		var fileElement = "";
		var img = "";
		var hiddenUrlId="";
		    
    	fileElement="file";
		img="#img";
		hiddenUrlId="#doctorHeadImage";
		    
		
 $.ajaxFileUpload
          (
              {
                  url: ctx+'/hospital/upload', //用于文件上传的服务器端请求地址
                  secureuri: false, //是否需要安全协议，一般设置为false
                  fileElementId: fileElement, //文件上传域的ID
                  dataType: 'json',
                  success: function (data, status)  //服务器成功响应处理函数
                  {
 					 //alert(data.imgurl);
                   $(img).attr("src", ctx+"/showImage/showImg?path="+data.imgurl);
                   //提交表单用
 					 $(hiddenUrlId).val(data.imgurl);
                   if (typeof (data.message) != 'undefined' && data.message!=null) {
                  	 alert(data.message);
                   }
                      
                  },
                  error: function (data, status, e)//服务器响应失败处理函数
                  {
                      alert(e);
                  }
              }
          );
          return false;
  
 }
	
	function setDGText(obj){
		var doctorGradeText = obj.options[obj.selectedIndex].text;
		$("#doctorGradeText").val(doctorGradeText);
	}
	
    function setTGText(obj){
    	var teachGradeText = obj.options[obj.selectedIndex].text;
		$("#teachGradeText").val(teachGradeText);
	}
    
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
    	 searchHosp(areaId);//根据父级地区查询医院
    	 if(areaId!=0){
    	   $("#areaId").val(areaId);
    	 } 
    	
    }

    //医院下拉联动
    function searchHosp(areaId){
    	if(areaId==0){
    		var areaIdParent=$("#areaIdParent").val();
    		searchArea(areaIdParent,null);
    		return;
    	}
    	var url = ctx+"/doctor/searchHosp";
    	
    	$.ajax({  
    		type : "post",  
    		url : url,  
    		data : {'areaId':areaId,'flag':'1'},  
    		async : false,  
    		asyncBoolean:false,
    		success : function(data){  
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

    		}  
        });
    	 if(areaId!=0){
    		   $("#areaId").val(areaId);
    		 } 
    	$(".m-input").remove();
    	var $select = $("select[data-edit-select]").filterSelect();
    	$select.on("change", function(){
    			    console.log(this.value)
    	});
    }
    
    
  //科室下拉联动
    function searchDep(obj,type){
      var hospId ="";
      var hospName ="";
      var istd = "";
	  if(type==1){
	    	hospId = obj.options[obj.selectedIndex].value;
	    	hospName = obj.options[obj.selectedIndex].text;
	    	istd  = $(obj).find("option:selected").attr("isthirdparty");
			  
		  
	    	$("#isThirdparty").val(istd);
	    		ifShow(istd);
	    	if(istd==1){//是第三方医院
	    	    alert("该医院是第三方医院，请填写医生编码");
	    	}
	    	if(hospId==0){
	    		return;
	    	}
	  }else if(type==2){
		  hospId = obj;
	  }
    	var url = ctx+"/doctor/searchDep";
    	$.post(url,{'hospId':hospId},function (data){
    			
    		   json =data;
    		 
    		  // 先清空第二个 
    	      $("#hdParent").empty(); 
    	      var option = "";
    	      option = $("<option>").val(0).text("请选择");
    	      $("#hdParent").append(option); 
    	      
    		for(var i=0; i<json.length; i++)     			
    		{   
    			
    			//if(json[i].standardDepartmentId)
    				
    			//{   //console.log(typeof json[i].standardDepartmentId);
    				//console.log(json[i].standardDepartmentId);
	    			option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
	    		    //alert(json[i].areaId+" " + json[i].areaName) 
    		
    		    $("#hdParent").append(option); 
    		} 
    	});
    	if(hospId!=0){
    		   $("#hospId").val(hospId);
    		   $("#hospName").val(hospName);
    		}

    }
  
  //二级科室下拉联动
    function searchHd(obj,number){
    	var hdId = obj.options[obj.selectedIndex].value;
    	var hdName = obj.options[obj.selectedIndex].text;
    	if(hdId==0){
    		return;
    	}
    	var hospId = $("#hospId").val();
    	var url = ctx+"/doctor/searchHdDep";
    	var selPeram = "";
    	$.post(url,{'departmentId':hdId,'hospId':hospId},function (data){
    		json = eval(data);
    		console.log(typeof json);
    		console.log(json.length);
    		console.log(json[0]);
    		  if(number==1){
    			  selPeram = "#hdChild1";
    		  }else{
    			  selPeram = "#hdChild2";
    		  }
    		  //添加前先清空
    		  $(selPeram).empty(); 
    	      var option = "";
    	      option = $("<option>").val(0).text("请选择");
    	      $(selPeram).append(option); 
    		for(var i=0; i<json.length; i++) 
    		{   //if(json[i].standardDepartmentId!=""&&json[i].standardDepartmentId!=null){
    			//option = "<option value="+json[i].departmentId+"standardDepartmentId="+json[i].standardDepartmentId+"]>"+json[i].departmentName+"</option>";
    			//option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).attr('sdid',json[i].standardDepartmentId);
    			option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).attr('sdid',json[i].standardDepartmentId).attr('areaId',json[i].areaId);
    			//}
    			$(selPeram).append(option); 
    		} 
    	});
    	 if(hdId!=0){
    	   $("#departmentId").val(hdId);
    	   $("#departmentName").val(hdName);
    	} 
    	
    } 
  
    function selectHd(obj){
    	$("#areaId").val($(obj).find("option:selected").attr('areaId'));
    	var hdC = obj.options[obj.selectedIndex].value;
    	var hdName = obj.options[obj.selectedIndex].text;
    	var sd  = $(obj).find("option:selected").attr("sdid");
    	//alert(sd);
    	if(hdC!=0){
    		   $("#departmentId").val(hdC);
    		   $("#standardDepartmentId").val(sd);
    		}
    }
    function selectHd2(obj){
    	var hdC = obj.val();
    	//var hdName = obj.find("option:selected").text;
    	var sd  = obj.find("option:selected").attr("sdid");
    	//alert(sd);
    	if(hdC!=0){
    		   $("#departmentId").val(hdC);
    		   $("#standardDepartmentId").val(sd);
    		}
    }
    
    
    function getData(){
    	var options =   $("#doctorDep option");
    	//debugger;
    	var html = "";
    	for(var i =0; i < options.length; i ++){
    		//alert($(options[i]).attr('sdid') + ", " + $(options[i]).attr('value'));
    		html += "<input type=\"hidden\" name=\"departments[" + i + "].departmentId\" value=\"" + $(options[i]).attr('value') + "\"/>";
    		html += "<input type=\"hidden\" name=\"departments[" + i + "].hospId\" value=\"" + $("#hospId").val() + "\"/>";
    		html += "<input type=\"hidden\" name=\"departments[" + i + "].areaId\" value=\"" + $(options[i]).attr('areaId') + "\"/>";
    		html += "<input type=\"hidden\" name=\"departments[" + i + "].standardDepartmentId\" value=\"" + $(options[i]).attr('sdid') + "\"/>";
    	}
    	$("#form").prepend(html);
    }
    
    function getData2(){
    	//debugger;
    	var html = "";
    	
    		//alert($(options[i]).attr('sdid') + ", " + $(options[i]).attr('value'));
    		html += "<input type=\"hidden\" name=\"departments[0].departmentId\" value=\"" + $("#departmentId").val() + "\"/>";
    		html += "<input type=\"hidden\" name=\"departments[0].hospId\" value=\"" + $("#hospId").val() + "\"/>";
    		html += "<input type=\"hidden\" name=\"departments[0].areaId\" value=\"" + $("#areaId").val() + "\"/>";
    		html += "<input type=\"hidden\" name=\"departments[0].standardDepartmentId\" value=\"" + $("#standardDepartmentId").val() + "\"/>";
    	
    	$("#form").prepend(html);
    }
    
    function ifOneDep(value){
    	if(value==1){//是专科医生
    		document.getElementById("showDepS").style.display="none";
    		$('#hdChild1').attr("multiple",false);
    		$('#hdChild1').attr("size","1");
    		//document.getElementById("hdChild1").hasOwnProperty("multiple")=false;
    		//document.getElementById("showDep").style.display="none";
    	}else if(value==2){//不是专科医生
    		document.getElementById("showDepS").style.display="block";
    		$('#hdChild1').attr("multiple",true);
    		$('#hdChild1').attr("size","5");
    		//document.getElementById("showDep").style.display="block";
    	}
    }
	
</script>
</html>