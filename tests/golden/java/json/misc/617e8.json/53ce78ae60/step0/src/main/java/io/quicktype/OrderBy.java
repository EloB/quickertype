package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OrderBy {
    private boolean ascending;
    private Expression expression;

    @JsonProperty("ascending")
    public boolean getAscending() { return ascending; }
    @JsonProperty("ascending")
    public void setAscending(boolean value) { this.ascending = value; }

    @JsonProperty("expression")
    public Expression getExpression() { return expression; }
    @JsonProperty("expression")
    public void setExpression(Expression value) { this.expression = value; }
}
