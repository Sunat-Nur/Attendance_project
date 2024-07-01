$(document).ready(function() {
   	let menus = [];
   	const activeMenuNo = localStorage.getItem('activeMenuNo');
   	
    fetchMenusAndRender();
    fetchParentMenuHierarchy();
 
    
    var isHoveringSubmenu = false;
    
  	const clickedMenuNo = localStorage.getItem('clickedMenuNo');
  	
  	if (!activeMenuNo) {
        // If there's no 'activeMenuNo' in local storage, adjust layout
        $('#sidebar').hide(); // Hide the sidebar
        $('#pageContent').css({
            'margin-left': '0', // Remove any margin to the left
            'width': '100%' // Set width to 100%
        });
    }
  	
    // Read the activeMenuNo from localStorage

   	if (activeMenuNo) {
        displayHierarchyInSidebar(menus, activeMenuNo); // This requires `menus` to be available globally or fetched again
 		// Mark the menu item as active
	    const selector = `[data-menu-no="${activeMenuNo}"]`;
	    $(selector).addClass('active');
    }
    
    
    // Hover event on main menu items
    $('.subheader').on('mouseenter', '.menu-item', function() {
        // Show only the submenu of the hovered menu item
        $(this).find('.submenu').first().show();
    });

    // Adjusted to manage submenu visibility on hover correctly
    $('.subheader').on('mouseleave', '.menu-item', function() {
        // Delay hiding to allow for hover on submenu
        setTimeout(function() {
            if (!isHoveringSubmenu) {
                 $('#submenuContainer').hide();
            }
        }, 100); // Small delay to catch transition between menu and submenu
    });

    // Track hover state on submenus directly
    $(document).on('mouseenter', '.submenu', function() {
        isHoveringSubmenu = true;
    }).on('mouseleave', '.submenu', function() {
        isHoveringSubmenu = false;
        $('#submenuContainer').hide(); // Hide this submenu
    });
    
    
	 function fetchParentMenuHierarchy() {
	    // Assuming you have a way to determine the currentMenuUrl
	    var currentMenuUrl = window.location.pathname; // Example to get the current URL's pathname
	
	    $.ajax({
	        url: '/webProject/syst/menu/parentMenusHierarchy.do',
	        type: 'GET',
	        data: { menuUrl: currentMenuUrl }, // Pass the current menu URL as a parameter
	        dataType: 'json',
	        success: function(hierarchy) {
	            console.log(hierarchy); // Process the hierarchy data as needed
	            // For example, use it to mark the active menu item or generate breadcrumbs
	            // This might involve iterating over the hierarchy and matching menu items in your DOM
	            
	            // Highlight the 0th object in the hierarchy array as the active menu
	            if (hierarchy.length > 0) {
	                const activeMenu = hierarchy[0];
	                const activeMenuItem = $(`li[data-menu-no="${activeMenu.menuNo}"]`);
	                activeMenuItem.addClass('active');
	                
	                // Generate breadcrumb
	                generateBreadcrumb(activeMenu, hierarchy);
	            }
	        },
	        error: function() {
	            console.error('Failed to load parent menu hierarchy.');
	        }
	    });
	}
	
	
	function generateBreadcrumb(activeMenu, hierarchy) {
	    const breadcrumbContainer = $('#breadcrumbContainer');
	    breadcrumbContainer.empty(); // Clear previous breadcrumb
	
	    // Define the home icon HTML. You can use an SVG, Font Awesome icon, or any other preferred icon library
	    const homeIconHtml = '<i class="fa fa-home"></i>'; // Example using Font Awesome, ensure you include the Font Awesome library
	
	    // Iterate over the hierarchy to generate breadcrumb
	    hierarchy.forEach((menu, index) => {
	        let breadcrumbItem;
	        if (menu.menuName === 'Home') {
	            // If menu name is Home, use the home icon instead of text
	            breadcrumbItem = $('<span>').html(homeIconHtml).addClass('breadcrumb-item');
	        } else {
	            // For all other menu names, use text
	            breadcrumbItem = $('<span>').text(menu.menuName).addClass('breadcrumb-item');
	        }
	
	        breadcrumbContainer.append(breadcrumbItem);
	
	        // Add active class to the last menu item
	        if (index === hierarchy.length - 1) {
	            breadcrumbItem.addClass('active');
	        }
	    });
	}


	function fetchMenusAndRender() {
	    $.ajax({
	        url: '/webProject/syst/menu/menuListForMenu.do',
	        type: 'GET',
	        dataType: 'json',
	        success: function(responseMenus) {
	            menus = responseMenus; // Store the fetched menus for later use
	            renderMainMenu(responseMenus);
	            markActiveMenu(); // Ensure this is called after menus are fetched and rendered
	            
	            // Call expandToActiveMenu here to ensure menus is populated
	            const activeMenuNo = localStorage.getItem('activeMenuNo');
	        },
	        error: function() {
	            alert('Failed to load menus.');
	        }
	    });
	}
	
	
    
function renderMainMenu(menus) {
    const mainMenus = menus.filter(menu => menu.upperMenuNo === 0);
    mainMenus.forEach(menu => {
        const menuItem = $('<li>').text(menu.menuName).attr('data-menu-no', menu.menuNo).addClass('menu-item main-menu-title');
        $('#menuContainer').append(menuItem);
        
        menuItem.on('click', function() {
		    if (menu.menuUrl) {
		        // Store the menuNo in localStorage before navigation
		        localStorage.setItem('activeMenuNo', menu.menuNo);
		        window.location.href = menu.menuUrl; // Navigate to the URL
		    }
		});
        
        menuItem.on('mouseenter', function(e) {
            e.stopPropagation(); // Prevent hover from bubbling up
            $('#submenuContainer').empty(); // Clear previous submenus

            const position = $(this).offset(); // Position of the main menu item
            const menuItemWidth = $(this).outerWidth(); // Width of the main menu item

            // Assuming renderSubMenu correctly populates #submenuContainer
            renderSubMenu(menu, menus, $('#submenuContainer'), 0, position);

            // Use setTimeout to wait for #submenuContainer to be populated and have a calculated width
            setTimeout(() => {
                const submenuWidth = $('#submenuContainer').outerWidth(); // Width of the submenu
                const newLeftPosition = position.left + menuItemWidth / 2 - submenuWidth / 2;

                $('#submenuContainer').css({
                    position: 'absolute',
                    top: position.top + $(this).outerHeight(), // Align the top of the submenu with the bottom of the menu item
                    left: newLeftPosition, // Adjust left to center submenu under the main menu item
                    display: 'none'
                }).slideDown('fast'); // Show submenu
            }, 0); // setTimeout ensures that the DOM has been updated before calculating widths
        });
    });
            expandActiveMenuHierarchy(menus, activeMenuNo);
}


    // Modified version of renderSubMenu to include the logic for handling menus without URLs
	function renderSubMenu(parentMenu, menus, container, level = 0, position) {
	    const subMenus = menus.filter(menu => menu.upperMenuNo === parentMenu.menuNo);
	
	    if (subMenus.length > 0) {
	        const submenuList = $('<ul>').addClass('submenu').css('display', level === 0 ? 'block' : 'none');
	
	        subMenus.forEach(subMenu => {
	            const submenuItem = $('<li>').text(subMenu.menuName).attr('data-menu-no', subMenu.menuNo).addClass('submenu-item');
	            
	            submenuItem.on('click', function(e) {
	                e.stopPropagation(); // Prevent the click from bubbling up
	                const firstUrlMenu = findFirstUrlMenu(subMenu.menuNo, menus);
	                if (firstUrlMenu) {
	                    localStorage.setItem('clickedMenuNo', firstUrlMenu.menuNo); // Save the clicked menu number
	                    localStorage.setItem('activeMenuNo', firstUrlMenu.menuNo);
	                    window.location.href = firstUrlMenu.menuUrl; // Navigate to the URL
	                } else {
	                    // If no URL is found, you might want to handle this case (e.g., show a notification)
	                }
	            });
	            
	            submenuList.append(submenuItem);
	        });
	
	        container.append(submenuList);
	    }
	}

    
    
function displayHierarchyInSidebar(allMenus, clickedMenuNo) {
    const sidebar = $('#sidebar');
    sidebar.empty(); // Clear existing sidebar content

    const clickedMenu = allMenus.find(menu => menu.menuNo.toString() === clickedMenuNo);
    
    let rootParent = clickedMenu;
    while (rootParent && rootParent.upperMenuNo !== 0) {
        rootParent = allMenus.find(menu => menu.menuNo === rootParent.upperMenuNo);
    }

    if (rootParent) {
        // Display the root parent (main menu title) at the top
        const mainMenuTitle = $('<div>').addClass('main-menu-title').text(rootParent.menuName);
        sidebar.append(mainMenuTitle);

        const mainMenuChildren = allMenus.filter(menu => menu.upperMenuNo === rootParent.menuNo);
        mainMenuChildren.forEach(child => {
            const menuElement = createMenuElement(child, allMenus, clickedMenuNo);
            sidebar.append(menuElement);
        });
    }
}


    // Modified createMenuElement function to handle active menu and its parent expansion
	function createMenuElement(menu, allMenus, clickedMenuNo, parentMenuNo, level = 0) {
	    const menuItem = $('<li>').addClass('submenu-item');
	    const menuName = $('<span>').text(menu.menuName).addClass('menu-name');
	    menuItem.append(menuName);
	
	    const children = allMenus.filter(m => m.upperMenuNo === menu.menuNo);
	
	    if (children.length > 0 || menu.menuUrl) {
	        const toggleSpan = $('<span>').addClass('toggle').html(children.length > 0 ? '[-]' : ''); // Indicate expanded
	        menuItem.append(toggleSpan);
	
	        // Automatically show child list if there are any children
	        const childList = $('<ul>').css('display', children.length > 0 ? 'block' : 'none'); // Show by default
	        children.forEach(child => {
	            childList.append(createMenuElement(child, allMenus, clickedMenuNo, menu.menuNo, level + 1));
	        });
	        menuItem.append(childList);
	
	        toggleSpan.on('click', function(e) {
	            e.stopPropagation();
	            const isVisible = childList.is(':visible');
	            childList.slideToggle('fast');
	            $(this).html(isVisible ? '[+]' : '[-]'); // Toggle indicator
	        });
	    }
	
	    menuName.on('click', function() {
	        if (menu.menuUrl) {
	            localStorage.setItem('clickedMenuNo', menu.menuNo.toString());
	            localStorage.setItem('activeMenuNo', menu.menuNo.toString());
	            window.location.href = menu.menuUrl;
	        } else {
	            $(this).siblings('.toggle').click();
	        }
	    });
	
	    // Maintain existing logic for highlighting active menu and ensuring its parents are expanded
	    if (menu.menuNo.toString() === clickedMenuNo) {
	        menuName.addClass('active');
	        menuItem.parentsUntil('#sidebar', 'ul').css('display', 'block');
	        menuItem.parentsUntil('#sidebar', 'li').find('> .toggle').html('[-]');
	    }
	
	    return menuItem;
	}


    // Ensure expandToActiveMenu is correctly utilized for displaying active menu and expanding its parents
    function markActiveMenu() {
        const activeMenuNo = localStorage.getItem('activeMenuNo');
        if (activeMenuNo) {
            displayHierarchyInSidebar(menus, activeMenuNo);
            // This will now correctly expand parent menus as well
        }
    }
    
 
    function expandActiveMenuHierarchy(menus, activeMenuNo) {
        var activeMenu = menus.find(menu => menu.menuNo.toString() === activeMenuNo);
        if (!activeMenu) return;

        // Expand all parent menus of the active menu
        var currentMenu = activeMenu;
        while (currentMenu.upperMenuNo !== 0) {
            var parentMenu = menus.find(menu => menu.menuNo === currentMenu.upperMenuNo);
            if (!parentMenu) break;

            $(`[data-menu-no="${parentMenu.menuNo}"]`).find('> .toggle').html('[-]').next('ul').show();
            currentMenu = parentMenu;
        }

        // Highlight and expand the active menu
        $(`[data-menu-no="${activeMenuNo}"]`).addClass('active').parents('li').find('> .toggle').html('[-]').next('ul').show();
    }





    function findFirstUrlMenu(menuNo, allMenus) {
        let queue = [menuNo];
        while (queue.length > 0) {
            const currentMenuNo = queue.shift();
            const currentMenu = allMenus.find(m => m.menuNo === currentMenuNo);
            if (currentMenu && currentMenu.menuUrl) {
                return currentMenu;
            }
            const children = allMenus.filter(m => m.upperMenuNo === currentMenuNo);
            queue.push(...children.map(m => m.menuNo));
        }
        return null; // In case no suitable URL is found
    }

    

    // Hide submenus when clicking outside, with consideration for submenu interaction
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.subheader, .submenu').length) {
             $('#submenuContainer').hide();
            isHoveringSubmenu = false;
        }
    });
    
});


