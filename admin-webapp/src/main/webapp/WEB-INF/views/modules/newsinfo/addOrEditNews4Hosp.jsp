<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>资讯新闻编辑</title>

</head>

<body>
<%-- <div id="content" class="col-md-10"> --%>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">资讯新闻编辑</a></li>
	</ul>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <span style="color:red;margin-left:0px">注意：图片请使用jpg格式！</span></p>
	<c:if test="${newsInfo!=null&&newsInfo!=''}">
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/news/update" method="POST">
	</c:if>
	<c:if test="${newsInfo==null||newsInfo==''}">
	<form class="form-horizontal form-input" name="form1" role="form" action="${ctx}/news/save4Hosp" method="POST">
	</c:if>
	    <c:if test="${newsInfo!=null}">
			<input id="newsId" name="newsId" type="hidden" value="${newsInfo.newsId}"/>
	    </c:if>
		<input id="imageurl" name="imageurl" type="hidden" value="${newsInfo.imageurl}"/>
		<input id="conImgUrl" name="conImgUrl" type="hidden" value="${newsInfo.conImgUrl}"/>
		<input id="imgflag" name="imgflag" type="hidden" value="${newsInfo.imageurl}"/>
		
		<%-- <input id="abstracts" name="abstracts" type="hidden" value="${newsInfo.abstracts}"/> --%>
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><span style="color:red;">*</span>标 &nbsp; &nbsp;题：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="title" name="title" placeholder="标题" datatype="*2-100"
					nullmsg="请输入标题！" errormsg="标题至少2个字符,最多100个字符！" value="<c:out value='${newsInfo.title}'/>">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="abstracts" class="col-sm-2 control-label"><span style="color:red;">*</span>摘 &nbsp; &nbsp;要：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="abstracts" name="abstracts" placeholder="摘要" datatype="*2-30"
					nullmsg="请输入摘要！" errormsg="摘要至少2个字符,最多30个字符！" value="<c:out value='${newsInfo.abstracts}'/>">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">关&nbsp; &nbsp;键 &nbsp; &nbsp;字：</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="keywords" name="keywords" placeholder="关键字" datatype="*0-100"
					nullmsg="请输入关键字！" errormsg="可以为空！" value="${newsInfo.keywords}">
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><span style="color:red;">*</span>标 &nbsp; &nbsp;签：</label>
			<div class="col-sm-5">
			    <c:forEach items="${newsTags}" var="tag" varStatus="status">
			   <c:if test="${tag.status!=2}">
			    <c:if test="${(status.count+2)%3==0}"><br/></c:if>
			    <c:if test="${selectedTags[tag.tagId]!=null}">
			    <input type="checkbox" id="tag" name="tag" checked="checked" value="${tag.tagId}"/>${tag.tagName}&nbsp; &nbsp;
			    </c:if>
			    <c:if test="${selectedTags[tag.tagId]==null}">
			    <input type="checkbox" id="tag" name="tag" value="${tag.tagId}"/>${tag.tagName}&nbsp; &nbsp;
			    </c:if>
			   </c:if>
			    </c:forEach>
			    <br/><a href="${ctx}/tag/toAddorEdit?flag=2">添加新标签-></a>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
