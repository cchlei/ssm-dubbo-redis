<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
 <title>tree</title>
 <style>
     *{magrin:0;padding:0}
     .step1 li{border-bottom:1px #898989 solid;padding:10px;}
     .step2{display:none;}
     .step2 li{border-bottom:1px #898989 solid;padding:10px;background:#CCFFFF;}
     .Step3 li{border-bottom:1px #898989 solid;padding:20px;background:#FFFFCC;}
 </style>
</head>
<body>
	<c:if test="${redioType == '1'}">
	
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">身体部位</a></li>
	</ul>
	<br />
	<c:if test="${body!=null}">
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tree/update" method="POST">	
	</c:if>
	<c:if test="${body==null}">
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tree/saveTree" method="POST">	
	</c:if>
	  
	  <input id="imgUrl" name="imgUrl" type="hidden" value="${body.img}"/>
	  <input id="redioType" name="redioType" type="hidden" value="${redioType}"/>
	  <input id="id" name="id" type="hidden" value="${body.id}"/>
	  <div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排 &nbsp;序&nbsp;号 &nbsp;：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="sort" name="sort" placeholder="排序号" datatype="*1-11"
					 errormsg="排序号至少1个字符,最多11个字符！" value="${body.sort}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
	    <div class="form-group">
			<label for="img" class="col-sm-2 control-label"><span style="color:red;">*</span>身体图片：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file"/><br/><input type="button" value="上传" onclick="upimg(1);" />  	
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><img src="${ctx}/showImage/showImg?path=${body.img}" id="img" width="100px" height="100px"  />
		</div>
		<div class="form-group">
			<label for="cont" class="col-sm-2 control-label"><span style="color:red;">*</span>描&nbsp; &nbsp;述&nbsp; &nbsp;：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="cont" name="cont" placeholder="身体部位描述" datatype="*2-500"
					nullmsg="请输入描述信息！" errormsg="地区名称至少1个字符,最多500个字符！" value="${body.cont}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
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
	</c:if>
	<c:if test="${redioType == '2'}">
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">疾病描述</a></li>
	</ul>
	<br />
	<c:if test="${disease!=null}">
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tree/update" method="POST">	
	</c:if>
	<c:if test="${disease==null}">
		<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tree/saveTree" method="POST">	
	</c:if>
	  
	  <input id="redioType" name="redioType" type="hidden" value="${redioType}"/>
	  <input id="redioId" name="redioId" type="hidden" value="${redioId}"/>
	  <input id="bodyId" name="bodyId" type="hidden" value="${disease.bodyId}"/>
	  <input id="id" name="id" type="hidden" value="${disease.id}"/>
	  <div class="form-group">
			<label for="sort" class="col-sm-2 control-label">排 &nbsp;序&nbsp;号 &nbsp;：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="sort" name="sort" placeholder="排序号" datatype="*1-11"
					 errormsg="排序号至少1个字符,最多11个字符！" value="${disease.sort}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="cont" class="col-sm-2 control-label"><span style="color:red;">*</span>描&nbsp; &nbsp;述&nbsp; &nbsp;：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="cont" name="cont" placeholder="疾病描述" datatype="*2-500"
					nullmsg="请输入描述信息！" errormsg="地区名称至少1个字符,最多500个字符！" value="${disease.cont}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
			<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
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
	</c:if>
	<c:if test="${redioType == '3' || redioType == '4'}">
		<ul class="nav nav-tabs">
			<li class="active"><a href="javascript:void(0)">导诊描述</a></li>
		</ul>
		<br />
		<c:if test="${guide!=null}">
			<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tree/update" method="POST">	
		</c:if>
		<c:if test="${guide==null}">
			<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/tree/saveTree" method="POST">	
		</c:if>
		  
		  <input id="redioType" name="redioType" type="hidden" value="${redioType}"/>
		  <input id="redioId" name="redioId" type="hidden" value="${redioId}"/>
		  <input id="diseaseId" name="diseaseId" type="hidden" value="${guide.diseaseId}"/>
		  <input id="pid" name="pid" type="hidden" value="${guide.pid}"/>
		  <input id="id" name="id" type="hidden" value="${guide.id}"/>
		  	<div class="form-group">
				<label for="flag" class="col-sm-2 control-label">是 &nbsp;否&nbsp;：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="flag" name="flag" placeholder="是否" datatype="*1-1"
						 errormsg="是否最多1个字符！" value="${guide.flag}" >
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
			</div>
			<div class="form-group">
				<label for="rootId" class="col-sm-2 control-label"><span style="color:red;">*</span>根&nbsp; &nbsp;ID&nbsp; &nbsp;：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="rootId" name="rootId" placeholder="根ID" datatype="*1-20"
						nullmsg="请输入描述信息！" errormsg="地区名称至少1个字符,最多20个字符！" value="${guide.rootId}">
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
				<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
			</div>
			<div class="form-group">
				<label for="isleaf" class="col-sm-2 control-label"><span style="color:red;">*</span>叶&nbsp; &nbsp;子&nbsp; &nbsp;节&nbsp; &nbsp;点&nbsp; &nbsp;：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="isleaf" name="isleaf" placeholder="是否叶子节点" datatype="*1-20"
						nullmsg="请输入描述信息！" errormsg="地区名称至少1个字符,最多20个字符！" value="${guide.isleaf}">
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
				<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
			</div>
			<div class="form-group">
				<label for="cont" class="col-sm-2 control-label"><span style="color:red;">*</span>描&nbsp; &nbsp;述&nbsp; &nbsp;：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="cont" name="cont" placeholder="导诊描述" datatype="*2-500"
						nullmsg="请输入描述信息！" errormsg="导诊描述至少1个字符,最多500个字符！" value="${guide.cont}">
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
				<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
			</div>
			<div class="form-group">
				<label for="depId" class="col-sm-2 control-label"><span style="color:red;">*</span>科&nbsp; &nbsp;室&nbsp; &nbsp;ID&nbsp; &nbsp;：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="depId" name="depId" placeholder="建议的疾病预挂科室" datatype="*1-20"
						nullmsg="请输入描述信息！" errormsg="科室ID至少1个字符,最多20个字符！" value="${guide.depId}">
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
				<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
			</div>
			<div class="form-group">
				<label for="depName" class="col-sm-2 control-label"><span style="color:red;">*</span>科&nbsp; &nbsp;室&nbsp; &nbsp;描&nbsp; &nbsp;述&nbsp; &nbsp;：</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="depName" name="depName" placeholder="科室名称" datatype="*0-500"
						nullmsg="请输入描述信息！" errormsg="科室ID至少1个字符,最多500个字符！" value="${guide.depName}">
				</div>
				<div class="col-sm-5 help-block Validform_checktip"></div>
				<br/><br/><span id="wmessage" style="color:red;margin-left:180px;display:none"></span>
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
	</c:if>
<script>
$(document).ready(function(){
	
	$(".form-input").Validform({
		showAllError : true,
		tiptype : function(msg, o, cssctl){
			if (!o.obj.is("form")){
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
			if($("#cont").val()==""){
				alert("请输入正确的描述！");
				return false;
			}
			$('#fat-btn').button('loading');
		},
		callback : function(json, statusText) {
			if (json.success) {
				$.alert(json.message, function(){
					
					json.message
					window.location.href = '${ctx}/tree/list';
					
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
	//列表图片上传
	function upimg(type){
		var ctx = "${ctx}";
		 var fileElement = "";
		var img = "";
		var hiddenUrlId="";
	    if(type==1){
	    	fileElement="file";
			img="#img";
			hiddenUrlId="#imgUrl";
	    }
	    alert(ctx+'/tree/upload');
		
		$.ajaxFileUpload({
		              url: ctx+'/tree/upload', //用于文件上传的服务器端请求地址
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

</script>
</body>
</html>
