<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>号源管理</title>
 
<style>  
/*  input:focus{  
    border:1px solid #f00;  
    background:#fcc;  
 }   */
 .focus{  
    border:1px solid #f00;  
    background:#fcc;  
 }  
</style> 

</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">号源管理</a></li>
	</ul>
	<%-- <a href="${ctx}/tag/list">跳转到标签列表页面</a> --%>
	<br />
	<form class="form-horizontal form-input" name="form1" id="form1" role="form" action="${ctx}/sources/save" method="POST">
	<!-- <input id="doctorId" name="doctorId" type="hidden" value="1418630649587009"/> -->
	<input id="doctorId" name="doctorId" type="hidden" value="${doctorId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${departmentId}"/>
	<input id="subflag" name="subflag" type="hidden" value="0"/>
	<input id="subflag2" name="subflag2" type="hidden" value="0"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label style="font-size:20px;">${hospName}-${departmentName}-${doctorName}</label>
		<div class="form-group">
			<label for="isTimespan" class="col-sm-2 control-label">是否分时段预约挂号：</label>
			<div class="col-sm-4">
			    <c:if test="${doctorResource.isTimespan!=null && doctorResource.isTimespan!=''}">
					<select class="mSelect"  class="mSelect"  id="isTimespan" name="isTimespan"  onchange="ifShow(this.value,'1');">
				</c:if>
				<c:if test="${doctorResource.isTimespan==null}">
					<select class="mSelect"  class="mSelect"  id="isTimespan" name="isTimespan"  onchange="ifShow(this.value,'2');">
				</c:if>
				 <option value="1">是</option>
				 <option value="2" selected="selected">否</option>
				</select>
			</div>
			

			<div class="col-sm-5 help-block Validform_checktip">修改时若更换号源模板类型会删除之前的模板！</div><br>
			<label for="singleDoubleWeek" class ="col-sm-2 control-label" >隔周排班：</label>
			<div class ="col-sm-4">
			<select class="mSelect"  class="mSelect"  name="singleDoubleWeek" id="singleDoubleWeek">
			<option value="0">全部</option>
			<option value="1">单周</option>
			<option value="2">双周</option>
			</select>
			</div>
			<br/>
			<label for="weeked" class="col-sm-2 control-label">当前日期周数:${weeked}</label>
			<label for="resourceReservedNum" class="col-sm-2 control-label">预留号源数:${resourceReservedNum}</label>
			

		</div>
<!-- 上午下午标签开始 -->
	<div id ="showDiv1">
		<ul class="nav nav-tabs">
			<li class="active" id="sel1" onclick="sel('sel','1','7')"><a href="javascript:void(0)" >星期一</a></li>
			<li id="sel2" onclick="sel('sel','2','7')"><a href="javascript:void(0);" >星期二</a></li>
			<li id="sel3" onclick="sel('sel','3','7')"><a href="javascript:void(0);">星期三</a></li>
			<li id="sel4" onclick="sel('sel','4','7')"><a href="javascript:void(0);">星期四</a></li>
			<li id="sel5" onclick="sel('sel','5','7')"><a href="javascript:void(0);">星期五</a></li>
			<li id="sel6" onclick="sel('sel','6','7')"><a href="javascript:void(0);">星期六</a></li>
			<li id="sel7" onclick="sel('sel','7','7')"><a href="javascript:void(0);">星期日</a></li>
	    </ul>
	    <div id="selCon1">
			<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
			<label>预约开始时间(小时)：</label>
			<input type="text"  name="beginRegisterTime" style='width:60px'/ >
			<label>预约截止/取消时间(小时)：</label>
			<input type="text"  name="overRegisterTime" style='width:60px'/ >
		<table class="table table-bordered table-hover tablesorter"  id="tableS1">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon1')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon1','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
		 </table>
		</div>
	
	<div id="selCon2" style="display:none">
	<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
		<label>预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<table class="table table-bordered table-hover tablesorter" id="tableS2">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon2')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon2','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			</table>
		</div>
	<div id="selCon3" style="display:none">
	<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
		<label>预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<table class="table table-bordered table-hover tablesorter" id="tableS3">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon3')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon3','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
			<!-- 	<td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
		</table>
	</div>
	<div id="selCon4" style="display:none">
	<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
		<label>预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<table class="table table-bordered table-hover tablesorter" id="tableS4">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon4')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon4','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
		</table>
	</div>
	<div id="selCon5" style="display:none">
	<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
		<label>预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<table class="table table-bordered table-hover tablesorter" id="tableS5">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon5')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon5','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
		</table>
	</div>
	<div id="selCon6" style="display:none">
	<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
		<label>预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<table class="table table-bordered table-hover tablesorter"  id="tableS6">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon6')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon6','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
		</table>
	</div>
	<div id="selCon7" style="display:none">
	<%-- <label>挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="resourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select> --%>
		<label>预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<table class="table table-bordered table-hover tablesorter" id="tableS7">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'selCon7')">全选/反选</th>
			    <th class="text-center">挂号类型</th>
			    <th class="text-center">挂号费</th>
			    <th class="text-center">取号地点</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'selCon7','1')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
			</tr> 
			</thead>
			<tr>
				<td>上午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
			<tr>
				<td>下午&nbsp;&nbsp;<input type='checkbox'>选中</td>
				<td>
				<select class="mSelect"  class="mSelect"  name="resourceTpye">
					<c:forEach items="${dicList}" var="dic" varStatus="status">
					  <option value="${dic.dictId}">${dic.dictName}</option>
					</c:forEach>
				</select>
				</td>
				<td><input type="text" style='width:80px' name="amexpense" /></td>
				<td><input type="text" style='width:100%'/></td>
				<td><input type="text" style='width:80px' name="source"/></td>
				<!-- <td><input type="text" name='beginTime' style='width:80px'/></td>
				<td><input type="text" name='endTime' style='width:80px'/></td> -->
			</tr>
		</table>
	</div>
