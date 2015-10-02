/*jslint browser: true*/
/*global jQuery*/
/*jslint vars: true*/

(function ($) {
    $.fn.bootstrapDynamicTabs = function () {

		this.each(function () {
			var $container = $(this);

			function DynamicTabs() {

				// Create object
				var TABS_OBJECT;
				TABS_OBJECT = this;
				TABS_OBJECT.tabsHorizontalContainer = $container;
				TABS_OBJECT.tabsHorizontalContainer.addClass("dynamic-tabs").wrap("<div class='dynamic-tabs-container clearfix'></div>");

				// Mark each tab with a 'tab-id' for easy access
				var $tabs      = TABS_OBJECT.tabsHorizontalContainer.children('li');
				$tabs.each(function (i) {
					$(this)
						.addClass("dynamic-tab")
						.attr("tab-id", i);
				});

				// Attach a dropdown to the right of the tabs bar
				// This will be toggled if tabs can't fit in a given viewport size
				TABS_OBJECT.tabsHorizontalContainer.after(
					"<div class='nav navbar-nav navbar-right dropdown tabs-dropdown'><a href='#' class='dropdown-toggle' data-toggle='dropdown'><span class='glyphicon glyphicon-th-list'/></a><ul class='dropdown-menu' role='menu'><div class='dropdown-header visible-xs'><p class='count'>Tabs</p><button type='button' class='close' data-dismiss='dropdown'><span aria-hidden='true'>&times;</span></button><div class='divider visible-xs'></div></div></ul></div>"
				);
				TABS_OBJECT.tabsVerticalContainer = TABS_OBJECT.tabsHorizontalContainer.siblings(".tabs-dropdown").find(".dropdown-menu");

				// Update tabs funtion
				var updateTabs = function () {

					var i, horizontalTab, tabId, verticalTab, tabWidth, isVisible;

					var availableWidth = TABS_OBJECT.tabsHorizontalContainer.width();
					var numVisibleHorizontalTabs = 1;

					var activeTab = TABS_OBJECT.tabsHorizontalContainer.find('.active');
					var activeTabIndex = activeTab.index();

					// active tab is always visible
					activeTab.toggleClass('hidden', false);
					availableWidth = availableWidth - activeTab.outerWidth(true);

					// Determine which tabs to show/hide
					var $tabs = TABS_OBJECT.tabsHorizontalContainer.children('li');

					// from active to firt
					for (i = activeTabIndex - 1; i >= 0; i--) {
						horizontalTab = $tabs.eq(i);
						if (availableWidth > 0) {
							horizontalTab.toggleClass('hidden', false);
							tabWidth = horizontalTab.outerWidth(true);
							isVisible = tabWidth <= availableWidth;
							if (isVisible) {
								availableWidth = availableWidth - tabWidth;
								numVisibleHorizontalTabs++;
							} else {
								availableWidth = -1;
							}
						} else {
							isVisible = false;
						}
						horizontalTab.toggleClass('hidden', !isVisible);
					}

					// from active to last
					for (i = activeTabIndex + 1; i < $tabs.length; i++) {
						horizontalTab = $tabs.eq(i);
						if (availableWidth > 0) {
							horizontalTab.toggleClass('hidden', false);
							tabWidth = horizontalTab.outerWidth(true);
							isVisible = tabWidth <= availableWidth;
							if (isVisible) {
								availableWidth = availableWidth - tabWidth;
								numVisibleHorizontalTabs++;
							} else {
								availableWidth = -1;
							}
						} else {
							isVisible = false;
						}
						horizontalTab.toggleClass('hidden', !isVisible);
					}

					// Toggle the Tabs dropdown if there are more tabs than can fit in the tabs horizontal container
					var numVisibleVerticalTabs = $tabs.length - numVisibleHorizontalTabs;
					var hasVerticalTabs = (numVisibleVerticalTabs > 0);
					TABS_OBJECT.tabsHorizontalContainer.siblings(".tabs-dropdown").toggleClass("hidden", !hasVerticalTabs);
				};

				// tabs dropdown event
				var onDropDow = function () {
					// Clone each tab into the dropdown
					TABS_OBJECT.tabsVerticalContainer.html("");
					TABS_OBJECT.tabsHorizontalContainer.children('li').clone().appendTo(TABS_OBJECT.tabsVerticalContainer);
					TABS_OBJECT.tabsVerticalContainer.children('li').toggleClass("hidden");
					TABS_OBJECT.tabsVerticalContainer.children('li').on("click", function (e) {
						TABS_OBJECT.tabsHorizontalContainer.find("[tab-id=" + $(this).attr("tab-id") + "]").tab("show");
						updateTabs();
					});
				};
				TABS_OBJECT.tabsHorizontalContainer.siblings(".tabs-dropdown").on('show.bs.dropdown', onDropDow);

				// now update tabs
				updateTabs();

				// Update tabs on window resize
				$(window).resize(function () {
					updateTabs();
				});
			}

			return new DynamicTabs();
		});
	};
}(jQuery));
