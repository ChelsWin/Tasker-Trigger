import Toybox.WatchUi;


(:glance)
class TaskerTriggerGlanceView extends WatchUi.GlanceView {

    var _yCentre;

    function initialize() {
        GlanceView.initialize();
    }

    // onLayout() is called to set the layout of the view
    function onLayout(dc) {
        _yCentre = dc.getHeight() / 2;
    }

    // onUpdate() is called to update the view
    function onUpdate(dc) as Void {
        // Set text color to white and background to transparent
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        // Draw the "Tasker Trigger" text starting from x = 0 and centered vertically
        dc.drawText(0, _yCentre, Graphics.FONT_GLANCE, "Tasker Trigger", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}