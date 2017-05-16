<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>地区编辑</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">地区编辑</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/area/save" method="POST">
		<input id="imId" name="imId" type="hidden" value="${imId}"/>
	    <input id="phoneId" name="phoneId" type="hidden" value="${phoneId}"/>
	    <input id="videoId" name="videoId" type="hidden" value="${videoId}"/>
	   <%--  <input id="imPId" name="imPId" type="hidden" value="${imPId}"/>
	    <input id="phonePId" name="phonePId" type="hidden" value="${phonePId}"/>
	    <input id="videoPId" name="videoPId" type="hidden" value="${videoPId}"/> --%>
	    <c:if test="${areInfo!=null}">
			<input id="areaId" name="areaId" type="hidden" value="${areInfo.areaId}"/>
	    </c:if>
	    <input id="ifExist" name="ifExist" type="hidden"/>
	    <input id="ifzipCodeTypeAllow" name="ifzipCodeTypeAllow" type="hidden"/>
	    <c:if test="${areaName!=null}">
	    <div class="form-group">
			<label for="tagName" class="col-sm-2 control-label">父&nbsp; &nbsp;地 &nbsp; &nbsp;区：</label>
			<div class="col-sm-5">
				<span>${areaName}</span>
				<input id="parentId" name="parentId" type="hidden" value="${parentId}"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		</c:if>
		<div class="form-group">
			<label for="areaName" class="col-sm-2 control-label">地&nbsp; &nbsp;区&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="areaName" name="areaName" placeholder="地区名称" datatype="*2-100"
					nullmsg="请输入地区名称！" errormsg="地区名称至少2个字符,最多100个字符！" value="${areInfo.areaName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="zipCode" class="col-sm-2 control-label">省&nbsp;市 &nbsp;区&nbsp;邮 &nbsp;政 &nbsp;编 &nbsp;码：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="省市区邮政编码" datatype="*6-100"
					nullmsg="请输入省市区邮政编码！" errormsg="省市区邮政编码至少6个字符！" value="${areInfo.zipCode}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessagezipCode" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排 &nbsp; &nbsp;序：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="sort" name="sort" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${areInfo.sort}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="initial" class="col-sm-2 control-label">首&nbsp;字&nbsp;母：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="initial" name="initial" datatype="*1-1" 
					nullmsg="请输入一个字母！" errormsg="只能输入1个字母！" value="${areInfo.initial}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="isHotArea" class="col-sm-2 control-label">是否是热门地区 ：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="isHotArea" name="isHotArea">
				 <c:if test="${areInfo.isHotArea==2||areInfo.isHotArea==null}">
				 <option value="2" selected="selected">否</option>
				 <option value="1">是</option>
				 </c:if>
				 <c:if test="${areInfo.isHotArea==1}">
				 <option value="1" selected="selected">是</option>
				 <option value="2">否</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="status" class="col-sm-2 control-label">状 &nbsp;&nbsp;态 ：</label>
			<div class="col-sm-4">
				<select class="sSelect"  class="sSelect"  id="status" name="status">
				 <c:if test="${areInfo.status==2}">
				 <option value="2" selected="selected">禁用</option>
				 <option value="1">启用</option>
				 </c:if>
				 <c:if test="${areInfo.status==1||areInfo.status==null}">
				 <option value="2">禁用</option>
				 <option value="1" selected="selected">启用</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<c:if test="${areaName==null}">
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">费&nbsp;用&nbsp;价&nbsp;格：</label>
			<div class="col-sm-5">
			图文咨询：<br/>
					<input id="imPId" name="imPId" type="hidden" value="${imPId}"/>
					<input type="text" id="imPrice" name="imPrice" style="width:50px;" value="${imPrice}">元/次<br/>
			电话咨询：<br/>
			<c:if test="${fn:length(spaPhoneList)==0}">
				<input type="text" style="width:50px;" id="phoneList[0].price" name="phoneList[0].price" value="">元/
				<input type="text" style="width:50px;" id="phoneList[0].minute" name="phoneList[0].minute" value="10">分钟<br/>
				<input type="text" style="width:50px;" id="phoneList[1].price" name="phoneList[1].price" value="">元/
				<input type="text" style="width:50px;" id="phoneList[1].minute" name="phoneList[1].minute" value="10">分钟<br/>
				<input type="text" style="width:50px;" id="phoneList[2].price" name="phoneList[2].price" value="">元/
				<input type="text" style="width:50px;" id="phoneList[2].minute" name="phoneList[2].minute" value="10">分钟<br/>
			</c:if>
			<c:forEach items="${spaPhoneList}" var="setPriceArea" varStatus="status">
				    <input id="phoneList[${status.count-1}].id" name="phoneList[${status.count-1}].id" type="hidden" value="${setPriceArea.id}"/>
					<input type="text" style="width:50px;" id="phoneList[${status.count-1}].price" name="phoneList[${status.count-1}].price" value="${setPriceArea.price}">元/
					<c:if test="${setPriceArea.minute=='' || setPriceArea.minute==null}">
					<input type="text" style="width:50px;" id="phoneList[${status.count-1}].minute" name="phoneList[${status.count-1}].minute" value="10">分钟<br/>
					</c:if>
					<c:if test="${setPriceArea.minute!='' && setPriceArea.minute!=null}">
					<input type="text" style="width:50px;" id="phoneList[${status.count-1}].minute" name="phoneList[${status.count-1}].minute"" value="${setPriceArea.minute}">分钟<br/>
					</c:if>
					<c:if test="${fn:length(spaPhoneList)==1}">
						<input type="text" style="width:50px;" id="phoneList[1].price" name="phoneList[1].price" value="">元/
						<input type="text" style="width:50px;" id="phoneList[1].minute" name="phoneList[1].minute" value="10">分钟<br/>
						<input type="text" style="width:50px;" id="phoneList[2].price" name="phoneList[2].price" value="">元/
						<input type="text" style="width:50px;" id="phoneList[2].minute" name="phoneList[2].minute" value="10">分钟<br/>
					</c:if>
			</c:forEach>
			视频咨询：<br/>
			<c:if test="${fn:length(spaVideoList)==0}">
				<input type="text" style="width:50px;" id="videoList[0].price" name="videoList[0].price" value="">元/
				<input type="text"  style="width:50px;" id="videoList[0].minute" name="videoList[0].minute" value="15">分钟<br/>
				<input type="text" style="width:50px;" id="videoList[1].price" name="videoList[1].price" value="">元/
				<input type="text"  style="width:50px;" id="videoList[1].minute" name="videoList[1].minute" value="15">分钟<br/>
				<input type="text" style="width:50px;" id="videoList[2].price" name="videoList[2].price" value="">元/
				<input type="text"  style="width:50px;" id="videoList[2].minute" name="videoList[2].minute" value="15">分钟<br/>
			</c:if>
			<c:forEach items="${spaVideoList}" var="setPriceArea" varStatus="status">
						<input id="videoList[${status.count-1}].id" name="videoList[${status.count-1}].id" type="hidden" value="${setPriceArea.id}"/>
						<input type="text" style="width:50px;" id="videoList[${status.count-1}].price" name="videoList[${status.count-1}].price" value="${setPriceArea.price}">元/
						<c:if test="${setPriceArea.minute=='' || setPriceArea.minute==null}">
						<input type="text"  style="width:50px;" id="videoList[${status.count-1}].minute" name="videoList[${status.count-1}].minute" value="15">分钟<br/>
						</c:if>
						<c:if test="${setPriceArea.minute!='' && setPriceArea.minute!=null}">
						<input type="text"  style="width:50px;" id="videoList[${status.count-1}].minute" name="videoList[${status.count-1}].minute" value="${setPriceArea.minute}">分钟<br/>
						</c:if>
					<c:if test="${fn:length(spaPhoneList)==1}">
						<input type="text" style="width:50px;" id="videoList[1].price" name="videoList[1].price" value="">元/
						<input type="text"  style="width:50px;" id="videoList[1].minute" name="videoList[1].minute" value="15">分钟<br/>
						<input type="text" style="width:50px;" id="videoList[2].price" name="videoList[2].price" value="">元/
						<input type="text"  style="width:50px;" id="videoList[2].minute" name="videoList[2].minute" value="15">分钟<br/>
					</c:if>
			</c:forEach>
					<%-- 图文咨询：<input type="text" id="imPrice" name="imPrice" style="width:50px;" value="${imPrice}">元/次<br/>
					电话咨询：<input type="text" style="width:50px;" id="phone1Price" name="phone1Price" value="${phone1Price}">元/
					<c:if test="${phone1PriceTime=='' || phone1PriceTime==null}">
					<input type="text" style="width:50px;" id="phone1PriceTime" name="phone1PriceTime" value="10">分钟<br/>
					</c:if>
					<c:if test="${phone1PriceTime!='' && phone1PriceTime!=null}">
					<input type="text" style="width:50px;" id="phone1PriceTime" name="phone1PriceTime" value="${phone1PriceTime}">分钟<br/>
					</c:if>
					视频咨询：<input type="text" style="width:50px;" id="videoPrice" name="videoPrice" value="${videoPrice}">元/
					<c:if test="${videoPriceTime=='' || videoPriceTime==null}">
					<input type="text"  style="width:50px;" id="videoPriceTime" name="videoPriceTime" value="15">分钟<br/>
					</c:if>
					<c:if test="${videoPriceTime!='' && videoPriceTime!=null}">
					<input type="text"  style="width:50px;" id="videoPriceTime" name="videoPriceTime" value="${videoPriceTime}">分钟<br/>
					</c:if> --%>
					<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
			
		</div>
		
		<div class="form-group">
			<label for="hospTel" class="col-sm-2 control-label">收&nbsp;费&nbsp;比&nbsp;例：</label>
			<div class="col-sm-5">
			        <c:if test="${im=='' || im==null}">图文咨询：<input type="text" id="im" name="im" value=""></c:if>
					<c:if test="${im!='' && im!=null}">图文咨询：<input type="text" id="im" name="im" value="${im}"></c:if>
					<br/>
					<c:if test="${phone1=='' || phone1==null}">电话咨询：<input type="text" id="phone1" name="phone1" value=""></c:if>
					<c:if test="${phone1!='' && phone1!=null}">电话咨询：<input type="text" id="phone1" name="phone1" value="${phone1}"></c:if>
					<br/>
					<c:if test="${video=='' || video==null}">图文咨询：视频咨询：<input type="text" id="video" name="video" value=""></c:if>
					<c:if test="${video!='' && video!=null}">视频咨询：<input type="text" id="video" name="video" value="${video}"></c:if>
					<br/>
					<div class="col-sm-5 help-block Validform_checktip">请按照20%的格式填写！</div>
			</div>
			
		</div>
		</c:if>
		
		
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
		var tag = "${areInfo}";
		var ctx = "${ctx}";
		if(tag!=""){
			document.form1.action=ctx+"/area/update"; 
			
		}
		
		//验证同级地区名称有没有重复
		$("input[name='areaName']").blur(function (){
		var url = "${ctx}/area/ifExist";
		var areaName = $("#areaName").val();
		var parentId = "${parentId}";
		 $.post(url,{'parentId':parentId,'areaName':areaName},function (data){
				if(!data.success){
					$('#wmessage').text("该地区名称已存在！");
					document.getElementById("wmessage").style.display="block";
					//alert("该地区名称已存在！");
					$("#ifExist").val("1");
				}else{
					$("#ifExist").val("0");
					document.getElementById("wmessage").style.display="none";
				}
		 });
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
				var ifExist = $("#ifExist").val();
				if(ifExist=="1"){
					alert("该地区名称已存在！");
					return false;
				}
				if(ifzipCodeTypeAllow=="1"){
					alert("邮政编码格式不正确！");
					return false;
				}
				
				/* var imPrice = $("#imPrice").val();
				var re=/^(?:[1-9][0-9]*(?:\.[0-9]+)?|0\.[0-9]+)$/;
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
				} */
				if(!parentId){
					var im = $("#im").val();
					var re= /^[0-9]{1,3}[%]$/;//是否是20%这种格式
					if(im!="" && !re.test(im)){
						alert("图文咨询收费比例格式填写错误，请按照'20%'的格式填写！");
						return false;
					}
					var phone = $("#phone1").val();
					var re= /^[0-9]{1,3}[%]$/;//是否是20%这种格式
					if(phone!="" && !re.test(phone)){
						alert("电话咨询收费比例格式填写错误，请按照'20%'的格式填写！");
						return false;
					}
					var video = $("#video").val();
					var re= /^[0-9]{1,3}[%]$/;//是否是20%这种格式
					if(video!="" && !re.test(video)){
						alert("视频咨询收费比例格式填写错误，请按照'20%'的格式填写！");
						return false;
					}
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						var ppId = "${areInfo.parentId}";
						if(ppId==""){
							ppId = "${parentId}";
						}
						var ppName = "${areaName}";
						window.location.href = '${ctx}/area/list?parentId='+ppId+'&areaName='+ppName;
					});
				} else {
						errorValidate('msg-info', json.message + ',' + "");
				}
				$('#fat-btn').button('reset');
			}
		});

	});
</script>
</html>