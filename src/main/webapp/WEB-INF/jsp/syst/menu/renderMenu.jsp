<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>

<c:forEach var="submenu" items="${currentMenu.subMenus}" varStatus="subStatus">
    <div class="menu-folder" data-menuNo="${submenu.menuNo}">
        <i class="fas fa-folder"></i>${submenu.menuName}
    </div>
    <c:if test="${not empty submenu.subMenus}">
        <div class="nested"> <!-- Initially hidden -->
            <c:set var="currentMenu" value="${submenu}" scope="request"/>
            <jsp:include page="renderMenu.jsp" />
        </div>
    </c:if>
</c:forEach>