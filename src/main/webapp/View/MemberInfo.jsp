<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- core 라이브러리 적용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery 3.7.0 적용 -->
<script src="https://code.jquery.com/jquery-3.7.0.js"
	integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
	crossorigin="anonymous"></script>
<!-- BootStrap 5.3.1  및 4.6.2 적용 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:600,700;"
	rel="stylesheet">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//탈퇴
function signout() {
	var result = confirm("회원탈퇴시 모든글과 게시물이 삭제됩니다. 정말 탈퇴하시겠습니까?")
	if (result) {
		location.href="${pageContext.request.contextPath}/member/deleter.do";
	}
}
//비로그인 접근시 보안
$(function () {	
	console.log("verify:${Verify}");
	console.log("id:${id}")
	console.log()
	if ("${id}"=="admin") {
		
	}
	else if ("${id}"=="") {
		alert("로그인 후 이용하세요");
		location.href="${pageContext.request.contextPath}/home.do"
	}
	else if ("${Verify}" != "success"){
		alert("접근권한이 없습니다.");
		location.href='${pageContext.request.contextPath}/home.do';
		
	}
});


//페이지 종료시 다른 세션값 제거
$(window).on("beforeunload", function () {
   	 	<% session.removeAttribute("flag");%>
   	 	<% session.removeAttribute("Verify");%>
   	 	<% session.removeAttribute("nicknamecheck");%>
   	 	<% session.removeAttribute("nicknamepossible");%>
   	 	
});   	
//nicknmae변경시 중복체크 해제
function unchecknickname(){
	$('#nickamecheck').val("N");
	document.getElementById('nicknamecheckbtn').removeAttribute("disabled");
	document.getElementById('nicknamecheckbtn').style.opacity=1;
}
//nickname 중복체크 fn
function nicknameCheck(fn){
	<c:set var="nicknamecheck" value="true" scope="session"/>
	console.log("nicknamecheck:"+${nicknamecheck});
        /*
            부모창에서 입력된 아이디를 쿼리스트링을 통해 팝업창으로 전달한다.
            이 때 파라미터명은 id이고 전달된 값은 사용자가 입력한 아이디 이다.
        */
        //url, 창이름, 창속성
        window.open("${pageContext.request.contextPath}/View/Page/nicknamecheck2.jsp","nicknameoverlap",
        "width=500,height=250");
}
function isValidate() {
    /*
        패스워드 입력은 2번 받아야 하므로 하나라도 입력값이 없다면
        경고창을 띄운다. 단, 포커스 이동은 하지 않는다.
    */
    if(frm.nickname.value==''){
        alert("닉네임을 입력하세요");
        frm.id.focus();
        return false;
        }
	if(frm.nicknamecheck.value=="N"){
	   	  alert("닉네임 중복검사를 해주세요");
	         frm.id.focus();
	         return false;
	   	 }
	if(frm.pwd.value !=frm.pwd2.value){
        alert('입력한 패스워드가 일치하지 않습니다.');
        //기존의 입력값을 지우기 위해 빈값을 할당한다.
        frm.pass.value='';
        frm.pass2.value='';
        //비밀번호 첫번째 항목으로 포커스를 이동한다.
        frm.pwd.focus();
        return false;
    }
}
$('#pass').focus();
</script>
<title></title>
<style>
body {
	background-color: #3e94ec;
	font-family: "Roboto", helvetica, arial, sans-serif;
	font-size: 16px;
	font-weight: 400;
	text-rendering: optimizeLegibility;
}

div.table-title {
	display: block;
	margin: auto;
	max-width: 600px;
	padding: 5px;
	width: 100%;
}

.table-title h3 {
	color: #fafafa;
	font-size: 30px;
	font-weight: 400;
	font-style: normal;
	font-family: "Roboto", helvetica, arial, sans-serif;
	text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
	text-transform: uppercase;
}

/*** Table Styles **/
.table-fill {
	background: white;
	border-radius: 3px;
	border-collapse: collapse;
	height: 320px;
	margin: auto;
	max-width: 600px;
	padding: 5px;
	width: 100%;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
	animation: float 5s infinite;
}

th {
	color: #D5DDE5;;
	background: #1b1e24;
	border-bottom: 4px solid #9ea7af;
	border-right: 1px solid #343a45;
	font-size: 23px;
	font-weight: 100;
	padding: 24px;
	text-align: left;
	text-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
	vertical-align: middle;
}

th:first-child {
	border-top-left-radius: 3px;
}

th:last-child {
	border-top-right-radius: 3px;
	border-right: none;
}

tr {
	border-top: 1px solid #C1C3D1;
	border-bottom-: 1px solid #C1C3D1;
	color: #666B85;
	font-size: 16px;
	font-weight: normal;
	text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1);
}

