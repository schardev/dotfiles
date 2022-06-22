// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// After every update manjaro keeps setting its website as homepage so
// set firefox home as default
user_pref("browser.startup.homepage", "about:home");

// Enable autoscroll by pressing mousewheel (default behaviour in Windows)
user_pref("general.autoScroll", true);

// Sober scrolling
user_pref("mousewheel.system_scroll_override.enabled", false);
