package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionThreadLocal.Deserializer.class)
@JsonSerialize(using = UnionThreadLocal.Serializer.class)
public class UnionThreadLocal {
    public Double doubleValue;
    public ThreadLocal threadLocalValue;

    static class Deserializer extends JsonDeserializer<UnionThreadLocal> {
        @Override
        public UnionThreadLocal deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionThreadLocal value = new UnionThreadLocal();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.threadLocalValue = jsonParser.readValueAs(ThreadLocal.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionThreadLocal");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionThreadLocal> {
        @Override
        public void serialize(UnionThreadLocal obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.threadLocalValue != null) {
                jsonGenerator.writeObject(obj.threadLocalValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