<!-- 上午下午标签结束 -->
</div>
<!-- 分时段标签开始 -->
<div id ="showDiv2"  style="display:none">
		<ul class="nav nav-tabs">
			<li class="active" id="tel1" onclick="sel('tel','1','7')"><a href="javascript:void(0)" >星期一</a></li>
			<li id="tel2" onclick="sel('tel','2','7')"><a href="javascript:void(0);" >星期二</a></li>
			<li id="tel3" onclick="sel('tel','3','7')"><a href="javascript:void(0);">星期三</a></li>
			<li id="tel4" onclick="sel('tel','4','7')"><a href="javascript:void(0);">星期四</a></li>
			<li id="tel5" onclick="sel('tel','5','7')"><a href="javascript:void(0);">星期五</a></li>
			<li id="tel6" onclick="sel('tel','6','7')"><a href="javascript:void(0);">星期六</a></li>
			<li id="tel7" onclick="sel('tel','7','7')"><a href="javascript:void(0);">星期日</a></li>
	    </ul>
	    <!-- 分时段--星期一开始 -->
	    <div id="telCon1">
	    <label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table11">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon1')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon1','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table11','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table12">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table12','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期一结束 -->
		</div>
		<!-- 分时段--星期二开始 -->
		<div id="telCon2" style="display:none">
		<label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table21">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon2')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon2','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table21','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table22">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table22','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期二结束 -->
		</div>
		<!-- 分时段--星期三开始 -->
		<div id="telCon3" style="display:none">
		<label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table31">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon3')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon3','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table31','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table32">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table32','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期三结束 -->
		</div>
		<!-- 分时段--星期四开始 -->
		<div id="telCon4" style="display:none">
		<label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table41">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon4')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon4','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table41','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table42">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table42','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期四结束 -->
		</div>
		<!-- 分时段--星期五开始 -->
		<div id="telCon5" style="display:none">
		<label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table51">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon5')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon5','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table51','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table52">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table52','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期五结束 -->
		</div>
		<!-- 分时段--星期六开始 -->
		<div id="telCon6" style="display:none">
		<label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table61">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon6')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon6','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table61','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table62">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table62','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期六结束 -->
		</div>
	<!-- 分时段--星期日开始 -->
	<div id="telCon7" style="display:none">
	<label>“当天号源”预约开始时间(小时)：</label>
		<input type="text"  name="beginRegisterTime" style='width:60px'/ >
		<label>预约截止/取消时间(小时)：</label>
		<input type="text"  name="overRegisterTime" style='width:60px'/ >	
		<br/>
	    <label>“上午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="amResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="amexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="amretrieveAddress" style='width:200px'/ >		
		<br/>
		<table class="table table-bordered table-hover tablesorter" id="table71">
			<thead>
			<tr>
			    <th><input type='checkbox' name="selectall" onclick="selectAll(this,'telCon7')">全选/反选</th>
			    <th class="text-center">开始时段</th>
			    <th class="text-center">截止时段</th>
			    <th><input type="text" style='width:80px'/>&nbsp;&nbsp;<input type="button" value="同步号源" onclick="sameSource(this,'telCon7','2')">&nbsp;&nbsp;号源数</th>
				<!-- <th class="text-center">预约开始时间</th>
				<th class="text-center">预约结束时间</th> -->
				<th class="text-center">操作</th>
			</tr> 
			</thead>
			
		 <a href="javascript:void(0);" onclick="addNewRow('table71','1');">添加行</a>
		 </table>
		 <label>“下午号源”挂&nbsp;号&nbsp;类&nbsp;型：</label>
		    <select class="mSelect"  class="mSelect"  name="pmResourceTpye">
				<c:forEach items="${dicList}" var="dic" varStatus="status">
				  <option value="${dic.dictId}">${dic.dictName}</option>
				</c:forEach>
			</select>
		<label>挂号费：</label>
		<input type="text"  name="pmexpense" style='width:60px'/ >	
		<label>取号地点：</label>
		<input type="text"  name="pmretrieveAddress" style='width:200px'/ >		
		<br/>
		 <table class="table table-bordered table-hover tablesorter" id="table72">
			<thead>
			
			<a href="javascript:void(0);" onclick="addNewRow('table72','2');">添加行</a>
		 </table>
		 <!-- 分时段--星期日结束 -->
		</div>
	<!-- 分时段标签结束 -->
	</div>	
	
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" id="fat-btn" onclick="saveSource();" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<!-- <button type="button" class="btn" onclick="history.go(-1)">返 回</button> -->
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div> 
	</form>
	<br />
