<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>账号列表</title>
</head>

<body>

	<form name="form" role="form" action="" method="POST" style="height:34px">
    	用户名：<input type="text"  id="username" name="username" style="width:200px;" value=""/><br><br>
		注册手机：<input type="text"  id="phone" name="phone" style="width:200px;" value=""/><label style="color:red"></label><br><br>
		用户姓名：<input type="text"  id="name" name="name" style="width:200px;" value=""/><br><br>
		身份证号：<input type="text"  id="idCard" name="idCard" style="width:200px;" value="" /><br><br>
		性&nbsp;别：男<input type="radio" id ="sex" name="sex" value="1" checked/>
		女<input type="radio" id ="sex" name="sex" value="2"/>
		<br><br>
		生&nbsp;日：<input type="text" id ="birthday" name="birthday" style="width:200px" value="" class="Wdate" onClick="WdatePicker()"><br><br>
		邮&nbsp;箱：<input type="text" id="email" name="email" style="width:200px" value=""><br><br>
		社保卡：<input type="text" id="medicareNumber" name="medicareNumber" style="width:200px" value=""><br><br>
	<button type="button" class="btn btn-primary" onclick="add();">提交</button>
	</form>

<script type="text/javascript">
function add(){
	
	var username=$("#username").val();
	var phone =$("#phone").val();
	var idCard = $("#idCard").val();
	var name = $("#name").val();
	var sex = $('input:radio[name=sex]:checked').val();
	var birthday=$("#birthday").val();
	var email =$("#email").val();
	var medicareNumber =$("#medicareNumber").val();
    if(name.length==0)
    {
    	alert('请输入姓名');
    	return false;
    }
    if(idCard.length==0 || (idCard.length!=15 && idCard.length!=18))
    {
    	alert('请输入有效的身份证号码');
    	return false;
    }
	if(!validatemobile(phone))
	{
		return false;
	}
	if(email.length>0)
	{
	    var format = /^[A-Za-z0-9+]+[A-Za-z0-9\.\_\-+]*@([A-Za-z0-9\-]+\.)+[A-Za-z0-9]+$/;
	    if (!email.match(format)) {
	    	alert('请输入正确的邮箱格式');
	        return false;
	    }
	}

	var url = "${ctx}/account/register";
	$.post(url,{'username':username,'phone':phone,'name':name,'idCard':idCard,'name':name,'sex':sex,'birthday':birthday,'email':email,'medicareNumber':medicareNumber},function (data){
		if(data.success){
			alert(data.message);
		}
	});
}
function validatemobile(mobile) 
{ 
    if(mobile.length==0) 
    { 
       alert('请输入手机号码'); 
       return false; 
    }     
    if(mobile.length!=11) 
    { 
        alert('请输入有效的手机号码'); 
        return false; 
    }
    return true;
}
</script>
</body>
</html>