<%
	Dim mnL1, mnL2	'Left Menu Depth
	mnL1 = "3"
	mnL2 = "0"
%>
<!--#include virtual="/common/define.asp"-->
<!--#include virtual="/common/FFBBS.asp"-->
<!--#include virtual="/common/FFConvert.asp"-->
<!--#include virtual="/common/FFString.asp"-->
<!--#include virtual="/include/paging.asp"-->
<!--#include virtual="/include/head.asp"-->

<body onLoad="init();">
<%
'[Define]-------------------------
	dim cpage, ckey, cstype, fields, condition, searchCondition, orderBy

'[Parameter]----------------------
	cpage	= Requestx("cpage")
	ckey	= Requestx("ckey")
	cstype	= Requestx("cstype")

'[Init]---------------------------
	if(cpage="")then
		cpage = 1
	end if

	dim mgr
	set mgr = new BBSManager
	mgr.setConnection(dbMan.getConnection())
	mgr.setTableName("view_Ethics_bbs")	
	mgr.setLinePerPage(10)	

	fields			= "seq_id, id, name, title, link, link_type, reg_dt, btype"
	orderBy			= "link_type desc, reg_dt desc, seq_id desc"
	condition		= "front_view='1' and link_type<>'3'"
	searchCondition = ""

	searchCondition = mgr.getSearchCondition(ckey, cstype)

'[Get Data]---------------------------
	dim recordCount
	recordCount = mgr.getRows(fields, condition, searchCondition, orderBy, cpage, "seq_id")
%>

<script src="<%=URL_ROOT%>js/FFCheckbox.js"></script>
<script src="<%=URL_ROOT%>js/FFSelectbox.js"></script>
<script src="<%=URL_ROOT%>js/FFForm.js"></script>
<script>
	function init(){
		if("<%=cstype%>" != ""){
			FFForm.setSearchType("<%=cstype%>");	
		}		
	}
</script>

<div id="wrap">
	<!-- S : menu/���� ���� ���� �Ʒ� class:main ����.. -->
	<!--#include virtual="/include/leftMenu.asp"-->
	<!-- E : menu/���� ���� ���� �Ʒ� class:main ����.. -->

	<!-- S : container -->
	<div id="container">
		<!--#include virtual="/include/globalMenu.asp"-->
		<div class="location">
			<a href="/index.asp">Home</a> &gt; <span>Ŀ�´�Ƽ</span> &gt; <span>��������</span>
		</div>
		
		<!-- S : subpage content -->
		<div class="content">
			
			<h1 class="tit"><img src="/images/community/notice/tit1.jpg" alt="��������" /></h1>
			<div class="community">
				<ul>
					<li class="pb30">
						<p><img src="/images/community/notice/itm1.gif" alt="�������� ������ �̲���� �����Դϴ�." /></p>
					</li>
				</ul>
				<form name="frm_act" onsubmit="return FFForm.goSearch('list.asp');">
					<input type="hidden" name="cpage"  value="<%=cpage%>">
					<input type="hidden" name="wt">
					<input type="hidden" name="cnum">
				<div class="list">					
					<table cellpadding="0" cellspacing="0" border="0" summary="�������� ����Ʈ �Դϴ�">
						<caption>�������� ����Ʈ�� �׸����� No, ����, �����, ��ȸ�� �� �ֽ��ϴ�.</caption>
						<colgroup>
							<col width="10%" />
							<col />
							<col width="16%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">����</th>
								<th scope="col">�����</th>
							</tr>
						</thead>
						<tbody>
<%
	dim startNumber, cnt, linkTxt
	startNumber = mgr.getStartNumberDESC()
	cnt = startNumber
	do while(mgr.moveNext())
	'do while(cnt>=(startNumber-9))
		
		select case mgr.getString("link_type")
			case 1 '����Ʈ
			linkTxt = "<a href=javascript:FFForm.goView('"&mgr.getString("seq_id")&"','view.asp')>"
			case 2 '��â
			linkTxt = "<a href='/community/notice/view.asp?cnum="&mgr.getString("seq_id")&"' target='_blank'>"
			'case 3 '�˾�
			case 4 '��ũ
			linkTxt = "<a href='"&mgr.getString("link")&"' target='_blank'>"
			case else
			linkTxt = "<a href=javascript:FFForm.goView('"&mgr.getString("seq_id")&"','view.asp')>"
		end Select
%>
							<tr>
								<td><%=startNumber - mgr.getCursorIndex()%></td>
								<td class="t"><%=linkTxt%><% if len(mgr.getString("title")) > 25 then response.write left(mgr.getString("title"),25)&".." else response.write mgr.getString("title") end if %></a> <% IF DATEDIFF("d",mgr.getString("reg_dt"),NOW())<2 THEN %><img src="/images/common/icon_new.gif" border="0" align="absmiddle"><% END IF %></td>
								<td><%=FFConvert.dateFormat(mgr.getString("reg_dt"),1)%></td>
							</tr>
<%	
		cnt = cnt -1
	Loop
%>
<%if(mgr.getCursorIndex()<0)then%>
							<tr>
								<td colspan="4" height="100">��ϵ� ���������� �����ϴ�</td>
							</tr>
<%end if%>
						</tbody>
					</table>

					<div class="pagingArea">
						<ul class="paging">
							<%call printPaging(recordCount, cpage, mgr.getNumberOfPage(), mgr.getLinePerPage(), "list.asp")%>
						</ul>						
					</div>

					<div class="searchBox">
						<div>
							<ul>
								<li class="s">
									<select name="cstype">
										<option value="title,content">��ü</option>
										<option value="title">����</option>
										<option value="content">����</option>
									</select>
								</li>
								<li class="c"><input type="text" name="ckey" value="<%=ckey%>" class="inTxt" /></li>
								<li class="b"><input type="image" src="/images/common/btn_search.gif" title="�˻�" /></li>
							</ul>
						</div>
					</div>
				
				</div>
				</form>

			</div>
		
		</div>
		<!-- E : subpage content -->

	</div>
	<!-- E : container -->

	<!-- S : layer -->
	<div id="pop_layer">
		<!--#include virtual="/include/siteMap.asp"-->

		<!--#include virtual="/include/contactUs.asp"-->
	</div>
	<!-- E : layer -->

	<!-- S : footer/���� ���� ���� -->
	<div id="footer">
		<!--#include virtual="/include/footer.asp"-->
	</div>
	<!-- E : footer/���� ���� ���� -->
</div>
</body>
</html>
<!--#include virtual="/include/DB_Close_bottom.asp"-->