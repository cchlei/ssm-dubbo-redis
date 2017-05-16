<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>医院基本信息编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">医院基本信息编辑</a></li>
		<c:if test="${hosInfo!=null}">
			<li><a href="${ctx}/hospital/addClinic?hospId=${hosInfo.hospId}">挂号类型信息编辑</a></li>
			<li><a href="${ctx}/hospDep/list?hospId=${hosInfo.hospId}&flag=hierarchy">医院科室列表</a></li>
			<li><a href="${ctx}/hospital/showHisData?hospId=${hosInfo.hospId}">医院his数据</a></li>
		</c:if>
	</ul>
	<br />
	<c:if test="${hosInfo!=null}">
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/hospital/update" method="POST">
	</c:if>
	<c:if test="${hosInfo==null}">
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/hospital/save" method="POST">
	</c:if>
	    <c:if test="${hosInfo!=null}">
			<input id="hospId" name="hospId" type="hidden" value="${hosInfo.hospId}"/>
	    </c:if>
			<input id="mapUrl" name="mapUrl" type="hidden" value="${hosInfo.mapUrl}"/>
			<input id="hospImage" name="hospImage" type="hidden" value="${hosInfo.hospImage}"/>
			<input id="deanHeadImage" name="deanHeadImage" type="hidden" value="${hosInfo.deanHeadImage}"/>
			<%-- <input id="hospDesc1" name="hospDesc1" type="hidden" value="${hosInfo.hospDesc}"/> --%>
			<input id="areaId" name="areaId" type="hidden" value="${hosInfo.areaId}"/>
			<input id="hospGradedText" name="hospGradedText" type="hidden"/>
			<input id="ifhospTelAllow" name="ifhospTelAllow" type="hidden"/>
			<input id="ifnetAddressAllow" name="ifnetAddressAllow" type="hidden"/>
			<input id="ifzipCodeTypeAllow" name="ifzipCodeTypeAllow" type="hidden"/>
			<input id="ifcityTelCodeAllow" name="ifcityTelCodeAllow" type="hidden"/>
			<input id="iflongitudeAllow" name="iflongitudeAllow" type="hidden"/>
			<input id="iflatitudeAllow" name="iflatitudeAllow" type="hidden"/>
			<input id="ifpinyinBrevityCodeAllow" name="ifpinyinBrevityCodeAllow" type="hidden"/>
			<input id="subflag" name="subflag" type="hidden" value="0"/>
			
		<div class="form-group">
			<label for="isPrepay" class="col-sm-2 control-label"><span style="color:red;">*</span>是否对接第三方医院：</label>
			<div class="col-sm-5">
			<c:if test="${hosInfo==null}">
				<select class="mSelect" id="isThirdparty" name="isThirdparty" onchange="ifShow(this.value);">
				 <option value="2">非第三方</option>
				 <option value="1">是,第三方直接对接</option>
				 <option value="3">是,第三方对接平台</option>
				 <option value="4">是,2和3两种都是</option>
				</select>
			</c:if>
			<c:if test="${hosInfo!=null}">
			    <c:if test="${hosInfo.isThirdparty==1}">是,第三方直接对接</c:if>
			    <c:if test="${hosInfo.isThirdparty==2}">非第三方</c:if>
			    <c:if test="${hosInfo.isThirdparty==3}">是,第三方对接平台</c:if>
			    <c:if test="${hosInfo.isThirdparty==4}">是,1和3两种都是</c:if>
			    <input type="hidden" name="isThirdparty" value="${hosInfo.isThirdparty}"/>
			</c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
			
		<div class="form-group" id="showHospCode" style="display:none">
			<label for="hospCode" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp;院&nbsp;编 &nbsp;码：</label>
			<div class="col-sm-5">
			<%-- <c:if test="${hosInfo==null}"> --%>
				<input type="text" class="form-control" id="hospCode" name="hospCode" placeholder="医院编码" datatype="*0-20"
					nullmsg="请输入医院编码！" errormsg="医院编码最多20个字符！" value="${hosInfo.hospCode}">
			<%-- </c:if>
			<c:if test="${hosInfo!=null}">
			     ${hosInfo.hospCode}
			     <input type="hidden" name="hospCode" value="${hosInfo.hospCode}"/>
			</c:if> --%>
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
				   </c:if>
			    </c:forEach>
			    </select>
			    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="selectArea(this.value);">
			    <c:if test="${hosInfo.areaId!=null}">
			    	<option>${areaMap[hosInfo.areaId]}</option>
			    </c:if>
			    <c:if test="${hosInfo.areaId==null}">
			   	    <option>请选择</option>
			    </c:if>
			    </select>&nbsp;&nbsp;<span id="warn" style="color:red;">请选择到二级地区！</span>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><span style="color:red;">*</span>医院图片：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file"/><br/><input type="button" value="上传" onclick="upimg(1);" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><a href="${hosInfo.hospImage}" target="_blank"><img src="${ctx}/showImage/showImg?path=${hosInfo.hospImage}" id="img" width="100px" height="100px"  /></a>
		</div>
		<div class="form-group">
			<label for="hospName" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;院 &nbsp;全 &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospName" name="hospName" placeholder="医院全称" datatype="*1-50"
					nullmsg="请输入医院全称！" errormsg="医院全称至少1个字符,最多50个字符！" value="${hosInfo.hospName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospSimpleName" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;院&nbsp;简 &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospSimpleName" name="hospSimpleName" placeholder="医院简称" datatype="*1-16"
					nullmsg="请输入医院简称！" errormsg="医院简称至少1个字符,最多16个字符！" value="${hosInfo.hospSimpleName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospGradedText" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;院 &nbsp;级 &nbsp;别：</label>
			<div class="col-sm-5">
				<%-- <input type="text" class="form-control" id="hospGradedText" name="hospGradedText" placeholder="医院级别" datatype="*1-16"
					nullmsg="请输入医院级别！" errormsg="医院级别至少1个字符,最多16个字符！" value="${hosInfo.hospGradedText}"> --%>
				<select class="mSelect"  class="mSelect"  id="hospGraded" name="hospGraded" onchange="setHGText(this);">
					<option value="">请选择</option>
					<option value="1000">三级特等</option>
					<option value="2000">三级甲等</option>
					<option value="3000">三级乙等</option>
					<option value="4000">三级丙等</option>
					<option value="5000">二级甲等</option>
					<option value="6000">二级乙等</option>
					<option value="7000">二级丙等</option>
					<option value="8000">一级甲等</option>
					<option value="9000">一级乙等</option>
					<option value="10000">一级丙等</option>
					<option value="11000">民营医院</option>
					<option value="12000">其他</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;院 &nbsp;电 &nbsp;话：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospTel" name="hospTel" placeholder="医院电话" datatype="*1-30"
					nullmsg="请输入医院电话！" errormsg="医院电话至少1个字符,最多30个字符！" value="${hosInfo.hospTel}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">电话号码格式为区号(2到3位)-电话号码(7到8位)-分机号(3位到多位)</div>
			<br/><br/><span id="wmessagehospTel" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="address" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp;院 &nbsp;地 &nbsp;址：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="address" name="address" placeholder="医院地址" datatype="*1-100"
					nullmsg="请输入医院地址！" errormsg="医院地址至少1个字符,最多100个字符！" value="${hosInfo.address}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="netAddress" class="col-sm-2 control-label">医 &nbsp;院 &nbsp;网 &nbsp;址：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="netAddress" name="netAddress" placeholder="医院网址" datatype="*0-200"
					nullmsg="请输入医院网址！" errormsg="医院网址最多200个字符！" value="${hosInfo.netAddress}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagenetAddress" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="hospDesc" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;院 &nbsp;描 &nbsp;述：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="hospDesc" name="hospDesc" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1">最多输入5000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="medicineWay" class="col-sm-2 control-label"><span style="color:red;">*</span>医&nbsp;疗&nbsp;方 &nbsp;式：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="medicineWay" name="medicineWay">
				 <c:if test="${hosInfo.medicineWay==1||hosInfo.medicineWay==null}">
				 <option value="1" selected="selected">中医</option>
				 <option value="2">西医</option>
				 <option value="3">结合</option>
				 </c:if>
				 <c:if test="${hosInfo.medicineWay==2}">
				 <option value="1">中医</option>
				 <option value="2" selected="selected">西医</option>
				 <option value="3">结合</option>
				 </c:if>
				 <c:if test="${hosInfo.medicineWay==3}">
				 <option value="1">中医</option>
				 <option value="2">西医</option>
				 <option value="3" selected="selected">结合</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospType" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;疗 &nbsp;类 &nbsp;型：</label>
			<div class="col-sm-5">
			    <input type=radio name=hospType value="1" checked> 综合医院 
				<input type=radio name=hospType value="2" >专科医院 
				<input type=radio name=hospType value="3">社区门诊医院 
				<input type=radio name=hospType value="4">专业医院 
				<input type=radio name=hospType value="0">其他 
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="featureDepartment" class="col-sm-2 control-label">特&nbsp;色&nbsp;科&nbsp;室&nbsp;描&nbsp;述：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="featureDepartment" name="featureDepartment" clos="8" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength2">最多输入100个字符</div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">邮 &nbsp;政 &nbsp;编 &nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="邮政编码" datatype="*0-6"
					nullmsg="请输入邮政编码！" errormsg="邮政编码最多6个字符！" value="${hosInfo.zipCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagezipCode" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">院长头像：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file3"/><br/><input type="button" value="上传" onclick="upimg(3);" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><img src="${ctx}/showImage/showImg?path=${hosInfo.deanHeadImage}" id="img3" width="100px" height="100px"  />
		</div>
		
		
		<div class="form-group">
			<label for="deanDesc" class="col-sm-2 control-label">院&nbsp;长&nbsp;简&nbsp;介：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="deanDesc" name="deanDesc" clos="8" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength3">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="trafficWayLine" class="col-sm-2 control-label"><span style="color:red;">*</span>交 &nbsp;通 &nbsp;路&nbsp;线：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="trafficWayLine" name="trafficWayLine" placeholder="交通路线" datatype="*1-200"
					nullmsg="请输入交通路线！" errormsg="交通路线至少1个字符,最多200个字符！" value="${hosInfo.trafficWayLine}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="retrieveTime" class="col-sm-2 control-label"><span style="color:red;">*</span>上午取号时间：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="retrieveTime" name="retrieveTime" placeholder="上午取号时间" datatype="*1-100"
					nullmsg="请输入上午取号时间！" errormsg="上午取号时间至少1个字符,取号时间最多100个字符！" value="${hosInfo.retrieveTime}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">可以是一段文字描述</div>
		</div>
		
		<div class="form-group">
			<label for="retrieveTime" class="col-sm-2 control-label"><span style="color:red;">*</span>下午取号时间：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="retrieveTimePm" name="retrieveTimePm" placeholder="下午取号时间" datatype="*1-100"
					nullmsg="请输入下午取号时间！" errormsg="下午取号时间至少1个字符,取号时间最多100个字符！" value="${hosInfo.retrieveTimePm}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">可以是一段文字描述</div>
		</div>
		
		<div class="form-group">
			<label for="latestUnsubscribeTime" class="col-sm-2 control-label"><span style="color:red;">*</span>退&nbsp;号 &nbsp;时 &nbsp;间：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="latestUnsubscribeTime" name="latestUnsubscribeTime" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.latestUnsubscribeTime}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">小时数</div>
		</div>
		
		<div class="form-group">
			<label for="beginRegisterTime" class="col-sm-2 control-label"><span style="color:red;">*</span>预约开始时间：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="beginRegisterTime" name="beginRegisterTime" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.beginRegisterTime}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">小时数</div>
		</div>
		
		<div class="form-group">
			<label for="overRegisterTime" class="col-sm-2 control-label"><span style="color:red;">*</span>预约截止时间：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="overRegisterTime" name="overRegisterTime" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.overRegisterTime}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">小时数</div>
		</div>
		
		<div class="form-group">
			<label for="resourceDays" class="col-sm-2 control-label"><span style="color:red;">*</span>号源生成天数：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="resourceDays" name="resourceDays" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.resourceDays}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="isPrepay" class="col-sm-2 control-label"><span style="color:red;">*</span>是&nbsp;否&nbsp;预&nbsp;付：</label>
			<div class="col-sm-5">
				<select class="mSelect"  class="mSelect"  id="isPrepay" name="isPrepay">
				 <c:if test="${hosInfo.isPrepay==2||hosInfo.isPrepay==null}">
				 <option value="1">需要预付费用</option>
				 <option value="2" selected="selected">不需预付</option>
				 </c:if>
				 <c:if test="${hosInfo.isPrepay==1}">
				 <option value="1" selected="selected">需要预付费用</option>
				 <option value="2">不需预付</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="contacts" class="col-sm-2 control-label">联&nbsp; &nbsp;系&nbsp; &nbsp;人：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="contacts" name="contacts" placeholder="联系人" datatype="*0-10"
					nullmsg="请输入联系人！" errormsg="联系人最多10个字符！" value="${hosInfo.contacts}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="contactWay" class="col-sm-2 control-label">联&nbsp;系&nbsp;电&nbsp;话：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="contactWay" name="contactWay" placeholder="联系电话" datatype="*0-30"
					nullmsg="请输入联系电话！" errormsg="联系电话最多30个字符！" value="${hosInfo.contactWay}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagecontactWay" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="pinyinBrevityCode" class="col-sm-2 control-label"><span style="color:red;">*</span>拼&nbsp;音&nbsp;简&nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="pinyinBrevityCode" name="pinyinBrevityCode" placeholder="拼音简码" datatype="*1-10"
					nullmsg="请输入拼音简码！" errormsg="拼音简码至少1个字符,最多10个字符！" value="${hosInfo.pinyinBrevityCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagepinyinBrevityCode" style="color:red;margin-left:180px;display:none"></span>
			
		</div>
		
		<div class="form-group">
			<label for="businessType" class="col-sm-2 control-label"><span style="color:red;">*</span>营&nbsp;业&nbsp;类&nbsp;型：</label>
			<div class="col-sm-5">
			    <select class="mSelect"  class="mSelect"  id="businessType" name="businessType">
			    <c:forEach items="${dicList}" var="dic" varStatus="status">
				    <c:if test="${dic.dictId==hosInfo.businessType}">
				    	<option value="${dic.dictId}" selected="selected">${dic.dictName}</option>
				    </c:if>
				    <c:if test="${dic.dictId!=hosInfo.businessType}">
				    	<option value="${dic.dictId}" >${dic.dictName}</option>
				    </c:if>
			    </c:forEach>
			</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="cityTelCode" class="col-sm-2 control-label"><span style="color:red;">*</span>医 &nbsp;院 &nbsp;所 &nbsp;在 &nbsp;城 &nbsp;市 &nbsp;区 &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="cityTelCode" name="cityTelCode" placeholder="所在区区号" datatype="*1-6"
					nullmsg="请输入区号！" errormsg="区号至少1个字符,最多6个字符！" value="${hosInfo.cityTelCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagecityTelCode" style="color:red;margin-left:180px;display:none"></span>
			
		</div>
		
		<div class="form-group">
			<label for="searchWord" class="col-sm-2 control-label"><span style="color:red;">*</span>搜索关键词：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="searchWord" name="searchWord" placeholder="搜索关键词" datatype="*1-50"
					nullmsg="请输入搜索关键词！" errormsg="关键词至少1个字符,最多50个字符！" value="${hosInfo.searchWord}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="accountNo" class="col-sm-2 control-label">账 &nbsp; &nbsp; &nbsp; &nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="accountNo" name="accountNo" placeholder="账号" datatype="*0-30"
					nullmsg="请输入账号！" errormsg="账号至少1个字符,最多30个字符！" value="${hosInfo.accountNo}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="bankName" class="col-sm-2 control-label">开 &nbsp;户&nbsp;银&nbsp;行：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="bankName" name="bankName" placeholder="开户银行" datatype="*0-50"
					nullmsg="请输入开户银行！" errormsg="开户银行至少1个字符,最多50个字符！" value="${hosInfo.bankName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="successfulRegisteredNum" class="col-sm-2 control-label">成&nbsp;功&nbsp;挂&nbsp;号&nbsp;人&nbsp;数：</label>
			<div class="col-sm-4">
			    <c:if test="${hosInfo==null}">
			    	<input type="text" class="form-control" id="successfulRegisteredNum" name="successfulRegisteredNum" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
			    </c:if>
				<c:if test="${hosInfo!=null}">
			    	<input type="text" class="form-control" id="successfulRegisteredNum" name="successfulRegisteredNum" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.successfulRegisteredNum}">
			    </c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="ipAddress" class="col-sm-2 control-label">IP &nbsp; &nbsp;地 &nbsp; &nbsp;址：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="ipAddress" name="ipAddress" placeholder="IP地址" datatype="*0-40"
					nullmsg="请输入IP地址！" errormsg="IP地址最多40个字符！" value="${hosInfo.ipAddress}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessageipAddress" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="automaticCheckPrice" class="col-sm-2 control-label">自&nbsp;&nbsp;动&nbsp;&nbsp;核&nbsp;&nbsp;价：</label>
			<div class="col-sm-4">
				<c:if test="${hosInfo==null}">
			    	<input type="text" class="form-control" id="automaticCheckPrice" name="automaticCheckPrice" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
			    </c:if>
				<c:if test="${hosInfo!=null}">
			    	<input type="text" class="form-control" id="automaticCheckPrice" name="automaticCheckPrice" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.automaticCheckPrice}">
			    </c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><span style="color:red;">*</span>地图URL地址：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file1"/><br/><input type="button" value="上传" onclick="upimg(2);" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><img src="${ctx}/showImage/showImg?path=${hosInfo.mapUrl}" id="img1" width="100px" height="100px"  />
		</div>
		
		<div class="form-group">
			<label for="longitude" class="col-sm-2 control-label"><span style="color:red;">*</span>经&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：</label>
			<div class="col-sm-4">
				<%-- <input type="text" class="form-control" id="longitude" name="longitude" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.longitude}"> --%>
				<input type="text" class="form-control" id="longitude" name="longitude" placeholder="经度" datatype="*1-30"
					nullmsg="请输入经度！" errormsg="经度至少1个字符,最多30个字符！" value="${hosInfo.longitude}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">格式：40.2550380000</div>
			<br/><br/><span id="wmessagelongitude" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		
		
		<div class="form-group">
			<label for="latitude" class="col-sm-2 control-label"><span style="color:red;">*</span>纬&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：</label>
			<div class="col-sm-4">
				<%-- <input type="text" class="form-control" id="latitude" name="latitude" placeholder="0" datatype="n" 
					nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${hosInfo.latitude}"> --%>
				<input type="text" class="form-control" id="latitude" name="latitude" placeholder="纬度" datatype="*1-30"
					nullmsg="请输入纬度！" errormsg="纬度至少1个字符,最多30个字符！" value="${hosInfo.latitude}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip">格式：117.0346570000</div>
			<br/><br/><span id="wmessagelongitude" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="bankName" class="col-sm-2 control-label">营&nbsp; 业&nbsp;时&nbsp;间：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="businessHours" name="businessHours" placeholder="营业时间" datatype="*0-100"
					nullmsg="请输入营业时间！" errormsg="营业时间最多100个字符！" value="${hosInfo.businessHours}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="expertTeam" class="col-sm-2 control-label">专&nbsp;家&nbsp;团&nbsp;队：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="expertTeam" name="expertTeam" clos="8" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength4">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="recommend" class="col-sm-2 control-label"><span style="color:red;">*</span>是&nbsp;否&nbsp;推 &nbsp;荐：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="recommend" name="recommend">
				 <c:if test="${hosInfo.recommend==1}">
				 <option value="1" selected="selected">推荐</option>
				 <option value="2">不推荐</option>
				 </c:if>
				 <c:if test="${hosInfo.recommend==2||hosInfo.recommend==null}">
				 <option value="1">推荐</option>
				 <option value="2" selected="selected">不推荐</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label"><span style="color:red;">*</span>排 &nbsp; &nbsp;序：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="sort" name="sort" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${hosInfo.sort}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="recommend" class="col-sm-2 control-label"><span style="color:red;">*</span>是否是爱康网：</label>
			<div class="col-sm-5">
				<select class="sSelect"  class="sSelect"  id="isIkang" name="isIkang">
				 <c:if test="${hosInfo.isIkang==1}">
				 <option value="1" selected="selected">是</option>
				 <option value="0">不是</option>
				 </c:if>
				 <c:if test="${hosInfo.isIkang==0||hosInfo.isIkang==null}">
				 <option value="1">是</option>
				 <option value="0" selected="selected">不是</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<%-- <div class="form-group">
			<label for="isEnabled" class="col-sm-2 control-label">是&nbsp;否&nbsp;启&nbsp;用：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="isEnabled" name="isEnabled">
				 <c:if test="${hosInfo.isEnabled==1||hosInfo.isEnabled==null}">
				 <option value="1" selected="selected">启用</option>
				 <option value="2">禁用</option>
				 </c:if>
				 <c:if test="${hosInfo.isEnabled==2}">
				 <option value="1">启用</option>
				 <option value="2" selected="selected">禁用</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div> --%>
		
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

