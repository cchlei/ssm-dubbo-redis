<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>挂号记录列表</title>
<style>
#divSCA
      {
          position: absolute;
          top:200px !important;
          width: 500px;
          height: 300px;
          font-size: 12px;
          background: #fff;
          border: 0px solid #000;
          z-index: 10001;
          display: none;
      }
      
      
#divSCACheckBox
      {
          position: absolute;
          top:200px !important;
          width: 500px;
          height: 300px;
          font-size: 12px;
          background: #fff;
          border: 0px solid #000;
          z-index: 10001;
          display: none;
      }
#close
      {
      position:absolute;
		right:0;/*   定位到右上   */
		top:0;
      }
       
</style>
</head>

<body>
	<!-- <ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">挂号记录列表</a></li>
	</ul> -->
	<div>
	<form name="form" role="form" action="${ctx}/regrecord/recordlist" method="GET">
    <%-- <input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/> --%>
    <input id="areaId" name="areaId" type="hidden" value="${areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${hospId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${registrationRecord.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${departmentName}"/>
    <input id="vip" name="vip" type="hidden" value="${vip}"/>
    <!-- <input id="flag" name="flag" type="hidden" value="${flag}"/>  -->
    <input id="scene" name="scene" type="hidden" value="${scene}"/>
    <input type="hidden" id="page" name="page" value="${page}"/>
    <input type="hidden" id="registerType" name="registerType" value="${registerType}"/>
    

	 <c:if test="${belongHospId==null || belongHospId==''}">
		所在地：
		<c:if test="${areaIdp!=null}">${areaMap[areaIdp]}</c:if>
		<c:if test="${areaIdp==null}">
		<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
	    <option value="0">请选择</option>
	    <c:forEach items="${areaList}" var="area" varStatus="status">
	       <c:if test="${area.parentId==0}">
		    	<c:choose>
			       <c:when test="${areaIdParent!=null && areaIdParent==area.areaId}">
			       		<option value="${area.areaId}" selected="selected">${area.areaName}</option>
			       </c:when>
			       <c:otherwise>
				    	<option value="${area.areaId}">${area.areaName}</option>
				   </c:otherwise>
			   </c:choose> 	
		   </c:if>
	    </c:forEach>
	    </select>
	    </c:if>
	    &nbsp;&nbsp;&nbsp;
	    <c:if test="${areaIdc!=null}">${areaMap[areaIdc]}</c:if>
	 	<c:if test="${areaIdc==null}">	
	    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
	    <c:choose>
	   	    <c:when test="${areaId!=null && areaId!=areaIdParent}">
	    	<option>${areaMap[areaId]}</option>
		    </c:when>
		    <c:otherwise>
		   	    <option value="0">请选择</option>
		    </c:otherwise>
		</c:choose>
	    </select>
	    </c:if>
	    &nbsp;&nbsp;&nbsp;
	         医院：<select class="mSelect"  class="lSelect"  id="hospital" name="hospital" onchange="searchDep(this,null,null)">
	   <%-- <c:if test="${hospId!=null}">
	    	<option>${hospName}</option>
	    </c:if> --%>
	    <c:if test="${registrationRecord.hospId==null}">
	    	<option value="0">请选择</option>
	    </c:if>
	    </select>
	 </c:if>&nbsp
	 <%--  邀请码：<input type="text"  id="invationCode" name="invationCode"   style="width:80px;" value="${invationCode}"/> --%>
    <c:if test="${scene=='2'}">
    	服务类型：<select class="mSelect"  class="mSelect"  id="serviceType" name="serviceType">
   	    <option value="">请选择</option>
    	<option value="1">挂号</option>
		<option value="2">挂号+导诊</option>
		<option value="3">老人陪护</option>
		<option value="4">挂号+导诊（上门取卡）</option>
	</select>
	</c:if>
    <br/>
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null,1)">
    <option value="0">请选择</option>
    </select>&nbsp;&nbsp;
    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
   	<%-- <c:if test="${registrationRecord.departmentId!=null && registrationRecord.departmentId!=hdParent}">
    	<option>${departmentName}</option>
    </c:if>  --%>
    <c:if test="${registrationRecord.departmentId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;
    医生：<select class="mSelect"  class="mSelect"  id="doctorId" name="doctorId">
     <c:if test="${registrationRecord.doctorId==null}">
    	<option value="">请选择</option>
    </c:if>
    </select>
    <c:if test="${scene=='2'}">
    项目编号：<input type="text"  id="projectNum" name="projectNum"   style="width:80px;" value="${projectNum}"/>
    爱康卡号：<input type="text"  id="ikangCardNum" name="ikangCardNum"   style="width:80px;" value="${ikangCardNum}"/>
	</c:if>
    <br/>
    就诊时间：<input class="Wdate" type="text" name="queryDiagnosisDateBegin" id="queryDiagnosisDateBegin"  value="<fmt:formatDate value="${registrationRecord.queryDiagnosisDateBegin}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;-&nbsp;
	<input class="Wdate" type="text" name="queryDiagnosisDateEnd" id="queryDiagnosisDateEnd"  value="<fmt:formatDate value="${registrationRecord.queryDiagnosisDateEnd}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;&nbsp;
	预约时间：<input class="Wdate" type="text" name="queryRegistrationDateBegin" id="queryRegistrationDateBegin"  value="<fmt:formatDate value="${registrationRecord.queryRegistrationDateBegin}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">&nbsp;-&nbsp;
	<input class="Wdate" type="text" name="queryRegistrationDateEnd" id="queryRegistrationDateEnd"  value="<fmt:formatDate value="${registrationRecord.queryRegistrationDateEnd}" pattern="yyyy-MM-dd"/>" onClick="WdatePicker()">
	<br/>
	就诊人：<input type="text"  id="patientName" name="patientName"   style="width:80px;" value="${registrationRecord.patientName}"/>
	操作人：<input type="text"  id="operatorName" name="operatorName"   style="width:80px;" value="${registrationRecord.operatorName}"/>
    医院处理状态：<select class="mSelect"  class="mSelect"  id="isGuide" name="isGuide">
   	    <option value="">请选择</option>
    	<option value="1">未处理</option>
		<option value="2">已接诊</option>
		<option value="3">已拒绝</option>
		<option value="4">已标记爽约</option>
		<option value="5">处理中</option>
		<option value="6">挂号失败</option>
	</select>
	取消状态：<select class="mSelect"  class="mSelect"  id="unsubscribeType" name="unsubscribeType">
	    <option value="">请选择</option>
		<option value="1">未取消</option>
		<option value="2">挂号人取消</option>
		<option value="3">医院未接诊</option>
		<option value="4">停诊</option>
		<option value="5">医生排班变更</option>
		<option value="6">客服取消</option>
	</select>
	<!-- 
	排序方式：<select class="mSelect"  class="mSelect"  id="sortOrder" name="sortOrder">
	    <option value="">请选择</option>
		<option value="1">医生</option>
		<option value="2">预约时间</option>
	</select>
	 -->
    <input type="submit" id="searchDoc" value="查询"/>
    <c:if test="${scene=='2'}">
    <button type="button"  onclick="download()">导 出</button>
    &nbsp;&nbsp;<font color="#FF0000">*导出数据前需要先查询* </font>
    </c:if>
    </form><p>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 挂号记录列表 
				<c:choose>
					<c:when test="${vip==1}"></c:when>
					<c:when test="${scene == 6}"></c:when>
					<c:otherwise>
						<button type="button" class="btn btn-primary btn-sm" id="regRecordIdCheckBoxCancel" style="float: right;margin-top: -6px;">多选取消</button>
					</c:otherwise>
				</c:choose>
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter table2">
			<thead>
			<tr>
				<c:choose>
					<c:when test="${vip==1}"></c:when>
					<c:when test="${scene == 6}"></c:when>
					<c:otherwise>
						<th class="text-center"><input type="checkbox" id="regRecordIdCheckBox"/></th>
					</c:otherwise>
				</c:choose>
			    <th class="text-center">医院名称</th>
				<th class="text-center">科室名称</th>
				<th class="text-center">医生</th>
				<th class="text-center">就诊人</th>
				<th class="text-center" style="width:30px;">性别</th>
				<th class="text-center">证件号</th>
				<th class="text-center">联系电话</th>
				<th class="text-center">就诊时间</th>
				<th class="text-center">预约时间</th>
				<th class="text-center">门诊类型</th>
				<th class="text-center">取号时间</th>
				<th class="text-center">取号地点</th>
				<c:if test="${scene==2}">
				<th class="text-center">服务类型</th>
				</c:if>
				<th class="text-center">操作人</th>
				<th class="text-center">社保卡号</th>
				<th class="text-center">医院处理状态</th>
				<c:if test="${scene!=6}">
				<th class="text-center">短信接收状态</th>
				</c:if>
				<c:if test="${vip!='1' && scene!=6}">
				<th class="text-center">操作</th>
				</c:if>
				<c:if test="${scene!='2' && scene!=6}">
				<th class="text-center">打印</th>
				</c:if>
				<c:if test="${scene=='2' && scene!=6}">
				<th class="text-center">编辑</th>
				</c:if>
			</tr>
			</thead>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="today"/>
			<c:forEach items="${regRecordList}" var="regRecord" varStatus="status">
			<tr>
			    <c:choose>
					<c:when test="${vip==1}"></c:when>
					<c:when test="${scene == 6}"></c:when>
					<c:otherwise>
						<td><input type="checkbox" name="checkbox" value="${regRecord.doctorId}" registrationRecordId="${regRecord.registrationRecordId}"  unsubscribeType="${regRecord.unsubscribeType}"  isGuide="${regRecord.isGuide}"/></td>
					</c:otherwise>
				</c:choose>
				<td>${regRecord.hospName} <p style="display:none;">hospId:${regRecord.hospId}"</p></td>
				<td>${regRecord.departmentName} <p style="display:none;">departmentId:${regRecord.departmentId}"</p></td>
				<td>${regRecord.doctorName} <p style="display:none;">doctorId:${regRecord.doctorId}"</p></td>
				<td>${regRecord.patientName} <p style="display:none;">patientId:${regRecord.patientId}"</p></td>
				<td>
				<c:if test="${regRecord.sex==1}">男</c:if>
				<c:if test="${regRecord.sex==2}">女</c:if>
				</td>
				<td>${regRecord.idCard} <p style="display:none;">recordId:${regRecord.registrationRecordId}"</p></td>
				<td>${regRecord.phoneNum} <p style="display:none;">rsourceId:${regRecord.resourceId}"</p></td>
				<td>
				<fmt:formatDate value="${regRecord.diagnosisDate}" pattern="yyyy-MM-dd,EEEE"/>&nbsp;
				<c:if test="${regRecord.ampm==1}">上午</c:if>
				<c:if test="${regRecord.ampm==2}">下午</c:if>	
				<c:if test="${regRecord.timespanStart!=''}">
				<fmt:formatDate value="${regRecord.timespanStart}" pattern="HH:mm"/>
				</c:if>
				</td>
				<td><fmt:formatDate value="${regRecord.registrationDate}" pattern="yyyy-MM-dd"/></td>
				<td>${regRecord.resourceTpyeText}</td>
				<td>${regRecord.retrieveTime}</td>
				<td>${regRecord.retrieveAddress}</td>
				<c:if test="${scene==2}">
					<td>
						<c:if test="${regRecord.serviceType=='1'}">挂号</c:if>
						<c:if test="${regRecord.serviceType=='2'}">挂号+导诊</c:if>
						<c:if test="${regRecord.serviceType=='3'}">老人陪护</c:if>
						<c:if test="${regRecord.serviceType=='4'}">挂号+导诊（上门取卡）</c:if>					
					</td>
				</c:if>
				<td>${regRecord.operatorName}</td>
				<td>${regRecord.medicareNumber}</td>
				<td>
				<c:if test="${regRecord.isGuide=='1'}">未处理</c:if>
				<c:if test="${regRecord.isGuide=='2'}">接诊</c:if>
				<c:if test="${regRecord.isGuide=='3'}">拒绝</c:if>
				<c:if test="${regRecord.isGuide=='4'}">爽约</c:if>
				<c:if test="${regRecord.isGuide=='5'}"><button type="button" class="btn btn-primary btn-sm" onclick="process('${regRecord.registrationRecordId}')">处理</button></c:if>
				<c:if test="${regRecord.isGuide=='6'}">挂号失败</c:if>
				</td>
				<c:if test="${scene!=6}">
				<td>
				<fmt:formatDate value="${regRecord.diagnosisDate}" type="both" dateStyle="long" pattern="yyyy-MM-dd" var="diagnosisDate"/>
				
				<!-- 	 ${today} - ${diagnosisDate}
				<c:if test="${today > diagnosisDate }">
					<a onclick="sendsms('${regRecord.registrationRecordId}')">重发1</a>
				</c:if> -->
				<c:if test="${today <= diagnosisDate && regRecord.unsubscribeType=='1'}">
					<button type="button" class="btn btn-primary btn-sm" onclick="sendsms('${regRecord.registrationRecordId}')">重 发 </button>
				</c:if>
				
				<c:choose>
					<c:when test="${regRecord.email=='NULL'}">发送中</c:when>  
					<c:when test="${regRecord.email=='DELIVRD'}">成功</c:when>  
				    <c:when test="${regRecord.email=='BLACKMB'}">拒收</c:when>
				    <c:when test="${regRecord.email=='History'}">成功</c:when>
				    <c:when test="${regRecord.email=='CU3:10'}">用户关机</c:when>
					<c:otherwise>${regRecord.email}</c:otherwise>
				</c:choose>
				</td>
				</c:if>
				<c:if test="${vip!='1' && scene!=6}">
				<td>
					<c:if test="${regRecord.unsubscribeType=='1' && regRecord.isGuide==1}">
					<button type="button" class="btn btn-primary btn-sm" onclick="toCancel('${regRecord.registrationRecordId}','<fmt:formatDate value="${regRecord.latestUnsubscribeTime}" pattern="yyyy-MM-dd"/>','${regRecord.doctorId}')">取消</button>
					</c:if>
					<%-- <c:if test="${regRecord.unsubscribeType>1}">已取消</c:if> --%>
					<c:if test="${regRecord.unsubscribeType=='2'}">挂号人取消</c:if>
					<c:if test="${regRecord.unsubscribeType=='3'}">医院未接诊</c:if>
					<c:if test="${regRecord.unsubscribeType=='4'}">停诊</c:if>
					<c:if test="${regRecord.unsubscribeType=='5'}">医生排班发生变更</c:if>
					<c:if test="${regRecord.unsubscribeType=='6'}">客服取消</c:if>
				</td>
				</c:if>
				<c:if test="${scene!='2' && scene!=6}">
				<td><button type="button" class="btn btn-primary btn-sm" onclick="preView('${regRecord.hospName}','${regRecord.patientName}','${regRecord.phoneNum}','${regRecord.idCard}','${regRecord.departmentName}','${regRecord.doctorName}','<fmt:formatDate value='${regRecord.diagnosisDate}' pattern='yyyy-MM-dd'/>','${regRecord.expenseText}','${regRecord.retrieveAddress}','<fmt:formatDate value='${regRecord.registrationDate}' pattern='yyyy-MM-dd HH:mm:ss'/>','${regRecord.retrieveTime}','${regRecord.ampm}','<fmt:formatDate value='${regRecord.timespanStart}' pattern='HH:mm'/>','<fmt:formatDate value='${regRecord.timespanEnd}' pattern='HH:mm'/>');">打 印 </button></td>
				</c:if>
				<c:if test="${scene=='2' && scene!=6}">
				<td>
				<button type="button" class="btn btn-primary btn-sm" onclick="javascript:window.location.href='${ctx}/register/editIndustry?recordId=${regRecord.registrationRecordId}'">修 改 </button>
				</td>
				</c:if>
				
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/regrecord/recordlist?hospId=${params.hospId}&queryDiagnosisDateBegin=${params.queryDiagnosisDateBegin}&queryDiagnosisDateEnd=${params.queryDiagnosisDateEnd}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&vip=${params.vip}&scene=${params.scene}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}&hospital=${params.hospital}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&doctorId=${params.doctorId}&projectNum=${params.projectNum}&ikangCardNum=${params.ikangCardNum}&queryRegistrationDateBegin=${params.queryRegistrationDateBegin}&queryRegistrationDateEnd=${params.queryRegistrationDateEnd}&patientName=${params.patientName}&operatorName=${params.operatorName}&isGuide=${params.isGuide}&serviceType=${params.serviceType}&unsubscribeType=${params.unsubscribeType}&sortOrder=${params.sortOrder}&registerType=${params.registerType}"/>	
	<div id="printer" style="display:none">
		<br/>
		<div style="padding:0 0.6cm;text-align:center;">
			<h2><span>导医通</span> </h2>
			<h2><span id="p_hospname"></span> </h2>
    		<span style="font-size: 14px; ">现场实名制预约回执单</span>
		</div>
	    <ul style='line-height:18px; font-size: 12px;list-style-type:none;margin:0.5cm 0.1cm 0.5cm 0.6cm;'>
	    	<li>患者姓名:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_patientName"></span></li>
	    	<li>联系电话:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_phoneNum"></span></li>
	    	<li>证件号码:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_idCard"></span></li>
	    	<li>预约科室:&nbsp;&nbsp;<span id="p_departmentName"></span></li>
	    	<li>预约专家:&nbsp;&nbsp;<span id="p_doctorName"></span></li>
	    	<li>就诊时间:&nbsp;&nbsp;<span id="p_diagnosisDate"></span></li>
	    	<li>挂号费用:&nbsp;&nbsp;<span id="p_expenseText"></span></li>
	    	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（请以医院公布价格为准）</li>
	    	<li>取号时间:&nbsp;&nbsp;<span id="p_retrieveTime"></span></li>
	    	<li>取号地点:&nbsp;&nbsp;<span id="p_retrieveAddress"></span></li>
	    	<li>---------------------------------------------------------</li>
	    	<li>取消预约:&nbsp;&nbsp;<span>（取消预约的注意事项）</span><div style='margin-bottom: 10px;'>请提早两个工作日致电400-920-2323.</div></li>
	    	<li>停诊通知:&nbsp;&nbsp;<span>（停诊通知的注意事项）</span><div style='margin-bottom: 10px;'>未定</div></li>
	  		<li>爽约:&nbsp;&nbsp;<span id="">（失约的处理）</span><div style='margin-bottom: 10px;'>爽约3次，您将进入导医通预约黑名单！</div></li>
	    	<li><span id="p_registrationDate"></span><div style='margin-bottom: 10px;'>（预约当日的日期/时间）</div></li>
	    	<li>---------------------------------------------------------</li>
	    	<li>免责声明:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>未定</div></li>
	    	<li>APP下载的二维码</li>
	    	<li style="text-align:center;"><img width="100" height="100" alt="二维码" src="../static/images/dimBarCode.jpg"></li>
	    </ul>
	</div>	
	
	<div id="printer_shzyyy" style="display:none">
		<br/>
		<div style="padding:0 0.6cm;text-align:center;">
			<h2><span>导医通</span> </h2>
			<h2><span id="p_hospname_shzyyy"></span> </h2>
    		<span style="font-size: 14px; ">现场实名制预约回执单</span>
		</div>
	    <ul style='line-height:18px; font-size: 12px;list-style-type:none;margin:0.5cm 0.1cm 0.5cm 0.6cm;'>
	    	<li>患者姓名:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_patientName_shzyyy"></span></li>
	    	<li>联系电话:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_phoneNum_shzyyy"></span></li>
	    	<li>证件号码:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_idCard_shzyyy"></span></li>
	    	<li>预约科室:&nbsp;&nbsp;<span id="p_departmentName_shzyyy"></span></li>
	    	<li>预约专家:&nbsp;&nbsp;<span id="p_doctorName_shzyyy"></span></li>
	    	<li>挂号时间:&nbsp;&nbsp;<span id="p_diagnosisDate_shzyyy"></span></li>
	    	<li>挂号费用:&nbsp;&nbsp;<span id="p_expenseText_shzyyy"></span></li>
	    	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（请以医院公布价格为准）</li>
	    	<li>备注:&nbsp;&nbsp;<span id="p_retrieveTime_shzyyy"></span></li>
	    	<li>取号地点:&nbsp;&nbsp;<span id="p_retrieveAddress_shzyyy"></span></li>
	    	<li>---------------------------------------------------------</li>
	    	<li>取消预约:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>请提早两个工作日致电400-920-2323.</div></li>
	  		<li>爽约:&nbsp;&nbsp;<span id=""></span><div style='margin-bottom: 10px;'>爽约3次，您将进入导医通预约黑名单！</div></li>
	    	<li><span id="p_registrationDate_shzyyy"></span><div style='margin-bottom: 10px;'>（预约当日的日期/时间）</div></li>
	    	<li>---------------------------------------------------------</li>
	    	<li>APP下载的二维码</li>
	    	<li style="text-align:center;"><img width="100" height="100" alt="二维码" src="../static/images/dimBarCode.jpg"></li>
	    </ul>
	</div>	

	<div id="printer_fdzsyy" style="display:none">
		<br/>
		<div style="padding:0 0.6cm;text-align:center;">
			<h2><span>导医通</span> </h2>
			<h2><span id="p_hospname_fdzsyy"></span> </h2>
	   		<span style="font-size: 15px; ">现场实名制预约回执单</span>
		</div>
	    <ul style='line-height:18px; font-size: 16px;list-style-type:none;margin:0.5cm 0.1cm 0.5cm 0.6cm;'>
	    	<li>患者姓名:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_patientName_fdzsyy"></span></li>
	    	<li>联系电话:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_phoneNum_fdzsyy"></span></li>
	    	<li>证件号码:&nbsp;&nbsp;<span style="font-size: 16px;" id="p_idCard_fdzsyy"></span></li>
	    	<li>预约科室:&nbsp;&nbsp;<span id="p_departmentName_fdzsyy"></span></li>
	    	<li>预约专家:&nbsp;&nbsp;<span id="p_doctorName_fdzsyy"></span></li>
	    	<li>就诊时间:&nbsp;&nbsp;<span id="p_diagnosisDate_fdzsyy"></span></li>
	    	<li>挂号费用:&nbsp;&nbsp;<span id="p_expenseText_fdzsyy"></span></li>
	    	<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 14px; ">（请以医院公布价格为准）</span></li>
	    	<li>取号时间:&nbsp;&nbsp;<span id="p_retrieveTime_fdzsyy"></span></li>
	    	<li>取号地点:&nbsp;&nbsp;<span id="p_retrieveAddress_fdzsyy"></span></li><br/><br/>
	    	<li>-------------------------------------</li>
	    	<li>取消预约:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>请提早两个工作日致电400-920-2323.</div></li>
	    	<li>停诊通知:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>未定.</div></li>
	  		<li>爽约:&nbsp;&nbsp;<span id=""></span><div style='margin-bottom: 10px;'>爽约3次，您将进入导医通预约黑名单！</div></li>
	    	<li><span id="p_registrationDate_fdzsyy"></span><div style='margin-bottom: 10px;'>（预约当日的日期/时间）</div></li>
	    	<li>-------------------------------------</li><br/><br/>
	    	<li>免责声明:&nbsp;&nbsp;<span></span><div style='margin-bottom: 10px;'>未定.</div></li>
	    	<li>APP下载的二维码</li>
	    	<li style="text-align:center;"><img width="100" height="100" alt="二维码" src="../static/images/fdzsyyDimBarCode.jpg"></li>
	    </ul>
	</div>		

	<div id="divSCA">
	   <input type="button" id="close" value="关闭" onclick="closeDiv()">
	   <input type="hidden" name="registrationRecordId" id="registrationRecordId">
	   <input type="hidden" name="latestUnsubscribeTime" id="latestUnsubscribeTime">
	   <input type="hidden" name="cancelDoctorId" id="cancelDoctorId">
	   <br/><br/><br/><br/>
	   &nbsp;&nbsp;&nbsp;&nbsp;请选择取消原因：<select id="cause" name="cause" class="lSelect">
	      <option value="1">${causeMAp['1']}</option>
	      <option value="2">${causeMAp['2']}</option>
	      <option value="3">${causeMAp['3']}</option>
	   </select>
	   <br/><br/><br/><br/>
	   <div style="margin-left:180px">
	   		<button type="button" id="cancelBut" onclick="cancel();" class="btn btn-primary">确定</button></div>
	   </div>
	<div id="divSCACheckBox">
	   <input type="button" id="close" value="关闭" onclick="closeDivSCACheckBox();">
	   <br/><br/><br/><br/>
	   &nbsp;&nbsp;&nbsp;&nbsp;请选择取消原因：<select id="checkBoxCancel" name="checkBoxCancel" class="lSelect">
	      <option value="1">${causeMAp['1']}</option>
	      <option value="2">${causeMAp['2']}</option>
	      <option value="3">${causeMAp['3']}</option>
	   </select>
	   <br/><br/><br/><br/>
	   <div style="margin-left:180px">
	   		<button type="button" id="checkBoxCancelBut" onclick="checkBoxCancel();" class="btn btn-primary">确定</button></div>
	   </div>
	</div>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	
	
	//全选反选
	$("#regRecordIdCheckBox").click(function(){
		var isChecked = $(this).prop("checked");
	    $("input[name='checkbox']").prop("checked", isChecked);
	});
	
	//多选取消按钮
	$("#regRecordIdCheckBoxCancel").click(function(){
		if($("input[name='checkbox']:checked").length==0){
			alert("请选择要取消的数据");
			return false;
		}
		openDivSCACheckBox();
	});	
	
	//查询条件赋值
	if("${registrationRecord.isGuide}"!=""){
		$("#isGuide").val("${registrationRecord.isGuide}");
	}
	if("${registrationRecord.unsubscribeType}"!=""){
		$("#unsubscribeType").val("${registrationRecord.unsubscribeType}");
	}
	if("${registrationRecord.serviceType}"!=""){
		$("#serviceType").val("${registrationRecord.serviceType}");
	}
	if("${sortOrder}"!=""){
		$("#sortOrder").val("${sortOrder}");
	}
	var areaIdParent = "${areaIdParent}";
	var areaId = "${areaId}";
	var hospId = "${registrationRecord.hospId}";
	var hdParent = "${hdParent}";
	var departmentId = "${registrationRecord.departmentId}";
	var doctorId = "${registrationRecord.doctorId}";
	console.log(areaIdParent+"--"+areaId);
	if(areaIdParent!="" && areaId==areaIdParent){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId);
			searchDep(null,hospId,hdParent);
			//alert(hdParent+"--"+departmentId);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId,null);
				$("#departmentId").val(departmentId);
				searchDoctor(departmentId,doctorId);
			}else{
				searchHd(null,1,departmentId,departmentId,null);
				$("#departmentId").val(departmentId);
				searchDoctor(departmentId,doctorId);
			}
		}else{
			searchHosp(areaIdParent,null);
		}
	}else if(areaIdParent!="" && areaId!=areaIdParent){
		searchArea(areaIdParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId,null);
				$("#departmentId").val(departmentId);
				searchDoctor(departmentId,doctorId);
			}
		}else{
			searchHosp(areaId,null);
		}
	}
});
function process(registrationRecordId){
	var url = ctx+"/register/processConsumer";
	$.post(url,{'recordId':registrationRecordId},function(json){
		if(json=='success'){
			$.alert('挂号记录已成功处理。', function() {
				var registerType = "${registerType}";
				//window.location.href = '${ctx}/regrecord/queryRecordlist?doctorId='+json.results+"&registerType="+registerType;
				window.location.href = '${ctx}/regrecord/recordlist?hospId=${params.hospId}&queryDiagnosisDateBegin=${params.queryDiagnosisDateBegin}&queryDiagnosisDateEnd=${params.queryDiagnosisDateEnd}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}&hospital=${params.hospital}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&doctorId=${params.doctorId}&projectNum=${params.projectNum}&ikangCardNum=${params.ikangCardNum}&queryRegistrationDateBegin=${params.queryRegistrationDateBegin}&queryRegistrationDateEnd=${params.queryRegistrationDateEnd}&patientName=${params.patientName}&operatorName=${params.operatorName}&isGuide=${params.isGuide}&serviceType=${params.serviceType}&unsubscribeType=${params.unsubscribeType}&sortOrder=${params.sortOrder}&registerType=${params.registerType}';
			});
		}else{
			alert("处理失败，请联系管理员。" + json);
			var registerType = "${registerType}";
			window.location.href = '${ctx}/regrecord/recordlist?hospId=${params.hospId}&queryDiagnosisDateBegin=${params.queryDiagnosisDateBegin}&queryDiagnosisDateEnd=${params.queryDiagnosisDateEnd}&areaId=${params.areaId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&areaIdParent=${params.areaIdParent}&areaIdChild=${params.areaIdChild}&hospital=${params.hospital}&hdParent=${params.hdParent}&hdChild1=${params.hdChild1}&doctorId=${params.doctorId}&projectNum=${params.projectNum}&ikangCardNum=${params.ikangCardNum}&queryRegistrationDateBegin=${params.queryRegistrationDateBegin}&queryRegistrationDateEnd=${params.queryRegistrationDateEnd}&patientName=${params.patientName}&operatorName=${params.operatorName}&isGuide=${params.isGuide}&serviceType=${params.serviceType}&unsubscribeType=${params.unsubscribeType}&sortOrder=${params.sortOrder}&registerType=${params.registerType}';
		}
	});
}
function sendsms(registrationRecordId){
	var url = ctx+"/register/sendsms";
	$.post(url,{'recordId':registrationRecordId},function(json){
		if(json=='success'){
			$.alert('短信重新发送', function() {
				if("${vip}"!=""){
					var vip = "${vip}";
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&vip="+vip+"&flag=1";;
				}else if("${scene}"!=""){
					var scene = "${scene}";
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&scene="+scene+"&flag=1";
				}else{
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&flag=1";
				}
				//window.location.reload();
			});
		}
	});
}
function cancel(){
	var registrationRecordId = $("#registrationRecordId").val();
	var latestUnsubscribeTime = $("#latestUnsubscribeTime").val();
	var cause = $("#cause").val();
	var doctorId = $("#doctorId").val();
	closeDiv();
	//alert(registrationRecordId+"---"+latestUnsubscribeTime+"---"+cause);
/* 	var now = new Date();
	latestUnsubscribeTime = latestUnsubscribeTime.replace(/-/g,"/");//替换字符，变成标准格式    
	var last = new Date(Date.parse(latestUnsubscribeTime));    
	  if(last<now){
		alert("已过最晚取消时间！！");
		return;
	}   */
	
	$.confirm("确定要取消此挂号？取消后不可恢复！", function() {
		$.get(ctx+"/regrecord/cancel/"+registrationRecordId,{'doctorId':doctorId,'cause':cause}, function(json) {
			var msg = "";
			if (json.message) {
				msg = json.message;
			}
			$.alert(msg, function() {
				if("${vip}"!=""){
					var vip = "${vip}";
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&vip="+vip+"&flag=1";;
				}else if("${scene}"!=""){
					var scene = "${scene}";
					//alert(json.results);
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&scene="+scene+"&flag=1";
				}else{
					window.location.href = '${ctx}/regrecord/recordlist?doctorId='+json.results+"&flag=1";
				}
				//window.location.reload();
			});
		}, "json");
	});
	
	
}
function toCancel(registrationRecordId,latestUnsubscribeTime,doctorId){
	$("#registrationRecordId").val(registrationRecordId);
	$("#latestUnsubscribeTime").val(latestUnsubscribeTime);
	$("#cancelDoctorId").val(doctorId);
	openDiv();
}