<%-- 		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"><span style="color:red;">*</span>显&nbsp;示&nbsp;端：</label>
			<div class="col-sm-5">
			    <c:if test="${newsInfo.pavoShow==1 || newsInfo==null}">
			    <input type="checkbox" id="pavoShow" name="pavoShow" checked="checked" value="1"/>导医通端
			    </c:if>
			     <c:if test="${newsInfo.pavoShow==0}">
			    <input type="checkbox" id="pavoShow" name="pavoShow"  value="0"/>导医通端
			    </c:if>
			    <c:if test="${newsInfo.physicalShow==1}">
			    <input type="checkbox" id="physicalShow" name="physicalShow" checked="checked" value="1"/>体检宝端
			    </c:if>
			    <c:if test="${newsInfo.physicalShow==0 || newsInfo==null}">
			    <input type="checkbox" id="physicalShow" name="physicalShow" value="0"/>体检宝端
			    </c:if>
			</div>
		<div class="col-sm-5 help-block Validform_checktip"></div>
		</div> --%>
		
		
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label"> 内&nbsp; &nbsp;容&nbsp; &nbsp;图&nbsp; &nbsp;片&nbsp; &nbsp;上 &nbsp; &nbsp;传：</label>
			<br/>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file1"/><br/><input type="button" value="上传" onclick="upimg(1);" />  
				 &nbsp; &nbsp;<span style="color:red;margin-left:0px">图片大小不能超过500k，且图片高/宽不能 > 2！</span>	
			</div>
			<%-- <div class="col-sm-5 help-block Validform_checktip"></div><img src="${ctx}${'/'}${newsInfo.conImgUrl}" id="img1" width="100px" height="100px"  /> --%>
			<div class="col-sm-5 help-block Validform_checktip"></div><img src="${ctx}/showImage/showImg?path=${newsInfo.conImgUrl}" id="img1" width="100px" height="100px"  />
		</div>
		
		<div class="form-group">
			<label for="saytext" class="col-sm-2 control-label"><span style="color:red;">*</span>资&nbsp; &nbsp;讯&nbsp; &nbsp;内&nbsp; &nbsp;容：</label>
			<div class="col-sm-5">
			<div id="aa"><script id="editor" name="content" type="text/plain" style="width:700px;height:400px;"></script></div>
				<!-- <textarea class="form-control" id="content" name="content" clos="20" rows="10"></textarea> -->
			</div>
			<div class="col-sm-5 help-block Validform_checktip" id="nLength"></div>
		</div>
		
		<%-- <div class="form-group">
			<label for="saytext" class="col-sm-2 control-label">是 &nbsp;否 &nbsp;推 &nbsp;荐 &nbsp;到 &nbsp;首 &nbsp;页：</label>
			<div class="col-sm-4">
				<select class="mSelect"  class="mSelect"  id="ifHomePage" name="ifHomePage">
				 <c:if test="${newsInfo.ifHomePage==2||newsInfo.ifHomePage==null}">
				 <option value="2" selected="selected">否</option>
				 <option value="1">是</option>
				 </c:if>
				 <c:if test="${newsInfo.ifHomePage==1}">
				 <option value="2">否</option>
				 <option value="1" selected="selected">是</option>
				 </c:if>
				</select>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		 --%>
		<div class="form-group">
			<label for="saytext" class="col-sm-2 control-label">阅&nbsp; &nbsp;读 &nbsp; &nbsp;数：</label>
			<div class="col-sm-4">
			    <c:if test="${newsInfo.readTimes==''||newsInfo.readTimes==null}">
					<input type="text" class="form-control" id="readTimes" name="readTimes" placeholder="0" datatype="n"
						nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="0">
			    </c:if>
			    <c:if test="${newsInfo.readTimes!=''&&newsInfo.readTimes!=null}">
					<input type="text" class="form-control" id="readTimes" name="readTimes" placeholder="0" datatype="n"
						nullmsg="请输入一个数字！" errormsg="只能输入数字类型！" value="${newsInfo.readTimes}">
			    </c:if>
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div>
		</div>
		
		<div class="form-group">
			<label for="saytext" class="col-sm-2 control-label">权 &nbsp; &nbsp;重：</label>
			<div class="col-sm-4">
				<c:if test="${newsInfo.weight==''||newsInfo.weight==null}">
					<input type="text" class="form-control" id="weight" name="weight" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="1">
			    </c:if>
			    <c:if test="${newsInfo.weight!=''&&newsInfo.weight!=null}">
					<input type="text" class="form-control" id="weight" name="weight" placeholder="1" datatype="n" min="1" 
					nullmsg="请输入一个大于等于1的数字！" errormsg="只能输入数字类型！" value="${newsInfo.weight}">
			    </c:if>
				
			</div>
			<div class="col-sm-5 help-block Validform_checktip">(越大越靠前)</div>
			<!-- <br/><br/><span id="wmessage" style="color:red;margin-left:180px"></span> -->
		</div>
		
		<div class="form-group" style="display:none">
			<label for="title" class="col-sm-2 control-label"><span style="color:red;">*</span>列&nbsp;表&nbsp;显&nbsp;示&nbsp;图 &nbsp;片 &nbsp;上  &nbsp;传：</label>
			<div class="col-sm-5">
				 <input type="file" name="file" id="file"/><br/><input type="button" value="上传" onclick="upimg(2);" />  
				 &nbsp; &nbsp;<span style="color:red;margin-left:0px">图片大小不能超过500k！</span>		
			</div>
			<div class="col-sm-5 help-block Validform_checktip"></div><img src="${ctx}/showImage/showImg?path=${newsInfo.imageurl}" id="img" width="100px" height="100px"  />
		</div> 
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="fat-btn" class="btn btn-primary" data-loading-text="正在保存...">保 存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn" onclick="history.go(-1)">返 回</button>
				<span id="msg-info" style="margin-left:10px;"></span>
			</div>
		</div>
	</form>
	<br />
