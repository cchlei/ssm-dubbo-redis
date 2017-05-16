<%@ page contentType="text/html;charset=UTF-8"%><%@ include
	file="/WEB-INF/views/include/taglib.jsp"%><head>
<title></title>

	<script type="text/javascript">
	$(document).ready(function(){
		var window_width = $(window).width();
		var document_height = $(document).height();
		var left_plan_width = $("#left_plan_div").width();
		var left_plan_height = $("#left_plan_div").height();
		var top_plan_height = $("#top_div").height();
		
		$("#right_plan_div").width(window_width - left_plan_width -10);
		$("#right_plan_div").height(document_height);
		
		$("#mainFrame").width(window_width - left_plan_width - 10);
		$("#mainFrame").height(document_height);
		$("#mainFrame").attr("src","${ctx}/home/welcome");
		$("#mainFrame").load(function(){
			var left_plan_height = $("#left_plan_div").height();
			var max_height = $(this).contents().find("body").height() + 20;
			//console.log(max_height +"-----------"+ left_plan_height);
			if(max_height < left_plan_height){
				max_height = left_plan_height;
			}
			//console.log(max_height);
			//console.log(body_height +"---------"+ main_height +"-----------"+ max_height);
			$(this).height(max_height); 
			$("#right_plan_div").height(max_height);
		});
	});
	$(window).resize(function(){
		var window_width = $(window).width();
		var left_plan_width = $("#left_plan_div").width();
		$("#right_plan_div").width(window_width - left_plan_width -10);
		$("#mainFrame").width(window_width - left_plan_width - 10);
		//console.log("============================");
	});
	</script>
	<style type="text/css">
		#top_div{
			height:30px;
			background-color: #428bca;
			line-height: 30px;
			overflow: hidden;
			margin-bottom: 5px;
		}
		#top_div div{
			height:30px;
			background-color: #428bca;
			font: bold; 
			font-size: 24px;
			color: #fff;
		}
		#top_div a{
			font: bold; 
			font-size: 18px;
			color: #fff;
		}
		#content_div {}
		#left_plan_div {
			width: 250px;
			float: left;
		}
		#right_plan_div {
			float: right;
		}
	</style>
</head>

<body>
	<!--顶部横幅-->
	<div id="top_div">
		<%@include file="/WEB-INF/views/modules/sys/nav.jsp"%>
	</div>
	<!--主体-->
	<div id="content_div">
		<!--左侧面板-->
		<div id="left_plan_div">
			<%@include file="/WEB-INF/views/modules/sys/menu.jsp"%>
		</div>
		<!--右侧面板-->
		<div id="right_plan_div">
			<iframe id="mainFrame" name="mainFrame" frameborder="no"></iframe>
		</div>
	</div>
</body>
</html>