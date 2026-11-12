package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FluffyKindString {
    MODULE, CLASS, VARIABLE, FUNCTION, INTERFACE, ENUMERATION, OBJECT_LITERAL, TYPE_ALIAS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MODULE: return "Module";
            case CLASS: return "Class";
            case VARIABLE: return "Variable";
            case FUNCTION: return "Function";
            case INTERFACE: return "Interface";
            case ENUMERATION: return "Enumeration";
            case OBJECT_LITERAL: return "Object literal";
            case TYPE_ALIAS: return "Type alias";
        }
        return null;
    }

    @JsonCreator
    public static FluffyKindString forValue(String value) throws IOException {
        if (value.equals("Module")) return MODULE;
        if (value.equals("Class")) return CLASS;
        if (value.equals("Variable")) return VARIABLE;
        if (value.equals("Function")) return FUNCTION;
        if (value.equals("Interface")) return INTERFACE;
        if (value.equals("Enumeration")) return ENUMERATION;
        if (value.equals("Object literal")) return OBJECT_LITERAL;
        if (value.equals("Type alias")) return TYPE_ALIAS;
        throw new IOException("Cannot deserialize FluffyKindString");
    }
}
