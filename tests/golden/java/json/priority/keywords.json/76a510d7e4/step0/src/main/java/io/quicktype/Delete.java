package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Delete {
    private long delete;

    @JsonProperty("delete")
    public long getDelete() { return delete; }
    @JsonProperty("delete")
    public void setDelete(long value) { this.delete = value; }
}