var isThirdpartyFlag=false;
	$(document).ready(function() {
		var hosInfo = "${hosInfo}";
		var ctx = "${ctx}";
		var isThirdparty = "${hosInfo.isThirdparty}";
		ifShow(isThirdparty);
		if(hosInfo!=""){
			document.form1.action=ctx+"/hospital/update"; 
			//让医院等级被选中
			document.getElementById("hospGraded").value = "${hosInfo.hospGraded}";
			//让是否是第三方被选中
			/* var obj = document.getElementById("isThirdparty");
			if(obj){
				obj.value = "${hosInfo.isThirdparty}";
			} */
			
			//给医院描述内容赋值
			  //var hospDesc = $("#hospDesc1").val();
			  var hospDesc =  "${hosInfo.hospDesc}";
			  if(hospDesc!=""){
				  $("#hospDesc").val(hospDesc); 
				}
			//给特色科室内容赋值
			$("#featureDepartment").val("${hosInfo.featureDepartment}");
			//给院长简介内容赋值
			$("#deanDesc").val("${hosInfo.deanDesc}");
			//给专家团队内容赋值
			$("#expertTeam").val("${hosInfo.expertTeam}");
			
			//让医疗类型选中
			 if('${hosInfo.hospType}'==0){
				$("input[name=hospType]:eq(4)").attr("checked",'checked'); 
			}else{
				var hospt = '${hosInfo.hospType}';
				var index = parseInt(hospt)-1;
				$("input[name=hospType]:eq("+index+")").attr("checked",'checked'); 
			}  
		}
		
		//查询条件赋值
		var parAreaId = "${parAreaId}";
		var areaId = "${hosInfo.areaId}";
		searchArea(parAreaId,areaId);
		//去掉医院描述里的换行符
		$("#hospDesc").blur(function (){
			var a = $("#hospDesc").val().replace(/\n/g, "");
			$("#hospDesc").val(a);
		});
		//控制描述信息输入字数
		$("#hospDesc").keyup(function(){
			 var a=5000-$("#hospDesc").val().length;
			 $("#nLength1").html("您还可以输入"+a+"个字符");
			 if($("#nLength1").html()<=0){
			   alert("字数不能超过5000");
			 }
		 });
		$("#featureDepartment").keyup(function(){
			 var a=100-$("#featureDepartment").val().length;
			 $("#nLength2").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过100");
			 }
		 });
		$("#deanDesc").keyup(function(){
			 var a=1000-$("#deanDesc").val().length;
			 $("#nLength3").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过1000");
			 }
		 });
		$("#expertTeam").keyup(function(){
			 var a=1000-$("#expertTeam").val().length;
			 $("#nLength4").html("您还可以输入"+a+"个字符");
			 if($("#nLength4").html()<=0){
			   alert("字数不能超过1000");
			 }
		 });
		//验证医院电话
		/* $("input[name='hospTel']").blur(function (){
			if(this.value==""){
				return;
			}
			var partten = /^(\d{3,4}\-)?(\d{7,8})(-(\d{3,}))?$/i;   //座机格式是 010-98909899
			if(!partten.test(this.value)){
				$("#ifhospTelAllow").val("1");
	        	  $('#wmessagehospTel').text("医院电话格式不正确！");
				  document.getElementById("wmessagehospTel").style.display="block";
		        }else{
		        	  $("#ifhospTelAllow").val("0");
			          document.getElementById("wmessagehospTel").style.display="none";

		        }
		}); */
		
		//验证网址
		$("input[name='netAddress']").blur(function (){
			if(this.value==""){
				return;
			}
			if(!IsURL(this.value)){
				  $("#ifnetAddressAllow").val("1");
	        	  $('#wmessagenetAddress').text("医院网址格式不正确！");
				  document.getElementById("wmessagenetAddress").style.display="block";
			}else{
				  $("#ifnetAddressAllow").val("0");
		          document.getElementById("wmessagenetAddress").style.display="none";
			}
		});
		
		//验证邮编
		$("input[name='zipCode']").blur(function (){
			if(this.value==""){
				return;
			}
			var re= /^[0-9]{6}$/;
	        if(!re.test(this.value)){
	          $("#ifzipCodeTypeAllow").val("1");
        	  $('#wmessagezipCode').text("邮政编码格式不正确！");
			  document.getElementById("wmessagezipCode").style.display="block";
	        }else{
	          $("#ifzipCodeTypeAllow").val("0");
	          document.getElementById("wmessagezipCode").style.display="none";

	        }
		});
		
		//验证联系电话
		$("input[name='contactWay']").blur(function (){
			if(this.value==""){
				return;
			}
			var partten = /^(\d{3,4}\-)?(\d{7,8})(-(\d{3,}))?$/i;   //座机格式是 010-98909899
			var myreg = /^(((13[0-9]{1})|(18[0-9]{1})|159|153|177)+\d{8})$/;//手机号
			var flag = 0;
			if(!partten.test(this.value)){
				if(this.value.length==11){
					if(!myreg.test(this.value)){
						flag = 1;
					}
				}else{
					flag=1;
				}
			}	
	        	  
			if(flag==0){
				document.getElementById("wmessagecontactWay").style.display="none";
			}else{
				$('#wmessagecontactWay').text("联系电话格式不正确！");
				  document.getElementById("wmessagecontactWay").style.display="block";
			}
		});
		
		//验证所在区号
		$("input[name='cityTelCode']").blur(function (){
			if(this.value==""){
				return;
			}
			var partten = /^[0-9]{3,4}$/;
			if(!partten.test(this.value)){
				$("#ifcityTelCodeAllow").val("1");
				$('#wmessagecityTelCode').text("区号格式不正确！");
				document.getElementById("wmessagecityTelCode").style.display="block";
			}else{
				$("#ifcityTelCodeAllow").val("0");
				document.getElementById("wmessagecityTelCode").style.display="none";
			}
		});
		
		//验证IP地址格式
		$("input[name='ipAddress']").blur(function (){
			if(this.value==""){
				return;
			}
			var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;
			if(!re.test(this.value)) {
				$('#wmessageipAddress').text("IP地址格式不正确！");
				document.getElementById("wmessageipAddress").style.display="block";
			}else{
				document.getElementById("wmessageipAddress").style.display="none";
			} 
			        
		});
		
		//验证经度
		$("input[name='longitude']").blur(function (){
			var re=/^(\d+)\.(\d+)$/;
			if(!re.test(this.value)) {
				$("#iflongitudeAllow").val("1");
				$('#wmessagelongitude').text("经度格式不正确！");
				document.getElementById("wmessagelongitude").style.display="block";
			}else{
				$("#iflongitudeAllow").val("0");
				document.getElementById("wmessagelongitude").style.display="none";
			} 
		});
		
		//验证纬度
		$("input[name='latitude']").blur(function (){
			var re=/^(\d+)\.(\d+)$/;
			if(!re.test(this.value)) {
				$("#iflatitudeAllow").val("1");
				$('#wmessagelatitude').text("经度格式不正确！");
				document.getElementById("wmessagelatitude").style.display="block";
			}else{
				$("#iflatitudeAllow").val("0");
				document.getElementById("wmessagelatitude").style.display="none";
			} 
		});
		
		//验证拼音简码
		$("input[name='pinyinBrevityCode']").blur(function (){
			var re = /^[a-zA-Z]{1,}$/;
			if(!re.test(this.value)) {
				$("#ifpinyinBrevityCodeAllow").val("1");
				$('#wmessagepinyinBrevityCode').text("拼音简码格式不正确！");
				document.getElementById("wmessagepinyinBrevityCode").style.display="block";
			}else{
				$("#ifpinyinBrevityCodeAllow").val("0");
				document.getElementById("wmessagepinyinBrevityCode").style.display="none";
			} 
		});
		
		//验证预约开始时间不能超过14*24小时
		$("input[name='beginRegisterTime']").blur(function (){
			var a = $(this).val();
			if(parseInt(a)>720){
				//alert($(this).val());
				$(this).addClass("focus");  
				$("#subflag").val("1");
				alert("预约开始时间不能超过30*24小时！");
			}else{
				$(this).removeClass("focus");
				$("#subflag").val("0");
			}
		});
		//验证预约结束时间不能大于预约开始时间
		$("input[name='overRegisterTime']").blur(function (){
			var a = $(this).val();
			var b = $("#beginRegisterTime").val();
			//var b = $(this).parent().parent().find($("input[name='beginRegisterTime']")).val();
			if(parseInt(a)>=parseInt(b)){
				$(this).addClass("focus");  
				$("#subflag").val("1");
				alert("预约结束时间不能超过或等于预约开始时间！");
			}else{
				$(this).removeClass("focus");
				$("#subflag").val("0");
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
				if($("#areaId").val()==""){
					alert("请选择所属地区！");
					return false;
				}
				if($("#hospGraded").val()==""){
					alert("请选择医院等级！");
					return false;
				}
				if($("#hospGradedText").val()==""){
					var c = $("#hospGraded").find("option:selected").text();
					$("#hospGradedText").val(c);
				}
				if($("#hospDesc").val()==""){
					alert("请填写医院描述！");
					return false;
				}
				var imgnull=ctx+"/showImage/showImg?path=";
				if($("#img").attr("src")==imgnull){
					alert("请上传医院图片！");
					return false;
				}
				if($("#img1").attr("src")==imgnull){
					alert("请上传地图URL地址！");
					return false;
				}
				/* if($("#ifhospTelAllow").val()=="1"){
					alert("医院电话格式不正确！");
					return false;
				} */
				if($("#ifnetAddressAllow").val()=="1"){
					alert("医院网址格式不正确！");
					return false;
				}
				
				if($("#ifcityTelCodeAllow").val()=="1"){
					alert("区号格式不正确！");
					return false;
				}
				if($("#iflongitudeAllow").val()=="1"){
					alert("经度格式不正确！");
					return false;
				}
				if($("#iflatitudeAllow").val()=="1"){
					alert("纬度格式不正确！");
					return false;
				}
				if($("#ifpinyinBrevityCodeAllow").val()=="1"){
					alert("拼音简码格式不正确！");
					return false;
				}
				if(isThirdpartyFlag && $("#hospCode").val()==""){
					alert("请填写医院编码！");
					return false;
				}
				var subflag = $("#subflag").val();
				if(subflag=="1"){
					alert("预约开始时间或预约结束时间填写不正确！");
					return false;
				}
				/* if($("#ifzipCodeTypeAllow").val()=="1"){
					alert("邮政编码格式不正确！");
					return false;
				} */
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						
							var hospId = "";
							if(hosInfo==""){
								//alert(json.errors);
								hospId = json.errors;
							}else{
								hospId = "${hosInfo.hospId}";
							}
							//医院基础信息添加成功后跳转到挂号类型编辑页面
							window.location.href = '${ctx}/hospital/addClinic?hospId='+hospId;
						
					});
				} else {
					errorValidate('msg-info', json.message + ',' + "");
					
				}
				$('#fat-btn').button('reset');
			}
		});

	});
	
	//列表图片上传
	 function upimg(type){
		 var fileElement = "";
		var img = "";
		var hiddenUrlId="";
		    if(type==1){
		    	fileElement="file";
				img="#img";
				hiddenUrlId="#hospImage";
		    }else if(type==3){
		    	fileElement="file3";
				img="#img3";
				hiddenUrlId="#deanHeadImage";
		    }else{
				fileElement="file1";
				img="#img1";
				hiddenUrlId="#mapUrl";
		    }
		
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
		/* if(areaId!=0){
		   $("#areaId").val(areaId);
		} */
		
	}
	
	function selectArea(areaIdC){
		//alert($("#areaIdParent").val());
		//alert(areaIdC);
		if(areaId!=0){
			   $("#areaId").val(areaIdC);
			}
	}
	
	function ifShow(value){
		if(value==1||value==3||value==4){
			document.getElementById("showHospCode").style.display="block";
		}else{
			document.getElementById("showHospCode").style.display="none";
		}
		if(value==1||value==4){
			isThirdpartyFlag=true;
		}else{
			isThirdpartyFlag=false;
		}
	}
	function setHGText(obj){
		var hospGradedText = obj.options[obj.selectedIndex].text;
		$("#hospGradedText").val(hospGradedText);
	}
	
	function IsURL(str_url){ 
        var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
        + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@  
        + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
        + "|" // 允许IP和DOMAIN（域名） 
        + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
        + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
       + "[a-z]{2,6})" // first level domain- .com or .museum  
       + "(:[0-9]{1,4})?" // 端口- :80  
       + "((/?)|" // a slash isn't required if there is no file name  
       + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
       var re=new RegExp(strRegex);  
 //re.test() 
       if (re.test(str_url)){ 
           return (true);  
       }else{  
           return (false);  
       } 
   } 
</script>
</html>