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
		<ul>
			<!-- <li>
				<h4>多月日历</h4>
				<div id="J_datePicker"></div>
				<br/>
				<br/>
			</li> -->
			<li>
				<h4>不产生号源日期编辑<span style="color:blue">(请按住Ctrl键选择多个期日)</span></h4>
				<input type="text" id="J_input" value="" style="*zoom:1;">
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
				<br/>
			    <br/>
				<br/>
				<br/>
			</li>
		</ul>
		<button type="button" id="noGen" class="btn btn-primary" onclick="noGenSumb()">保 存</button>
		<script>
		var ctx = "${ctx}";
		$(document).ready(function() {
			var dateString = "${dateString}";
			//alert(dateString);
			$("#J_input").val(dateString);
			
			
		});
			$kit.$(function() {
				//默认日历
				/* window.picker = new $kit.ui.DatePicker.NMonths();
				picker.init();
				$kit.el('#J_datePicker').appendChild(picker.picker);
				picker.show();
				picker.ev({
					ev : 'change',
					fn : function(e) {
						alert(picker.getValue());
					}
				}) */
				
				//输入框下拉
				//开始和结束日期限制
				/* $kit.ev({
					el : '#J_input',
					ev : 'focus',
					fn : function(e) {
						var d
						d = e.target[$kit.ui.DatePicker.defaultConfig.kitWidgetName];
						if(d) {
							d.show();
						} else {
							d = new $kit.ui.DatePicker({
								startDate : GetDateStr(1),
								dateFormat : 'yyyy-mm-dd'
							}).init();
							d.adhere($kit.el('#J_input'));
							d.show();
						}
					}
				}); */
				$kit.ev({
					el : '#J_input',
					ev : 'focus',
					fn : function(e) {
						var d, ipt = e.target;
						d = e.target[$kit.ui.DatePicker.defaultConfig.kitWidgetName];
						if(d) {
							d.show();
						} else {
							d = new $kit.ui.DatePicker.NMonths({
								date : ipt.value,
								startDate : GetDateStr(1),
								dateFormat : 'yyyy-mm-dd'
							});
							d.init();
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
				

			})
			
			function noGenSumb(){
				var resultDate=[];
				//var temp = "";
				var count = 0;
				var dateString = $("#J_input").val();
				var result = [];
				if(dateString!="" && dateString!=null){
				   result=dateString.split(",");
				}
				for(var i=0;i<result.length;i++){
					//var ttDate = result[i];
					//ttDate = ttDate.replace(/(\d{4}).(\d{1,2}).(\d{1,2}).+/mg, '$1-$2-$3');  
					var noGenDate = new Date(result[i].replace(/-/g, '/'));
					//alert(noGenDate); 
					count++;
					//resultDate.push(noGenDate);
		    		//temp += ("\""+result[i]+"\"");
		    		//temp += ",";	
				  
				}
				for(var i=0;i<result.length;i++){
					count++;
					resultDate.push(result[i]);
				  
				}
				var message = "";
				if(parseInt(count)<1){
					message = "您未选择任何日期（删除之前所选日期）,确定这样操作吗！";
					//alert("您未选择任何日期,确定这样操作吗！");
				}else{
					message = "确定这些日期不产生号源吗！";
				}
				//alert(resultDate);
				$.confirm(message, function() {
					var url = ctx + "/holidays/saveNoGenerative";
					$.ajax({
						type : "POST",
						url : url,
						dataType : "json",
						contentType : "application/json",
						data : $.toJSON(resultDate),
						success : function(data) {
							alert(data.message);
							window.location.reload();
						}
					});
				});
			}
			
			//取明天日期
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