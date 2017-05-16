<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>日期到日期不可见列表页</title>
</head>

<body>
		<table class="table table-bordered table-hover tablesorter" id="table1">
		<thead>
			<tr id="headId">
				<th>日期</th>
				<th>对应不可见号源日期</th>
				<th>操作</th>
			</tr>
		</thead>
		<a href="${ctx}/holidays/addInvisible" >新增+</a><br/>
		
		</table>
		
<script type="text/javascript">
	var ctx = "${ctx}";
	$(document).ready(function() {
		var data = eval('(' + '${data}' + ')');
		initInvisibleData(data);
		
		$(".table-bordered td a").bind("click", function(){
			if ($(this).attr('del_id')) {
				var id = $(this).attr('del_id');
				$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
					$.get("${ctx}/holidays/delete/"+id, function(json) {
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
		});
	});
	
	function initInvisibleData(data){
		$.each(data, function(i, n) { 
			addDataRow("table1",i,n);
		}); 
	}
	
	function addDataRow(tableId,key,value){
		var bodyObj=document.getElementById(tableId);  
		 bodyObj.style.display = '';
		    if(bodyObj==null)   
		    {  
		        alert("Body of Table not Exist!");  
		        return;  
		    }  
		    var rowCount = bodyObj.rows.length;  
		    var newRow = bodyObj.insertRow(rowCount++);    
		    var firstCell = newRow.insertCell(0);
		    var secondCell = newRow.insertCell(1);
		    var thirdCell = newRow.insertCell(2);
		    
		    firstCell.style.width="100px";
		    secondCell.style.width="150px";
		    thirdCell.style.width="150px";
		    
		    firstCell.innerHTML = key;
		    secondCell.innerHTML = value;
		    thirdCell.innerHTML = "<a href='#' del_id='"+key+"'>删除</a>";
	}
	
</script>
</body>
</html>