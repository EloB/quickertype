package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
 * example, with an orientation of top these anchor positions map to a left-, center-, or
 * right-aligned title.
 *
 * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
 * `"start"` for other composite views.
 *
 * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
 * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
 * composite views, `anchor` is always `"start"`.
 */
public enum Anchor {
    START, MIDDLE, END;

    @JsonValue
    public String toValue() {
        switch (this) {
            case START: return "start";
            case MIDDLE: return "middle";
            case END: return "end";
        }
        return null;
    }

    @JsonCreator
    public static Anchor forValue(String value) throws IOException {
        if (value.equals("start")) return START;
        if (value.equals("middle")) return MIDDLE;
        if (value.equals("end")) return END;
        throw new IOException("Cannot deserialize Anchor");
    }
}
