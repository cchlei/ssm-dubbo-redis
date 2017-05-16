<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>加号记录列表</title>
<style type="text/css">
.contioner .imgdiv{float: left;width: 100px;}
.contioner .imgurl{float: left; cursor: pointer;padding: 3px;}
.contioner .desc{float: left;padding-top: 10px;width: 100px;}
</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">加号记录列表</a></li>
	</ul>
	<div>
	<form name="form" role="form" action="${ctx}/extraResource/list" method="GET">
	<input id="areaId" name="areaId" type="hidden" value="${params.areaId}"/>
	<input id="hospId" name="hospId" type="hidden" value="${params.hospId}"/>
	<input id="departmentId" name="departmentId" type="hidden" value="${params.departmentId}"/>
	<input id="departmentName" name="departmentName" type="hidden" value="${params.departmentName}"/>
	所在地：  
	<select class="mSelect"  class="mSelect"  id="areaIdParent" name="areaIdParent" onchange="searchArea(this.value,null)">
    <option value="0">请选择</option>
    <c:forEach items="${areaList}" var="area" varStatus="status">
       <c:if test="${area.parentId==0}">
	    	<c:choose>
		       <c:when test="${params.areaIdParent!=null && params.areaIdParent==area.areaId}">
		       		<option value="${area.areaId}" selected="selected">${area.areaName}</option>
		       </c:when>
		       <c:otherwise>
			    	<option value="${area.areaId}">${area.areaName}</option>
			   </c:otherwise>
		   </c:choose> 	
	   </c:if>
    </c:forEach>
    </select>&nbsp;&nbsp;&nbsp;
    <select class="mSelect"  class="mSelect"  id="areaIdChild" name="areaIdChild" onchange="searchHosp(null,this.value,null);">
    <c:choose>
   	    <c:when test="${params.areaId!=null && params.areaId!=params.areaIdParent}">
    	<option>${areaMap[params.areaId]}</option>
	    </c:when>
	    <c:otherwise>
	   	    <option value="0">请选择</option>
	    </c:otherwise>
	</c:choose>
    </select>&nbsp;&nbsp;&nbsp;
    医院：<select class="lSelect"  class="lSelect"  id="hospital" name="hospital" onchange="searchDep(this,null,null)">
    <c:if test="${params.hospId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select><br/>
	医院科室：<select class="mSelect"  class="mSelect"  id="hdParent" name="hdParent" onchange="searchHd(this,1,null,null)">
    <option value="0">请选择</option>
    </select>&nbsp;&nbsp;
    <!-- <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="searchHd(this.value,2);"> -->
    <select class="mSelect"  class="mSelect"  id="hdChild1" name="hdChild1" onchange="selectHd(this);">
    <c:if test="${params.departmentId==null}">
    	<option value="0">请选择</option>
    </c:if>
    </select>&nbsp;&nbsp;
    医生姓名：<input type="text"  id="doctorName" name="doctorName"   style="width:80px;" value="${params.doctorName}"/>&nbsp;&nbsp;&nbsp;
	<input type="submit" value="查询" /><span style="color:blue">(地区和科室查询条件选择到二级有效)</span>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 加号记录列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
				<th class="text-center">就诊人</th>
			    <th class="text-center">所患疾病</th>
				<th class="text-center" width="8%">预约目的</th>
				<th class="text-center" width="12%">方便就诊时间</th>
				<th class="text-center">病情描述</th>
				<th class="text-center">上传的病历/化验单</th>
				<th class="text-center">最后一次就诊医院</th>
				<th class="text-center" width="6%">之前是否看过该医院</th>
				<th class="text-center">申请时间</th>
				<th class="text-center">状态</th>
			</tr>
			</thead>
			<c:forEach items="${extraResourceList}" var="list" varStatus="status">
			<tr>
			    <td>${list.patientName}</td>
				<td>${list.disease}</td>
				<td>
				<c:if test="${list.purpose==1}">检查/诊断</c:if>
				<c:if test="${list.purpose==2}">复诊</c:if>
				<c:if test="${list.purpose==3}">治疗/手术</c:if>
				</td>
				<td>
				<c:if test="${list.status!=5}">
					开始时间：<fmt:formatDate value="${list.diagStartDate}" pattern="yyyy-MM-dd"/>
					结束时间<fmt:formatDate value="${list.diagEndDate}" pattern="yyyy-MM-dd"/>
				</c:if>
				<c:if test="${list.status==5}">
					<fmt:formatDate value="${list.diagDate}" pattern="yyyy-MM-dd"/>
                </c:if>
				</td>
				<td>${list.conditionDesc}</td>
				<td>
				<c:forEach items="${fn:split(list.conditionImgUrls,',')}" var="url">
						            <c:if test="${ null!= url && '' != url}">
						            	<img class="imgurl" alt="检查资料" src="${url }" width="50px" height="50px">
						            </c:if>
						   		 </c:forEach>
				</td>
				<td>${list.lastDiagHospName}</td>
				<td>
				<c:if test="${list.isDiaged==1}">是</c:if>
				<c:if test="${list.isDiaged==0}">否</c:if>
				</td>
				<td><fmt:formatDate value="${list.createDate}" pattern="yyyy-MM-dd"/></td>
				<td>
				<c:if test="${list.status==1}">未处理</c:if>
				<c:if test="${list.status==2}">待就医</c:if>
				<c:if test="${list.status==3}">已拒绝</c:if>
				<c:if test="${list.status==4}">已取消</c:if>
				<c:if test="${list.status==5}">已就医</c:if>
				<c:if test="${list.status==6}">已过期</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<page:page pager="${page}" linkUrl="${ctx}/extraResource/list?areaId=${params.areaId}&areaIdParent=${params.areaIdParent}&hospId=${params.hospId}&departmentId=${params.departmentId}&departmentName=${params.departmentName}&doctorName=${params.doctorName}"/>
