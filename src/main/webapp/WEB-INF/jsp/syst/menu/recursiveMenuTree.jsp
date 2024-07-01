<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty menuNode}">
    <div class="list-group-item">
        <span class="menu-toggle" onclick="toggleMenu(this);">
            <!-- Use custom folder icon here -->
            <span class="folder-icon"></span>
            ${menuNode.name}
        </span>
        <c:if test="${not empty menuNode.children}">
            <div class="submenu" style="display:none;">
                <c:forEach var="childNode" items="${menuNode.children}">
                    <c:set var="menuNode" value="${childNode}" scope="request" />
                    <jsp:include page="recursiveMenuTree.jsp" />
                </c:forEach>
            </div>
        </c:if>
    </div>
</c:if>





<script>
function toggleMenu(element) {
    var submenu = element.nextElementSibling;
    var iconOpen = element.querySelector('.fa-folder-open-o'); // Open folder icon
    var iconClosed = element.querySelector('.fa-folder'); // Closed folder icon

    if (submenu.style.display === "none") {
        submenu.style.display = "block";
        if(iconOpen && iconClosed) { // Ensure icons are present
            iconOpen.style.display = 'inline-block';
            iconClosed.style.display = 'none';
        }
    } else {
        submenu.style.display = "none";
        if(iconOpen && iconClosed) {
            iconOpen.style.display = 'none';
            iconClosed.style.display = 'inline-block';
        }
    }
}

</script>

<style>
.menu-toggle {
    cursor: pointer;
}
.arrow {
    display: inline-block;
    margin-left: 5px;
}
.submenu {
    list-style-type: none;
    padding-left: 20px;
}
.folder-icon {
    display: inline-block;
    width: 1.5em;
    height: 1.2em;
    background-color: #f9d835; /* Folder color */
    clip-path: polygon(0 0, 80% 0, 100% 20%, 100% 100%, 0 100%); /* Clip path to create the tab shape */
}

.folder-icon:before {
    content: '';
    display: block;
    position: relative;
    top: 0.3em;
    left: 0.1em;
    width: 100%;
    height: 0.6em;
    background-color: #f3c30b; /* Darker color for folder bottom */
    z-index: -1;
}

</style>
