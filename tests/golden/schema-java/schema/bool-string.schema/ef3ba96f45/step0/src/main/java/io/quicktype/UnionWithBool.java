package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWithBool.Deserializer.class)
@JsonSerialize(using = UnionWithBool.Serializer.class)
public class UnionWithBool {
    public Boolean boolValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<UnionWithBool> {
        @Override
        public UnionWithBool deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWithBool value = new UnionWithBool();
            switch (jsonParser.currentToken()) {
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize UnionWithBool");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWithBool> {
        @Override
        public void serialize(UnionWithBool obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("UnionWithBool must not be null");
        }
    }
}
