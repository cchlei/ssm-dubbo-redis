<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>短 信 模 板 维 护</title>
<script type="text/javascript" src="/admin/static/js/jquery.form.js"></script>
<style type="text/css">
.modal{
position:absolute;
top: 86%;                 
left: 10%; 
margin: -60px 0px 0px -60px;
}

</style>
</head>
<body>
<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 短 信 模 板 列 表
				<button style="float: right" class="btn btn-danger btn-sm" id="addM">新增</button>
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">模板ID</th>
				<th class="text-center">模板主题</th>
				<th class="text-center">模板内容</th>
				<th class="text-center">模板类别</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${conList}" var="contentTemp" varStatus="status">
			<tr>
				<td>${contentTemp.id}</td>
				<td>${contentTemp.title}</td>
				<td width="40%">${contentTemp.cont}</td>
				<td>${contentTemp.sort}</td>
				<td><a href="#" del_id="${contentTemp.id}" id="del">删除</a>
				<a href="#" edit_id="${contentTemp.id}" id="edit">编辑</a></td>
			</tr>
			</c:forEach> 
		</table>
		<!-- 编辑模态框（Modal） -->
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="editLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="editLabel">编辑</h4>
				</div>
				<div class="modal-body"> 
					<form class="form-horizontal form-input" role="form" id="form" action="${ctx}/contenttemp/update" method="POST">
						<div class="form-group">
							<label for="contentTempId" class="col-sm-2 control-label">模板ID</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="contentTempId" name="id" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label">模板主题</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="title" name="title">
							</div>
						</div>
						<div class="form-group">
							<label for="content" class="col-sm-2 control-label">模板内容</label>
							<div class="col-sm-10">
								<textarea type="text" class="form-control" id="cont" name="cont"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="sort" class="col-sm-2 control-label">模板类别</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="sort" name="sort">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="submit" >提交更改</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>	
			<!-- 新增模态框（Modal） -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="addLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="addLabel">新增</h4>
				</div>
				<div class="modal-body"> 
					<form class="form-horizontal form-input" role="form" id="form1" action="${ctx}/contenttemp/save" method="POST">
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label">模板主题</label>
							<div class="col-sm-10">
								<input type="text" class="form-control"  name="title">
							</div>
						</div>
						<div class="form-group">
							<label for="content" class="col-sm-2 control-label">模板内容</label>
							<div class="col-sm-10">
								<textarea type="text" class="form-control"  name="cont"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="sort" class="col-sm-2 control-label">模板类别</label>
							<div class="col-sm-10">
								<input type="text" class="form-control"  name="sort">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="add" >确认添加</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
		<script type="text/javascript">
		   $(document).ready(function(){
			   $(".table-bordered td #del").bind("click",function(){
				   if ($(this).attr('del_id')) {
					var id = $(this).attr('del_id');
					$.confirm("确定要删除此条数据吗？删除后不可恢复！",function(){
						$.get("${ctx}/contenttemp/delete/"+id,function(json) {
							var msg = "";
							if (json.message) {
								msg = json.message;
							}
							$.alert(msg, function() {
								window.location.reload();
							});
						},"json");
					});
				}
			   });
		   });
		 
			$(document).ready(function() {
				$(".table-bordered td #edit").bind("click", function() {
					if ($(this).attr('edit_id')) {
						var id = $(this).attr('edit_id');
						$.get("${ctx}/contenttemp/get/" + id, function(json) {
							if (json.results) {
								var obj = json.results;
							}
							$("#contentTempId").val(obj.id);
							$("#sort").val(obj.sort);
							$("#title").val(obj.title);
							$("#cont").val(obj.cont);
						}, "json");
						$("#editModal").modal("show");
					}
				});
			});

			$(document).ready(function() {
				$("#submit").bind("click", function() {
					$('#form').ajaxSubmit({
						success : function(json) {
							var msg = "";
							if (json.message) {
								msg = json.message;
							}
							$.alert(msg, function() {
								window.location.reload();
							});
						}
					});
				});
			});

			
			$(document).ready(function() {
				$("#addM").bind("click", function() {
					$("#addModal").modal("show");
				});

				$("#add").bind("click", function() {
					$("#form1").ajaxSubmit({
						success : function(json) {
							var msg = "";
							if (json.message) {
								msg = json.message;
							}
							$.alert(msg, function() {
								window.location.reload();
							});
						}
					});
				})
			});
		</script>
	</div>
</body>
</html>