//地区下拉联动
function searchArea(areaId,areaIdChild){
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
			if(areaIdChild!=null && areaIdChild == json[i].areaId){
				option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].areaId).text(json[i].areaName);
			}
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#areaIdChild").append(option); 
		} 
	});
	if(areaIdChild==null){
		searchHosp(areaId,null);//根据父级地区查询医院
	}
	 
	 if(areaId!=0){
	   $("#areaId").val(areaId);
	 } 
	
}

//医院下拉联动
function searchHosp(areaId,hospId){
	//alert(hospId);
	if(areaId==0){
		return;
	}
	var url = ctx+"/regrecord/searchHosp";
	$.ajax({  
		type : "post",  
		url : url,  
		data : {'areaId':areaId},  
		async : false,  
		asyncBoolean:false,
		success : function(data){  
			json = eval(data);
			  // 先清空第二个 
		      $("#hospital").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#hospital").append(option); 
		      //alert(hospId);
			for(var i=0; i<json.length; i++) 
			{ 
				if(hospId!=null && hospId == json[i].hospId){
					option = $("<option>").val(json[i].hospId).text(json[i].hospName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].hospId).text(json[i].hospName);
				}
			    //alert(json[i].areaId+" " + json[i].areaName) 
			    $("#hospital").append(option); 
			} 
		}  
    });
	
	 if(areaId!=0){
		   $("#areaId").val(areaId);
		 } 
	
}