<script type="text/javascript">
var ctx = "${ctx}";
$(document).ready(function() {
	//查询条件赋值
	var areaIdParent = "${params.areaIdParent}";
	var areaId = "${params.areaId}";
	var hospId = "${params.hospId}";
	var hdParent = "${params.hdParent}";
	var departmentId = "${params.departmentId}";
	if(areaIdParent!="" && areaId==""){
		searchArea(areaIdParent,null);
		if(hospId!=""){
			searchHosp(areaIdParent,hospId,1);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}else{
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}
		}else{
			searchHosp(areaIdParent,null,1);
		}
	}else if(areaIdParent!="" && areaId!=""){
		searchArea(areaIdParent,areaId);
		if(hospId!=""){
			searchHosp(areaId,hospId,null);
			searchDep(null,hospId,hdParent);
			if(hdParent!=null && hdParent!=departmentId){
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}else{
				searchHd(null,1,hdParent,departmentId);
				$("#departmentId").val(departmentId);
			}
		}else{
			searchHosp(areaId,null,null);
		}
	}
	
	
	
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
	
});
//地区下拉联动
function searchArea(areaId,areaIdChild){
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
			if(areaIdChild!=null && areaIdChild == json[i].areaId){
				option = $("<option>").val(json[i].areaId).text(json[i].areaName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].areaId).text(json[i].areaName);
			}
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#areaIdChild").append(option); 
		} 
	});
	 searchHosp(areaId,null,1);//根据父级地区查询医院
	 /* if(areaId!=0){
	   $("#areaId").val(areaId);
	 }  */
	
}

//医院下拉联动
function searchHosp(areaId,hospId,flag){
	if(areaId==0){
		return;
	}
	var flag = "${params.flag}";
	if(flag!="sources"){
		flag="1";
	}else{
		flag="1";
	}
	var url = ctx+"/doctor/searchHosp";
	$.ajax({  
		type : "post",  
		url : url,  
		data : {'areaId':areaId,'flag':flag},  
		async : false,  
		asyncBoolean:false,
		success : function(data){  
			json = eval(data);
			  // 先清空第二个 
		      $("#hospital").empty(); 
		      var option = "";
		      option = $("<option>").val(0).text("请选择");
		      $("#hospital").append(option); 
			for(var i=0; i<json.length; i++) 
			{ 
				if(hospId!=null && hospId == json[i].hospId){
					option = $("<option>").val(json[i].hospId).text(json[i].hospName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].hospId).text(json[i].hospName);
				}
			    //alert(json[i].areaId+" " + json[i].areaName) 
			    $("#hospital").append(option); 
			} 
		}  
    });
	
	 if(areaId!=0 && hospId!=null && flag!=1){
		   $("#areaId").val(areaId);
		 } 
	
}

