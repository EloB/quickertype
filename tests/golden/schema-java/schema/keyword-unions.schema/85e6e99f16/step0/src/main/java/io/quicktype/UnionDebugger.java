package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDebugger.Deserializer.class)
@JsonSerialize(using = UnionDebugger.Serializer.class)
public class UnionDebugger {
    public Double doubleValue;
    public Debugger debuggerValue;

    static class Deserializer extends JsonDeserializer<UnionDebugger> {
        @Override
        public UnionDebugger deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDebugger value = new UnionDebugger();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.debuggerValue = jsonParser.readValueAs(Debugger.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDebugger");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDebugger> {
        @Override
        public void serialize(UnionDebugger obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.debuggerValue != null) {
                jsonGenerator.writeObject(obj.debuggerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
