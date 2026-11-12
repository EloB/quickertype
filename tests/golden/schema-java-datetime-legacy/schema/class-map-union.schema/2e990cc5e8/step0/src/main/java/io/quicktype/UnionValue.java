package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionValue.Deserializer.class)
@JsonSerialize(using = UnionValue.Serializer.class)
public class UnionValue {
    public Double doubleValue;
    public Boolean boolValue;
    public UnionClass unionClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<UnionValue> {
        @Override
        public UnionValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionValue value = new UnionValue();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.unionClassValue = jsonParser.readValueAs(UnionClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionValue> {
        @Override
        public void serialize(UnionValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.unionClassValue != null) {
                jsonGenerator.writeObject(obj.unionClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("UnionValue must not be null");
        }
    }
}
