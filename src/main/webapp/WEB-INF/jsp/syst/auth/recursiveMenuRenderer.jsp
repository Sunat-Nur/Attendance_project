<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty menuNode}">
    <div class="list-group-item">
        <c:if test="${menuNode.upperMenuNo != null}">
    <input type="checkbox" name="selectedMenus" value="${menuNode.id}" ${selectedMenuIds.contains(menuNode.id) ? 'checked' : ''}/>
</c:if> <!-- Check if menu ID is in selectedMenuIds list -->
        <span class="menu-toggle" onclick="toggleMenu(this);">
            <i class="fa ${empty menuNode.children ? 'fa-file' : 'fa-folder'}"></i>
            ${menuNode.name}
        </span>
        <c:if test="${not empty menuNode.children}">
            <div class="submenu" style="display:none;">
                <c:forEach var="childNode" items="${menuNode.children}">
                    <c:set var="menuNode" value="${childNode}" scope="request" />
                    <jsp:include page="recursiveMenuRenderer.jsp" />
                </c:forEach>
            </div>
        </c:if>
    </div>
</c:if>




<script>
function toggleMenu(element) {
   
    var submenu = element.nextElementSibling;
    if (submenu.style.display === "none") {
        submenu.style.display = "block";
        element.querySelector('.arrow').innerHTML = '&#9652;';
    } else {
        submenu.style.display = "none"; // Hide the submenu
        element.querySelector('.arrow').innerHTML = '&#9662;';
    }
}


document.addEventListener('DOMContentLoaded', function() {
    // Automatically open the first level of the tree menu
    document.querySelectorAll('.submenu').forEach(function(submenu, index) {
        // Check if this is the first level by seeing if it's a direct child of a 'list-group' class
        if(submenu.closest('.list-group-item').parentNode.classList.contains('list-group')) {
            submenu.style.display = 'block'; // Show the first level
            var toggleIcon = submenu.previousElementSibling.querySelector('i');
            if (toggleIcon) {
                toggleIcon.classList.remove('fa-folder');
                toggleIcon.classList.add('fa-folder-open'); // Change the icon if you have one for open folders
            }
        }
    });
});

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
</style>