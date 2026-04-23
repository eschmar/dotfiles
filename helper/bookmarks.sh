P="$HOME/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist"
killall -u "$USER" cfprefsd 2>/dev/null || true
plutil -convert xml1 "$P"
/usr/libexec/PlistBuddy -c "Set :SidebarBookmarksHierarchyViewPreference true" "$P" 2>/dev/null || \
/usr/libexec/PlistBuddy -c "Add :SidebarBookmarksHierarchyViewPreference bool true" "$P"
/usr/libexec/PlistBuddy -c "Set :SidebarBookmarksCompactViewModePreference true" "$P" 2>/dev/null || \
/usr/libexec/PlistBuddy -c "Add :SidebarBookmarksCompactViewModePreference bool true" "$P"
killall -u "$USER" cfprefsd 2>/dev/null || true
