<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<script src="${ctxStatic}/js/kit/kit.js"></script>
		<!--[if IE]>
		<script src="../../src/js/ieFix.js"></script>
		<![endif]-->
		<script type="text/javascript">
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-30210234-1']);
			_gaq.push(['_trackPageview']); (function() {
				var ga = document.createElement('script');
				ga.type = 'text/javascript';
				ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(ga, s);
			})();

		</script>
		<script src="${ctxStatic}/js/kit/array.js"></script>
		<script src="${ctxStatic}/js/kit/date.js"></script>
		<script src="${ctxStatic}/js/kit/dom.js"></script>
		<script src="${ctxStatic}/js/kit/selector.js"></script>
		<link rel="stylesheet" href="${ctxStatic}/css/kit/css.css" />
		<!--widget-->
		<script src="${ctxStatic}/js/kit/widget/DatePicker/datepicker.js"></script>
		<script src="${ctxStatic}/js/kit/widget/DatePicker/datepicker-n-months.js"></script>
		<link rel="stylesheet" href="${ctxStatic}/css/kit/widget/DatePicker/datepicker.css" />
	</head>
	<body>
	    <div>
	    <span style="color:blue">(请按住Ctrl键选择多个期日)</span><br/>
		日期：<input type="text" id="J_input" >&nbsp;&nbsp;
		对应不可见号源日期：<input type="text" id="J_input_1" >
		<button type="button" id="noGen" class="btn btn-primary" onclick="invisilbeSumb()">保 存</button>
		</div>
		
<script>
var ctx = "${ctx}";
	$kit.$(function() {
		//输入框下拉
		$kit.ev({
			el : '#J_input',
			ev : 'focus',
			fn : function(e) {
				var d, ipt = e.target;
				d = e.target[$kit.ui.DatePicker.defaultConfig.kitWidgetName];
				if(d) {
					d.show();
				} else {
					d = new $kit.ui.DatePicker({
						date : ipt.value,
						startDate : GetDateStr(0),
						dateFormat : 'yyyy-mm-dd'
					}).init();
					d.adhere($kit.el('#J_input'));
					d.show();
				}
			}
		});
		$kit.ev({
			el : document,
			ev : 'click',
			fn : function(e) {
				var input = $kit.el('#J_input');
				d = input[$kit.ui.DatePicker.defaultConfig.kitWidgetName];
				if(d && !$kit.contains(d.picker, e.target) && input != e.target) {
					d.hide();
				}
			}
		});

		$kit.ev({
			el : '#J_input_1',
			ev : 'focus',
			fn : function(e) {
				var d, ipt = e.target;
				d = e.target[$kit.ui.DatePicker.defaultConfig.kitWidgetName];
				if(d) {
					d.show();
				} else {
					d = new $kit.ui.DatePicker.NMonths({
						date : ipt.value,
						startDate : GetDateStr(0),
						dateFormat : 'yyyy-mm-dd'
					});
					d.init();
					d.adhere($kit.el('#J_input_1'));
					d.show();
				}
			}
		});
		$kit.ev({
			el : document,
			ev : 'click',
			fn : function(e) {
				var input = $kit.el('#J_input_1');
				d = input[$kit.ui.DatePicker.defaultConfig.kitWidgetName];
				if(d && !$kit.contains(d.picker, e.target) && input != e.target) {
					d.hide();
				}
			}
		});
		

	})
	
	function invisilbeSumb(){
		var jsonDate = "{";
		var dateKey = $("#J_input").val();
		var temp = "";
		var count = 0;
		var dateString = $("#J_input_1").val();
		var result=dateString.split(",");
		for(var i=0;i<result.length;i++){
			//var ttDate = result[i];
			//ttDate = ttDate.replace(/(\d{4}).(\d{1,2}).(\d{1,2}).+/mg, '$1-$2-$3');  
			//var noGenDate = new Date(result[i].replace(/-/g, '/'));
			//alert(noGenDate); 
			count++;
			//resultDate.push(noGenDate);
    		temp += ("\""+result[i]+"\"");
    		temp += ",";	
		  
		}
		if(parseInt(count)<1){
			alert("请选择日期！");
		}else{
			//var dateKeyResult = new Date(dateKey.replace(/-/g, '/'));
			jsonDate += "\""+dateKey+"\":[" + temp + "]}";
		}
		//alert(jsonDate);
		var result1 = eval('(' + jsonDate + ')');
		//alert(result1);
		$.confirm("确定添加吗！", function() {
			var url = ctx + "/holidays/saveInvisible";
			$.ajax({
				type : "POST",
				url : url,
				dataType : "json",
				contentType : "application/json",
				data : $.toJSON(result1),
				success : function(data) {
					alert(data.message);
					window.location.href = '${ctx}/holidays/invisible';
				}
			});
		});
		
	}
	
	//取今天日期
	function GetDateStr(AddDayCount) {
	    var dd = new Date();
	    dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
	    var y = dd.getFullYear();
	    var m = dd.getMonth()+1;//获取当前月份的日期
	    var d = dd.getDate();
	    return y+"-"+m+"-"+d;
	}
</script>
</body>
</html>