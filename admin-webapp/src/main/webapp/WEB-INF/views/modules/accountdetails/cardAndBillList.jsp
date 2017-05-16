<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>账户明细</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">账户明细</a></li>
	</ul>
	
	<div>
	<div class="panel panel-default">
	
	    <div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 绑定银行卡信息
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter" id="table1">
			<thead>
			<tr>
			    <th class="text-center" width="20px">银行卡号</th>
				<th class="text-center">所属银行</th>
				<th class="text-center" >绑定时间</th>
				<th class="text-center">操作</th>
			</tr>
			</thead>
			<c:forEach items="${cardList}" var="bankCard" varStatus="status">
			<tr>
				<td  class="text-center">${bankCard.bankCardNum}</td>
				<td  class="text-center">${bankCard.bankName}</td>
			    <td  class="text-center"><fmt:formatDate value="${bankCard.createTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
				<td  class="text-center">
				<a href="javascript:void(0);" onclick="deleteBankCard('${bankCard.id}');">删除</a>
				</td>
			</tr>
			</c:forEach>
		</table>
		</div>
		<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 账户资金明细列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center">项目</th>
				<th class="text-center">时间</th>
				<th class="text-center" width="80px">金额</th>
				<th class="text-center">订单号</th>
				<th class="text-center">资金来源</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="tradeRecord" varStatus="status">
			<tr>
				<td  class="text-center">
				<c:if test="${tradeRecord.tradeType==1}">用户充值</c:if>
				<c:if test="${tradeRecord.tradeType==2}">用户消费</c:if>
				<c:if test="${tradeRecord.tradeType==3}">医生收入</c:if>
				<c:if test="${tradeRecord.tradeType==4}">医生提现</c:if>
				<c:if test="${tradeRecord.tradeType==5}">退款</c:if>
				</td>
			    <td  class="text-center"><fmt:formatDate value="${tradeRecord.createTime}" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
				<td  class="text-center">${tradeRecord.amount}</td>
				<td  class="text-center">${tradeRecord.orderId}</td>
				<td  class="text-center">
				<c:if test="${tradeRecord.tradeChannel==1}">支付宝</c:if>
				<c:if test="${tradeRecord.tradeChannel==2}">微信</c:if>
				<c:if test="${tradeRecord.tradeChannel==3}">导医通</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/accountDetails/accountAmountList?userName=${params.userName}&phoneNum=${params.phoneNum}"/>	
 <script type="text/javascript">
var ctx = "${ctx}";
	$(document).ready(function() {
		
	});
	
	function deleteBankCard(cardId){
	if(cardId!=null && cardId!=""){
		$.confirm("确定要删除此条数据吗？删除后不可恢复！", function() {
			$.get("${ctx}/accountDetails/delete/"+cardId, function(json) {
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
		
		
	}
</script>