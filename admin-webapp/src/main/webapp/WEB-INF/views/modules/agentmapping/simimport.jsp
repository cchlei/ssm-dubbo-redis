<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>统计管理</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">模拟数据生成</a></li>
	</ul>
	<br/>
		
		 
	<form name="form" class="form-horizontal form-input" role="form" action="${ctx}/import/simimport" method="GET">

		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">开&nbsp;
				&nbsp;始&nbsp; &nbsp;日 &nbsp; &nbsp;期：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="begindate" id="begindate"
					style="width: 120px;" nullmsg="请输入开始时间！" value=""
					onClick="WdatePicker({maxDate:'#F{$dp.$D(\'enddate\')}'})">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>

		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">结&nbsp;
				&nbsp;束&nbsp; &nbsp;日 &nbsp; &nbsp;期：</label>
			<div class="col-sm-5">
				<input class="Wdate" type="text" name="enddate" id="enddate"  style="width:120px;" nullmsg="请输入结束时间！" value="" onClick="WdatePicker({minDate:'#F{$dp.$D(\'begindate\')}'})">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">数&nbsp;据&nbsp;量&nbsp;：</label>
			<div class="col-sm-5">
				<input  type="text" name="num" nullmsg="请输入数据量！" id="num"  style="width:50px;">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在导入...">导入</button>&nbsp;&nbsp;&nbsp;
			    <button type="button" id="fat-btn2" class="btn btn-primary" data-loading-text="正在刪除..." >刪除</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
			    
	</form>
		
		
		
<script type="text/javascript">
		var ctx = "${ctx}";
		
	 $(document).ready(function() {
		 var begindate = null;
		 var enddate = null;
		 var num = null;
		 $(".form-input").Validform({
			 	/* showAllError : true,
				tiptype : function(msg, o, cssctl) {
					if (!o.obj.is("form")) {
						alert($(o.obj.parent().parent().find(".Validform_checktip")).html());
						var objtip = o.obj.parent().parent().find(".Validform_checktip");
						cssctl(objtip, o.type);
						objtip.text(msg);
					} else {
						var objtip = o.obj.find("#msg-info");
						cssctl(objtip, o.type);
						objtip.text(msg);
					};
				}, */
				postonce : true,
				ajaxPost : true,
				beforeSubmit:function(curform){
					$('#fat-btn').button('loading');
					$('#fat-btn2').button('loading');
				},
				callback : function(json) {
						$.alert(json.message);
					
					$('#fat-btn').button('reset');
					$('#fat-btn2').button('reset');
				}
			});

	}); 
	 
	 $("#fat-btn2").bind("click", function(){
		  begindate = $("#begindate").val();
		  enddate = $("#enddate").val();
		  num = $("#num").val();
		url = "${ctx}/import/simimport" + "?deleteflag=1&begindate=" + begindate+ "&enddate=" + enddate+ "&num=" + num;
		 $.confirm("确定要删除数据吗？删除后可重新生成！", function() {
			 	$('#fat-btn').button('loading');
				$('#fat-btn2').button('loading');
				$.get(url,function(json) {
					$.alert(json.message);
					$('#fat-btn').button('reset');
					$('#fat-btn2').button('reset');
			}, "json");
		});
	});

</script>
</html>