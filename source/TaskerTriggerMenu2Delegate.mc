import Toybox.WatchUi;
import Toybox.Communications;


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
        
        // Send the open web page request notification to the paired phone
        Communications.openWebPage("http://" + menuItemLabel, {}, {});
        // Create a new view to show that the trigger was sent
        var triggerSentView = new TriggerSentView(menuItemLabel);
        // Push the view to the screen
        WatchUi.pushView(triggerSentView, null, WatchUi.SLIDE_IMMEDIATE);
    }
}