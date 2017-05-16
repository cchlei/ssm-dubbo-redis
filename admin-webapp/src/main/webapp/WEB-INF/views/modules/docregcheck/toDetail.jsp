<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>查看</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">查看</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/docregcheck/editeAgain" method="POST">
	    <c:if test="${userDoctor!=null}">
			<input id="userId" name="userId" type="hidden" value="${userDoctor.userId}"/>
	    </c:if>
	    <input id="areaId" name="areaId" type="hidden" value="${userDoctor.areaId}"/>
	    <input id="standDeptId" name="standDeptId" type="hidden" value="${userDoctor.standDeptId}"/>
	    <input id="gradeText" name="gradeText" type="hidden" value="${userDoctor.gradeText}"/>
	    <input id="areaName" name="areaName" type="hidden" value="${userDoctor.areaName}"/>
	    <input id="standDeptName" name="standDeptName" type="hidden" value="${userDoctor.standDeptName}"/>
	    <input id="auditStatus" name="auditStatus" type="hidden" value="${userDoctor.auditStatus}"/>
	    <input id="doctorHeadImage" name="doctorHeadImage" type="hidden" value="${userDoctor.doctorHeadImage}"/>
	    <input id="introduce1" name="introduce1" value="${userDoctor.introduce}" type="hidden"/>
	    <input id="specialtyDesc1" name="specialtyDesc1" value="${userDoctor.specialtyDesc}" type="hidden"/>
	    <input id="imId" name="imId" type="hidden" value="${imId}"/>
	    <input id="phoneId" name="phoneId" type="hidden" value="${phoneId}"/>
	    <input id="videoId" name="videoId" type="hidden" value="${videoId}"/>
	    <input id="imPId" name="imPId" type="hidden" value="${imPId}"/>
	    <input id="phonePId" name="phonePId" type="hidden" value="${phonePId}"/>
	    <input id="videoPId" name="videoPId" type="hidden" value="${videoPId}"/>
		<div class="form-group">
			<label for="areaName" class="col-sm-2 control-label">姓&nbsp; &nbsp;名 ：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="name" name="name" placeholder="姓名" datatype="*2-100"
					nullmsg="请输入姓名！" errormsg="姓名至少2个字符,最多100个字符！" value="${userDoctor.name}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" >
			<label for="doctorCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;地 &nbsp;区：</label>
			<div class="col-sm-5">
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
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;医&nbsp;院：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="hospName" name="hospName" placeholder="所在医院" datatype="*4-100"
					nullmsg="请输入所在医院名称！" errormsg="所在医院至少4个字符！" value="${userDoctor.hospName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">所&nbsp;在&nbsp;科&nbsp;室：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="deptName" name="deptName" placeholder="所在科室" datatype="*2-100"
					nullmsg="请输入所在科室名称！" errormsg="所在科室至少2个字符！" value="${userDoctor.deptName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">标&nbsp;准&nbsp;科&nbsp;室：</label>
			<div class="col-sm-4">
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
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="doctorGrade" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;职 &nbsp;称：</label>
			<div class="col-sm-5">
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
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">医 &nbsp;院 &nbsp;电 &nbsp;话：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="telExt" name="telExt" placeholder="医院电话" datatype="*1-30"
					nullmsg="请输入医院电话！" errormsg="医院电话至少1个字符,最多30个字符！" value="${userDoctor.telExt}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">上&nbsp;传&nbsp;图&nbsp;片：</label>
			<div class="col-sm-5" id="img_div">
				<c:forEach items="${fn:split(userDoctor.activeImgUrl, ',')}" var="imgUrl" varStatus="status1">
					<img src="${imgUrl}" id="img" width="200px" height="200px"  />
				</c:forEach>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="imageType" class="col-sm-2 control-label">图&nbsp;片&nbsp;类&nbsp;型</label>
			<div class="col-sm-5">
			<select class="mSelect"  class="mSelect"  id="imageType" name="imageType">
			    <c:if test="${userDoctor.imageType==1}">
				    <option value="1" selected="selected">手持医院工作证</option>
				    <option value="2">手持医院资格证</option>
			    </c:if>
			    <c:if test="${userDoctor.imageType==2}">
				    <option value="1">手持医院工作证</option>
				    <option value="2" selected="selected">手持医院资格证</option>
			    </c:if>
			</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">当&nbsp;前&nbsp;状&nbsp;态：</label>
			<div class="col-sm-5">
				<span style="font-size:20px;font-weight:bold;">审核通过</span>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">医生头像图片：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file"/><br/><input type="button" value="上传" onclick="upimg();" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><a href="${userDoctor.doctorHeadImage}" target="_blank"><img src="${ctx}/showImage/showImg?path=${userDoctor.doctorHeadImage}" id="img2" width="100px" height="100px"  /></a>
		</div>
		
		<div class="form-group">
			<label for="introduce" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;简 &nbsp;介：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="introduce" name="introduce" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength1">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="specialtyDesc" class="col-sm-2 control-label">医 &nbsp;生 &nbsp;特 &nbsp;长：</label>
			<div class="col-sm-5">
				<textarea class="form-control" id="specialtyDesc" name="specialtyDesc" clos="15" rows="10"></textarea>
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength2">最多输入1000个字符</div>
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">服&nbsp;务&nbsp;开&nbsp;关：</label>
			<div class="col-sm-5">
					图文咨询：
					<span id="imChargeSpan"></span>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="changeStat('${userDoctor.userId}','${userDoctor.name}','imChargeConsultation')">切换</button>
					<input type="hidden" id="imStatus" value="${imStatus}">
					<br/>
					电话咨询：
					<span id="phoneChargeSpan"></span>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="changeStat('${userDoctor.userId}','${userDoctor.name}','phoneChargeConsultation')">切换</button>
					<input type="hidden" id="phoneStatus" value="${phoneStatus}">
					<br/>
					视频咨询：
					<span id="videoChargeSpan"></span>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary" onclick="changeStat('${userDoctor.userId}','${userDoctor.name}','videoChargeConsultation')">切换</button>
					<input type="hidden" id="videoStatus" value="${videoStatus}">
					<br/>
					
					<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
			
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">费&nbsp;用&nbsp;价&nbsp;格：</label>
			<div class="col-sm-5">
				<label>图文咨询：</label>
				<select class="mSelect"  id="imPrice" name="imPrice">
					<option value="0">请选择</option>
					
						<c:forEach items="${imPrices}" var="imPricef" varStatus="status">
						<c:if test="${imPrice==imPricef}">
				    	<option value="${imPricef}" selected="selected">${imPrice}</option>
				     	</c:if>
				     	<c:if test="${imPrice!=imPricef}">
				    	<option value="${imPricef}">${imPricef}</option>
				     	</c:if>
						 	
						</c:forEach>
				</select>元/
					<!-- 图文咨询：<input type="text" id="imPrice" name="imPrice" style="width:50px;" value="${imPrice}">元/次<br/> -->
					<br></br>
					<label>电话咨询：</label>
						<select class="mSelect"  id="phone1Price" name="phone1Price">
							<option value="">请选择</option>
							
								<c:forEach items="${phone1Prices}" var="phonePrice" varStatus="status">
									<c:if test="${phone1Price==phonePrice}">
							    	<option value="${phonePrice}" selected="selected">${phone1Price}</option>
							     	</c:if>
							     	<c:if test="${phone1Price!=phonePrice}">
							    	<option value="${phonePrice}">${phonePrice}</option>
							     	</c:if>
								    	
								</c:forEach>
						</select>元/
					<!-- 电话咨询：<input type="text" style="width:50px;" id="phone1Price" name="phone1Price" value="${phone1Price}">元/ -->
					<c:if test="${phone1PriceTime=='' || phone1PriceTime==null}">
					<input type="text" style="width:50px;" id="phone1PriceTime" name="phone1PriceTime" value="10">分钟<br/>
					</c:if>
					<c:if test="${phone1PriceTime!='' && phone1PriceTime!=null}">
					<input type="text" style="width:50px;" id="phone1PriceTime" name="phone1PriceTime" value="${phone1PriceTime}">分钟<br/>
					</c:if>
					
					
					
					<label>视频咨询：</label>
						<select class="mSelect"  id="videoPrice" name="videoPrice">
							<option value="">请选择</option>
							
								<c:forEach items="${videoPrices}" var="videoPricef" varStatus="status">
						
									<c:if test="${videoPrice==videoPricef}">
							    	<option value="${videoPricef}" selected="selected">${videoPrice}</option>
							     	</c:if>
							     	<c:if test="${videoPrice!=videoPricef}">
							    		<option value="${videoPricef}">${videoPricef}</option>
							     	</c:if>
								
								
								</c:forEach>
						</select>元/
					<!-- 视频咨询：<input type="text" style="width:50px;" id="videoPrice" name="videoPrice" value="${videoPrice}">元/ -->
					<c:if test="${videoPriceTime=='' || videoPriceTime==null}">
					<input type="text"  style="width:50px;" id="videoPriceTime" name="videoPriceTime" value="15">分钟<br/>
					</c:if>
					<c:if test="${videoPriceTime!='' && videoPriceTime!=null}">
					<input type="text"  style="width:50px;" id="videoPriceTime" name="videoPriceTime" value="${videoPriceTime}">分钟<br/>
					</c:if>
					<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
			
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">收&nbsp;费&nbsp;比&nbsp;例：</label>
			<div class="col-sm-5">
			        <c:if test="${im=='' || im==null}">图文咨询：<input type="text" id="im" name="im" value="100%"></c:if>
					<c:if test="${im!='' && im!=null}">图文咨询：<input type="text" id="im" name="im" value="${im}"></c:if>
					<br/>
					<c:if test="${phone1=='' || phone1==null}">电话咨询：<input type="text" id="phone1" name="phone1" value="100%"></c:if>
					<c:if test="${phone1!='' && phone1!=null}">电话咨询：<input type="text" id="phone1" name="phone1" value="${phone1}"></c:if>
					<br/>
					<c:if test="${video=='' || video==null}">图文咨询：视频咨询：<input type="text" id="video" name="video" value="100%"></c:if>
					<c:if test="${video!='' && video!=null}">视频咨询：<input type="text" id="video" name="video" value="${video}"></c:if>
					<br/>
					<div class="col-sm-5 help-block Validform_checktip">请按照20%的格式填写！</div>
			<br/><br/><br/>
				<a href="${ctx}/timeslice/timeSliceList?doctorName=${userDoctor.name}">查看医生服务信息</a><br/>
				<a href="${ctx}/accountDetails/cardAndBillList?userId=${userDoctor.userId}">查看医生银行卡</a><br/>
				<a href="${ctx}/accountDetails/accountAmountList?uid=${userDoctor.userId}">查看医生账户金额</a><br/>
				<a href="${ctx}/payment/paymentOrderList?userId=${userDoctor.userId}">查看医生所有订单</a><br/>
				<a href="${ctx}/docregcheck/toRawData?userId=${userDoctor.userId}">查看医生审核时所填信息</a><br/>
			</div>
			
		</div>
		
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" id="refuse" class="btn btn-primary" onclick="refuseBut()">审核拒绝</button>
				&nbsp;&nbsp;
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>
<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {
		
		//医生服务开关初始值
		var imStatus = "${imStatus}";
		var phoneStatus = "${phoneStatus}";
		var videoStatus = "${videoStatus}";
		if(imStatus==0){
			$("#imChargeSpan").html("关闭");
		}else{
			$("#imChargeSpan").html("开启");
		}
		if(phoneStatus==0){
			$("#phoneChargeSpan").html("关闭");
		}else{
			$("#phoneChargeSpan").html("开启");
		}
		if(videoStatus==0){
			$("#videoChargeSpan").html("关闭");
		}else{
			$("#videoChargeSpan").html("开启");
		}
		
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
		
		//给医生简介内容赋值
		var introduce1 = $("#introduce1").val();
		$("#introduce").val(introduce1);
		//给医生特长内容赋值
		var specialtyDesc1 = $("#specialtyDesc1").val();
		$("#specialtyDesc").val(specialtyDesc1);
		
		//控制描述信息输入字数
		$("#introduce").keyup(function(){
			 var a=1000-$("#introduce").val().length;
			 $("#nLength1").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过1000");
			 }
		 });
		
		//控制描述信息输入字数
		$("#specialtyDesc").keyup(function(){
			 var a=500-$("#specialtyDesc").val().length;
			 $("#nLength2").html("您还可以输入"+a+"个字符");
			 if(a<=0){
			   alert("字数不能超过500");
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
				
				 var imPrice = $("#imPrice").val();
				//var re= /^[1-9]/d*/[./]*d*|0/./d*[1-9]/d*$/;
				var re= /^(?:[1-9][0-9]*(?:\.[0-9]+)?|0\.[0-9]+)$/;
				if(imPrice!="" && !re.test(imPrice)){
					alert("图文咨询服务价格格式填写错误，请填写有效数字！");
					return false;
				}
				var phonePrice = $("#phone1Price").val();
				var re= /^(?:[1-9][0-9]*(?:\.[0-9]+)?|0\.[0-9]+)$/;
				if(phonePrice!="" && !re.test(phonePrice)){
					alert("电话咨询服务价格格式填写错误，请填写有效数字！");
					return false;
				}
				var videoPrice = $("#videoPrice").val();
				var re= /^(?:[1-9][0-9]*(?:\.[0-9]+)?|0\.[0-9]+)$/;
				if(videoPrice!="" && !re.test(videoPrice)){
					alert("视频咨询服务价格格式填写错误，请填写有效数字！");
					return false;
				}
				
				var im = $("#im").val();
				var re= /^[0-9]{1,3}[%]$/;//是否是20%这种格式
				if(!re.test(im)){
					alert("图文咨询收费比例格式填写错误，请按照'20%'的格式填写！");
					return false;
				}
				var phone = $("#phone1").val();
				var re= /^[0-9]{1,3}[%]$/;//是否是20%这种格式
				if(!re.test(phone)){
					alert("电话咨询收费比例格式填写错误，请按照'20%'的格式填写！");
					return false;
				}
				var video = $("#video").val();
				var re= /^[0-9]{1,3}[%]$/;//是否是20%这种格式
				if(!re.test(video)){
					alert("视频咨询收费比例格式填写错误，请按照'20%'的格式填写！");
					return false;
				}
				
				var phone1PriceTime = $("#phone1PriceTime").val();
				if(phone1PriceTime=='0'){
					alert("电话咨询时间不可以为0！");
					return false;
				}
				
				var videoPriceTime = $("#videoPriceTime").val();
				if(videoPriceTime=='0'){
					alert("视频咨询时间不可以为0！");
					return false;
				}
				
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						window.location.href = '${ctx}/docregcheck/checkedDoctorList';
					});
				} else {
						errorValidate('msg-info', json.message + ',' + "");
				}
				$('#fat-btn').button('reset');
			}
		});

	});
	
	//拒绝
	function refuseBut(){
		var url = ctx+"/docregcheck/refuseAgain";
		var userId = $("#userId").val();
		$.post(url,{'auditStatus':0,'userId':userId},function (data){
			$.alert(data.message, function(){
				window.location.href = '${ctx}/docregcheck/checkedDoctorList';
			});
		});
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
    
    //图片上传
    function upimg(){
		var fileElement = "";
		var img = "";
		var hiddenUrlId="";
		    
    	fileElement="file";
		img="#img2";
		hiddenUrlId="#doctorHeadImage";
		    
		
 		$.ajaxFileUpload
          (
              {
                  url: ctx+'/docregcheck/upload', //用于文件上传的服务器端请求地址
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
    
    function changeStat(userId,userName,serviceName){
    	var imStatus = $("#imStatus").val();
    	var phoneStatus = $("#phoneStatus").val();
    	var videoStatus = $("#videoStatus").val();
    	var color = "black";
    	//转换医生服务开关启用关闭状态
    	if("imChargeConsultation"==serviceName){
    			status=imStatus;
	    	}else if("phoneChargeConsultation"==serviceName){
	    		status=phoneStatus;
	    	}else if("videoChargeConsultation"==serviceName){
	    		status=videoStatus;
	    	} 
    	var image = "";
    	if(status==0){
    		status=1;
    		image = "开启";
    		color = "black";
    	}else if(status==1){
    		status=0;
    		image = "关闭";
    		color = "red";
    	} 
    	url="${ctx}/docregcheck/change?userId="+userId+"&userName="+userName+"&status="+status+"&serviceName="+serviceName;
    	 $.ajax({  
 			type : "post",  
 			url : url,  
 			async : false,  
 			asyncBoolean:false,
 			success : function(data){  
 				if("imChargeConsultation"==serviceName){
 		    		$("#imChargeSpan").html(image);
 		    		$("#imChargeSpan").css("color",color);
 		    		$("#imStatus").val(status);
 		    	}else if("phoneChargeConsultation"==serviceName){
 		    		$("#phoneChargeSpan").html(image);
 		    		$("#phoneChargeSpan").css("color",color);
 		    		$("#phoneStatus").val(status);
 		    	}else if("videoChargeConsultation"==serviceName){
 		    		$("#videoChargeSpan").html(image);
 		    		$("#videoChargeSpan").css("color",color);
 		    		$("#videoStatus").val(status);
 		    	} 
 			}  
 	    }); 
    	
    }
	

</script>
</html>