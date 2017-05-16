<%@ page contentType="text/html;charset=UTF-8" %><%@ include file="/WEB-INF/views/include/taglib.jsp"%><meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="renderer" content="webkit">
<link href="${ctxStatic}/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/css/default.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/css/fullcalendar.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/css/jquery.jsonview.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/js/jquery.min.js" type="text/javascript" ></script>
<script src="${ctxStatic}/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/validform.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/jquery.bootstrap.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/application.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/ajaxfileupload.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/jquery.json-2.4.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/sources.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/respond.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/encrypt.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/jquery.divbox.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/ueditor/lang/zh-cn/zh-cn.js"></script>
<script src="${ctxStatic}/js/moment.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/fullcalendar.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/LodopFuncs.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/jquery.jsonview.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/jquery.form.js" type="text/javascript"></script>
<script src="${ctxStatic}/js/jedate/jedate.js" type="text/javascript"></script>
<script src="${ctxStatic}/layer/layer.js" type="text/javascript"></script>
<!--[if lt IE 9]>
<script src="${ctxStatic}/js/html5.js"></script>
<![endif]-->

<script type="text/javascript" charset="utf-8">
$.fn.serializeObject = function(){
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}
</script>