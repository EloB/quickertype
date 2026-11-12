package io.quicktype;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ResultType {
    FINANCIAL_DATA_NGO, FINANCIAL_DATA_LAWYER, FINANCIAL_DATA_TRADE_ASSOCIATION;

    @JsonValue
    public String toValue() {
        switch (this) {
            case FINANCIAL_DATA_NGO: return "FinancialDataNGO";
            case FINANCIAL_DATA_LAWYER: return "FinancialDataLawyer";
            case FINANCIAL_DATA_TRADE_ASSOCIATION: return "FinancialDataTradeAssociation";
        }
        return null;
    }

    @JsonCreator
    public static ResultType forValue(String value) throws IOException {
        if (value.equals("FinancialDataNGO")) return FINANCIAL_DATA_NGO;
        if (value.equals("FinancialDataLawyer")) return FINANCIAL_DATA_LAWYER;
        if (value.equals("FinancialDataTradeAssociation")) return FINANCIAL_DATA_TRADE_ASSOCIATION;
        throw new IOException("Cannot deserialize ResultType");
    }
}