<%-- </div> --%>

<script type="text/javascript">
		var ctx = "${ctx}";
		var resourceDays ="${resourceDays}";
	$(document).ready(function() {
		var ifModify = "${ifModify}";
		if(ifModify=="1"){
			document.form1.action=ctx+"/sources/update"; 
			//初始化是否分时段下拉框
			var isTimespan = "${doctorResource.isTimespan}";
			$("#isTimespan").val(isTimespan);
			//初始化隔周排班属性
			var singleDoubleWeek = "${doctorResource.singleDoubleWeek}"
			$("#singleDoubleWeek").val(singleDoubleWeek);
			ifShow(isTimespan);
			//初始化表格数据
			var data = eval('(' + '${data}' + ')');
			if(isTimespan==1){
				initTimeData(data);
			}else if(isTimespan==2){
				initDayData(data);//初始化上午下午号源数据
				var timeQuantum = eval('(' + '${timeQuantum}' + ')');
				initTimeQuantum(timeQuantum);
			}
		}else{
			//初始化预约开始时间和预约结束时间
			var beginRegisterTime = "${beginRegisterTime}";
			var overRegisterTime = "${overRegisterTime}";
			$("input[name='beginRegisterTime']").val(beginRegisterTime);
			$("input[name='overRegisterTime']").val(overRegisterTime);
			//初始化时间段
			var timeQuantum = eval('(' + '${timeQuantum}' + ')');
			initTimeQuantum(timeQuantum);
		}
		
		//验证时间段开始时间格式
		$("input[name='start']").blur(function (){
			var a = $(this).val();
			var reg = /^(\d{1,2}):(\d{1,2})$/;     
	        var r = a.match(reg);     
	        if(r==null) {   
	        	$(this).addClass("focus");  
				$("#subflag2").val("1");
	            alert("开始时段格式不正确！");   
	   		 }else{
				$(this).removeClass("focus");
				$("#subflag2").val("0");
			}
		});
		//验证时间段结束时间格式
		$("input[name='end']").blur(function (){
			var a = $(this).val();
			var reg = /^(\d{1,2}):(\d{1,2})$/;     
	        var r = a.match(reg);     
	        if(r==null) {   
	        	$(this).addClass("focus");  
				$("#subflag2").val("1");
	            alert("结束时段格式不正确！");   
	   		 }else{
				$(this).removeClass("focus");
				$("#subflag2").val("0");
			}
		});
		
		//验证预约开始时间不能超过14*24小时
		$("input[name='beginRegisterTime']").blur(function (){
			var a = $(this).val();
			if(parseInt(a)>(resourceDays*24)){
				//alert($(this).val());
				$(this).addClass("focus");  
				$("#subflag").val("1");
				alert("预约开始时间不能超过"+resourceDays+"*24小时！");
			}else{
				$(this).removeClass("focus");
				$("#subflag").val("0");
			}
		});
		//验证预约结束时间不能大于预约开始时间
		$("input[name='overRegisterTime']").blur(function (){
			var a = $(this).val();
			var b = $(this).parent().parent().find($("input[name='beginRegisterTime']")).val();
			if(parseInt(a)>=parseInt(b)){
				$(this).addClass("focus");  
				$("#subflag").val("1");
				alert("预约结束时间不能超过或等于预约开始时间！");
			}else{
				$(this).removeClass("focus");
				$("#subflag").val("0");
			}
		});
	    //验证挂号费格式
	    $("input[name='amexpense']").blur(function (){
	    	if(this.value=="" || this.value=="0"){
	    		$(this).removeClass("focus");
				return;
			}
	    	//var isNum = /^\d+(\.\d+)?$/
	    	var isMoney = /^[\d]{1,7}(.[\d]{1,2})?$/;
	    	if(!isMoney.test(this.value)) {
	    		$(this).addClass("focus");
	    		alert("挂号费格式不正确，小数点前最多7位，小数点后最多两位！");
	    	}else{
	    		$(this).removeClass("focus");
	    	}
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
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						//window.location.href = '${ctx}/link/list';
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
	
</script>
</html>