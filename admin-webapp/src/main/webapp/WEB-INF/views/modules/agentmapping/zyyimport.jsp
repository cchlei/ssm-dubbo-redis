<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>统计管理</title>
</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">数据导入</a></li>
	</ul>
	<br/>
		
		 <div class="form-group">
		 <form name="form" class="form-horizontal form-input" role="form" action="${ctx}/import/zyyimport" method="GET">
			<label for="effectTime" class="col-sm-2 control-label">数据导入：</label>
		医院选择：<select class="mSelect"    id="hosp" name="hosp"	onchange=" checkvisible(this.value)">
				<option value="">请选择</option>
				<option value="1">中医院</option>
				<option value="2">浦南</option>
				</select>
		导入日期：<input class="Wdate" type="text" name="date" id="date"  style="width:120px;" value="" onClick="WdatePicker()">
		   <!--  <input type="submit" id="import" value="导入"   onclick="return check(this.form)"/> -->
		    <button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在导入...">导入</button>
			</form>
		</div>
		
		
<script type="text/javascript">
		var ctx = "${ctx}";
		$("#fat-btn").hide();
		function checkvisible(select){
			if(select==""){
				$("#fat-btn").hide();
			}else{
				$("#fat-btn").show();
			}
		}
		
	 $(document).ready(function() {
		 if("${date}"!=""){
				$("#date").val("${date}");
			}
		 $(".form-input").Validform({
				postonce : true,
				ajaxPost : true,
				beforeSubmit:function(curform){
					$('#fat-btn').button('loading');
				},
				callback : function(json, statusText) {
						$.alert(json.message);
						errorValidate("msg-info", '');
					
					$('#fat-btn').button('reset');
				}
			});

	});
	 

</script>
</html>