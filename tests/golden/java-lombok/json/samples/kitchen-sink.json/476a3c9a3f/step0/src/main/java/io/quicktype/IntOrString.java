package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = IntOrString.Deserializer.class)
@JsonSerialize(using = IntOrString.Serializer.class)
public class IntOrString {
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<IntOrString> {
        @Override
        public IntOrString deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            IntOrString value = new IntOrString();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize IntOrString");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<IntOrString> {
        @Override
        public void serialize(IntOrString obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("IntOrString must not be null");
        }
    }
}
