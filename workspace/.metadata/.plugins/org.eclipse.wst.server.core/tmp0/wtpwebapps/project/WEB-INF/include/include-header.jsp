<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- META -->
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title></title>
		
	<!-- CSS -->
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css"  href="<c:url value='/css/style.css'/>" />
		
	<!-- SCRIPT -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"></script>
 
	<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>
		<script src="<c:url value='/js/jquery.cookie.js'/>" charset="utf-8"></script>
</head>

<body>
 	<!-- top -->
		<nav class="navbar navbar-default">
  			<div class="container-fluid">
    			<div class="navbar-header">
      				<a class="navbar-brand" href="<c:url value='/' />"> 홈페이지 </a><span class="fa fa-heart pulse2"></span>	
      				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
      					<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
      				</button>
    			</div>
    		<div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav">
        		<!-- <li class="active"><a href="#">Home</a></li> -->
        			<li><a href="<c:url value='/sample/openBoardList.do' />"> 게시판 </a></li>

      			</ul>
      		<!-- if not login state -->
      			<c:if test="${null == sName}">
       				<ul class="nav navbar-nav navbar-right">
	        			<li><a href="#" class="navbar-right-btn" data-toggle="modal" data-target="#joinModal"><span class="glyphicon glyphicon-user"></span> 회원가입 </a></li>
        				<li><a href="#" data-toggle="modal" data-target="#loginModal"><span class="glyphicon glyphicon-log-in"></span> 로그인 </a></li>
      				</ul>
      			</c:if>
      		<!-- if login state -->
				<c:if test="${null != sName}">
					<ul class="nav navbar-nav navbar-right">
	        			<li><a href="#"><span class="glyphicon glyphicon-user"></span><strong>${sName}</strong>님</a></li>
        				<li><a href="#this" id="logout"><span class="glyphicon glyphicon-log-in"></span> 로그아웃 </a></li>
      				</ul>
				</c:if>
			</div>
			</div>
			</div>
		</nav>

	<!-- bottom -->
		<div class="home-bottom">
		</div>
		
	<!-- Login modal -->
			<div class="modal-buttons">
  				<div class="modal fade" id="loginModal" role="dialog">
    				<div class="modal-dialog modal-sm">
       					<div class="modal-content">
        					<div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>
		          				<h4 class="modal-title"> 로그인 </h4>
        					</div>
      					
			        	<!-- Login form -->
       						<div class="modal-body">
       							<form role="form" id="loginForm" autocomplete="off">
  									<div class="form-group">
  										<span> 아이디 <input type="text" class="form-control" name="id"></span>
  									</div>
  									<div class="form-group">
	   									<span> 비밀번호 <input type="password" class="form-control" name="password"></span>
  									</div>
									<button type="button" class="btn btn-default" id="loginSubmit"> Login </button>
  									<button type="button" class="btn btn-default" data-dismiss="modal"> Close </button>
  								</form>

								<!-- Login with NAVER -->
								<br/> <div id="naver_id_login"></div>
								<script type="text/javascript">
									var naver_id_login = new naver_id_login("vJVcwMNm4zNwoM88mdcA", "http://127.0.0.1:8081/project/");
									naver_id_login.setButton("green", 3,40);
									naver_id_login.init_naver_id_login();
								</script>
								<!-- login with FACEBOOK -->
								<br/> <a href="#"><img src="<c:url value='/images/fb-login.png'/>" width="185" height="40" onclick="facebooklogin();"></a>								
  							</div>
  						</div>
  					</div>
  				</div>

  			<!-- Join modal -->
  				<div class="modal fade" id="joinModal" role="dialog">
    				<div class="modal-dialog modal-sm">
       					<div class="modal-content">
        					<div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>
		          				<h4 class="modal-title"> 회원가입 </h4>
        					</div>
      			
			        	<!-- Join form -->
       						<div class="modal-body">
       							<form role="form" id="joinForm" autocomplete="off">
  									<div class="form-group">
   										<span> 아이디 <input type="text" class="form-control" name="id" onkeyup="joinIdCheck(this.value)"></span>
   										<br/> <span id="joinIdCheck"></span>
  									</div>
  									<div class="form-group">
	   									<span> 비밀번호 <input type="password" class="form-control" name="password1" id="password1"></span>
	   									<br/>
  									</div>
  									<div class="form-group">
	   									<span> 재확인 <input type="password" class="form-control" name="password2" onkeyup="joinPasswordCheck(this.value)"></span>
	   									<br/> <span id="passwordCheck"></span>
  									</div>
  									<div class="form-group">
   										<span> 닉네임 <input type="text" class="form-control" name="name"> </span>
   										<br/>
  									</div>
  									
									<button type="button" class="btn btn-default" id="joinSubmit"> Join </button>
  									<button type="button" class="btn btn-default" data-dismiss="modal"> Close </button> <br/>
  								</form>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
  			<%@ include file="/WEB-INF/include/include-body.jsp" %>
