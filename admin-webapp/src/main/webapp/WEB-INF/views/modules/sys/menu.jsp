<%@ page contentType="text/html;charset=UTF-8"%><%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!-- <div class="col-md-2"> -->
<div>
	<div class="panel-group" id="accordion">
		<c:if test="${resourceMap['collapse_one']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
						<i class="glyphicon glyphicon-envelope"></i>资讯新闻 
					</a>
				</h2>
			</div>
			<div id="collapseOne" class="panel-collapse collapse in">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['tag_list']!=null}">
						<li><a href="${ctx}/tag/list" target="mainFrame"><i class="glyphicon glyphicon-list"></i>标签列表 </a></li>
						</c:if>
						<c:if test="${resourceMap['news_list']!=null}">
						<li><a href="${ctx}/news/list" target="mainFrame"><i class="glyphicon glyphicon-list"></i> 资讯列表 </a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_forth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseForth"><i class="glyphicon glyphicon-paperclip"></i> 数据规则设置 </a>
				</h2>
			</div>
			<div id="collapseForth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<%-- <li><a href="${ctx}/dic/toAddorEdit" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  数 据 字 典 添 加</a></li> --%>
						<c:if test="${resourceMap['dic_list_ghlx']!=null}">
						<li><a href="${ctx}/dic/list?code=GHLX" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 标 准 挂 号 类 型 管 理</a></li>
						</c:if>
						<c:if test="${resourceMap['dic_list_yylx']!=null}">
						<li><a href="${ctx}/dic/list?code=YYLX" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 医 院 营 业 类 型</a></li>
						</c:if>
						<c:if test="${resourceMap['dic_list_yszc']!=null}">
						<li><a href="${ctx}/dic/list?code=YSZC" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 医 师 职 称 管 理</a></li>
						</c:if>
						<c:if test="${resourceMap['dic_list_ysxl']!=null}">
						<li><a href="${ctx}/dic/list?code=YSXL" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 医 师 学 历 等 级</a></li>
						</c:if>
						<c:if test="${resourceMap['dic_list_fffs']!=null}">
						<li><a href="${ctx}/dic/list?code=FFFS" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 付 费 方 式 管 理</a></li> 
						</c:if>
						<c:if test="${resourceMap['standarddep_list']!=null}">
						<li><a href="${ctx}/standardDep/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  标 准 科 室 维 护</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_third']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseThird"><i class="glyphicon glyphicon-file"></i> 基础数据维护 </a>
				</h2>
			</div>
			<div id="collapseThird" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['area_list']!=null}">
						<li><a href="${ctx}/area/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 地 区 维 护</a></li>
						</c:if>
						<c:if test="${resourceMap['hospital_list']!=null}">
						<li><a href="${ctx}/hospital/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  医 院 维 护</a></li>
						</c:if>
						<%-- <c:if test="${resourceMap['standarddep_list']!=null}">
						<li><a href="${ctx}/standardDep/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  标 准 科 室 维 护</a></li>
						</c:if> --%>
						<c:if test="${resourceMap['hospdep_list']!=null}">
						<li><a href="${ctx}/hospDep/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  医 院 科 室 维 护</a></li>
						</c:if>
						<c:if test="${resourceMap['doctor_list']!=null}">
						<li><a href="${ctx}/doctor/list?hospId=" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  医 生 维 护</a></li>
						</c:if>
						<%-- <li><a href="${ctx}/doctor/list?hospId=" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  医 生 维 护2</a></li> --%>
						 <c:if test="${resourceMap['contentTemp_list']!=null}">
						<li><a href="${ctx}/contenttemp/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  短 信 模 板 维 护</a></li>
						</c:if> 
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_fifth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseFifth"><i class="glyphicon glyphicon-earphone"></i> 号 源 管 理 </a>
				</h2>
			</div>
			<div id="collapseFifth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<%-- <li><a href="${ctx}/dic/toAddorEdit" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>  数 据 字 典 添 加</a></li> --%>
						<%-- <li><a href="${ctx}/stopAndVisit/toAddorEdit" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 停复诊管理</a></li> --%>
						<%-- <li><a href="${ctx}/stopAndVisit/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 停诊记录</a></li> --%>
						<c:if test="${resourceMap['doctor_list']!=null}">
						<li><a href="${ctx}/doctor/list?flag=sources" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 号 源 管 理</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 挂号管理模块开始 -->
		<c:if test="${resourceMap['register_admin']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#register_admin"><i class="glyphicon glyphicon-briefcase"></i> 后 台 挂 号  </a>
				</h2>
			</div>
			<div id="register_admin" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['register_doctorlist']!=null}">
						<li><a href="${ctx}/register/doctorList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 人 工 挂 号</a></li>
						</c:if>
						
						<c:if test="${resourceMap['register_vip']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> VIP 挂 号</a></li>
						</c:if>

						<c:if test="${resourceMap['register_scene']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=2" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 现场挂号</a></li>
						</c:if>

						<c:if test="${resourceMap['register_industry']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=3" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 行业项目预约</a></li>
						</c:if>
						
						<!-- 
						<c:if test="${resourceMap['register_web_register']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=4" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 网站合作预约</a></li>
						</c:if> 
						-->
						
						<c:if test="${resourceMap['register_area']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=5" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 区域客户预约</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['register_query']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#register_query"><i class="glyphicon glyphicon-briefcase"></i> 挂 号 记 录 </a>
				</h2>
			</div>
			<div id="register_query" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
					
						<c:if test="${resourceMap['register_list']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 人工挂号记录</a></li>
						</c:if>

						<c:if test="${resourceMap['register_viplist']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?vip=1&flag=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> VIP挂号记录</a></li>
						</c:if>

						<c:if test="${resourceMap['register_scenelist']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 现场挂号记录</a></li>
						</c:if>

						<c:if test="${resourceMap['register_industrylist']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=2" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 项目预约记录</a></li>
						</c:if>

						<c:if test="${resourceMap['register_web_list']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=3" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 网站预约记录</a></li>
						</c:if>
						<c:if test="${resourceMap['record_list_pc']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=9" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>PC网站挂号记录</a></li>
						</c:if>
						<c:if test="${resourceMap['register_area_list']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=5" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 区域预约记录</a></li>
						</c:if>
						
						<c:if test="${resourceMap['register_cooperation_list']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=6" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 合作医院挂号记录</a></li>
						</c:if>
					<li><a href="${ctx}/regrecord/recordlist?flag=0&scene=0" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 邀请码预约记录</a></li>
				</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 挂号管理模块开始
		<c:if test="${resourceMap['collapse_sixth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSixth"><i class="glyphicon glyphicon-briefcase"></i> 挂 号 管 理 </a>
				</h2>
			</div>
			<div id="collapseSixth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['register_doctorlist']!=null}">
						<li><a href="${ctx}/register/doctorList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 人 工 挂 号</a></li>
						</c:if>
						<c:if test="${resourceMap['register_list']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 挂号记录/取消</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>

		<c:if test="${resourceMap['collapse_sixth2']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSixth2"><i class="glyphicon glyphicon-briefcase"></i> VIP挂 号 管 理 </a>
				</h2>
			</div>
			<div id="collapseSixth2" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['register_vip']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> VIP 挂 号</a></li>
						</c:if>
						<c:if test="${resourceMap['register_viplist']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?vip=1&flag=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> VIP挂号记录</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_sixth3']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSixth3"><i class="glyphicon glyphicon-briefcase"></i> 现场挂号管理</a>
				</h2>
			</div>
			<div id="collapseSixth3" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['register_scene']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=2" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 现场挂号</a></li>
						</c:if>
						<c:if test="${resourceMap['register_scenelist']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 现场挂号记录</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_sixth4']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSixth4"><i class="glyphicon glyphicon-briefcase"></i> 行业项目预约</a>
				</h2>
			</div>
			<div id="collapseSixth4" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['register_industry']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=3" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 行业项目预约</a></li>
						</c:if>
						<c:if test="${resourceMap['register_industrylist']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=2" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 项目预约记录</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>		
		
		<c:if test="${resourceMap['collapse_web_cooperate']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseWebCooperate"><i class="glyphicon glyphicon-briefcase"></i> 医院网站合作预约</a>
				</h2>
			</div>
			<div id="collapseWebCooperate" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
					 
						<c:if test="${resourceMap['register_web_register']!=null}">
						<li><a href="${ctx}/register/doctorList?vip=4" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 网站合作预约</a></li>
						</c:if>
					
						<c:if test="${resourceMap['register_web_list']!=null}">
						<li><a href="${ctx}/regrecord/recordlist?flag=1&scene=3" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 网站预约记录</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		挂号管理模块结束  -->
		<c:if test="${resourceMap['collapse_seventh']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSeventh"><i class="glyphicon glyphicon-plus"></i> 医院端管理 </a>
				</h2>
			</div>
			<div id="collapseSeventh" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav1 nav-pills nav-stacked">
						<c:if test="${resourceMap['regrecord_list']!=null}">
						<li><a href="${ctx}/regrecord/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 未处理挂号信息处理</a></li>
						</c:if>
						<c:if test="${resourceMap['regrecord_list']!=null}">
						<li><a href="${ctx}/regrecord/list?flag=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 挂号信息查询</a></li>
						</c:if>
						<c:if test="${resourceMap['regrecord_doctorList']!=null}">
						<li><a href="${ctx}/regrecord/doctorList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 医生停/复诊</a></li>
						</c:if>
						<c:if test="${resourceMap['regrecord_statisticslist']!=null}">
						<li><a href="${ctx}/regrecord/statisticslist" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 预约统计</a></li>
						</c:if>
	                    <c:if test="${resourceMap['list4Hosp']!=null}">
						<li><a href="${ctx}/news/list4Hosp" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>资讯文章</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_eighth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseEighth"><i class="glyphicon glyphicon-wrench"></i> 系 统 管 理 </a>
				</h2>
			</div>
			<div id="collapseEighth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['system_toadd']!=null}">
						<li><a href="${ctx}/sysmgr/toAdd" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>就诊人端</a></li>
						</c:if>
						<c:if test="${resourceMap['system_toaddForDoctor']!=null}">
						<li><a href="${ctx}/sysmgr/toAddForDoctor" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医生端版</a></li>
						</c:if>
						<%-- <li><a href="${ctx}/sysmgr/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 版本管理记录</a></li> --%>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_ninth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseNinth"><i class="glyphicon glyphicon-lock"></i> 权 限 管 理 </a>
				</h2>
			</div>
			<div id="collapseNinth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['role_list']!=null}">
						<li><a href="${ctx}/role/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>角 色 管 理</a></li>
						</c:if>
						<c:if test="${resourceMap['resource_list']!=null}">
						<li><a href="${ctx}/resource/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>资 源 管  理</a></li>
						</c:if>
						<c:if test="${resourceMap['manager_list']!=null}">
						<li><a href="${ctx}/manager/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 用  户 管 理</a></li>
						</c:if>
						<%-- <li><a href="${ctx}/sysmgr/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i> 版本管理记录</a></li> --%>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_tenth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseTenth"><i class="glyphicon glyphicon-user"></i>账号管理</a>
				</h2>
			</div>
			<div id="collapseTenth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
					    <c:if test="${resourceMap['toregister']!=null}">
						<li><a href="${ctx}/account/toRegister" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>账号注册</a></li>
						</c:if>
						<c:if test="${resourceMap['getaccountlist']!=null}">
						<li><a href="${ctx}/user/list?flag=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>账号管理</a></li>
						</c:if>
						<c:if test="${resourceMap['getsmslist']!=null}">
						<li><a href="${ctx}/sms/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>短信管理</a></li>
						</c:if>
						<c:if test="${resourceMap['sms_smsList']!=null}">
						<li><a href="${ctx}/sms/smsList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>预约短信管理</a></li>
						</c:if>
						<c:if test="${resourceMap['sms_SignerList']!=null}">
						<li><a href="${ctx}/smsSigner/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>短信签名管理</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_eleventh']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseEleventh"><i class="glyphicon glyphicon-user"></i>意见反馈管理</a>
				</h2>
			</div>
			<div id="collapseEleventh" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['suggestion_getSuggestionList']!=null}">
						<li><a href="${ctx}/suggestion/getSuggestionList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>意见反馈</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_twelfth']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseTwelfth"><i class="glyphicon glyphicon-user"></i>医院微站管理</a>
				</h2>
			</div>
			<div id="collapseTwelfth" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['hosp_micro_stationList']!=null}">
						<li><a href="${ctx}/microstation/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>微站管理</a></li>
						</c:if>
						<c:if test="${resourceMap['hosp_micro_buildings']!=null}">
						<li><a href="${ctx}/hospbuilding/buildings" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医院大楼管理</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		
		<c:if test="${resourceMap['collapse_thirteen']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseThirteen"><i class="glyphicon glyphicon-user"></i>统计管理</a>
				</h2>
			</div>
			<div id="collapseThirteen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['statistics_toOpera']!=null}">
						<li><a href="${ctx}/statistics/toOpera" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>统计管理</a></li>
						</c:if>
						<c:if test="${resourceMap['/statisResource/list']!=null}">
						<li><a href="${ctx}/statisResource/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>统计号源</a></li>
						</c:if>
						<c:if test="${resourceMap['statistics_Area_RecordNum']!=null}">
						<li><a href="${ctx}/statistics/statisticsAreaRecordNum?type=area" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>统计区域挂号</a></li>
						</c:if>
						<c:if test="${resourceMap['statistics_Narea_RecordNum']!=null}">
						<li><a href="${ctx}/statistics/statisticsNareaRecordNum?type=area" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>地区数据统计</a></li>
						</c:if>
						<c:if test="${resourceMap['statistics_RecordNum']!=null}">
						<li><a href="${ctx}/statistics/statisticsRecordNum?type=all" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>统计挂号记录</a></li>
						</c:if>
						<c:if test="${resourceMap['statistics_RecordNum_sim']!=null}">
						<li><a href="${ctx}/statistics/statisticsRecordNum?type=sim" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>统计挂号记录.</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 任务调度-->
		<c:if test="${resourceMap['collapse_schedule']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSchedule"><i class="glyphicon glyphicon-user"></i>任务调度管理 </a>
				</h2>
			</div>
			<div id="collapseSchedule" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['schedule_list']!=null}">
							<li><a href="${ctx}/schedule/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>任务调度列表 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_fourteen']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseFourteen"><i class="glyphicon glyphicon-user"></i>基础数据导入管理</a>
				</h2>
			</div>
			<div id="collapseFourteen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['agent_mapping_list']!=null}">
						<li><a href="${ctx}/agent/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>平台配置</a></li>
						</c:if>
						<c:if test="${resourceMap['import_quartz']!=null}">
						<li><a href="${ctx}/import_quartz/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>平台数据导入</a></li>
						</c:if>
						<c:if test="${resourceMap['hosp_mapping_list']!=null}">
						<li><a href="${ctx}/agentMapping/hospList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>平台关联映射</a></li>
						</c:if>
						<c:if test="${resourceMap['/processor/list']!=null}">
						<li><a href="${ctx}/processor/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>单医院配置</a></li>
						</c:if>
						<c:if test="${resourceMap['import_quartz_single']!=null}">
						<li><a href="${ctx}/import_quartz/single" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>单医院数据导入</a></li>
						</c:if>
						<c:if test="${resourceMap['/processor/hospList']!=null}">
						<li><a href="${ctx}/processor/hospList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>单医院关联映射 </a></li>
						</c:if>
						
						<!--  
						<c:if test="${resourceMap['agent_mapping_import']!=null}">
						<li><a href="${ctx}/import/toExecutive" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>导入管理</a></li>
						</c:if>
						<c:if test="${resourceMap['zyy_mapping_import']!=null}">
						<li><a href="${ctx}/import/import_zyy" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医院信息导入</a></li>
						</c:if>
						<c:if test="${resourceMap['single_hosp_import']!=null}">
						<li><a href="${ctx}/import/import_single_hosp" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>单个医院导入</a></li>
						</c:if>
						-->
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
				
		<!-- 20150702   孔豪新增  基础信息管理  菜单-->
		<c:if test="${resourceMap['collapse_eighteen']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseEighteen"><i class="glyphicon glyphicon-user"></i>前置机管理 </a>
				</h2>
			</div>
			<div id="collapseEighteen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['/processor/list']!=null}">
						<li><a href="${ctx}/processor/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>前置机管理 </a></li>
						</c:if>
						<c:if test="${resourceMap['/processorHand/list']!=null}">
						<li><a href="${ctx}/processorHand/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>前置机定时执行 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_fifteen']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseFifteen"><i class="glyphicon glyphicon-user"></i>预约管理</a>
				</h2>
			</div>
			<div id="collapseFifteen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['appointment_toOpera']!=null}">
						<li><a href="${ctx}/appointment/toOpera" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>预约信息</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 20150620   孔豪新增  疾病导诊管理  菜单-->
		<c:if test="${resourceMap['collapse_tree']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSixteen"><i class="glyphicon glyphicon-user"></i>疾病导诊管理</a>
				</h2>
			</div>
			<div id="collapseSixteen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['/tree/list']!=null}">
						<li><a href="${ctx}/tree/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>疾病导诊</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<c:if test="${resourceMap['collapse_seventeen']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSeventeen"><i class="glyphicon glyphicon-user"></i>渠道规则管理</a>
				</h2>
			</div>
			<div id="collapseSeventeen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['channel_list']!=null}">
						<li><a href="${ctx}/channel/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>渠道列表</a></li>
						</c:if>
						<c:if test="${resourceMap['scene_list']!=null}">
						<li><a href="${ctx}/scene/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>场景列表</a></li>
						</c:if>
						<c:if test="${resourceMap['rule_list']!=null}">
						<li><a href="${ctx}/rule/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>规则列表</a></li>
						</c:if>
						<c:if test="${resourceMap['wx_source']!=null}">
						<li><a href="${ctx}/wxsource/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>微信渠道列表</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 20150702   孔豪新增  基础信息管理  菜单-->
		<c:if test="${resourceMap['collapse_baserecord']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseSeventeen"><i class="glyphicon glyphicon-user"></i>基础信息管理 </a>
				</h2>
			</div>
			<div id="collapseSeventeen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['/baserecord/list']!=null}">
						<li><a href="${ctx}/baserecord/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>基础信息查询</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 节假日管理菜单-->
		<c:if test="${resourceMap['collapse_nineteen']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseNineteen"><i class="glyphicon glyphicon-user"></i>节假日管理 </a>
				</h2>
			</div>
			<div id="collapseNineteen" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['holidays_hospital_noGenerative']!=null}">
						<li><a href="${ctx}/holidaysHosp/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>不产生号源日期编辑(医院)</a></li>
						</c:if>
						<c:if test="${resourceMap['holidays_noGenerative']!=null}">
						<li><a href="${ctx}/holidays/noGenerative" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>不产生号源日期编辑 </a></li>
						</c:if>
						<c:if test="${resourceMap['holidays_invisible']!=null}">
						<li><a href="${ctx}/holidays/invisible" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>不可见号源日期编辑 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		<!-- 缓存管理菜单-->
		<c:if test="${resourceMap['collapse_twentyOne']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseTwentyOne"><i class="glyphicon glyphicon-user"></i>缓存管理 </a>
				</h2>
			</div>
			<div id="collapseTwentyOne" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['cache/doctorList']!=null}">
						<li><a href="${ctx}/cache/list?flag=sources" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医生列表 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- app患者端注册用户白名单管理-->
		<c:if test="${resourceMap['collapse_twentyTwo']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseTwentyTwo"><i class="glyphicon glyphicon-user"></i>白名单管理 </a>
				</h2>
			</div>
			<div id="collapseTwentyTwo" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['whitelist_whitelist']!=null}">
						<li><a href="${ctx}/whitelist/whitelist?flag=sources" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>白名单列表 </a></li>
						</c:if>
						<c:if test="${resourceMap['preregistrationwhitelist_whitelist']!=null}">
						<li><a href="${ctx}/preregistrationwhitelist/whitelist" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>预注册用户白名单列表 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 医院二维码下载次数统计-->
		<c:if test="${resourceMap['collapse_twentyThree']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseTwentyThree"><i class="glyphicon glyphicon-user"></i>医院二维码下载次数 </a>
				</h2>
			</div>
			<div id="collapseTwentyThree" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['hospDownLoadTimes_list']!=null}">
						<li><a href="${ctx}/hospDownLoadTimes/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医院二维码下载次数列表 </a></li>
						</c:if>
					</ul> 
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['QR-code_statistics']!=null}">
						<li><a href="${ctx}/QRCodeStatistics/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>二维码扫描统计 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 名片申请管理-->
		<c:if test="${resourceMap['collapse_namecard']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseNamecard"><i class="glyphicon glyphicon-user"></i>名片申请管理 </a>
				</h2>
			</div>
			<div id="collapseNamecard" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['namecard_list']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/namecard/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>名片申请 </a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 医生注册审核管理-->
		<c:if test="${resourceMap['collapse_docregcheck']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseDocregcheck"><i class="glyphicon glyphicon-user"></i>医生注册审核管理 </a>
				</h2>
			</div>
			<div id="collapseDocregcheck" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['docregcheck_check']!=null}">
						<li><a href="${ctx}/docregcheck/regDoctorList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>注册审核 </a></li>
						</c:if>
						<c:if test="${resourceMap['docregcheck_userManage']!=null}">
						<li><a href="${ctx}/docregcheck/checkedDoctorList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>用户管理 </a></li>
						</c:if>
						<c:if test="${resourceMap['docregcheck_hospdoctorList']!=null}">
						<li><a href="${ctx}/docregcheck/hospdoctorList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医生账号注册</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 免费咨询管理 -->
		<c:if test="${resourceMap['collapse_freeconsultation']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseFreeconsultation"><i class="glyphicon glyphicon-user"></i>咨询管理 </a>
				</h2>
			</div>
			<div id="collapseFreeconsultation" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['freeconsultation_list']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/freeConsultation/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>免费咨询管理</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 加号列表 -->
		<c:if test="${resourceMap['collapse_extraresource']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseExtraresource"><i class="glyphicon glyphicon-user"></i>加号管理 </a>
				</h2>
			</div>
			<div id="collapseExtraresource" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['extraResource_list']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/extraResource/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>加号列表</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 医生文章 -->
		<c:if test="${resourceMap['collapse_article']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseArticle"><i class="glyphicon glyphicon-user"></i>医生文章 </a>
				</h2>
			</div>
			<div id="collapseArticle" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['doctor_article']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/doctorArticle/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医生文章</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
				<!-- 医生文章 -->
		<c:if test="${resourceMap['collapse_compete']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#collapseCompete"><i class="glyphicon glyphicon-user"></i>后台申请 </a>
				</h2>
			</div>
			<div id="collapseCompete" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['competeResource_list']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/competeresource/list" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>申请抢号</a></li>
						</c:if>
						<c:if test="${resourceMap['record_List']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/competeresource/recordlist" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>抢号列表</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 支付 -->
		<c:if test="${resourceMap['collapse_payment']!=null}">
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#collapsePayment">
						<i class="glyphicon glyphicon-user"></i>支付相关功能 
					</a>
				</h2>
			</div>
			<div id="collapsePayment" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['withdrawals_list']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/payment/withdrawalsList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>提现</a></li>
						</c:if>
						<%-- <c:if test="${resourceMap['appeal_List']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/payment/appealList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>申诉</a></li>
						</c:if> --%>
						<c:if test="${resourceMap['payment_order_List']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/payment/paymentOrderList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>订单</a></li>
						</c:if>
						<c:if test="${resourceMap['account_amount_List']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/accountDetails/accountAmountList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>账户明细</a></li>
						</c:if>
						<c:if test="${resourceMap['time_slice_List']!=null}">
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/timeslice/timeSliceList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>医生排班</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		
		<!-- 陪诊服务 -->
		<c:if test="${resourceMap['accompany_service']!=null}">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion" href="#accompanyservice">
						<i class="glyphicon glyphicon-user"></i>陪诊服务 
					</a>
				</h2>
			</div>
			<div id="accompanyservice" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<c:if test="${resourceMap['accom_order_manage']!=null}">
						<li class="namecard_btn" id="accom_order_manage"><a href="${ctx}/accom/toOrderList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>陪诊订单管理</a></li>
						</c:if>
						<c:if test="${resourceMap['supplier_manage']!=null}">
						<li class="namecard_btn" id="supplier_manage"><a href="${ctx}/accom/supplierList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>供应商管理</a></li>
						</c:if>
						<c:if test="${resourceMap['supplier_accom_order_list']!=null}">
						<li class="namecard_btn" id="supplier_accom_order_list"><a href="${ctx}/accom/toOrderList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>陪诊订单管理</a></li>
						</c:if>
						<c:if test="${resourceMap['accome_xpense_manage']!=null}">
						<li class="namecard_btn" id="accome_xpense_manage"><a href="${ctx}/accom/costsList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>陪诊费用管理</a></li>
						</c:if>
						<c:if test="${resourceMap['accom_personnel_manage']!=null}">
						<li class="namecard_btn" id="accom_personnel_manage"><a href="${ctx}/accomperson/accomPersonList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>陪诊人员管理</a></li>
						</c:if>
						<c:if test="${resourceMap['accom_personnel_manage']!=null}">
						<li class="namecard_btn" id="accom_personnel_manage"><a href="${ctx}/accom/costsList" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>陪诊记录</a></li>
						</c:if>
					</ul> 
				</div>
			</div>
		</div>
		</c:if>
		<!-- 停诊服务 -->
		<c:if test="${resourceMap['collapse_stopInfo']!=null}"> 
		<div class="panel panel-primary">
		<div class="panel-heading">
				<h2 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordion"
						href="#stopInfo"><i class="glyphicon glyphicon-user"></i>停诊信息 </a>
				</h2>
			</div>
			<div id="stopInfo" class="panel-collapse collapse">
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						 <c:if test="${resourceMap['stopInfo_list']!=null}"> 
						<li class="namecard_btn" id="namecard_btn"><a href="${ctx}/stopInfo/recordlist?flag=1&scene=1" target="mainFrame"><i class="glyphicon glyphicon-tasks"></i>停诊列表</a></li>
						 </c:if> 
					</ul> 
				</div>
			</div>
		</div>
		 </c:if>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#accordion .panel-heading a").click(function(){
		$('.accordion-toggle i').removeClass('icon-chevron-down');
		$('.accordion-toggle i').addClass('icon-chevron-right');
		if(!$($(this).attr('href')).hasClass('in')){
			$(this).children('i').removeClass('icon-chevron-right');
			$(this).children('i').addClass('icon-chevron-down');
		}
	});
	$(".panel-collapse a").click(function(){
		$("#accordion li").removeClass("active");
		$("#accordion li i").removeClass("icon-white");
		$(this).parent().addClass("active");
		$(this).children("i").addClass("icon-white");
	});
	$(".glyphicon-off").parent().bind("click", function(){
		$.get("${ctx}/logout", {}, function(json) {
			/* if (json.success) {
				$.alert(json.message, function() {
					
				});
			} */
		}, "json");
		parent.window.location.href = "${ctx}/account/login?redirectUrl=" + encodeURIComponent(parent.window.location.href);
	});
});
</script>