//科室下拉联动
function searchDep(obj,hospId1,hdParent){
	var hospId = 0;
	//var hospName = "";
	if(hospId1 != null){
		hospId = hospId1;
	}else{
		hospId = obj.options[obj.selectedIndex].value;
		//hospName = obj.options[obj.selectedIndex].text;
	}
	    
	if(hospId==0){
		$("#hospId").val("");
		return;
	}
	var url = ctx+"/regrecord/searchDep";
	$.post(url,{'hospId':hospId},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#hdParent").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择").prop("selected",true);
	      $("#hdParent").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(hdParent!=null && hdParent == json[i].departmentId){
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
			}
			
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#hdParent").append(option); 
		} 
	});
	if(hospId!=0){
		   $("#hospId").val(hospId);
		   //$("#hospName").val(hospName);
		}

}

//二级科室下拉联动
function searchHd(obj,number,departmentId,departmentIdChild,ifFlag){
	var hdId = 0;
	var hdName ="";
	if(departmentId!=null){
		hdId = departmentId;
	}else{
		hdId = obj.options[obj.selectedIndex].value;
		hdName = obj.options[obj.selectedIndex].text;
	}	
	var flag = "${flag}";
	if(flag=="sources"){
		$('#searchDoc').attr('disabled', true);
	}
	
	if(hdId==0){
		 $("#departmentId").val(null);
		return;
	}
	var hospId = $("#hospId").val();
	var url = ctx+"/doctor/searchHdDep";
	var selPeram = "";
	$.post(url,{'departmentId':hdId,'hospId':hospId},function (data){
		json = eval(data);
		  if(number==1){
			  selPeram = "#hdChild1";
		  }else{
			  selPeram = "#hdChild2";
		  }
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val("").text("请选择");
	      $(selPeram).append(option); 
	       if(json.length>0 && ifFlag==1){
	    	  //$("#departmentId").val(json[0].departmentId);
	    	  //searchDoctor(json[0].departmentId,null);
	      } 
		for(var i=0; i<json.length; i++) 
		{ 
			//console.log(departmentIdChild+"--"+json[i].departmentId);
			if(departmentIdChild!=null && departmentIdChild == json[i].departmentId){
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
			}
		    $(selPeram).append(option); 
		} 
	});
	
	if(hdId!=0){
	   $("#departmentId").val(hdId);
	   $("#departmentName").val(hdName);
	}
	
} 
function selectHd(obj){
	var hdC = obj.options[obj.selectedIndex].value;
	var hdName = obj.options[obj.selectedIndex].text;
	if(hdC!=0){
		   $("#departmentId").val(hdC);
		   $("#departmentName").val(hdName);
		  // $("#searchDoc").removeAttr("disabled");
		}
	searchDoctor(hdC,null);
}
//医生下拉
function searchDoctor(departmentId,doctorId){
	var url = ctx+"/regrecord/searchDoctor";
	$.post(url,{'departmentId':departmentId},function (data){
		json = eval(data);
		  selPeram = "#doctorId";
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val("").text("请选择");
	      $(selPeram).append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(doctorId!=null && doctorId == json[i].doctorId){
				option = $("<option>").val(json[i].doctorId).text(json[i].doctorName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].doctorId).text(json[i].doctorName);
			}
		    $(selPeram).append(option); 
		} 
	});
}
var LODOP ;
function preView(hospName,patientName,phoneNum,idCard,departmentName,doctorName,diagnosisDate,expenseText,retrieveAddress,registrationDate,retrieveTime,ampm,timestamp,endtimestamp){
	LODOP = getLodop();
    LODOP.PRINT_INIT("");
    LODOP.SET_PRINT_PAGESIZE(3,800,300,"");//这里3表示纵向打印且纸高“按内容的高度”；300表示纸宽30.0mm；30表示页底空白3.0mm
    if(ampm==1){
		ampm="上午";    	
    }
    if(ampm==2){
		ampm="下午";    	
    }
    if(hospName=="上海市中医医院" || hospName=="上海市中医医院石门路门诊部"){
        $("#p_hospname_shzyyy").text(hospName);
        $("#p_patientName_shzyyy").text(patientName);
        $("#p_phoneNum_shzyyy").text(phoneNum);
        $("#p_idCard_shzyyy").text(idCard);
        $("#p_departmentName_shzyyy").text(departmentName);
        $("#p_doctorName_shzyyy").text(doctorName);
        $("#p_diagnosisDate_shzyyy").text(diagnosisDate+" "+ampm+" "+timestamp+"-"+endtimestamp);
        $("#p_expenseText_shzyyy").text(expenseText);
        $("#p_registrationDate_shzyyy").text(registrationDate);
        $("#p_retrieveAddress_shzyyy").text(retrieveAddress);
        if(hospName=="上海市中医医院" ){
        	$("#p_retrieveTime_shzyyy").text("1号楼名专家只接受复诊预约");
        }
        if(hospName=="上海市中医医院石门路门诊部"){
        	$("#p_retrieveTime_shzyyy").text("");
        }
    	LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer_shzyyy").innerHTML);
    }else if(hospName=="复旦大学附属中山医院"){
        $("#p_hospname_fdzsyy").text(hospName);
        $("#p_patientName_fdzsyy").text(patientName);
        $("#p_phoneNum_fdzsyy").text(phoneNum);
        $("#p_idCard_fdzsyy").text(idCard);
        $("#p_departmentName_fdzsyy").text(departmentName);
        $("#p_doctorName_fdzsyy").text(doctorName);
        $("#p_diagnosisDate_fdzsyy").text(diagnosisDate+" "+ampm+" "+timestamp+"-"+endtimestamp);
        $("#p_expenseText_fdzsyy").text(expenseText);
        $("#p_retrieveAddress_fdzsyy").text(retrieveAddress);
        $("#p_registrationDate_fdzsyy").text(registrationDate);
        $("#p_retrieveTime_fdzsyy").text(retrieveTime);
        //LODOP.ADD_PRINT_RECT(0,0,305,505,2);
    	LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer_fdzsyy").innerHTML);  
    }else{
        $("#p_hospname").text(hospName);
        $("#p_patientName").text(patientName);
        $("#p_phoneNum").text(phoneNum);
        $("#p_idCard").text(idCard);
        $("#p_departmentName").text(departmentName);
        $("#p_doctorName").text(doctorName);
        $("#p_diagnosisDate").text(diagnosisDate+" "+ampm+" "+timestamp+"-"+endtimestamp);
        $("#p_expenseText").text(expenseText);
        $("#p_retrieveAddress").text(retrieveAddress);
        $("#p_registrationDate").text(registrationDate);
        $("#p_retrieveTime").text(retrieveTime);
        //LODOP.ADD_PRINT_RECT(0,0,305,505,2);
    	LODOP.ADD_PRINT_HTM(0,0,270,100,document.getElementById("printer").innerHTML);    	
    }
    
    LODOP.PREVIEW();
    //LODOP.PRINT();
}

