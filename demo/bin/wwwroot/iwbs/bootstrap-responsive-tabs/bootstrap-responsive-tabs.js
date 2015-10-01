/*jslint browser: true*/
/*global jQuery*/
/*jslint vars: true*/

(function ($) {
    $.fn.bootstrapResponsiveTabs = function () {

		// Helper function to sort tabs base on their original index positions
		var sort_tabs = function ($tabsContainer) {
			var $tabs = $tabsContainer.find(".responsive-tab");
			$tabs.sort(function (a, b) {
				return +a.getAttribute('tab-index') - +b.getAttribute('tab-index');
			});
			$tabsContainer.detach(".responsive-tab").append($tabs);
		};

		// Main functions for each instantiated responsive tabs
		this.each(function () {

			var $container = $(this);
			var ResponsiveTabs = (function () {
				function ResponsiveTabs() {

					var TABS_OBJECT;
					TABS_OBJECT = this;
					TABS_OBJECT.activeTabId = 1;
					TABS_OBJECT.tabsHorizontalContainer = $container;
					TABS_OBJECT.tabsHorizontalContainer.addClass("responsive-tabs").wrap("<div class='responsive-tabs-container clearfix'></div>");

					// Update tabs
					var update_tabs = function () {

						// Determine which tabs to show/hide
						var $tabs = TABS_OBJECT.tabsHorizontalContainer.children('li');
						var availableWidth = TABS_OBJECT.tabsHorizontalContainer.width();
						var numVisibleHorizontalTabs = 0;
						var i;
						for (i = 0; i < $tabs.length; i++) {
							var horizontalTab = $tabs.eq(i);
							var tabId = horizontalTab.attr("tab-id");
							var verticalTab = TABS_OBJECT.tabsVerticalContainer.find(".responsive-tab[tab-id=" + tabId + "]");
							if (availableWidth > 0) {
								horizontalTab.toggleClass('hidden', false);
							}
							var tabWidth = horizontalTab.outerWidth(true);
							var isVisible = tabWidth <= availableWidth;
							if (isVisible) {
								availableWidth = availableWidth - tabWidth;
								numVisibleHorizontalTabs++;
							} else {
								availableWidth = -1;
							}
							horizontalTab.toggleClass('hidden', !isVisible);
							verticalTab.toggleClass('hidden', isVisible);
						}

						// Toggle the Tabs dropdown if there are more tabs than can fit in the tabs horizontal container
						var numVisibleVerticalTabs = $tabs.length - numVisibleHorizontalTabs;
						var hasVerticalTabs = (numVisibleVerticalTabs > 0);
						TABS_OBJECT.tabsHorizontalContainer.siblings(".tabs-dropdown").toggleClass("hidden", !hasVerticalTabs);
						TABS_OBJECT.tabsVerticalContainer.toggleClass("hidden", !hasVerticalTabs);
						TABS_OBJECT.tabsVerticalContainer.siblings(".dropdown-toggle").find(".count").text("Tabs " + "(" + numVisibleVerticalTabs + ")");

						// Make 'active' tab always visible in horizontal container
						// and hidden in vertical container
						var activeTab = TABS_OBJECT.tabsHorizontalContainer.find(".responsive-tab[tab-id=" + TABS_OBJECT.activeTabId + "]");
						var activeTabCurrentIndex = activeTab.index();
						var activeTabDefaultIndex = activeTab.attr("tab-index");
						var lastVisibleHorizontalTab = TABS_OBJECT.tabsHorizontalContainer.find(".responsive-tab:visible").last();
						var lastVisibleTabIndex = lastVisibleHorizontalTab.index();

						var lastHiddenVerticalTab = TABS_OBJECT.tabsVerticalContainer.find(".responsive-tab.hidden").last();
						var activeVerticalTab = TABS_OBJECT.tabsVerticalContainer.find(".responsive-tab[tab-index=" + activeTabCurrentIndex + "]");

						if (activeTabCurrentIndex >= numVisibleHorizontalTabs) {
							activeTab.insertBefore(lastVisibleHorizontalTab);
							activeTab.removeClass("hidden");
							lastVisibleHorizontalTab.addClass("hidden");

							lastHiddenVerticalTab.removeClass("hidden");
							activeVerticalTab.addClass("hidden");
						}

						if ((activeTabCurrentIndex < activeTabDefaultIndex) && (activeTabCurrentIndex < lastVisibleTabIndex)) {
							activeTab.insertAfter(lastVisibleHorizontalTab);
						}
					};

					// SETUP
					var setup = (function () {
						// Reset all tabs for calc function
						var totalWidth = 0;
						var $tabs      = TABS_OBJECT.tabsHorizontalContainer.children('li');

						// Stop function if there are no tabs in container
						if ($tabs.length === 0) {
							return;
						}

						// Mark each tab with a 'tab-id' for easy access
						$tabs.each(function (i) {
							var tabIndex;
							tabIndex = $(this).index();
							$(this)
								.addClass("responsive-tab")
								.attr("tab-id", i + 1)
								.attr("tab-index", tabIndex);
						});

						// Attach a dropdown to the right of the tabs bar
						// This will be toggled if tabs can't fit in a given viewport size

						TABS_OBJECT.tabsHorizontalContainer.after(
							"<div class='nav navbar-nav navbar-right dropdown tabs-dropdown js-tabs-dropdown'> \
							<a href='#' class='dropdown-toggle' data-toggle='dropdown'><span class='count'>Tabs </span><b class='caret'></b></a> \
							<ul class='dropdown-menu' role='menu'> \
								<div class='dropdown-header visible-xs'>\
									<p class='count'>Tabs</p> \
									<button type='button' class='close' data-dismiss='dropdown'><span aria-hidden='true'>&times;</span></button> \
									<div class='divider visible-xs'></div> \
								</div> \
							</ul> \
							</div>"
						);

						// Clone each tab into the dropdown
						TABS_OBJECT.tabsVerticalContainer = TABS_OBJECT.tabsHorizontalContainer.siblings(".tabs-dropdown").find(".dropdown-menu");
						$tabs.clone().appendTo(TABS_OBJECT.tabsVerticalContainer);

						// Update tabs
						update_tabs();
					}());


					/** 
					* Change Tab
					*/
					var change_tab = (function (e) {
						TABS_OBJECT.tabsHorizontalContainer.parents(".responsive-tabs-container").on("click", ".responsive-tab", function (e) {

							// Set 'activeTabId' property from clicked tab
							var target = $(e.target);
							TABS_OBJECT.activeTabId = $(this).attr("tab-id");

							// Update tab 'active' class for horizontal container if tab is clicked
							// from dropdown. Otherwise Bootstrap handles the normal 'active' class placement.
							var verticalTabSelected = target.parents(".dropdown-menu").length > 0;
							if (verticalTabSelected) {
								TABS_OBJECT.tabsHorizontalContainer.find(".responsive-tab").removeClass("active");
								TABS_OBJECT.tabsHorizontalContainer.find(".responsive-tab[tab-id=" + TABS_OBJECT.activeTabId + "]").addClass("active");
							}

							TABS_OBJECT.tabsVerticalContainer.find(".responsive-tab").removeClass("active");

							// Call 'sort_tabs' to re-arrange tabs based on their original index positions
							// Call 'update_tabs' to resize tabs and determine which one to show/hide 
							sort_tabs(TABS_OBJECT.tabsHorizontalContainer);
							sort_tabs(TABS_OBJECT.tabsVerticalContainer);
							update_tabs();
						});
					}());

					// Update tabs on window resize
					$(window).resize(function () {
						update_tabs();
					});
				}

				return new ResponsiveTabs();
			}());
		});
	};
}(jQuery));
