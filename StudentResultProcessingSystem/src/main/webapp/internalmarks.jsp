<%@page import="com.mysql.cj.util.Base64Decoder"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%	
	ResultSet resultSet = (ResultSet) request.getAttribute("firstInternal");
	ResultSet resultSet2 = (ResultSet) request.getAttribute("secondInternal");

	int grandTotalObtained = 0;
	int grandTotalMax = 0;

//	String base64Image = "data:image/png;base64,";
//	base64Image	= base64Image + (String)session.getAttribute("userImage");

	if(resultSet == null){
%>
<jsp:forward page="/studdashboard.jsp"></jsp:forward>
<%} %>

    
<!DOCTYPE html5>
<html>
<head>
    <link rel="stylesheet" href="css/internal.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/dd03fdb332.js" crossorigin="anonymous"></script>
    <script src="js/pdf.js"></script>
    </head>
    <body>
        <a href=""><i class="fa-solid fa-arrow-left"></i></a>
        <button id="btn">Print PDF</button><br>
        <div class="main">
            
            <div class="inner">
             <h1><span>CANARA&nbsp;</span><img src="css/images/canlogo.png" class="logo"><span>&nbsp;COLLEGE</span></h1>
             <h5>Marks Sheet</h5>
             <h6><span style="color: palegoldenrod">Programme:&nbsp;&nbsp;<%=request.getAttribute("programmeName")%></span><span><%=session.getAttribute("programme")%></span></h6>
             <div class="img"><img src="css/images/faculty.png" class="studimg"></div>
             <div class="right"><h3><br><br><span >Date:&nbsp;</span><span><%=request.getAttribute("resulDate")%></span></h3><h4><span>Reg No:&nbsp;</span><span><%=session.getAttribute("regNo")%></span></h4></div>
            </div>
            <table border="1" class="table1" rules="all" align="center"> 
                    <tr bgcolor="#7dace4">
                        <th colspan="8" >FIRST INTERNAL MARKS SHEET</th>
                    </tr>
                    
                    <tr bgcolor="lightblue">
                        <th colspan="2">Courses</th>
                        <th colspan="4">Marks</th>
                        <th rowspan="2">Grade</th>
                        <th rowspan="2">Result</th>
                    </tr>
                    <tr bgcolor="lightblue">
                        <th>Name</th>
                        <th>Code</th>
                        <th></th>
                        <th>Max</th>
                        <th>Min</th>
                        <th>Obtained</th>
                    </tr>
                    
                <%
	                try{
	                	while(resultSet.next()){
	                		
							grandTotalMax = grandTotalMax + resultSet.getInt("max_marks");
							grandTotalObtained = grandTotalObtained + resultSet.getInt("obtained_marks");
    	 		%>
    	 		
                    <tr bgcolor="whitesmoke">
                        <td><%=resultSet.getString("course_name").toUpperCase()%></td>
                        <td><%=resultSet.getString("course_code").toUpperCase()%></td>
                        <td><%=resultSet.getString("course_type")%></td>
                        <td><%=resultSet.getString("max_marks")%></td>
                        <td><%=resultSet.getString("min_marks")%></td>
                        <td><%=resultSet.getString("obtained_marks")%></td>    <!--Obtained-->
                        <td><%=resultSet.getString("grade")%></td>    <!--Grade-->
                        <td><%=resultSet.getString("result").toUpperCase()%></td>    <!--Result-->
                    </tr>
                 <%  }
                 	}catch(SQLException e){
                		 e.printStackTrace();
                 }%>
                    
                    <tr bgcolor="whitesmoke">
                        <th colspan="2">Grand Total</th>
                        <td></td>    
                        <td><%=grandTotalMax%></td>   <!--Max total according to number of subjects--> 
                        <td></td>     <!--Min-->
                        <td><%=grandTotalObtained%></td>	<!--grand total-->
                        <td></td>
                        <td></td>
                    </tr>

                    
                   <%float average = 0f;float average2 = 0f;try{average = grandTotalObtained * 100 /grandTotalMax;}catch(ArithmeticException e){average = 0f;}%>
                    <tr class="tr2" bgcolor="whitesmoke">
                    <td colspan="8">&nbsp;Internal Average Percentage: <%=average%>%</td>
                    </tr>
                </table>
            
            
            <table border="1" class="table2" rules="all" align="center"> 
                    <tr bgcolor="#7dace4">
                        <th colspan="8" >SECOND INTERNAL MARKS SHEET</th>
                    </tr>
                    
                    <tr bgcolor="lightblue">
                        <th colspan="2">Courses</th>
                        <th colspan="4">Marks</th>
                        <th rowspan="2">Grade</th>
                        <th rowspan="2">Result</th>
                    </tr>
                    <tr bgcolor="lightblue">
                        <th>Name</th>
                        <th>Code</th>
                        <th></th>
                        <th>Max</th>
                        <th>Min</th>
                        <th>Obtained</th>
                    </tr>
                    
                <%
	                try{
	                	grandTotalMax = 0;
	                	grandTotalObtained = 0;
	                	
	                	while(resultSet2.next()){
	                		
							grandTotalMax = grandTotalMax + resultSet2.getInt("max_marks");
							grandTotalObtained = grandTotalObtained + resultSet2.getInt("obtained_marks");
    	 		%>
                    <tr bgcolor="whitesmoke">
                        <td><%=resultSet2.getString("course_name").toUpperCase()%></td>
                        <td><%=resultSet2.getString("course_code").toUpperCase()%></td>
                        <td><%=resultSet2.getString("course_type")%></td>
                        <td><%=resultSet2.getString("max_marks")%></td>
                        <td><%=resultSet2.getString("min_marks")%></td>
                        <td><%=resultSet2.getString("obtained_marks")%></td>    <!--Obtained-->
                        <td><%=resultSet2.getString("grade")%></td>    <!--Grade-->
                        <td><%=resultSet2.getString("result").toUpperCase()%></td>    <!--Result-->    <!--Result-->
                    </tr>
                    
                 <%  }
                 	}catch(SQLException e){
                		 e.printStackTrace();
                 }%>
                 
                    
                    <tr bgcolor="whitesmoke">
                        <th colspan="2">Grand Total</th>
                        <td></td>    
                        <td><%=grandTotalMax%></td>    		<!--Max total according to number of subjects-->
                        <td></td>     						<!--Min-->
                        <td><%=grandTotalObtained%></td>	<!--grand total-->
                        <td></td>
                        <td></td>
                    </tr>
                    
                  	<% try{average2 = grandTotalObtained * 100 /grandTotalMax;}catch(ArithmeticException e){average2 = 0f;}%>
                    <tr class="tr2" bgcolor="whitesmoke">
                    <td colspan="8">&nbsp;Internal Average Percentage: <%=average2%>%</td>
                    </tr>
                    <%if(average <= 0 && average2 <=0){
                    
            			String loginUser = (String) session.getAttribute("user");
            			
            			
            			if(loginUser == "student") {
            			%>
            			
            				<script type="text/javascript"> 
            				
		            		window.onload = function(){
		            			swal({title: "Sorry",
		               				 text: "No Result Data Found!",
		               				 icon: "warning",
		               				 buttons: {
		               					 ok: "OK",
		               				 },	 
		               			})
		               			.then((value) => {	
		               				if(value == "ok"){
		               					document.location.href="studdashboard.jsp";
		               				}else{
		               					document.location.href="studdashboard.jsp";
		               				}
		               			});
		            		}
            					
            				</script>
            			
            			<%}else if(loginUser == "staff") { %>	
            				
            				<script type="text/javascript"> 
            				window.onload = function(){
		            			swal({title: "Sorry",
		               				 text: "No Result Data Found!",
		               				 icon: "warning",
		               				 buttons: {
		               					 ok: "OK",
		               				 },	 
		               			})
		               			.then((value) => {	
		               				if(value == "ok"){
		               					document.location.href="staffdashboard.jsp";
		               				}else{
		               					document.location.href="staffdashboard.jsp";
		               				}
		               			});
		            		}
            					
            				</script>
            					
            			<%}else if(loginUser == "admin") { %>
            			
            				<script type="text/javascript"> 
            				window.onload = function(){
		            			swal({title: "Sorry",
		               				 text: "No Result Data Found!",
		               				 icon: "warning",
		               				 buttons: {
		               					 ok: "OK",
		               				 },	 
		               			})
		               			.then((value) => {	
		               				if(value == "ok"){
		               					document.location.href="admindashboard.jsp";
		               				}else{
		               					document.location.href="admindashboard.jsp";
		               				}
		               			});
		            		}
            					
            				</script>
            				
            			<% }
                    } %>
                </table>
        </div>
    </body>
</html>