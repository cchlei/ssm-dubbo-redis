<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>行业项目预约信息</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">行业项目预约信息</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/register/saveIndustry" method="POST">
	    <input id="recordId" name="recordId" type="hidden" value="${recordId}"/>
		<input id="edit" name="edit" type="hidden" value="${edit}"/>
		<div class="form-group">
			<label for="incName" class="col-sm-2 control-label">企&nbsp; &nbsp;业&nbsp; &nbsp;名 &nbsp; &nbsp;称：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="incName" name="incName" placeholder="企业名称" datatype="*4-50"
					nullmsg="请输入企业名称！" errormsg="企业名称至少4个字符,最多100个字符！" value="${industry.incName}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="ikangCard" class="col-sm-2 control-label">爱&nbsp;康&nbsp;卡&nbsp;卡&nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="ikangCard" name="ikangCard" placeholder="爱康卡卡号" datatype="*6-50"
					nullmsg="请输入爱康卡卡号！" errormsg="爱康卡卡号至少6个字符！" value="${industry.ikangCard}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="owner" class="col-sm-2 control-label">卡&nbsp; &nbsp;主：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="owner" name="owner" placeholder="卡主" datatype="*2-20"
					nullmsg="请输入卡主！" errormsg="卡主至少2个字符！" value="${industry.owner}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<!-- 
		<div class="form-group">
			<label for="serviceType" class="col-sm-2 control-label">服&nbsp;务 &nbsp;类&nbsp;型：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="serviceType" name="serviceType" placeholder="服务类型" datatype="*2-50"
					nullmsg="请输入服务类型！" errormsg="服务类型至少2个字符！" value="${industry.serviceType}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		 -->
		<div class="form-group">
			<label for="serviceType" class="col-sm-2 control-label">服&nbsp;务&nbsp;类&nbsp;型： </label>
			<div class="col-sm-5">
				<select class="mSelect"  class="mSelect"  id="serviceType" name="serviceType">
					<c:choose>
						<c:when test="${industry.serviceType==1 || industry.serviceType==null}">
							<option value="1" selected="selected">挂号</option>
							<option value="2">挂号+导诊</option>
							<option value="3">老人陪护</option>
							<option value="4">挂号+导诊（上门取卡）</option>
						</c:when>
					    <c:when test="${industry.serviceType==2}">
							<option value="1">挂号</option>
							<option value="2" selected="selected">挂号+导诊</option>
							<option value="3">老人陪护</option>
							<option value="4">挂号+导诊（上门取卡）</option>
						</c:when>
						<c:when test="${industry.serviceType==3}">
							<option value="1">挂号</option>
							<option value="2">挂号+导诊</option>
							<option value="3" selected="selected">老人陪护</option>
							<option value="4">挂号+导诊（上门取卡）</option>
						</c:when>
						<c:when test="${industry.serviceType==4}">
							<option value="1">挂号</option>
							<option value="2">挂号+导诊</option>
							<option value="3">老人陪护</option>
							<option value="4" selected="selected">挂号+导诊（上门取卡）</option>
						</c:when>
						<c:otherwise>
							<option value="1">挂号</option>
							<option value="2">挂号+导诊</option>
							<option value="3">老人陪护</option>
							<option value="4">挂号+导诊（上门取卡）</option>
							<option value="${industry.serviceType}" selected="selected">${industry.serviceType}</option>
						</c:otherwise>  
					</c:choose> 
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="projectNum" class="col-sm-2 control-label">项&nbsp;目&nbsp;编&nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="projectNum" name="projectNum" placeholder="项目编号" datatype="*2-50"
					nullmsg="请输入项目编号！" errormsg="项目编号至少2个字符！" value="${industry.projectNum}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="relationCard" class="col-sm-2 control-label">关&nbsp;联&nbsp;卡&nbsp;号：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="relationCard" name="relationCard" placeholder="关联卡卡号" datatype="*2-50"
					nullmsg="请输关联卡卡号！" errormsg="关联卡卡号至少2个字符！" value="${industry.relationCard}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="customerName" class="col-sm-2 control-label">导&nbsp;诊&nbsp;人&nbsp;姓&nbsp;名：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="customerName" name="customerName" placeholder="导诊人姓名" value="${industry.customerName}"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="customerPhone" class="col-sm-2 control-label">导&nbsp;诊&nbsp;人&nbsp;电&nbsp;话：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="customerPhone" name="customerPhone" placeholder="导诊人电话" value="${industry.customerPhone}"/>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<c:if test="${message==null}">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				</c:if>
				&nbsp;&nbsp;
				<c:if test="${edit!=null}">
					<c:if test="${message==null}">
						<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
					</c:if>
					<c:if test="${message!=null}">
						<button type="button" class="btn" onclick="history.go(-2)">返 回</button>
					</c:if>
				</c:if>
				<c:if test="${edit==null}">
				<button type="button" class="btn" onclick="history.go(-4)">返 回</button>
				</c:if>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
		
		<div >
			<h4 ></br></br>
				<c:if test="${message!=null}">${message}</c:if>
			</h4>
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
					errorValidate("msg-info", '');
					if (json.data.title) {
						errorValidate('title', json.message + ',' + json.data.title);
					}
					
				}
				$('#fat-btn').button('reset');
			}
		});

	});
</script>
</html>