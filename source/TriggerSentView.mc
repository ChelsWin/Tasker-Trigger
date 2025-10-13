import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;


class TriggerSentView extends WatchUi.View {

    // Theme and colours
    var _theme = THEME_DARK;
    var _fgColour = Graphics.COLOR_WHITE;
    var _bgColour = Graphics.COLOR_BLACK;
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
        // Set the colours
        _theme = Application.getApp().getTheme();
        if (_theme.equals(THEME_LIGHT)) {
            _fgColour = Graphics.COLOR_BLACK;
            _bgColour = Graphics.COLOR_WHITE;
        } else {
            _fgColour = Graphics.COLOR_WHITE;
            _bgColour = Graphics.COLOR_BLACK;
        }
    }

    // onShow() is called when the view is shown
    function onShow() {
        _timer = new Timer.Timer();
        // Start the timer to call popView after 1.6 seconds
        _timer.start(method(:popView), 1600, false);
    }

    // onUpdate() is called to update the view
    function onUpdate(dc) {
        // Check if the theme has changed
        if (Application.getApp().getTheme() != _theme) {
            onLayout(dc);
        }

        // Set the text colour and background based on the theme
        dc.setColor(_fgColour, _bgColour);
        dc.clear();
        // Draw the message and "Triggered!" text centered on the screen (added 2 line breaks so it is visible on Instinct Crossover)
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, _message + "\n\nTriggered!", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
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