import Toybox.Lang;
import Toybox.Timer;
import Toybox.WatchUi;


class TriggerSentView extends WatchUi.View {

    // Timer to auto-close the view
    var _timer;
    // Message to display on screen
    var _message;

    function initialize(message as String) {
        View.initialize();
        // Truncate the message if it exceeds 16 characters
        if (message.length() > 16) {
            _message = message.substring(0, 13) + "...";
        } else {
            _message = message;
        }
    }

    // onLayout() is called to set the layout of the view
    function onLayout(dc) {
    }

    // onShow() is called when the view is shown
    function onShow() {
        _timer = new Timer.Timer();
        // Start the timer to call popView after 1.6 seconds
        _timer.start(method(:popView), 1600, false);
    }

    // onUpdate() is called to update the view
    function onUpdate(dc) {
        dc.clear();
        // Set text color to white and background to black
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_TINY, _message + "\nTriggered!", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    // onHide() is called when the view is hidden
    function onHide() {
        // Stop the timer
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }
    }

    // Called to close the view and return to the previous one
    function popView() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}