//科室下拉联动
function searchDep(obj,hospId1,hdParent){
	var hospId = 0;
	//var hospName = "";
	if(hospId1 != null){
		hospId = hospId1;
	}else{
		hospId = obj.options[obj.selectedIndex].value;
		//hospName = obj.options[obj.selectedIndex].text;
	}
	    
	if(hospId==0){
		return;
	}
	var url = ctx+"/doctor/searchDep";
	var depFlag =  $("#depCheckbox").is(":checked");
	$.post(url,{'hospId':hospId,"depFlag":depFlag},function (data){
		json = eval(data);
		  // 先清空第二个 
	      $("#hdParent").empty(); 
	      var option = "";
	      option = $("<option>").val(0).text("请选择");
	      $("#hdParent").append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			if(hdParent!=null && hdParent == json[i].departmentId){
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
			}else{
				option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
			}
			
		    //alert(json[i].areaId+" " + json[i].areaName) 
		    $("#hdParent").append(option); 
		} 
	});
	if(hospId!=0){
		   $("#hospId").val(hospId);
		   //$("#hospName").val(hospName);
		}

}

//二级科室下拉联动
function searchHd(obj,number,departmentId,departmentIdChild){
	var hdId = 0;
	var hdName ="";
	if(departmentId!=null){
		hdId = departmentId;
	}else{
		hdId = obj.options[obj.selectedIndex].value;
		hdName = obj.options[obj.selectedIndex].text;
	}	
	var flag = "${params.flag}";
	if(flag=="sources"){
		$('#searchDoc').attr('disabled', true);
	}
	if(hdId==0){
		return;
	}
	var hospId = $("#hospId").val();
	var url = ctx+"/doctor/searchHdDep";
	var depFlag =  $("#depCheckbox").is(":checked");
	var selPeram = "";
	$.post(url,{'departmentId':hdId,'hospId':hospId,"depFlag":depFlag},function (data){
		json = eval(data);
		  if(number==1){
			  selPeram = "#hdChild1";
		  }else{
			  selPeram = "#hdChild2";
		  }
		  //添加前先清空
		  $(selPeram).empty(); 
	      var option = "";
	      option = $("<option>").val("").text("请选择");
	      $(selPeram).append(option); 
		for(var i=0; i<json.length; i++) 
		{ 
			//console.log(departmentIdChild+"--"+json[i].departmentId);
			if(flag=="sources"){//号源编辑医生列表页不查出没关联二级科室的医院科室
					if(departmentIdChild!=null && departmentIdChild == json[i].departmentId){
						option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
					}else{
						option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
					}
			    //}
			}else{
				if(departmentIdChild!=null && departmentIdChild == json[i].departmentId){
					option = $("<option>").val(json[i].departmentId).text(json[i].departmentName).prop("selected",true);
				}else{
					option = $("<option>").val(json[i].departmentId).text(json[i].departmentName);
				}
			}
		    $(selPeram).append(option); 
		} 
	});
	 /* if(hdId!=0){
	   $("#departmentId").val(hdId);
	   $("#departmentName").val(hdName);
	}  */
	
} 
function selectHd(obj){
	var hdC = obj.options[obj.selectedIndex].value;
	var hdName = obj.options[obj.selectedIndex].text;
	if(hdC==null || hdC==""){
		$("#searchDoc").attr("disabled","true");
	}
	if(hdC!=0){
		   $("#departmentId").val(hdC);
		   $("#departmentName").val(hdName);
		   $("#searchDoc").removeAttr("disabled");
		}
}

</script>
</body>
</html>