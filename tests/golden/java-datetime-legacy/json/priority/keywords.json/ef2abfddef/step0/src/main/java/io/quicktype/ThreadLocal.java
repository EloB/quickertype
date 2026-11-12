package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ThreadLocal {
    private long threadLocal;

    @JsonProperty("thread_local")
    public long getThreadLocal() { return threadLocal; }
    @JsonProperty("thread_local")
    public void setThreadLocal(long value) { this.threadLocal = value; }
}
