<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%session.setAttribute("LoginUser", "StudentLogin"); %> 
   
<% 
	response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
	if((request.getSession(false).getAttribute("student")!=null) )
	{
%> 
<jsp:forward page="/studdashboard.jsp"></jsp:forward>
<%} %> 

<!DOCTYPE html5>
<html>
    <head>
        <title>Student Login</title>
        <link rel="stylesheet" href="css/studentlogin.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css"/>
     	<script type="text/javascript" src="${pageContext.request.contextPath}/js/login.js"></script>
    	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
     </head>
    <body>
        <section class="header"> 
            <div class="maindiv2">
                <a href="home.jsp"><div class="divback"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;&nbsp;<span style="color: blue;font-size: 24px">Back</span></div></a>
               <h1>Login as <span style="color: blue">Student</span></h1> 
                
                
                <form name="studentLoginForm" action="LoginServlet" method="post" class="login1" onsubmit="return validate();">
                    <i class="fa-solid fa-user"></i>
                    <input name="username" class="field1" type="text" placeholder="Register Number"><br><br>
                    <i class="fa-solid fa-eye-slash" id="show-password" onclick="toggle()"></i>
                    <input id='password' name="password" class="field2" type="password" placeholder="Password"><br><br>
                    <span style="color:red"><%=(request.getAttribute("errMessage") == null) ? ""
         										: request.getAttribute("errMessage")%></span><br/>
         			<input type="hidden" value="student"/>
                    <input type="submit" value="Log In" class="btn"/>
                </form>
				<form id='forgotPasswordForm' action="forgotpassword.jsp" method="post">
					<input name="userType" type="hidden" value="student"/>
                    <a onclick="redirectForgot();"><p class="fp">Forgot password?<p></a>
                </form>
                </div>   
            <section class="header2">
                <div class="title"><p><b>Canara Exam Manager</b></p></div>
                <div class="leftdiv"><img class="edu" src="css/images/sd.png" ></div>
           </section>
            </section>   
            
            <script type="text/javascript">

            	
            	function validate(){
            		
            		var username = document.studentLoginForm.username.value; 
	                var password = document.studentLoginForm.password.value;
	           
	                
	                if((username == null || username == "")&&(password == null || password == "")){
	                	Swal.fire(
	                			  'Sorry',
	                			  'Please Enter Register Number and Password',
	                			  'error'
	                			)
	        			return false;
	                }
	                else if(username == null || username == ""){
	                	Swal.fire(
	                			  'Sorry',
	                			  'Please Enter Register Number',
	                			  'error'
	                			)
	        			return false;
	        		}
	        		else if(password == null || password == ""){
	        			Swal.fire(
	              			  'Sorry',
	              			  'Please Enter Password',
	              			  'error'
	              			)
	        			return false;
	        		}
            		
            	}
            	
                function redirectForgot(){
                	document.getElementById("forgotPasswordForm").submit();
                }
            	
            
            </script>  
    </body>
</html>