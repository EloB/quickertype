package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum PurpleKindString {
    VARIABLE, FUNCTION, PROPERTY, METHOD, CONSTRUCTOR, ACCESSOR, ENUMERATION_MEMBER, MODULE, OBJECT_LITERAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case VARIABLE: return "Variable";
            case FUNCTION: return "Function";
            case PROPERTY: return "Property";
            case METHOD: return "Method";
            case CONSTRUCTOR: return "Constructor";
            case ACCESSOR: return "Accessor";
            case ENUMERATION_MEMBER: return "Enumeration member";
            case MODULE: return "Module";
            case OBJECT_LITERAL: return "Object literal";
        }
        return null;
    }

    @JsonCreator
    public static PurpleKindString forValue(String value) throws IOException {
        if (value.equals("Variable")) return VARIABLE;
        if (value.equals("Function")) return FUNCTION;
        if (value.equals("Property")) return PROPERTY;
        if (value.equals("Method")) return METHOD;
        if (value.equals("Constructor")) return CONSTRUCTOR;
        if (value.equals("Accessor")) return ACCESSOR;
        if (value.equals("Enumeration member")) return ENUMERATION_MEMBER;
        if (value.equals("Module")) return MODULE;
        if (value.equals("Object literal")) return OBJECT_LITERAL;
        throw new IOException("Cannot deserialize PurpleKindString");
    }
}
