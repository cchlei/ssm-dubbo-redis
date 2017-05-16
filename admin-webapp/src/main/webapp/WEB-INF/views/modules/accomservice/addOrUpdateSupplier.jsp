<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>陪诊订单列表</title>
<style type="text/css">
	/**表格css**/
	#box {display:table;width: 500px;}
	.css_tr {display: table-row;}
	.css_td {display: table-cell;border-bottom: 1px solid #c0c3c5;width: 261px;    padding: 12px;color:#039cf9;}
	#css_title{background-color: #9ea1a7;font-size: 22px;}
	#css_title .css_td{
		color:#000;
	}
	.datainp{width: 174px;height:27px;border:1px #ccc solid;}
	.button{width: 159px;}
	#BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
	#DialogDiv{position:absolute;width:400px; left:45%; top:50%; margin-left:-200px;height: 510px;overflow: auto;z-index:100;background-color:#fff; border:1px #8FA4F5 solid; padding:1px;}
	/*#DialogDiv{position:absolute;width:400px; left:48%; top:50%; margin-left:-200px; height:auto; z-index:100;background-color:#fff; border:1px #8FA4F5 solid; padding:1px;}   */
	#DialogDiv h2{ height:25px; font-size:14px; background-color:#8FA4F5; position:relative; padding-left:10px; line-height:25px;}  
	#DialogDiv h2 a{position:absolute; right:5px; font-size:12px; color:#000000}  
	#DialogDiv .form{padding:10px;}
	#suppName{margin: 2px 51px;}
	#scale{margin: 2px 0px 2px 64px;}
	#accountKey{margin: 2px 59px;}
	#td-status{margin: 2px 59px;}
	#enable{margin-left: 55px;}
</style>
</head>
<body>
	<div id="BgDiv"></div>
	<!--遮罩层显示的DIV-->  
	<div id="DialogDiv" style="display:none">  
		<h2>选择医院项目名称<a href="javascript:;" id="btnClose" onclick="closeDiv('DialogDiv')">关闭</a></h2>
		<div class="select">
			<input  type="text" id="search"/>
			<input type="button" id="select" onclick="ShowDIV('search')" class="button" value="搜索"/>
		</div>  
		<div class="form"></div>
	</div>  
	<div id="dialog">
		<div>添加供应商</div><br>
		<form id="add" method="post" action="">
			<div><span>供应商名称:</span><input type="text"	class="suppName" id="suppName"name="suppName"/><strong id="nametag"></strong></div>
	           <div><span>分账比例:</span><input type="text"	class="datainp" id="scale"	name="scale"/><span>%</span></div>
	           <div>
		           	<span>合作日期:</span>
		            <span>开始时间:</span><input type="text"	class="datainp"  id="startDate"name="startDate" placeholder="请选择" readonly>
					<span>结束时间:</span><input type="text"	class="datainp"  id="endDate" name="endDate" 	placeholder="请选择" readonly>
					<strong id="time"></strong>
				</div>
			<div class="adduser">
				<span>分配用户:</span>
				<label class="setinput"><input type="text"	class="datainp" id="accountKey" name="accountKey" placeholder="请选择"  readonly></label>
				<strong id="accountKeyTips"></strong>
				<span><a href="#" class="button" id="spname" onclick="ShowDIV('sname')">选择用户</a></span>
			</div>
       		<div id="td-status">
       			<span>状态:</span>
        		<span><input type="radio"  class="status" id="enable" name="status" value="1"/>启用</span>
        		<span><input type="radio"  class="status" id="disable" name="status" value="0"/>停用</span>
         		<strong id="statustips"></strong>
        	</div>
	  	</form>
        <button type="button" class="button" id="btn">保存</button>
        <span><a href="${ctx}/accom/supplierList" class="button">返回</a></span>
	</div>
<script type="text/javascript">
$(document).ready(function (){
	/**
	 * @author chlei
	 * @date   2016年11月24日 13:02:02
	 * 给陪诊服务添加 供应商用户
	 */
	 $("#btn").click(function (){
		/**
		 * 表单序列化
		 */
		 var uid=$(".uid").val();
		 var suppName=$("#suppName").val();
		 var status=$("input[name='status']:checked").val();
		 var startTime=$("#startDate").val();
		 var start=new Date(startTime);  
		 var endTime=$("#endDate").val();
		 var end=new Date(endTime);
		 if(start>=end){
			 $("#statustips").html("");
			 var html="<span style='color:red;'>*结束时间要大于开始时间!</span>";
			 $("#time").html(html);
			 return false;
		 }
		 if(uid==null||uid==undefined||uid==""){
			 $("#time").html("");
			 var html="<span style='color:red;'>*请选择账户,分配账户!</span>";
			 $("#accountKeyTips").html(html);
		 }else if(status==null||status==undefined||status==""){
			 $("#accountKeyTips").html("");
			 var html="<span style='color:red;'>*请选择状态!</span>";
			 $("#statustips").html(html);
		 }else{
			var postData = $("#add").serialize()+"&uid="+uid;
			/**
			 * 异步提交
			 */			
			$.ajax({
				type : "post",
				data : postData,
				url :  "../accom/add",
				dataType : "json",
				success : function(data){
				  /*errors:null
					imgurl:null
					message:"此用户已分配为供应商!"
					results:false
					success:true */
					if(data.result=="true"){
						alert(data.message+"!");
					}else{
						alert(data.message+"!");
					}
				}
			});
		} 
	});
});

 /**
  * @author chlei
  * @date   2016年11月24日 18:00:02
  * 根据 type 判断是 搜索弹出窗口 或 选择项目弹出窗口 
  */ 
function ShowDIV(type){
	var ohtml="";
 	/**
	 * 获得输入框中的值
	 */
	 var postData = $("#search").val();
	 /**
	  * 异步加载
	  */			
 	$.ajax({
 		type : 	"post",
 		data : 	{"rid":1487921222731003},
 		url  : 	"../manager/accomList",
 		dataType : "json",
 		success : function(data){
 			$.each(data.results.roleMap, function(i, val) {
 				var username=val['username'];
 				var uid=val['uid'];
 				ohtml +="<div class='css_tr'>"+
							"<div class='css_td'>" +
								"<a href='javascript:void(0)' onclick='spname(pselect"+uid+")' id='pselect"+val['uid']+"' value='"+val['uid']+"'>"+val['username'] + "</a>" +
								"<span id='username"+uid+"' style='display:none'>"+username+"</span>"+
							"</div>"+
						"</div>";
 			});
 			$(".form").html(ohtml);
 			$("#BgDiv").css({ display: "block", height: $(document).height() });  
 			var yscroll = document.documentElement.scrollTop;  
 			$("#DialogDiv").css("top","85px");  
 			$("#DialogDiv").css("display","block");  
 			document.documentElement.scrollTop = 0;  
 		}
 	});
};

/**
 * @author chlei
 * @date   2016年11月24日 19:06:02
 * * 关闭弹出窗口 
 */
function closeDiv(thisObjID){  
	$("#BgDiv").css("display", "none");  
	$("#" + thisObjID).css("display", "none");  
};

/**
 * @author chlei
 * @date   2016年11月24日 18:00:02
 * 选择项目名称 进行表单填充 关闭弹出窗口 
 */
function spname(pname){
	 var input="";
	 var pid=$(pname).attr("value");
	 var accountname=$(pname).text();
	 //<label class="setinput"><input type="text"	class="datainp" id="accountKey" name="accountKey" placeholder="请选择"  readonly></label>
	input +="<label class='setinput'><input type='text'	class='datainp' id='accountKey' name='accountKey' value='"+accountname+"'  readonly></label>"+
			"<input type='hidden' class='uid' name='accountKey' value='"+pid+"'/>";
	$(".setinput").html(input);//html()
	$("#BgDiv").css("display", "none");  
	$("#DialogDiv" ).css("display", "none");
};
</script>
<script type="text/javascript">
		jeDate({
			dateCell : "#startDate",
			format : "YYYY-MM-DD hh:mm:ss",
			isinitVal : false,
			isTime : true, //isClear:false,
			minDate : "2014-09-19 00:00:00",
		//	okfun : function(val) {alert(val)}
		})
		jeDate({
			dateCell : "#endDate",
			format : "YYYY-MM-DD hh:mm:ss",
			isinitVal : false,
			isTime : true, //isClear:false,
			minDate : "2014-09-19 00:00:00",
		//	okfun : function(val) {alert(val)}
		})
	</script>
</body>
</html>