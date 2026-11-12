package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = FooUnion.Deserializer.class)
@JsonSerialize(using = FooUnion.Serializer.class)
public class FooUnion {
    public Double doubleValue;
    public Long integerValue;
    public Boolean boolValue;
    public String stringValue;
    public List<Long> integerArrayValue;
    public FooClass fooClassValue;

    static class Deserializer extends JsonDeserializer<FooUnion> {
        @Override
        public FooUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            FooUnion value = new FooUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
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
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.fooClassValue = jsonParser.readValueAs(FooClass.class);
                    break;
                default: throw new IOException("Cannot deserialize FooUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<FooUnion> {
        @Override
        public void serialize(FooUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.fooClassValue != null) {
                jsonGenerator.writeObject(obj.fooClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
