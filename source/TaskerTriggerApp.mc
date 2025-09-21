import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


enum Theme {
    THEME_LIGHT,
    THEME_DARK
}

class TaskerTriggerApp extends Application.AppBase {

    // Store a reference to the menu UI
    var _menu;
    // Define the number of tasks
    var _numberOfTasks = 20;
    // Theme tracking
    private var _theme = THEME_LIGHT;

    function initialize() {
        AppBase.initialize();
        updateTheme();
    }

    // onNightModeChanged() is called when the device's night mode setting changes
    function onNightModeChanged() as Void {
        // Update the theme
        updateTheme();
        // Force a screen update
        WatchUi.requestUpdate();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        // Create a new menu with a title
        _menu = new WatchUi.Menu2({ :title => Rez.Strings.AppName });
        // Create a delegate to handle menu item interactions
        var delegate = new TaskerTriggerMenu2Delegate();
        updateMenuItems();
        // Return the menu and its delegate as the initial view
        return [_menu, delegate];
    }

    // onSettingsChanged() is called when the settings are changed
    function onSettingsChanged() as Void {
        if (_menu == null) {
            return;
        }
        updateMenuItems();
        // Request a screen update so changes are shown
        WatchUi.requestUpdate();
    }

    // getGlanceView() is called to return the glance view and its delegate
    function getGlanceView() {
        return [ new TaskerTriggerGlanceView() ];
    }

    // Update the theme based on the device settings
    private function updateTheme() as Void {
        // Test for night mode
        if (System.getDeviceSettings() has :isNightModeEnabled) {
            _theme = System.getDeviceSettings().isNightModeEnabled ? THEME_DARK : THEME_LIGHT;
        } else {
            _theme = THEME_DARK;
        }
    }

    // Theme accessor
    function getTheme() as Theme {
        return _theme;
    }

    // --------------------------
    //      Helper Methods
    // --------------------------
    
    // Updates the list of task menu items based on stored settings
    function updateMenuItems() {
        removeNoTasksPlaceholder();

        var menuItemCount = 0;

        for (var i = 1; i <= _numberOfTasks; i += 1) {
            var taskKey = "task_" + i.toString();
            // Load and trim the task name
            var taskName = trimString(Properties.getValue(taskKey));

            // If the task has a valid name then add or update its menu item
            if (!taskName.equals(null) && taskName.length() > 0) {
                addOrUpdateTaskMenuItem(taskKey, taskName);
                menuItemCount += 1;
            } else {
                // If the task is empty then remove it from the menu if it exists
                var index = _menu.findItemById(taskKey);
                if (index != -1) {
                    _menu.deleteItem(index);
                }
            }
        }

        // If no tasks were added then show a placeholder message
        if (menuItemCount == 0) {
            addPlaceholderIfNoTasks();
        }
    }

    // Adds or updates a single task menu item
    function addOrUpdateTaskMenuItem(taskKey as String, taskName as String) {
        var index = _menu.findItemById(taskKey);
        var item = new WatchUi.MenuItem(taskName, null, taskKey, {});
        if (index != -1) {
            // If the item already exists then update it
            _menu.updateItem(item, index);
        } else {
            // Otherwise, add it as a new item
            _menu.addItem(item);
        }
    }

    // Adds a placeholder menu item if no tasks are defined
    function addPlaceholderIfNoTasks() {
        var item = new WatchUi.MenuItem(Rez.Strings.no_tasks, null, "no_tasks", {});
        _menu.addItem(item);
    }

    // Removes the "No tasks configured" placeholder if it exists
    function removeNoTasksPlaceholder() {
        var noTasksIndex = _menu.findItemById("no_tasks");
        if (noTasksIndex != -1) {
            _menu.deleteItem(noTasksIndex);
        }
    }

    // Removes leading and trailing whitespace (spaces, newlines, and tabs)
    function trimString(str as String) as String {
        if (str.equals(null) || str.length() == 0) {
            return ""; // Return empty string if input is null or empty
        }
        var chars = str.toCharArray();
        var start = 0;
        var end = chars.size() - 1;

        // Trim leading whitespace
        while (start <= end && (chars[start].equals(' ') || chars[start].equals('\n') || chars[start].equals('\t'))) {
            start += 1;
        }

        // Trim trailing whitespace
        while (end >= start && (chars[end].equals(' ') || chars[end].equals('\n') || chars[end].equals('\t'))) {
            end -= 1;
        }

        // Return the trimmed string
        if (start > end) {
            return ""; // Return empty string if all characters are trimmed
        }
        return str.substring(start, end + 1);
    }
}

function getApp() as TaskerTriggerApp {
    return Application.getApp() as TaskerTriggerApp;
}