<%-- </div> --%>

<script type="text/javascript" >
var ctx = "${ctx}";
var ue = UE.getEditor('editor',{
    maximumWords:10000 
});
	 $(document).ready(function() {
		 var text = "${newsInfo.content}";
		 console.log(text);
		ue.ready(function() {
		ue.setContent(text);  //赋值给UEditor
		
		$("[name = pavoShow]:checkbox").bind("click", function () {
			var pCheckBox = $("[name = pavoShow]:checkbox").prop('checked');
			if(pCheckBox){
				$("[name = pavoShow]:checkbox").val('1');
			}else{
				$("[name = pavoShow]:checkbox").val('0');
			}
		 });
		$("[name = physicalShow]:checkbox").bind("click", function () {
			var pCheckBox = $("[name = physicalShow]:checkbox").prop('checked');
			if(pCheckBox){
				$("[name = physicalShow]:checkbox").val('1');
			}else{
				$("[name = physicalShow]:checkbox").val('0');
			}
		 });
    }); 
		/*  var news = "${newsInfo}";
		if(news!=""){
			document.form1.action=ctx+"/news/update"; 
			
		}  */
		
		/* //验证权重是否重复
		$('#weight').blur(function (){
			var url = ctx+"/news/checkWeight";
			var weight = $("#weight").val();
			if(weight<1){
				$('#wmessage').text("权重值必须大于1！");
			}
			$.post(url,{'weight':weight},function (data){
				if(!data.success){
					//alert(data.message);
					$('#wmessage').text(data.message);
				}
			});

		}); */


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
				var ab = ue.getContentTxt().trim();
				/* if(ab.length>20){
					$('#abstracts').val(ab.substring(0,20));//摘要
				}else{
					$('#abstracts').val(ab);//摘要
				} */
				if($('#weight').val()<1){
					alert("权重必须大于等于1！");
					return false;
				}
				if(ab.length>10000){
					alert("内容字符数不能大于10000");
					return false;
				}
				if(ab.length<1){
					alert("请输入资讯内容！");
					return false;
				}
				var str="";
				$('input[name="tag"]:checked').each(function(){ 
					str+=$(this).val();  
					}); 
				if(str==""){
					alert("请勾选标签！");
					return false;
				}
				//var imgnull=ctx+"/";
				if($("#imgflag").val()==""){
					alert("请上传咨询列表图片！");
					return false;
				}
				var root = UE.htmlparser(ue.getContent(), true);
				ue.setContent(root.toHtml(true));
				$('#fat-btn').button('loading');
			},
			callback : function(json, statusText) {
				if (json.success) {
					$.alert(json.message, function(){
						//window.location.reload();
						window.location.href = '${ctx}/news/list4Hosp';
					});
				} else {
					$.alert(json.message, function(){
						$('#fat-btn').button('reset');
					});
					
				}
				$('#fat-btn').button('reset');
			}
		});

	});
	
	//列表图片上传
	 function upimg(type){
		 var fileElement = "";
		var img = "";
		var hiddenUrlId="";
		if(type==1){
			fileElement="file1";
			img="#img1";
			hiddenUrlId="#conImgUrl";
		}else{
			fileElement="file";
			img="#img";
			hiddenUrlId="#imageurl";
		} 
   $.ajaxFileUpload
            (
                {
                    url: ctx+'/news/upload', //用于文件上传的服务器端请求地址
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId: fileElement, //文件上传域的ID
                    dataType: 'json',
                    success: function (data, status)  //服务器成功响应处理函数
                    {
   					 //alert(data.imgurl);
                     $(img).attr("src", ctx+"/showImage/showImg?path="+data.imgurl);
                     $("#imgflag").val(data.imgurl);
                     //提交表单用
   					 $(hiddenUrlId).val(data.imgurl);
                     if (typeof (data.message) != 'undefined' && data.message!=null) {
                    	 alert(data.message);
                     }
                        
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        alert(e);
                    }
                }
            );
            return false;
    
   }
	
</script>
</html>