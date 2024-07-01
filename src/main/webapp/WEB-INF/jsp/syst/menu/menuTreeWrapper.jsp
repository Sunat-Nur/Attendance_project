<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<div class="menu-tree">
    <c:forEach items="${menuTree.root.children}" var="menuNode">
        <c:set var="menuNode" value="${menuNode}" scope="request" />
        <jsp:include page="recursiveMenuTree.jsp" />
    </c:forEach>
</div>