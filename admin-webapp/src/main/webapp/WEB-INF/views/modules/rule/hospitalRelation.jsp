<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>渠道医院关联编辑</title>
</head>

<body>
	<div style="margin-left:300px;margin-top:10px">
	<form class="form-horizontal form-input" name="form" id="form" role="form" action="${ctx}/channel/saveChannelHospRel" method="POST">
	<input id="channelId" name="channelId" type="hidden" value="${channelId}"/>
                <label style="font-size:20px;">当前渠道：${channelName}</label><br/>
				所在地：  
			<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value)">
		    <option value="0">请选择</option>
		    <c:forEach items="${areaList}" var="area" varStatus="status">
		       <c:if test="${area.parentId==0}">
			    	<option value="${area.areaId}">${area.areaName}</option>
			   </c:if>
		    </c:forEach>
		    </select>
		    <span style="margin-left:30px;"><select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(this.value);">
		   	    <c:if test="${areaId!=null}">
		    	<option>${areaMap[areaId]}</option>
			    </c:if>
			    <c:if test="${areaId==null}">
			   	    <option value="0">请选择</option>
			    </c:if>
		    </select></span><br/>
		    <div>
		    <div style="float:left" >
		    <select id="hospital" name="hospital" style="width:200px"  multiple='multiple' size='20' >
		    <option value="0">请选择</option>
		    </select>
		    </div>
		    <div style="float:left" >
		    <input type="button" id="go" value=">>"/><br/>
  			<input type="button" id="back" value="<<"/>
  			</div>
  			<div style="float:left">
		    <select  name="channelHosp" id="channelHosp" style="width:200px"  multiple='multiple' size='23.9' >
		    <c:if test="${hospList!=null&&fn:length(hospList)>0}">
  				<c:forEach items="${hospList}" var="hosp" varStatus="status">
  				<option value="${hosp.hospId}"  selected="selected">${hosp.hospName}</option>
  				</c:forEach>
  			</c:if>
		    </select>
		    </div> 		
		    </div>	
	
	<div style="clear:both;height:0;width:0"></div> 
	<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
	</div>
	</form>
    </div>

<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {
		
		//多选科室
		$('#go').click(function() {
			var options =   $("#hospital option:selected");

			options.clone().prependTo($('#channelHosp'));
			$('#channelHosp option').attr("selected", "selected");

			});
		$('#back').click(function() {
			var options =   $("#channelHosp option:selected").remove();

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
				
				//alert(getData()); 
				return getData();
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						window.location.href = ctx+'/channel/list';
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
	
	function getData(){
		var list = [];
    	var options =   $("#channelHosp option");
    	var html = "";
    	for(var i =0; i < options.length; i ++){
    		list[i]=$(options[i]).attr('value');
    		html += "<input type=\"hidden\" name=\"hospIds\" value=\"" + $(options[i]).attr('value') + "\"/>";
    	}
    	if(isRepeat(list)){
    		alert("请不要选择重复的医院！");
    		return false;
    	}
    	if(list==""){
    		alert("请选择至少一家医院！");
    		return false;
    	}
    	$("#form").prepend(html);
    	return true;
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
    	 searchHosp(areaId);//根据父级地区查询医院
    	
    }
	
  //医院下拉联动
    function searchHosp(areaId){
    	if(areaId==0){
    		return;
    	}
    	var url = ctx+"/doctor/searchHosp";
    	$.post(url,{'areaId':areaId,'flag':'1'},function (data){
    		json = eval(data);
    		  // 先清空第二个 
    	      $("#hospital").empty(); 
    	      var option = "";
    	      option = $("<option>").val(0).text("请选择");
    	      $("#hospital").append(option); 
    		for(var i=0; i<json.length; i++) 
    		{ 
    			option = $("<option>").val(json[i].hospId).text(json[i].hospName).attr('isthirdparty',json[i].isThirdparty);
    		    $("#hospital").append(option); 
    		} 
    	});
    	
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