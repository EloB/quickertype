package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Checked {
    private long checked;

    @JsonProperty("checked")
    public long getChecked() { return checked; }
    @JsonProperty("checked")
    public void setChecked(long value) { this.checked = value; }
}
