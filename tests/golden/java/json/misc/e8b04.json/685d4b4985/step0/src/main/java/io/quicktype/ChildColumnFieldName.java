package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ChildColumnFieldName {
    PRODUCT, COMPLAINT_WHAT_HAPPENED, SUB_PRODUCT, ISSUE;

    @JsonValue
    public String toValue() {
        switch (this) {
            case PRODUCT: return "product";
            case COMPLAINT_WHAT_HAPPENED: return "complaint_what_happened";
            case SUB_PRODUCT: return "sub_product";
            case ISSUE: return "issue";
        }
        return null;
    }

    @JsonCreator
    public static ChildColumnFieldName forValue(String value) throws IOException {
        if (value.equals("product")) return PRODUCT;
        if (value.equals("complaint_what_happened")) return COMPLAINT_WHAT_HAPPENED;
        if (value.equals("sub_product")) return SUB_PRODUCT;
        if (value.equals("issue")) return ISSUE;
        throw new IOException("Cannot deserialize ChildColumnFieldName");
    }
}