function download(){
	var hospId = $("#hospId").val();
	var queryDiagnosisDateBegin = $("#queryDiagnosisDateBegin").val();
	var queryDiagnosisDateEnd = $("#queryDiagnosisDateEnd").val();
	var areaId = $("#areaId").val();
	var departmentId = $("#departmentId").val();
	var departmentName = $("#departmentName").val();
	var vip = $("#vip").val();
	var scene = $("#scene").val();
	var areaIdParent = $("#areaIdParent").val();
	var areaIdChild = $("#areaIdChild").val();
	var hospital = $("#hospital").val();
	var hdParent = $("#hdParent").val();
	var hdChild1 = $("#hdChild1").val();
	var doctorId = $("#doctorId").val();
	var projectNum = $("#projectNum").val();
	var ikangCardNum = $("#ikangCardNum").val();
	var queryRegistrationDateBegin = $("#queryRegistrationDateBegin").val();
	var queryRegistrationDateEnd = $("#queryRegistrationDateEnd").val();
	var patientName = $("#patientName").val();
	var isGuide = $("#isGuide").val();
	var serviceType = $("#serviceType").val();
	var unsubscribeType = $("#unsubscribeType").val();
	var registerType = $("#registerType").val();
	//alert(queryBeginDate1+"="+queryEndDate1);
	var url="${ctx}/regrecord/industryDownload?hospId="+hospId
			+"&queryDiagnosisDateBegin="+queryDiagnosisDateBegin
			+"&queryDiagnosisDateEnd="+queryDiagnosisDateEnd
			+"&areaId="+areaId
			+"&departmentId="+departmentId
			+"&departmentName="+departmentName
			+"&registerType="+registerType
			+"&vip="+vip
			+"&scene="+scene
			+"&areaIdParent="+areaIdParent
			+"&areaIdChild="+areaIdChild
			+"&hospital="+hospital
			+"&hdParent="+hdParent
			+"&hdChild1="+hdChild1
			+"&doctorId="+doctorId
			+"&projectNum="+projectNum
			+"&ikangCardNum="+ikangCardNum
			+"&queryRegistrationDateBegin="+queryRegistrationDateBegin
			+"&queryRegistrationDateEnd="+queryRegistrationDateEnd
			+"&patientName="+patientName
			+"&isGuide="+isGuide
			+"&serviceType="+serviceType
			+"&unsubscribeType="+unsubscribeType;
    window.open(url);
}

