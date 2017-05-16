<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>名片申请列表</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">列表</a></li>
	</ul>
	<br/>
	 <div class="form-group">
	 <form name="form" role="form" action="${ctx}/namecard/list" method="GET">
		    开始时间： <input value="${params.startDate }" class="Wdate" type="text" name="startDate" id="startDate" tyle="width:120px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\',{d:-30})}',maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',onpicked:function(){endDate.focus();}})" />
	                 结束时间：<input  value="${params.endDate }" class="Wdate" type="text" name="endDate" id="endDate"  tyle="width:120px;" onfocus="WdatePicker({maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'startDate\')}'})" />
		 	&nbsp;&nbsp; <button type="button" class="btn" onclick="subBut();">确定</button>
	     <button type="button" class="btn" style="float: right;" onclick="download()">导出列表</button>
	  </form>
	 </div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">提交时间</th>
				<th class="text-center">姓名</th>
				<th class="text-center">所在医院</th>
				<th class="text-center">所在科室</th>
				<th class="text-center">医生职称</th>
				<th class="text-center">手机号</th>
				<th class="text-center">二维码</th>
				<th class="text-center">收货人</th>
				<th class="text-center">收货地址</th>
				<th class="text-center">收货电话</th>
			</tr>
			</thead>
			<c:forEach items="${doctorList }" var="doctor">
				<tr>
					<td class="text-center"><fmt:formatDate value="${doctor.createDate }" pattern="yyyy.MM.dd"/></td>
					<td class="text-center">${doctor.name}</td>
					<td class="text-center">${doctor.hospName}</td>
					<td class="text-center">${doctor.deptName }</td>
					<td class="text-center">${doctor.gradeText }</td>
					<td class="text-center">${doctor.phone }</td>
					<td class="text-center"><a href="javascript:;"class="qrcode" xcode2="${doctor.xcode2 }"><img src="${ctx}/static/images/qrcode.png"/></a></td>
					<td class="text-center">${doctor.doctorCardAddress.name }</td>
					<td class="text-center">${doctor.doctorCardAddress.address }</td>
					<td class="text-center">${doctor.doctorCardAddress.phone }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/namecard/list?startDate=${params.startDate }&endDate=${params.endDate}"/>
	<script type="text/javascript">
		$(function(){
			/*-----------二维码 start---------*/
			/* $(window.parent.document).find("#myModal").remove();
			$(window.parent.document).find('body').append('<div id="myModal" class="modal"><img  src="" style="cursor: pointer;" /></div>');
			
			var $myModal = $(window.parent.document).find("#myModal");
			$myModal.css({"width": "300px","height": "300px","margin": "auto","display": "none","position": "fixed"});
			$myModal.find("img").css("margin","auto"); */
			
			$(".tablesorter .qrcode").click(function(){
				var $this = $(this);
				if($this.attr("xcode2")){
					/* $myModal.find("img").attr("src",'${ctx }'+"/code.jsp?xcode2="+$this.attr("xcode2"));
					$myModal.show(); */
					window.open('${ctx }'+"/code.jsp?xcode2="+$this.attr("xcode2"));
				}else{
					alert("该用户没有二维码信息！");
				}
				
			});
			
			/*  $myModal.click(function(){
				$myModal.hide();
			}); */
			 
			/*-----------二维码 end---------*/
		});
		 /*-----------查询 start---------*/
		function subBut(){
			
			var startDate = $("#startDate").val();
			if(startDate==""){
				alert("请选择开始时间！");
				return;
			}
			
			var endDate = $("#endDate").val();
			if(endDate==""){
				alert("请选择结束时间！");
				return;
			}
			
			this.form.submit();  
		};
		/*------------查询 end---------*/
		
	    /*-----------导出- start---------*/
		function download(){
			
			var startDate = $("#startDate").val();
			if(startDate==""){
				alert("请选择开始时间！");
				return;
			}
			
			var endDate = $("#endDate").val();
			if(endDate==""){
				alert("请选择结束时间！");
				return;
			}
			
			var url="${ctx}/namecard/download?startDate="+startDate+"&endDate="+endDate;
		    window.open(url);
		}
		 /*-----------导出- end---------*/
	
	</script>
</body>
</html>