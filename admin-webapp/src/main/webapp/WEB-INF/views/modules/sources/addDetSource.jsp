<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>新增一条号源记录</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">新增号源记录</a></li>
	</ul>
	<br />
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/sourcesDet/saveNewDay" method="POST">
	<input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
	<input id="doctorName" name="doctorName" type="hidden" value="${doctorName}"/>
	<input id="ifexpenseAllow" name="ifexpenseAllow" type="hidden"/>
	
	<c:forEach items="${dicList}" var="dic" varStatus="status">
		<c:if test="${status.count==1}">
			<input id="resourceTpyeText" name="resourceTpyeText" type="hidden" value="${dic.dictName}"/>
		
		</c:if>
	</c:forEach>
	<input id="subflag" name="subflag" type="hidden" value="0"/>
	<input id="subflag2" name="subflag2" type="hidden" value="0"/>
	<input id="subflag3" name="subflag2" type="hidden" value="0"/>
		<div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">是否分时段预约挂号：</label>
			<div class="col-sm-5">
			<select class="sSelect" id="isTimespan" name="isTimespan" onchange="ifShow(this.value);">
				<option value="1">是</option>
				<option value="2" selected="selected">否</option>
			</select>
			<%-- <input id="isTimespan" name="isTimespan" type="hidden" value="${isTimespan}"/>
				<c:if test="${isTimespan==1}">是</c:if>
				<c:if test="${isTimespan==2}">否</c:if> --%>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
	    <div class="form-group">
			<label for="resourceDate" class="col-sm-2 control-label">号源所在日期：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="resourceDate" id="resourceDate" onClick="WdatePicker()">
				<!-- <input id="d424" class="Wdate" type="text" name="resourceDate" id="resourceDate"  onfocus="WdatePicker({dateFmt:'yyyy-M-d H:mm:ss'})"/> -->
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
		</div>
		
		<!-- <div class="form-group">
			<label for="isTimespan" class="col-sm-2 control-label">是否分时段预约挂号：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="isTimespan" name="isTimespan"  onchange="ifShow(this.value);">
				 <option value="1">是</option>
				 <option value="2" selected="selected">否</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div> -->
		
		<div class="form-group">
			<label for="tagName" class="col-sm-2 control-label">挂&nbsp;号&nbsp;类 &nbsp;型：</label>
			<div class="col-sm-5">
				<select class="mSelect"  class="mSelect"  name="resourceTpye" id="resourceTpye" onchange="setValue(this);">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="expense" class="col-sm-2 control-label">挂&nbsp;号&nbsp;费：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="expense" name="expense" placeholder="挂号费" datatype="*1-10"
					nullmsg="请输入挂号费！" errormsg="挂号费至少1个字符,最多10个字符！">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessageexpense" style="color:red;margin-left:180px;display:none"></span>
			
		</div>
		
		<div class="form-group">
			<label for="retrieveAddress" class="col-sm-2 control-label">取号地点：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="retrieveAddress" name="retrieveAddress" placeholder="取号地点" datatype="*2-100"
					nullmsg="请输入取号地点！" errormsg="取号地点至少2个字符,最多100个字符！">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="ampm" class="col-sm-2 control-label">上午还是下午：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="ampm" name="ampm">
				 <option value="1" selected="selected">上午</option>
				 <option value="2">下午</option>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" id="start" style="display:none">
			<label for="timespanStart" class="col-sm-2 control-label">开始时段：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="timespanStart" name="timespanStart" placeholder="开始时段" datatype="*0-5"
					nullmsg="请输入开始时段！" errormsg="格式不正确！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group" id="end" style="display:none">
			<label for="timespanEnd" class="col-sm-2 control-label">结束时段：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="timespanEnd" name="timespanEnd" placeholder="结束时段" datatype="*0-5"
					nullmsg="请输入结束时段！" errormsg="格式不正确！" >
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="resourceNum" class="col-sm-2 control-label">号源数：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="resourceNum" name="resourceNum" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="beginRegisterTime" class="col-sm-2 control-label">预约开始时间（小时）：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="beginRegisterTime" name="beginRegisterTime" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="overRegisterTime" class="col-sm-2 control-label">预约结束时间（小时）：</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="overRegisterTime" name="overRegisterTime" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！">
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
		var resourceDays="${resourceDays}";
	$(document).ready(function() {
		//验证时间段开始时间格式
		//var a = $("#resourceTpyeText").val();
		//var isTimespan = '${isTimespan}';
		//alert(isTimespan);
		//ifShow(isTimespan);
		/* if(isTimespan==1){
			//验证时间段开始时间格式
			init();
		}	 */
		initDate2();
		//验证号源所在日期与数据库现有的是否重复
		$("input[name='resourceDate']").blur(function (){
			var url = ctx+"/sourcesDet/checkDate";
			var resourceDate = $(this).val();
			var doctorId = $("#doctorId").val();
			var departmentId = "${departmentId}";
		    if(resourceDate!=""){
				/* $('#wmessage').text("请选择号源所在日期！");
				document.getElementById("wmessage").style.display="block";
				//alert("请选择号源所在日期！");
				$("#subflag3").val("1");
				return; */
				$.post(url,{'resourceDate':resourceDate,'doctorId':doctorId,'departmentId':departmentId},function (data){
					if(data.success){
						if(data.message==1){
							$("#subflag3").val("1");
							$('#wmessage').text("该医生已有这一天的号源记录，请在这一天的号源详情中追加！");
							document.getElementById("wmessage").style.display="block";
							//alert("该医生已有这一天的号源记录，请在这一天的号源详情中追加！");
						}else if(data.message==0){
							$("#subflag3").val("0");
							document.getElementById("wmessage").style.display="none";
							//$('#wmessage').text("可以添加！");
							//alert("可以添加！");
						}
					}
				});
		    } 
		});
		
		//验证挂号费
		$("input[name='expense']").blur(function (){
	    	if(this.value=="" || this.value=="0"){
	    		$(this).removeClass("focus");
				return;
			}
	    	//var isNum = /^\d+(\.\d+)?$/
	    	var isMoney = /^[\d]{1,7}(.[\d]{1,2})?$/;
	    	if(!isMoney.test(this.value)) {
	    		  $("#ifexpenseAllow").val("1");
	        	  $('#wmessageexpense').text("挂号费格式不正确！");
				  document.getElementById("wmessageexpense").style.display="block";
		        }else{
	        	  $("#ifexpenseAllow").val("0");
		          document.getElementById("wmessageexpense").style.display="none";

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
				var isTimespan = '${isTimespan}';
				var resourceDate = $("#resourceDate").val();
				if(resourceDate==""){
						$('#wmessage').text("请选择号源所在日期！");
						document.getElementById("wmessage").style.display="block";
						//alert("请选择号源所在日期！");
						$("#subflag3").val("1");
						return false;
					}  
				if(isTimespan==1){
					if($("#subflag2").val()!=0){
						alert("时间段格式不正确！");
						return false;
					}
				}
				
				if($("#subflag").val()!=0){
					alert("预约时间不正确！");
					return false;
				}
				
				if($("#subflag3").val()!=0){
					alert("请重新选择号源所在日期！");
					return false;
				}
				
				if($("#ifexpenseAllow").val()=="1"){
					alert("挂号费格式不正确！");
					return false;
				}
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						var doctorId = $("#doctorId").val();
						var hospId = "${hospId}";
						var doctorName = $("#doctorName").val();
						var ctx = "${ctx}";
						var departmentId = "${departmentId}";
						var url = ctx+"/sourcesDet/list?doctorId="+doctorId+"&doctorName="+doctorName+"&departmentId="+departmentId+"&hospId="+hospId;
						window.location.href=url;
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
	
	function setValue(obj){
		//给挂号类型名称赋值
		var resourceTpyeText = obj.options[obj.selectedIndex].text;
		$("#resourceTpyeText").val(resourceTpyeText);
	}
	
	function ifShow(value){
		if(value==2){
			document.getElementById("start").style.display="none";
			document.getElementById("end").style.display="none";
		}else if(value==1){
			document.getElementById("start").style.display="block";
			document.getElementById("end").style.display="block";
		}
		init();
	}
	
	//分时段格式验证格式是否正确
	function init(){
		$("input[name='timespanStart']").blur(function (){
		var a = $(this).val();
		var reg = /^(\d{1,2}):(\d{1,2})$/;     
        var r = a.match(reg);     
        if(r==null) {   
        	$(this).addClass("focus");  
			$("#subflag2").val("1");
            alert("开始时段格式不正确！");   
   		 }else{
			$(this).removeClass("focus");
			$("#subflag2").val("0");
		}
		});
	}
		
	function initDate2(){
		
		//验证预约开始时间不能超过14*24小时
		$("input[name='beginRegisterTime']").blur(function (){
			var a = $(this).val();
			if(parseInt(a)>(resourceDays*24)){
				//alert($(this).val());
				$(this).addClass("focus");  
				$("#subflag").val("1");
				alert("预约开始时间不能超过"+resourceDays+"*24小时！");
			}else{
				$(this).removeClass("focus");
				$("#subflag").val("0");
			}
		});
		//验证预约结束时间不能大于预约开始时间
		$("input[name='overRegisterTime']").blur(function (){
			var a = $(this).val();
			var b = $("#beginRegisterTime").val();
			if(parseInt(a)>=parseInt(b)){
				$(this).addClass("focus");  
				$("#subflag").val("1");
				alert("预约结束时间不能超过或等于预约开始时间！");
			}else{
				$(this).removeClass("focus");
				$("#subflag").val("0");
			}
		});
	
	//验证时间段结束时间格式
	$("input[name='timespanEnd']").blur(function (){
		var a = $(this).val();
		var reg = /^(\d{1,2}):(\d{1,2})$/;     
        var r = a.match(reg);     
        if(r==null) {   
        	$(this).addClass("focus");  
			$("#subflag2").val("1");
            alert("结束时段格式不正确！");   
   		 }else{
			$(this).removeClass("focus");
			$("#subflag2").val("0");
		}
	});
	}
</script>
</html>