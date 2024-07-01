<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<html>
<head>
    <title>Menu Structure</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .menu-folder {
            cursor: pointer;
            margin: 5px;
        }

        .menu-folder .fas {
            margin-right: 8px;
            color: #edc309;
        }

        .menu-folder-structure .nested {
            display: none;
            margin-left: 20px;
        }

        .menu-folder-structure .active {
            display: block;
        }
    </style>
    
    
<script>
function loadMenus() {
    var selectedMenuNo;
    var clickedSubMenus = []; // Array to store clicked submenus

    // Function to clear submenu array; call this when needed
    function clearClickedSubMenus() {
        clickedSubMenus = [];
    }

    // Function to get clicked submenus; use this to access the submenus array elsewhere
    function getClickedSubMenus() {
        return clickedSubMenus;
    }

    $.ajax({
        url: 'getMenusForMenuTree.do',
        type: 'GET',
        dataType: 'json',
        success: function(menus) {
            var menuContainer = $('.menu-folder-structure');
            menus.forEach(function(menu, index) {
                // Include data-menuNo attribute here
                var menuItem = $('<div class="menu-folder" data-menuNo="' + menu.menuNo + '">')
                    .html('<i class="fas fa-folder"></i> ' + menu.menuName)
                    .on('click', function() {
                        var menuNo = $(this).data('menuNo');
                        selectedMenuNo = menuNo; // Update the global variable.
                        console.log("selected menu number:" + menu.menuNo);
                        $(this).next('.nested').toggleClass('active');
                        $(this).find('.fas').toggleClass('fa-folder-open fa-folder');
                        if (menu.subMenus) {
                            clickedSubMenus = menu.subMenus;
                            updateTableWithSubMenus(clickedSubMenus);
                        }
                        setMenuNumber(menu);
                    });

                var subMenuContainer = $('<div class="nested">');
                if (menu.subMenus && menu.subMenus.length > 0) {
                    addSubMenus(menu.subMenus, subMenuContainer);
                }
                menuContainer.append(menuItem);
                menuContainer.append(subMenuContainer);
            });

            // Automatically expand the root menu and load its submenus
            if (menus.length > 0 && menus[0].subMenus) {
                $('.menu-folder').first().trigger('click');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading menus: " + error);
        }
    });

    function addSubMenus(subMenus, parentElement) {
        subMenus.forEach(function(subMenu) {
            // Also include data-menuNo attribute for submenus
            var subMenuItem = $('<div class="menu-folder" data-menuNo="' + subMenu.menuNo + '">')
                .html('<i class="fas fa-folder"></i> ' + subMenu.menuName)
                .on('click', function(event) {
                    var menuNo = $(this).data('menuNo');
                    selectedMenuNo = menuNo; // Update the global variable.
                    console.log("selected menu number:" + subMenu.menuNo);
                    event.stopPropagation();
                    $(this).next('.nested').toggleClass('active');
                    $(this).find('.fas').toggleClass('fa-folder-open fa-folder');
                    if (subMenu.subMenus) {
                        clickedSubMenus = subMenu.subMenus;
                        updateTableWithSubMenus(clickedSubMenus);
                    }
                    setMenuNumber(subMenu);
                });

            var nestedSubMenuContainer = $('<div class="nested">');
            if (subMenu.subMenus && subMenu.subMenus.length > 0) {
                addSubMenus(subMenu.subMenus, nestedSubMenuContainer);
            }
            parentElement.append(subMenuItem);
            parentElement.append(nestedSubMenuContainer);
        });
    }
}

// Call the function to load menus when the document is ready
$(document).ready(function() {
    loadMenus();
});

</script>


</head>
<body>

<div class="menu-folder-structure">
    <c:forEach var="menu" items="${rootMenus}" varStatus="status">
        <div class="menu-folder" data-menuNo="${menu.menuNo}">
            <i class="fas fa-folder"></i>${menu.menuName}
        </div>
        <c:if test="${not empty menu.subMenus}">
            <div class="nested">
                <c:set var="currentMenu" value="${menu}" scope="request"/>
                <jsp:include page="renderMenu.jsp" />
            </div>
        </c:if>
    </c:forEach>
</div>

</body>
</html>