function openDiv() {
	$("#divSCA").OpenDiv();
}

function closeDiv() {
	$("#registrationRecordId").val("");
	$("#latestUnsubscribeTime").val("");
	$("#divSCA").CloseDiv();	
}

function openDivSCACheckBox() {
	$("#divSCACheckBox").OpenDiv();
}

function closeDivSCACheckBox() {
	$("#divSCACheckBox").CloseDiv();
}

function checkBoxCancel(){
	closeDivSCACheckBox();
	//alert(registrationRecordId+"---"+latestUnsubscribeTime+"---"+cause);
/* 	var now = new Date();
	latestUnsubscribeTime = latestUnsubscribeTime.replace(/-/g,"/");//替换字符，变成标准格式    
	var last = new Date(Date.parse(latestUnsubscribeTime));    
	  if(last<now){
		alert("已过最晚取消时间！！");
		return;
	}   */
	$.confirm("确定要取消此挂号？取消后不可恢复！", function() {
		var cause = $("#checkBoxCancel").val();
		var doctorIds="";
		var registrationRecordIds="";
		$("input[name='checkbox']:checkbox").each(function(){ 
			var $this = $(this);
			var unsubscribeType = $this.attr("unsubscribeType");
			var isGuide = $this.attr("isGuide");
			if ($this.prop("checked") && unsubscribeType ==1 && isGuide == 1){ //符合取消条件的
				doctorIds += $this.attr('value')+','; 
				registrationRecordIds += $this.attr('registrationRecordId')+','; 
			};
		}); 
		//console.log("doctorIds:"+doctorIds);
		//console.log("registrationRecordIds:"+doctorIds);
		
		$.get(ctx+"/regrecord/checkBoxCancel",{'doctorIds':doctorIds,'registrationRecordIds':registrationRecordIds,'cause':cause}, function(json) {
			var msg = "";
			if (json.message) {
				msg = json.message;
			}
			$.alert(msg, function() {
				if("${vip}"!=""){
					var vip = "${vip}";
					window.location.href = "${ctx}/regrecord/recordlist?vip="+vip+"&flag=1";;
				}else if("${scene}"!=""){
					var scene = "${scene}";
					//alert(json.results);
					window.location.href = "${ctx}/regrecord/recordlist?scene="+scene+"&flag=1";
				}else{
					window.location.href = "${ctx}/regrecord/recordlist?flag=1";
				} 
				//window.location.reload();
			});
		}, "json");  
		
	});
	
}



</script>
</body>
</html>
