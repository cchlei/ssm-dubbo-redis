<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>场景规则关联编辑</title>
</head>

<body>
	<div style="margin-left:20px;margin-top:10px">
	<form class="form-horizontal form-input" name="form" id="form" role="form" action="${ctx}/scene/saveSceneRuleRel" method="POST">
	<input id="sceneId" name="sceneId" type="hidden" value="${sceneId}"/>
	<input id="sceneName" name="sceneName" type="hidden" value="${sceneName}"/>
                <label style="font-size:20px;">当前场景：${sceneName}</label><br/>
			
			
	<table class="table table-bordered table-hover tablesorter" id="table1">
	<thead>
		<tr id="headId">
			<th>规则类型</th>
			<th>规则</th>
			<th>优先级（不可修改）</th>
			<th>操作</th>
		</tr>
	</thead>
	<a href="javascript:void(0);" onclick="addNewRow();">新增+</a><br/>
	<c:if test="${ruleList==null||fn:length(ruleList)<1}">
	<tr>
		<td>
		<select class="mSelect"  id="ruleType" name="ruleType" onchange="searchRule(this.value,this)">
		 <option value="">请选择</option>
		 <option value="1">通用</option>
		 <option value="2">渠道</option>
		</select>
		</td>
		<td>
		<select class="mSelect"  id="rule" name="rule">
		<option value="">请选择</option>
		</select>
		</td>
		<td><input type="text" style='width:80px' name="rulePriority" value="1" readonly="readonly"/></td>
		<td><a href="javascript:void(0);">上移</a>&nbsp;<a href="javascript:void(0);">下移</a>&nbsp;<a href="javascript:void(0);" onclick="removeRow(this)">删除</a></td>
	</tr>	
	</c:if>
	</table>
			
	<div style="clear:both;height:0;width:0"></div> 
	<button type="button" id="fat-btn" onclick="saveBut();" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
	</div>
	</form>
    </div>

