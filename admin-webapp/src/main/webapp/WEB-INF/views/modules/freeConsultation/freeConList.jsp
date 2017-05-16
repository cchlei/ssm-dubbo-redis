<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>免费咨询管理</title>
<style type="text/css">
.contioner .imgdiv{float: left;width: 100px;}
.contioner .imgurl{float: left; cursor: pointer;padding: 3px;}
.contioner .desc{padding-top: 10px;width: 100px;}
</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">列表</a></li>
	</ul>
	<br/>
	 <div class="form-group">
	 <form name="form" role="form" action="${ctx}/freeConsultation/list" method="GET">
	  <!-- 标准 -->科室名称：
	 <select class="mSelect"  class="mSelect"  id="standardDepIdParent" name="standardDepIdParent" onchange="searchStandardDep(this.value,null);">
	 	<option value="0">请选择</option>
	    <c:forEach items="${standardDepartmentList}" var="standardDep" varStatus="status">
	       <c:if test="${standardDep.parentId==0}">
		    	<c:choose>
			       <c:when test="${params.standardDepIdParent!=null && params.standardDepIdParent==standardDep.standardDepartmentId}">
			       		<option value="${standardDep.standardDepartmentId}" selected="selected">${standardDep.departmentName}</option>
			       </c:when>
			       <c:otherwise>
				    	<option value="${standardDep.standardDepartmentId}">${standardDep.departmentName}</option>
				   </c:otherwise>
			   </c:choose> 	
		   </c:if>
	    </c:forEach>
	    </select>&nbsp;&nbsp;&nbsp;
	    <select class="mSelect"  class="mSelect"  id="standardDepIdChild" name="standardDepIdChild">
	    <c:choose>
	   	    <c:when test="${params.standardDepIdChild!=null && params.standardDepIdChild!=params.standardDepParentId}">
	    	<option value="${params.standardDepIdChild }">${standardDepChildMap[params.standardDepIdChild]}</option>
		    </c:when>
		    <c:otherwise>
		   	    <option value="0">请选择</option>
		    </c:otherwise>
		</c:choose>
	    </select>&nbsp;&nbsp;&nbsp;
	    <input id="departmentId" name="departmentId" type="hidden" value="${params.standardDepIdChild }"/>
		 &nbsp;&nbsp; <button type="button" class="btn" onclick="subBut();">确定</button>
	  </form>
	 </div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i>列 表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">患者</th>
				<th class="text-center">患病时长</th>
				<th class="text-center">是否检查过</th>
				<th class="text-center">就诊过的医院科室</th>
				<th class="text-center">所患疾病</th>
				<th class="text-center">上传检查资料</th>
				<th class="text-center">病情描述</th>
				<th class="text-center">药物治疗情况</th>
				<th class="text-center">其他治疗经历</th>
				<th class="text-center">咨询标题</th>
				<th class="text-center">咨询内容</th>
				<th class="text-center">发起时间</th>
			</tr>
			</thead>
			<c:forEach items="${freeConList }" var="freeCon">
				<tr>
					<td class="text-center">${freeCon.patientName}</td>
					<td class="text-center">${freeCon.diseaseDays}</td>
					<td class="text-center">${freeCon.isCheckUp==1?'是':'否'}</td>
					<td class="text-center">${freeCon.diagDepartmentName }</td>
					<td class="text-center">${freeCon.disease }</td>
					<td class="text-center">
						<div class="contioner">
					    	<div class="imgdiv">
						    	<c:forEach items="${fn:split(freeCon.checkUpInfoImgUrls,',')}" var="url">
						            <c:if test="${ null!= url && '' != url}">
						            	<img class="imgurl" alt="检查资料" src="${url }" width="50px" height="50px">
						            </c:if>
						   		 </c:forEach>
						    </div>
						    <div class="desc">${freeCon.checkUpInfoDesc }</div>
					    </div>
					</td>
					<td class="text-center">
					    <div class="contioner">
					    	<div class="imgdiv">
						    	<c:forEach items="${fn:split(freeCon.diseaseInfoImgUrls,',')}" var="url">
						            <c:if test="${ null!= url && '' != url}">
						            	<img class="imgurl" alt="疾病描述资料" src="${url }" width="50px" height="50px">
						            </c:if>
						   		 </c:forEach>
						    </div>
						    <div class="desc">${freeCon.diseaseInfoDesc }</div>
					    </div>
					</td>
					<td class="text-center">
						<div class="contioner">
					    	<div class="imgdiv">
						    	<c:forEach items="${fn:split(freeCon.drugTreatmentInfoImgUrls,',')}" var="url">
						            <c:if test="${ null!= url && '' != url}">
						            	<img class="imgurl" alt="药物治疗附件" src="${url }" width="50px" height="50px">
						            </c:if>
						   		 </c:forEach>
						    </div>
						    <div class="desc">${freeCon.drugTreatmentInfoDesc }</div>
					    </div>
					</td>
					<td class="text-center">
						<div class="contioner">
					    	<div class="imgdiv">
						    	<c:forEach items="${fn:split(freeCon.otherTreatmentInfoImgUrls,',')}" var="url">
						            <c:if test="${ null!= url && '' != url}">
						            	<img class="imgurl" alt="其他药物治疗附件" src="${url }" width="50px" height="50px">
						            </c:if>
						   		 </c:forEach>
						    </div>
						    <div class="desc">${freeCon.otherTreatmentInfoDesc }</div>
					    </div>
					</td>
					<td class="text-center">${freeCon.consultationTitle }</td>
					<td class="text-center">${freeCon.consultationSummary }</td>
					<td class="text-center"><fmt:formatDate value="${freeCon.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/freeConsultation/list?departmentId=${params.departmentId }&standardDepIdParent=${params.standardDepIdParent }&standardDepIdChild=${params.standardDepIdChild }"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//刷新科室
			var standardDepIdChild = "${params.standardDepIdChild}";
			searchStandardDep($("#standardDepIdParent").val(),standardDepIdChild);
			
			
			/*-----------图片显示---------*/
			$(window.parent.document).find("#showimg").remove();
			$(window.parent.document).find('body').append('<div id="showimg" class="modal"><img  src="" style="cursor: pointer;text-align: center;" /></div>');
			
			var $showimg = $(window.parent.document).find("#showimg");
			$showimg.css({"margin": "auto","display": "none","position": "fixed","text-align": "center","line-height":"100vh","height":"100vh"});
			
			$(".tablesorter .imgurl").click(function(){
				var $this = $(this);
				$showimg.find("img").attr("src",$this.attr("src"));
				$showimg.show();
			});
			
			 $showimg.click(function(){
				$showimg.hide();
			});
			 
			/*-----------图片显示---------*/
		});
		 /*-----------查询 start---------*/
		function subBut(){
			
			var standardDepIdChild = $("#standardDepIdChild").val();
			if(standardDepIdChild == ""){
				alert("请选择科室!");
				return;
			}
			var departmentId = $("#standardDepIdChild").val();
			 if(departmentId!=0){
			   $("#departmentId").val(departmentId);
			 } 
			this.form.submit();  
		};
		/*------------查询 end---------*/
		
		function searchStandardDep(standardDepartmentId,standardDepIdChild){
			 // 先清空第二个 
		      $("#standardDepIdChild").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#standardDepIdChild").append(option);
			if(standardDepartmentId==0){
				return;
			}
			var url = "${ctx}"+"/freeConsultation/searchStandardDepartment";
			$.post(url,{'standardDepartmentId':standardDepartmentId},function (data){
				json = eval(data);
			      $.each(data,function(entryIndex,entry){
			    	  if(standardDepIdChild!=null && standardDepIdChild == entry.standardDepartmentId){
							option = $("<option>").val(entry.standardDepartmentId).text(entry.departmentName).prop("selected",true);
						}else{
							option = $("<option>").val(entry.standardDepartmentId).text(entry.departmentName);
						}
					    $("#standardDepIdChild").append(option); 
			      });
			});
		}
		
		
	</script>
</body>
</html>