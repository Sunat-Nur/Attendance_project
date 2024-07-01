<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>

<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/webProject/resources/js/total.js" type="text/javascript"></script>
    
</head>
<body>
    <div class="header">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/syst/main/home.do">
                <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Miraegisul IT">
            </a>
        </div>
        <div class="user-logout-group">
            <div class="user-info">
                <img src="${pageContext.request.contextPath}/resources/images/user-icon.png" alt="User">
                <span class="username">${loggedInUser.name}</span>
                <c:if test="${not empty lastAccess}">
                    <span class="last-access">Last Access: <fmt:formatDate value="${lastAccess}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </c:if>
            </div>
            <div class="logout">
                <a href="${pageContext.request.contextPath}/syst/main/logout.do">
                    <img src="${pageContext.request.contextPath}/resources/images/log-out.png" alt="Logout">
                    <span>Logout</span>
                </a>
            </div>
        </div>
    </div>
</body>

<script>
$(document).ready(function() {
    $(document).on('click', '.logo, .logout', function(e) {
        localStorage.removeItem('activeMenuNo');
    });  
});  
</script>
