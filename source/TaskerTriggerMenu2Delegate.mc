import Toybox.Communications;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


class TaskerTriggerMenu2Delegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    // onSelect() is called when a menu item is selected
    function onSelect(menuItem) {
        // Get the label (used in the URL)
        var menuItemLabel = menuItem.getLabel();

        if (menuItem.getId().equals("no_tasks")) {
            return; // Do nothing if no tasks are configured
        }
        
        // Check if the paired phone is connected
        var deviceSettings = System.getDeviceSettings();
        if (!deviceSettings.phoneConnected) {
            // Show an error message if the phone is not connected
            var errorView = new TriggerSentView("Phone not connected\nCheck Bluetooth\nor disable\nbattery saver", true);
            WatchUi.pushView(errorView, null, WatchUi.SLIDE_IMMEDIATE);
            return;
        }
        
        // Send the open web page request notification to the paired phone
        Communications.openWebPage("http://" + menuItemLabel, {}, {});
        // Create a new view to show that the trigger was sent
        var triggerSentView = new TriggerSentView(menuItemLabel, false);
        // Push the view to the screen
        WatchUi.pushView(triggerSentView, null, WatchUi.SLIDE_IMMEDIATE);
    }
}