</body>
	<script>
        $(document).ready(function(){
            $("#loginSubmit").on("click", function(e){ // 로그인
            	for (var i=0; i<2; i++) {
        			if (loginForm[i].value == null || loginForm[i].value == "") {
        				alert ("빈칸이 있습니다!");
        				loginForm[i].focus(); 
        			return false;
        			}
        		}         
                e.preventDefault();
                fn_login();
            });
            
            $("#joinSubmit").on("click", function(e){ // 회원가입
            	for (var i=0; i<3; i++) {
        			if (joinForm[i].value == null || joinForm[i].value == "") {
        				alert ("빈칸이 있습니다!");
        				joinForm[i].focus(); 
        			return false;
        			}
        		}
                e.preventDefault();
                fn_join();
            });
            
            $("#logout").on("click", function(e){ // 로그아웃
            	e.preventDefault();
                fn_logout();
            });
        });
        
        function fn_login() {
            var comSubmit = new ComSubmit("loginForm");
            comSubmit.setUrl("<c:url value='/common/login.do' />");
            comSubmit.submit();
        }
        
        function fn_join() {
            var comSubmit = new ComSubmit("joinForm");
            comSubmit.setUrl("<c:url value='/common/join.do' />");
            comSubmit.submit();
        }
        
        function fn_logout() {
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/common/logout.do' />");
            comSubmit.submit();
        }
        
     // login with FACEBOOK
        window.fbAsyncInit = function() {  
         FB.init({appId: '1509929706002331', status: true, cookie: true,xfbml: true});      
        };
         
        //?? ???????????
        (function(d){  
         var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];  
         if (d.getElementById(id)) {return;}  
         js = d.createElement('script'); js.id = id; js.async = true;  
         js.src = "//connect.facebook.net/en_US/all.js";  
         ref.parentNode.insertBefore(js, ref);  
        }(document)); 
         
        
        function facebooklogin() {  
         FB.login(function(response) {
        	 // 로그인 성공시
           if (response.status === 'connected') {
          		getMyProfile();
           } else if (response.status === 'not_authorized') {
             // 페이스북에는 로그인 되어있으나, 앱에는 로그인 되어있지 않다.
           } else {
             // 페이스북에 로그인이 되어있지 않아서, 앱에 로그인 되어있는지 불명확하다.
           } alert("이미 로그인 하셨습니다.");
         } , {scope: "user_about_me,email,user_birthday"} ); //나는 유저의 아이디(이메일)과 생일 정보를 얻어오고 싶다.
         
        } 
         
        function getMyProfile() {
         FB.api('/me',function(user){
         
         var myName= user.name ;
         var myEmail = user.email;
         var myId = user.id;
         
         if(myEmail != ""){
           //정보를 post로 보내고 submit처리
         }
         });
         
         FB.api('/me/picture?type=large',function(data) {
         var myImg = data.data.url;
         });
        }
	</script>
</html>