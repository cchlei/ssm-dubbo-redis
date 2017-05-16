<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en" ng-app>
<head>
<meta charset="utf-8">
<title>微信文章</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="description" content="">
<meta name="keywords" content="">
<meta content="yes" name="apple-mobile-web-app-capable" /> 
<meta content="black" name="apple-mobile-web-app-status-bar-style" /> 
<meta content="telephone=no" name="format-detection" />
<style>
	/* css reset */
body,p,h2,h3,h4,h5,ul,ol,li,form,input,td,th,dl,dd,td,th,img{margin:0;padding:0;}
input{border:none;outline:none; background:none;}
em{font-style:normal;}
li{list-style:none; vertical-align:top;}
img{border:none;vertical-align:top;}
a{text-decoration:none; outline:none;}
a:hover, a:focus{outline:none;text-decoration:none;}
p{line-height: inherit;}
.clear{zoom:1}
.clear:after{content:"";display:block; clear:both;}
/* end css reset */
/* public */
body,input,p,h1, h2, h3, h4, h5, h6{font-family: '黑体','Microsoft YaHei',SimHei;font-size:14px;-webkit-text-size-adjust:none;}
h1, h2, h3, h4, h5, h6{font-weight:normal;}


.header{font-weight:900;text-align:center;line-height:38px;font-size:16px;}

.content .title{height:32px;line-height:32px;background:#f0f7ff;border-bottom:1px solid #f5f5f5;padding:0 10px;overflow:hidden;}
.content .title p{float:left;width:25%;}
.content .list{padding:0 10px;}
.content .list li{height:32px;line-height:32px;border-bottom:1px solid #f5f5f5;overflow:hidden;}
.content .list p{float:left;width:25%;font-size:12px;}
</style>
</head>
<body>
<div class="header">
   文章不存在
</div>
<div class="content">
 该文章不存在或已被删除!
</div>
</body>
</html>

