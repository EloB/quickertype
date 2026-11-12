package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

/**
 * The mouse cursor used over the mark. Any valid [CSS cursor
 * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
 */
public enum Cursor {
    AUTO, DEFAULT, NONE, CONTEXT_MENU, HELP, POINTER, PROGRESS, WAIT, CELL, CROSSHAIR, TEXT, VERTICAL_TEXT, ALIAS, COPY, MOVE, NO_DROP, NOT_ALLOWED, E_RESIZE, N_RESIZE, NE_RESIZE, NW_RESIZE, S_RESIZE, SE_RESIZE, SW_RESIZE, W_RESIZE, EW_RESIZE, NS_RESIZE, NESW_RESIZE, NWSE_RESIZE, COL_RESIZE, ROW_RESIZE, ALL_SCROLL, ZOOM_IN, ZOOM_OUT, GRAB, GRABBING;

    @JsonValue
    public String toValue() {
        switch (this) {
            case AUTO: return "auto";
            case DEFAULT: return "default";
            case NONE: return "none";
            case CONTEXT_MENU: return "context-menu";
            case HELP: return "help";
            case POINTER: return "pointer";
            case PROGRESS: return "progress";
            case WAIT: return "wait";
            case CELL: return "cell";
            case CROSSHAIR: return "crosshair";
            case TEXT: return "text";
            case VERTICAL_TEXT: return "vertical-text";
            case ALIAS: return "alias";
            case COPY: return "copy";
            case MOVE: return "move";
            case NO_DROP: return "no-drop";
            case NOT_ALLOWED: return "not-allowed";
            case E_RESIZE: return "e-resize";
            case N_RESIZE: return "n-resize";
            case NE_RESIZE: return "ne-resize";
            case NW_RESIZE: return "nw-resize";
            case S_RESIZE: return "s-resize";
            case SE_RESIZE: return "se-resize";
            case SW_RESIZE: return "sw-resize";
            case W_RESIZE: return "w-resize";
            case EW_RESIZE: return "ew-resize";
            case NS_RESIZE: return "ns-resize";
            case NESW_RESIZE: return "nesw-resize";
            case NWSE_RESIZE: return "nwse-resize";
            case COL_RESIZE: return "col-resize";
            case ROW_RESIZE: return "row-resize";
            case ALL_SCROLL: return "all-scroll";
            case ZOOM_IN: return "zoom-in";
            case ZOOM_OUT: return "zoom-out";
            case GRAB: return "grab";
            case GRABBING: return "grabbing";
        }
        return null;
    }

    @JsonCreator
    public static Cursor forValue(String value) throws IOException {
        if (value.equals("auto")) return AUTO;
        if (value.equals("default")) return DEFAULT;
        if (value.equals("none")) return NONE;
        if (value.equals("context-menu")) return CONTEXT_MENU;
        if (value.equals("help")) return HELP;
        if (value.equals("pointer")) return POINTER;
        if (value.equals("progress")) return PROGRESS;
        if (value.equals("wait")) return WAIT;
        if (value.equals("cell")) return CELL;
        if (value.equals("crosshair")) return CROSSHAIR;
        if (value.equals("text")) return TEXT;
        if (value.equals("vertical-text")) return VERTICAL_TEXT;
        if (value.equals("alias")) return ALIAS;
        if (value.equals("copy")) return COPY;
        if (value.equals("move")) return MOVE;
        if (value.equals("no-drop")) return NO_DROP;
        if (value.equals("not-allowed")) return NOT_ALLOWED;
        if (value.equals("e-resize")) return E_RESIZE;
        if (value.equals("n-resize")) return N_RESIZE;
        if (value.equals("ne-resize")) return NE_RESIZE;
        if (value.equals("nw-resize")) return NW_RESIZE;
        if (value.equals("s-resize")) return S_RESIZE;
        if (value.equals("se-resize")) return SE_RESIZE;
        if (value.equals("sw-resize")) return SW_RESIZE;
        if (value.equals("w-resize")) return W_RESIZE;
        if (value.equals("ew-resize")) return EW_RESIZE;
        if (value.equals("ns-resize")) return NS_RESIZE;
        if (value.equals("nesw-resize")) return NESW_RESIZE;
        if (value.equals("nwse-resize")) return NWSE_RESIZE;
        if (value.equals("col-resize")) return COL_RESIZE;
        if (value.equals("row-resize")) return ROW_RESIZE;
        if (value.equals("all-scroll")) return ALL_SCROLL;
        if (value.equals("zoom-in")) return ZOOM_IN;
        if (value.equals("zoom-out")) return ZOOM_OUT;
        if (value.equals("grab")) return GRAB;
        if (value.equals("grabbing")) return GRABBING;
        throw new IOException("Cannot deserialize Cursor");
    }
}
