package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum TypeEnum {
    INTRINSIC, REFLECTION, ARRAY, REFERENCE, TYPE_PARAMETER, TUPLE, UNION, STRING_LITERAL;

    @JsonValue
    public String toValue() {
        switch (this) {
            case INTRINSIC: return "intrinsic";
            case REFLECTION: return "reflection";
            case ARRAY: return "array";
            case REFERENCE: return "reference";
            case TYPE_PARAMETER: return "typeParameter";
            case TUPLE: return "tuple";
            case UNION: return "union";
            case STRING_LITERAL: return "stringLiteral";
        }
        return null;
    }

    @JsonCreator
    public static TypeEnum forValue(String value) throws IOException {
        if (value.equals("intrinsic")) return INTRINSIC;
        if (value.equals("reflection")) return REFLECTION;
        if (value.equals("array")) return ARRAY;
        if (value.equals("reference")) return REFERENCE;
        if (value.equals("typeParameter")) return TYPE_PARAMETER;
        if (value.equals("tuple")) return TUPLE;
        if (value.equals("union")) return UNION;
        if (value.equals("stringLiteral")) return STRING_LITERAL;
        throw new IOException("Cannot deserialize TypeEnum");
    }
}
