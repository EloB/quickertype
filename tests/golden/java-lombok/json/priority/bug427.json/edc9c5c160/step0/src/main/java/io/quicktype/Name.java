package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Name {
    STRING, NUMBER, VOID, T, BOOLEAN, BASE_CLASS, ANY, ARRAY, MY_NUMBER;

    @JsonValue
    public String toValue() {
        switch (this) {
            case STRING: return "string";
            case NUMBER: return "number";
            case VOID: return "void";
            case T: return "T";
            case BOOLEAN: return "boolean";
            case BASE_CLASS: return "BaseClass";
            case ANY: return "any";
            case ARRAY: return "Array";
            case MY_NUMBER: return "MyNumber";
        }
        return null;
    }

    @JsonCreator
    public static Name forValue(String value) throws IOException {
        if (value.equals("string")) return STRING;
        if (value.equals("number")) return NUMBER;
        if (value.equals("void")) return VOID;
        if (value.equals("T")) return T;
        if (value.equals("boolean")) return BOOLEAN;
        if (value.equals("BaseClass")) return BASE_CLASS;
        if (value.equals("any")) return ANY;
        if (value.equals("Array")) return ARRAY;
        if (value.equals("MyNumber")) return MY_NUMBER;
        throw new IOException("Cannot deserialize Name");
    }
}
