package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Meta {
    private View view;

    @JsonProperty("view")
    public View getView() { return view; }
    @JsonProperty("view")
    public void setView(View value) { this.view = value; }
}