tr:hover td {
	background: #4E5066;
	color: #FFFFFF;
	border-top: 1px solid #22262e;
}

tr:first-child {
	border-top: none;
}

tr:last-child {
	border-bottom: none;
}

tr:nth-child(odd) td {
	background: #EBEBEB;
}

tr:nth-child(odd):hover td {
	background: #4E5066;
}

tr:last-child td:first-child {
	border-bottom-left-radius: 3px;
}

tr:last-child td:last-child {
	border-bottom-right-radius: 3px;
}

td {
	background: #FFFFFF;
	padding: 20px;
	text-align: left;
	vertical-align: middle;
	font-weight: 300;
	font-size: 18px;
	text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
	border-right: 1px solid #C1C3D1;
}

td:last-child {
	border-right: 0px;
}

th.text-left {
	text-align: left;
}

th.text-center {
	text-align: center;
}

th.text-right {
	text-align: right;
}

td.text-left {
	text-align: left;
}

td.text-center {
	text-align: center;
}

td.text-right {
	text-align: right;
}
</style>
</head>
<body>
	<jsp:include page="./NavBar.jsp"></jsp:include>
	<div id="layer"
		style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
			id="btnCloseLayer"
			style="cursor: pointer; position: absolute; right: -3px; top: -5px; z-index: 1"
			onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_detailAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_detailAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
	<br /><br />
	<form action="${pageContext.request.contextPath }/member/infoedit.do" method="post" name="frm">
	<div id="wrap" style="margin: auto; width: 100%; height: 120%">
		<table class="table-fill">
			<thead>
				<tr>
					<th colspan="2" style="text-align: center;">회원정보</th>
				</tr>
			</thead>
			<tbody class="table-hover">
				<tr>
					<td class="text-left">ID</td>
					<td class="text-left">${dto.id }</td>
				</tr>
				<tr>
					<td class="text-left">비밀번호</td>
					<td class="text-left"><input type="password" name="pass" id="pwd"
						value=${dto.pass } /></td>
				</tr>
				<tr>
					<td class="text-left">비밀번호확인</td>
					<td class="text-left"><input type="password" name="pass2" id='pwd2'
						value=${dto.pass } /></td>
				</tr>
				<tr>
					<td class="text-left">nickname
						<button type="button" onclick="nicknameCheck(this.form);"
							id="nicknamecheckbtn"
							style="background-color: rgb(70, 70, 70); color: white;">
							닉네임변경</button>
					</td>
					<td class="text-left">
					<input type="text" onkeydown="unchecknickname();" name="nickname" id="nickname"
						value="${dto.nickname }" readonly="readonly" />
						<input type="hidden" name="nicknamecheck" id="nicknamecheck" value="Y" />
					</td>
				</tr>
				<tr>
					<td class="text-left">email</td>
					<td class="text-left"><input type="text" value="${dto.email }" name="email" /></td>
				</tr>

				<tr>
					<td class="text-left">우편번호 <input type="button"
						class="btn-info" onclick="sample2_execDaumPostcode()" value="주소찾기"></td>
					<td class="text-left"><input type="text" id="sample2_postcode" name="postcode"
						value="${dto.postcode }" /></td>
				</tr>
				<tr>
					<td class="text-left">주소<br></td>
					<td class="text-left"><input type="text" id="sample2_address" name="adress1"
						value="${dto.adress1 }"></td>
				</tr>
				<tr>
					<td class="text-left">상세주소</td>
					<td class="text-left"><input type="text" name="adress2"
						id="sample2_detailAddress" value="${dto.adress2 }"></td>
				</tr>

				<tr>
					<td class="text-left">gender</td>
					<td class="text-left">${dto.gender }</td>
				</tr>
				<tr>
					<td class="text-left">birth</td>
					<td class="text-left">${dto.birth }</td>
				</tr>
				<tr>
					<td class="text-left">가입일</td>
					<td class="text-left">${dto.regidate }</td>
				</tr>
				<tr>
					<td class="text-left">핸드폰 번호</td>
					<td class="text-left"><input type="text" name="phonenumber" id="phonenumber"
						value="${dto.phonenumber }" /></td>
				</tr>
			</tbody>
		</table>
		<br>
            <div style="text-align: center;">
            <button type="submit" class="btn btn-primary" onclick="isValidate();">변경하기</button>
            <button type="button" class="btn btn-danger" onclick="signout();">회원탈퇴</button>
            <button type="button" class="btn btn-lightdark" onclick="location.href='${pageContext.request.contextPath }/home.do'" >홈으로</button>
            <br /><br /><br /><br />
            </div>
		</div>
	</form>
</body>
</html>