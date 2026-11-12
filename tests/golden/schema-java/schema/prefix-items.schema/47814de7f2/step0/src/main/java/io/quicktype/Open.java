package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = Open.Deserializer.class)
@JsonSerialize(using = Open.Serializer.class)
public class Open {
    public Boolean boolValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Open> {
        @Override
        public Open deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Open value = new Open();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Open");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Open> {
        @Override
        public void serialize(Open obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Open must not be null");
        }
    }
}
