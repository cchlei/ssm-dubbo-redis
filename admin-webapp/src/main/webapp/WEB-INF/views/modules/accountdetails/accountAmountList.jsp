<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%><html>
<head>
<title>账户明细</title>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">账户明细</a></li>
	</ul>
	
	<div>
	<form name="form" role="form" action="${ctx}/accountDetails/accountAmountList" method="GET">
	用户名：<input type="text"  id="username" name="username"  value="<c:out value='${params.username}'/>"/>&nbsp;&nbsp;&nbsp;
	电话：<input type="text"  id="phone" name="phone"  value="<c:out value='${params.phone}'/>"/>&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp; <button type="submit" class="btn" >查询</button>
	</form>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<i class="glyphicon glyphicon-list"></i> 账户明细列表
			</h4>
		</div>
		<table class="table table-bordered table-hover tablesorter">
			<thead>
			<tr>
			    <th class="text-center" width="20px">用户名</th>
				<th class="text-center">手机号</th>
				<th class="text-center" width="80px">充值金额</th>
				<th class="text-center">消费金额</th>
				<th class="text-center">收入金额</th>
				<th class="text-center">提现金额</th>
				<th class="text-center">绑定银行卡数量</th>
				<th class="text-center" width="100px">操作</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="accountAmount" varStatus="status">
			<tr>
				<td  class="text-center">${accountAmount.userName}</td>
			    <td  class="text-center">${accountAmount.phoneNum}</td>
				<td  class="text-center">${accountAmount.rechargeAmount}</td>
				<td  class="text-center">${accountAmount.purchaseAmount}</td>
				<td  class="text-center">${accountAmount.incomeAmount}</td>
				<td  class="text-center">${accountAmount.withdrawAmount}</td>
				<td  class="text-center">${accountAmount.bankCount}</td>
				<td  class="text-center">
				<a href="${ctx}/accountDetails/cardAndBillList?userId=${accountAmount.userId}" >明细查询</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
    <page:page pager="${page}" linkUrl="${ctx}/accountDetails/accountAmountList?username=${params.username}&phoneNum=${params.phoneNum}"/>	
 <script type="text/javascript">
var ctx = "${ctx}";
	$(document).ready(function() {
		
	});