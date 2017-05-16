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
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div id="wrapper" style="position: relative;" class="printSize2">
		<form class="form-horizontal form-input" id = "form" name="form" role="form" >
			身体部位：<input id="cont" name="cont" type="text" value="${cont}" datatype="1-500"
					nullmsg="请输入描述信息！" errormsg="地区名称至少1个字符,最多500个字符！">
			<input id="redioId" name="redioId" type="hidden" value="${redioId} }">
			<input id="redioType" name="redioType" type="hidden" value="${redioType} }">
			<input id="saveOrUpdate" name="saveOrUpdate" type="hidden" value="${saveOrUpdate} }">
			<input type="button" OnClick="javascript:subBut();" value="查询" />
		</form>
	</div>
	<div style="height:34px;position: absolute;bottom: 0;right: 0;"></div>
		
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<div style="float:right;">
		<button type="button" class="btn" onclick="submitRed();">添加</button>&nbsp;&nbsp;
		<button type="button" class="btn" onclick="reset();">修改</button>&nbsp;&nbsp;
		
		<button type="button" id="dlt" class="btn" onclick="dlt();">删除</button>&nbsp;&nbsp; 
		
	</div>
	<div id="data"></div>
<script>
	var ctx = "${ctx}"
	//一级
	window.onload =  Step1();
	function Step1() {
		$.get("/admin/guide/bodylist",function(result) {
			//console.log(result)
			var StepNo1 = result;
	
			var data = StepNo1.results;
	
			var html = '<ul class="step1">';
	        
			for (var i = 0; i < data.length; i++) {
				//	html+= "<input type='checkbox' id='reception' name='reception' /">"
	
				//  html+= "<li onclick='Step2("+data[i].id+")'>"+data[i].cont+"</li>"
				html += "<li onclick='Step2("
						+ data[i].id
						+ ")'>"
						+ "<input type='radio' id='reception' name='reception' value="+data[i].id+">"
						+ data[i].cont + "</li>"
	
				html += "<ul class='step2' id='bodyId"+data[i].id+"'></ul>";
	
			}
	
			var list = document.getElementById('data');
			list.innerHTML = html;
	
		});
	}
	//二级
	function Step2(bodyId) {//insertAfter
		if ($('#bodyId' + bodyId).html() != '') {
			if ($('#bodyId' + bodyId).css('display') == 'none') {

				$('#bodyId' + bodyId).css('display', 'block');

			} else {

				$('#bodyId' + bodyId).css('display', 'none');

			}
			return;
		}
		var url = "${ctx}/guide/getDiseaseByBodyIdNoWhere?bodyId=" + bodyId;
		$.get(url,function(result) {
			var StepNo2 = result;
			// var StepNo2 = {"code":1,"errors":null,"message":"获取疾病信息成功","results":[{"bodyId":1,"cont":"背痛","id":1,"sort":0},{"bodyId":1,"cont":"背痛2","id":2,"sort":0}]};
			var data = StepNo2.results;
			var html = "";

			for (var i = 0; i < data.length; i++) {//diseaseId

				html += "<li onclick='Step3("
						+ data[i].id
						+ ",0,"
						+ bodyId
						+ ")'>--"
						+ "<input type='radio' id='reception' name='reception' value="+data[i].id+">"
						+ data[i].cont + '-'
						+ data[i].id 
						+ "</li>"
						+"<div style='float:right;'>"
						+"<button type='button' class='btn' onclick='submitRed("+data[i].id+")'>添加</button>&nbsp;&nbsp;"
						+"<button type='button' class='btn' onclick='reset("+data[i].id+")'>修改</button>&nbsp;&nbsp;"
						+"<button type='button' id='dlt' class='btn' onclick='dlt("+data[i].id+")'>删除</button>&nbsp;&nbsp;"
						+"</div>";
				// html+= "<li onclick='Step3("+data[i].id+",0,"+bodyId+")'>--"+data[i].cont+'-'+data[i].id+"</li>";

				html += "<ul  class='Step3' id='diseaseId"+data[i].id+"_"+bodyId+"'></ul>";

			}

			$('#bodyId' + bodyId).css('display',
					'block');
			var list = document.getElementById('bodyId'
					+ bodyId);
			list.innerHTML = html;
		});
	}
	//三级
	function Step3(diseaseId, pid, bodyId) {//insertAfter
		if ($('#diseaseId' + diseaseId + "_" + bodyId).html() != '') {
			//alert($('#bodyId'+bodyId).css('display'))
			if ($('#diseaseId' + diseaseId + "_" + bodyId).css(
					'display') == 'none') {

				$('#diseaseId' + diseaseId + "_" + bodyId).css(
						'display', 'block');

			} else {
				$('#diseaseId' + diseaseId + "_" + bodyId).css(
						'display', 'none');
			}
			return;
		}

		var url = "${ctx}/guide/getListByDiseaseId?diseaseId="+ diseaseId;
		$.get(url,function(result) {
			totalHtml = '';
			totalHtml2 = '';
			var StepNo3 = result;
			//var StepNo3 = {"code":1,"errors":null,"message":"获取病情导诊列表","results":[{"cont":"背痛是否发生在背部遭受重击或震荡之后，或是在重体力劳动或搬运重物之后？","depId":null,"depName":null,"diseaseId":1,"flag":2,"id":1122,"isleaf":0,"pid":0,"rootId":0},{"cont":"是否感觉手脚不听使唤，大小便不能控制如常？","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1123,"isleaf":0,"pid":1122,"rootId":0},{"cont":"你的脊柱是否有侧弯或变形？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1124,"isleaf":0,"pid":1122,"rootId":0},{"cont":"急诊！立刻就医！你可能有脊柱损伤。","depId":1421738197236124,"depName":"急诊科","diseaseId":1,"flag":1,"id":1125,"isleaf":1,"pid":1123,"rootId":1},{"cont":"你的一条腿或一边的手臂是否有疼痛、针刺感或麻木？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1126,"isleaf":0,"pid":1123,"rootId":0},{"cont":"请及时就医。你可能患有需要医治的骨骼疾病。","depId":1421738197236062,"depName":"骨科","diseaseId":1,"flag":1,"id":1127,"isleaf":1,"pid":1124,"rootId":1},{"cont":"当你醒来的时候或在完成一天的工作之后，你是否感到疼痛和僵硬？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1128,"isleaf":0,"pid":1124,"rootId":0},{"cont":"就医。你可能有肌肉、骨骼或神经的损伤。","depId":1421738197236062,"depName":"骨科","diseaseId":1,"flag":1,"id":1129,"isleaf":1,"pid":1126,"rootId":1},{"cont":"你可能有扭伤或劳损。如果症状持续，请就医。","depId":1421738197236062,"depName":"骨科","diseaseId":1,"flag":0,"id":1130,"isleaf":1,"pid":1126,"rootId":1},{"cont":"背痛可能是由于不恰当的背部支撑或不好的工作姿势而引起的。","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1131,"isleaf":1,"pid":1128,"rootId":1},{"cont":"你超重吗？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1132,"isleaf":0,"pid":1128,"rootId":0},{"cont":"超重的体重可能给您的背部加上了过多的压力。请减肥。","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1133,"isleaf":1,"pid":1132,"rootId":1},{"cont":"你是40岁以上吗？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1134,"isleaf":0,"pid":1132,"rootId":0},{"cont":"就医。你可能有关节或骨骼方面的疾病。","depId":1421738197236062,"depName":"骨科","diseaseId":1,"flag":1,"id":1135,"isleaf":1,"pid":1134,"rootId":1},{"cont":"背痛的时候是否伴有腹痛或骨盆痛，并且这种痛时发时好？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1136,"isleaf":0,"pid":1134,"rootId":0},{"cont":"你是否有以下任何症状？1）尿频或尿痛 2）血尿 3）发烧","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1137,"isleaf":0,"pid":1136,"rootId":0},{"cont":"发烧吗？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1138,"isleaf":0,"pid":1136,"rootId":0},{"cont":"参阅“尿频”，“血尿”","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1139,"isleaf":1,"pid":1137,"rootId":1},{"cont":"疼痛是否发生在临近月经期的时候？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1140,"isleaf":0,"pid":1137,"rootId":0},{"cont":"是否有肌肉和关节的疼痛，并且伴有喉咙痛、咳嗽和流涕？","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1141,"isleaf":0,"pid":1138,"rootId":0},{"cont":"你是否有低背部和臀部的疼痛和僵硬，尤其是在休息或静坐之后，或是持续超过1个小时的晨起僵硬？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1142,"isleaf":0,"pid":1138,"rootId":0},{"cont":"见“痛经”、“经血过多”、不规律月经“","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1143,"isleaf":1,"pid":1140,"rootId":1},{"cont":"疼痛是否是突然发生并且常发生在餐后？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1144,"isleaf":0,"pid":1140,"rootId":0},{"cont":"你可能患有呼吸系统的感染。如果症状持续，请就医。","depId":1419389945226003,"depName":"呼吸内科","diseaseId":1,"flag":1,"id":1145,"isleaf":1,"pid":1141,"rootId":1},{"cont":"你是否有以下任何症状？1）背部一动就疼 2）持续性的隐痛 3）糖尿病史或静脉内的药物使用","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1146,"isleaf":0,"pid":1141,"rootId":0},{"cont":"就医。你可能有关节炎症。","depId":1421738197236062,"depName":"骨科","diseaseId":1,"flag":1,"id":1147,"isleaf":1,"pid":1142,"rootId":1},{"cont":"你是否感到臀部或腿的疼痛？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1148,"isleaf":0,"pid":1142,"rootId":0},{"cont":"请咨询医生。你可能患有腹部的疾病。","depId":1421290785541007,"depName":"普通外科","diseaseId":1,"flag":1,"id":1149,"isleaf":1,"pid":1144,"rootId":1},{"cont":"就医。你的症状需要进一步的诊断。","depId":1421290785541007,"depName":"普通外科","diseaseId":1,"flag":0,"id":1150,"isleaf":1,"pid":1144,"rootId":1},{"cont":"请及时看医生。你可能有感染。","depId":1421738197236011,"depName":"感染科","diseaseId":1,"flag":1,"id":1151,"isleaf":1,"pid":1146,"rootId":1},{"cont":"就医。你的症状需要诊治。","depId":1421738197236003,"depName":"风湿免疫科","diseaseId":1,"flag":0,"id":1152,"isleaf":1,"pid":1146,"rootId":1},{"cont":"疼痛是否向下往腿部放射？","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1153,"isleaf":0,"pid":1148,"rootId":0},{"cont":"背痛是否伴有身体其它部位的疼痛、僵硬或压痛，并同时感到体弱或疲劳？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1154,"isleaf":0,"pid":1148,"rootId":0},{"cont":"就医。你可能有坐骨神经的损伤。","depId":1421290785541007,"depName":"普通外科","diseaseId":1,"flag":1,"id":1155,"isleaf":1,"pid":1153,"rootId":1},{"cont":"就医。你的症状需要诊治。","depId":1421290785541007,"depName":"普通外科","diseaseId":1,"flag":0,"id":1156,"isleaf":1,"pid":1153,"rootId":1},{"cont":"你是否伴有以下任何症状？1）消化不良2）恶心或呕吐 3）食欲不好 4）比平常更易口渴和多尿","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1157,"isleaf":0,"pid":1154,"rootId":0},{"cont":"在你的身体一侧是否有一小块皮肤有疹子，并有烧灼或瘙痒感？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1158,"isleaf":0,"pid":1154,"rootId":0},{"cont":"立刻咨询医生。你可能患有甲状旁腺机能亢进。 ","depId":1421290785541044,"depName":"内分泌科","diseaseId":1,"flag":1,"id":1159,"isleaf":1,"pid":1157,"rootId":1},{"cont":"你是否有不明原因的严重疼痛、疲倦、和体重减轻？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1160,"isleaf":0,"pid":1157,"rootId":0},{"cont":"就医。你可能患有神经感染。","depId":1421738197236049,"depName":"皮肤科","diseaseId":1,"flag":1,"id":1161,"isleaf":1,"pid":1158,"rootId":1},{"cont":"你是否有麻木感、针刺感，或肌肉虚弱？","depId":null,"depName":null,"diseaseId":1,"flag":0,"id":1162,"isleaf":0,"pid":1158,"rootId":0},{"cont":"立刻咨询医生。你可能患有骨髓方面的疾病。","depId":1421738197236062,"depName":"骨科","diseaseId":1,"flag":1,"id":1163,"isleaf":1,"pid":1160,"rootId":1},{"cont":"就医。你的症状需要诊治。","depId":1421290785541007,"depName":"普通外科","diseaseId":1,"flag":0,"id":1164,"isleaf":1,"pid":1160,"rootId":1},{"cont":"见”麻木或针刺感“","depId":null,"depName":null,"diseaseId":1,"flag":1,"id":1165,"isleaf":1,"pid":1162,"rootId":1},{"cont":"如果你的症状持续超过一个月，请咨询医生。","depId":1421290785541007,"depName":"普通外科","diseaseId":1,"flag":0,"id":1166,"isleaf":1,"pid":1162,"rootId":1}]};
			var data = StepNo3.results;
			var html = "<li>";
	
			for (var i = 0; i < data.length; i++) {
				//totalHtml
				if (data[i].pid == 0) {
					totalHtml += "<input type='radio' id='reception' name='reception' value="+data[i].id+">|--";
					/* totalHtml += '<p>' + data[i].cont
							+ '-' + data[i].id + '</p>'; */
					totalHtml +=   data[i].cont
						+ '-' + data[i].id + '</br>';
					get_next_question(data[i].id, data)
					break;
				}
	
			}
	
			if (totalHtml == '') {
				totalHtml = '当前没有问卷';
	
			}
	
			html += totalHtml + "</li>"
	
			var list = document
					.getElementById('diseaseId'
							+ diseaseId + '_' + bodyId);
			list.innerHTML = html;
		});
	}
	var totalHtml = '';
	var totalHtml2 = '';
	var arr = [];
	function get_next_question(pid, data) {
		var num = 0;

		for (var i = 0; i < data.length; i++) {
			if (pid == data[i].pid) {
				if (!arr[data[i].pid]) {

					totalHtml2 += "&nbsp;&nbsp;&nbsp;"
					arr[data[i].pid] = totalHtml2;

				}

				var keshi = '';//depName
				if (data[i].depName != null) {
					keshi = '<b>科室：' + data[i].depName + '('
							+ data[i].depId + ')' + '</b>';

				}
				if (data[i].flag == 1) {
					totalHtml += "<input type='radio' id='reception' name='reception' value="+data[i].id+">";

					/* totalHtml += "<p>" + arr[data[i].pid] + "|--是:"
							+ data[i].cont + '-' + data[i].id
							+ "&nbsp;&nbsp;<span>" + keshi
							+ "</span></p>"; */
					totalHtml += arr[data[i].pid] + "|--是:"
					+ data[i].cont + '-' + data[i].id
					+ "&nbsp;&nbsp;<span>" + keshi
					+ "</span></br>";		

				} else {
					totalHtml += "<input type='radio' id='reception' name='reception' value="+data[i].id+">";

					/* totalHtml += "<p>" + arr[data[i].pid] + "|--否:"
							+ data[i].cont + '-' + data[i].id
							+ "&nbsp;&nbsp;<span>" + keshi
							+ "</span></p>"; */
					totalHtml += arr[data[i].pid] + "|--否:"
					+ data[i].cont + '-' + data[i].id
					+ "&nbsp;&nbsp;<span>" + keshi
					+ "</span></br>";		
				}

				get_next_question(data[i].id, data);
				num++;
				if (num == 2) {

					break;
				}
			}
		}
		return;
	}

	function submitRed(id) {
		$("#redioType").val("");
		var redio = $('input:radio:checked').val();
		if(redio == null ){
			if(id == null){
				$("#redioType").val("1");
			}
		}
		if(id != null){
			if(redio == null ){
				$("#redioType").val("3");
				redio = id;
			}
		}
		$("#redioId").val(redio);
		var redioId = $("#redioId").val();

		var className = $('input:radio:checked').closest("li").parent(
				"ul").attr("class");
		if (className == "step1") {
			$("#redioType").val("2");
		}
		if (className == "step2") {
			$("#redioType").val("3");
		}
		if (className == "Step3") {
			$("#redioType").val("4");
		}
		if (className == null) {
			if(id != null){
				$("#redioType").val("3");
			}
		}
		var redioType = $("#redioType").val();
		$("#saveOrUpdate").val("save");
		var saveOrUpdate = $("#saveOrUpdate").val();
		var url = "${ctx}/tree/toAddPage" + "?redioId= " + redioId
				+ "&redioType=" + redioType + "&saveOrUpdate="
				+ saveOrUpdate
		window.location.href = url;
	}

	function reset(id) {
		$("#redioType").val("");
		var redio = $('input:radio:checked').val();	
		if(redio == null ){
			if(id == null){
				alert("请选择要修改的选项");
				return;
			}
		}
		if(id != null){
			if(redio == null ){
				$("#redioType").val("2");
				redio = id;
				alert(redio+"redio");
			}
		}
		$("#redioId").val(redio);
		var redioId = $("#redioId").val();
		

		var className = $('input:radio:checked').closest("li").parent(
				"ul").attr("class");
		if (className == "step1") {
			$("#redioType").val("1");
		}
		if (className == "step2") {
			$("#redioType").val("2");
		}
		if (className == "Step3") {
			$("#redioType").val("3");
		}
		if (className == null) {
			if(id != null){
				$("#redioType").val("2");
			}
		}
		
		var redioType = $("#redioType").val();
		$("#saveOrUpdate").val("update");
		var saveOrUpdate = $("#saveOrUpdate").val();
		var url = "${ctx}/tree/toAddPage" + "?redioId= " + redioId
				+ "&redioType=" + redioType + "&saveOrUpdate="
				+ saveOrUpdate
		window.location.href = url;
	}

	
	function dlt(id) {
		$("#redioType").val("");
		var redio = $('input:radio:checked').val();
		if(redio == null ){
			if(id == null){
				alert("请选择要修改的选项");
				return;
			}
		}
		if(id != null){
			if(redio == null ){
				$("#redioType").val("2");
				redio = id;
				alert(redio+"redio");
			}
		}
		$("#redioId").val(redio);
		var redioId = $("#redioId").val();

		var className = $('input:radio:checked').closest("li").parent(
				"ul").attr("class");
		if(className == null){
			if(id != null){
				$("#redioType").val("2");
			}
		}else{	
			if (className == "step1") {
				$("#redioType").val("1");
			}
			if (className == "step2") {
				$("#redioType").val("2");
			}
			if (className == "Step3") {
				$("#redioType").val("3");
			}
			
				
			/* }); */
		}
		var redioType = $("#redioType").val();
		var url = "${ctx}/tree/delete" + "?redioId= " + redioId
				+ "&redioType=" + redioType
		/* $("#dlt").bind("click", function(){ */
			$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
				$.get(url, function(json) {
					var msg = "";
					if (json.message) {
						msg = json.message;
					}
					$.alert(msg, function() {
						window.location.reload();
					});
				}, "json");
			});
		
		
	}
	
	function subBut(){
		var cont = $("#cont").val();
		var dataStr = "/admin/tree/selectByCont?"
		$.ajax({  
			url:dataStr,  
			type:'GET',  
			data : {"cont":encodeURIComponent(cont)},
			dataType:'json',  
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success:function(results) { 
	 		    var data = results.results;
				var html = '<ul class="step1">';
	     
	     		for (var i = 0; i < data.length; i++) {
					//	html+= "<input type='checkbox' id='reception' name='reception' /">"
					//  html+= "<li onclick='Step2("+data[i].id+")'>"+data[i].cont+"</li>"
					html += "<li onclick='Step2("
							+ data[i].id
							+ ")'>"
							+ "<input type='radio' id='reception' name='reception' value="+data[i].id+">"
							+ data[i].cont + "</li>"
		
					html += "<ul class='step2' id='bodyId"+data[i].id+"'></ul>";
		
				}
				var list = $('#data').html(html);			
			},  
		});  
	}
	
	
</script>
</body>
</html>
