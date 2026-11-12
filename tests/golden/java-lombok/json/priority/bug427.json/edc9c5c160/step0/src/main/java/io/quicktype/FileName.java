package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum FileName {
    MODULES_TS, CLASSES_TS, FLATTENED_TS, ACCESS_TS, DEFAULT_EXPORT_TS, ENUMERATIONS_TS, FUNCTIONS_TS, GENERICS_TS, SINGLE_EXPORT_TS, TYPESCRIPT_13_TS, TYPESCRIPT_14_TS, TYPESCRIPT_15_TS, VARIABLES_TS;

    @JsonValue
    public String toValue() {
        switch (this) {
            case MODULES_TS: return "modules.ts";
            case CLASSES_TS: return "classes.ts";
            case FLATTENED_TS: return "flattened.ts";
            case ACCESS_TS: return "access.ts";
            case DEFAULT_EXPORT_TS: return "default-export.ts";
            case ENUMERATIONS_TS: return "enumerations.ts";
            case FUNCTIONS_TS: return "functions.ts";
            case GENERICS_TS: return "generics.ts";
            case SINGLE_EXPORT_TS: return "single-export.ts";
            case TYPESCRIPT_13_TS: return "typescript-1.3.ts";
            case TYPESCRIPT_14_TS: return "typescript-1.4.ts";
            case TYPESCRIPT_15_TS: return "typescript-1.5.ts";
            case VARIABLES_TS: return "variables.ts";
        }
        return null;
    }

    @JsonCreator
    public static FileName forValue(String value) throws IOException {
        if (value.equals("modules.ts")) return MODULES_TS;
        if (value.equals("classes.ts")) return CLASSES_TS;
        if (value.equals("flattened.ts")) return FLATTENED_TS;
        if (value.equals("access.ts")) return ACCESS_TS;
        if (value.equals("default-export.ts")) return DEFAULT_EXPORT_TS;
        if (value.equals("enumerations.ts")) return ENUMERATIONS_TS;
        if (value.equals("functions.ts")) return FUNCTIONS_TS;
        if (value.equals("generics.ts")) return GENERICS_TS;
        if (value.equals("single-export.ts")) return SINGLE_EXPORT_TS;
        if (value.equals("typescript-1.3.ts")) return TYPESCRIPT_13_TS;
        if (value.equals("typescript-1.4.ts")) return TYPESCRIPT_14_TS;
        if (value.equals("typescript-1.5.ts")) return TYPESCRIPT_15_TS;
        if (value.equals("variables.ts")) return VARIABLES_TS;
        throw new IOException("Cannot deserialize FileName");
    }
}