<script type="text/javascript">
	var ctx = "${ctx}";
	var ruleMap = new Object();
	$(document).ready(function() {
		var jsonStr = '${ruleList}';
		if(jsonStr){
			var ruleList = eval('(' + '${ruleList}' + ')');
			var length = ruleList.length;
			
			//组装规则类型、规则map
			var urlsearch = ctx + "/rule/searchRule";
			for ( var i = 0; i < length; i++) {
				var ruleType = ruleList[i].ruleType;
				 $.ajax({  
						type : "post",  
						url : urlsearch,  
						data : {'ruleType':ruleType},  
						async : false,  
						asyncBoolean:false,
						success : function(data){  
							json = eval(data);
							ruleMap[ruleType]=json;
						}  
				    }); 
			}
			init(ruleList,length);
		}
		
		$("#tableId tr a").each(function() {
			var that = this;
			$(that).click(function() {
				bindClick(that);
			});
		});

	});

	function init(list, length) {
		for ( var i = 0; i < length; i++) {
			addNewRow(list[i]);
		}
	}

	//保存按钮
	function saveBut() {
		var sceneId = $("#sceneId").val();
		var result = getJsonDate(sceneId);
		var url = document.form.action;
		//判断规则和优先级是否有重复值
		var list = $("select[name='rule']");
		var list1 = [];
		var listrp = $("input[name='rulePriority']");
		var listrp1 = [];
		for ( var i = 0; i < list.length; i++) {
			list1[i] = list[i].value;
		}
		if(isRepeat(list1)){
			alert("有重复的规则，请删除重复项！");
			return;
		}
		for ( var i = 0; i < listrp.length; i++) {
			listrp1[i] = listrp[i].value;
		}
		if(isRepeat(listrp1)){
			alert("有重复的优先级，请删除重复项！");
			return;
		}
		//return;
		$.confirm("确定要保存数据吗？", function() {
			$.ajax({
				type : "POST",
				url : url,
				dataType : "json",
				contentType : "application/json",
				data : result,
				success : function(data) {
					alert(data.message);
					window.location.href = ctx + '/scene/list';
				}
			});
		});

	}

	//拼接json数据
	function getJsonDate(sceneId) {
		var tableObj = document.getElementById("table1");
		var jsonDate = "[";
		for ( var i = 1; i < tableObj.rows.length; i++) { //遍历Table的所有Row
			ruleId = tableObj.rows[i].cells[1].getElementsByTagName("select")[0].value;
			rulePriority = tableObj.rows[i].cells[2].childNodes[0].value;
			if (sceneId != "" && (ruleId != ""&&ruleId!="0") && rulePriority != "") {
				jsonDate += ("{\"sceneId\":" + sceneId + ",\"ruleId\":"
						+ ruleId + ",\"rulePriority\":" + rulePriority + "");
				jsonDate += "},";
			}
		}
		jsonDate = jsonDate.substring(0, jsonDate.length - 1);
		jsonDate += "]";
		//alert(jsonDate);
		//var obj = eval('(' + jsonDate + ')');
		return jsonDate;
	}

	//table添加一行
	function addNewRow(rule) {
		var tableId = "table1";
		var bodyObj = document.getElementById(tableId);
		bodyObj.style.display = '';
		if (bodyObj == null) {
			alert("Body of Table not Exist!");
			return;
		}
		var rowCount = bodyObj.rows.length;
		var newRow = bodyObj.insertRow(rowCount++);
		var firstCell = newRow.insertCell(0);
		var secondCell = newRow.insertCell(1);
		var thirdCell = newRow.insertCell(2);
		var forthCell = newRow.insertCell(3);
		var str = "<select class='mSelect'  id='ruleType' name='ruleType' onchange='searchRule(this.value,this)'>";
		str += "<option value=''>请选择</option>";
		str += "<option value='1'>通用</option>";
		str += "<option value='2'>渠道</option>";
		str += "</select>";
		firstCell.innerHTML = str;
		var str1 = "";
		if (rule == "" || rule == null) {
			str1 = "<select class='mSelect'  id='rule' name='rule'>";
			str1 += "<option value=''>请选择</option>";
			str1 += "</select>";
		} else {
			//给规则类型赋值
			firstCell.getElementsByTagName("select")[0].value=rule.ruleType;
			var list = ruleMap[rule.ruleType];
			str1 = "<select class='mSelect'  id='rule' name='rule'>";
			for ( var i = 0; i < ruleMap[rule.ruleType].length; i++) {
				if(rule.ruleId == list[i].ruleId){
					str1 +="<option value='"+list[i].ruleId+"' selected='selected'>"+list[i].ruleName+"</option>";
				}else{
					str1 +="<option value='"+list[i].ruleId+"'>"+list[i].ruleName+"</option>";
				}
			}
			str1 += "</select>";
		}
		secondCell.innerHTML = str1;
		if (rule == "" || rule == null) {
			thirdCell.innerHTML = "<input type='text' style='width:80px' name='rulePriority' value='"
					+ (rowCount - 1) + "' readonly='readonly'/>";
		} else {
			thirdCell.innerHTML = "<input type='text' style='width:80px' name='rulePriority'value='"+rule.rulePriority+"' readonly='readonly'/>";
		}
		forthCell.innerHTML = "<a href='javascript:void(0);'>上移</a>&nbsp;<a href='javascript:void(0);'>下移</a>&nbsp;<a href='javascript:void(0);'onclick='removeRow(this)'>删除</a>";
		$(forthCell).find('a').each(function(index) {
			var _this = this;
			$(_this).click(function() {
				bindClick(_this);
			});
		});
		
	}

	//table删除一行
	function removeRow(inputobj, tableId) {
		var tableId = "table1";
		var bodyObj = document.getElementById(tableId);
		var rowCount = bodyObj.rows.length;
		var min = 1;
		/* if (rowCount <= min) {
			alert("不可以删除最后一行！");
			return;
		} */
		if (inputobj == null)
			return;
		var parentTD = inputobj.parentNode;
		var parentTR = parentTD.parentNode;
		var parentTBODY = parentTR.parentNode;
		parentTBODY.removeChild(parentTR);
		resetRulePriority();
	}

	//规则下拉联动
	function searchRule(ruleType, objOne) {
		var obj = objOne.parentNode;
		var selectElemt = obj.parentNode.cells[1]
				.getElementsByTagName("select")[0];
		if (ruleType == 0 || ruleType == null || ruleType == "") {
			return;
		}
		var url = ctx + "/rule/searchRule";
		$.post(url, {
			'ruleType' : ruleType
		}, function(data) {
			json = eval(data);
			// 先清空第二个 
			$(selectElemt).empty();
			var option = "";
			option = $("<option>").val(0).text("请选择");
			$(selectElemt).append(option);
			for ( var i = 0; i < json.length; i++) {
				option = $("<option>").val(json[i].ruleId).text(
						json[i].ruleName);
				$(selectElemt).append(option);
			}
		});

	}

	
	function bindClick(that) {
		var _value = $(that).html();
		var _trObj = $(that).parent().parent();
		if (_value == '上移') {
			if (_trObj.prev("#headId").length > 0) {
				alert('已经是第一行');
			} else {
				var _prevHtml = _trObj.prev();
				_trObj.prev().remove();
				_trObj.after(_prevHtml);
				_trObj.next().find('a').each(function(index) {
					var _this = this;
					$(_this).click(function() {
						bindClick(_this);
					});
				});
				resetRulePriority();
			}
		} else if (_value == '下移') {
			if (_trObj.next().length > 0) {
				var _nextHtml = _trObj.next();
				_trObj.next().remove();
				_trObj.before(_nextHtml);
				$(_nextHtml).find('a').each(function(index) {
					var _this = this;
					$(_this).click(function() {
						bindClick(_this);
					});
				});
				resetRulePriority();
			} else {
				alert('已经是最后一行');
			}
		}
	}
	
	//重新计算优先级
	function resetRulePriority(){
		var tableObj = document.getElementById("table1");
		for ( var i = 1; i < tableObj.rows.length; i++) { //遍历Table的所有Row
			rulePriority = tableObj.rows[i].cells[2].childNodes[0].value=i;
		}
	}
	
	
	//判断数组里是否有重复值
	function isRepeat(arr) {

		var hash = {};

		for ( var i in arr) {

			if (hash[arr[i]])

				return true;

			hash[arr[i]] = true;

		}

		return false;

	}
</script>
</html>	