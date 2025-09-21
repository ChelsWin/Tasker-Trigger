import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


(:glance)
class TaskerTriggerGlanceView extends WatchUi.GlanceView {

    // Theme and colours
    var _theme = THEME_DARK;
    var _fgColour = Graphics.COLOR_WHITE;
    // Centre Y position for text
    var _yCentre = 0;

    function initialize() {
        GlanceView.initialize();
    }

    // onLayout() is called to set the layout of the view
    function onLayout(dc) {
        _yCentre = dc.getHeight() / 2;

        // Update the theme and set the colours accordingly
        _theme = Application.getApp().getTheme();
        _fgColour = (_theme.equals(THEME_LIGHT)) ? Graphics.COLOR_BLACK : Graphics.COLOR_WHITE;
    }

    // onUpdate() is called to update the view
    function onUpdate(dc) as Void {
        // Check if the theme has changed
        if (Application.getApp().getTheme() != _theme) {
            onLayout(dc);
        }
        
        // Set the text colour and background
        dc.setColor(_fgColour, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        // Draw the "Tasker Trigger" text starting from x = 0 and centered vertically
        dc.drawText(0, _yCentre, Graphics.FONT_GLANCE, "Tasker Trigger", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}