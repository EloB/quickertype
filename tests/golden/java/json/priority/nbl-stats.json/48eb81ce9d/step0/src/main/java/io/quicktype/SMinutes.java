package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = SMinutes.Deserializer.class)
@JsonSerialize(using = SMinutes.Serializer.class)
public class SMinutes {
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<SMinutes> {
        @Override
        public SMinutes deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            SMinutes value = new SMinutes();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                default: throw new IOException("Cannot deserialize SMinutes");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<SMinutes> {
        @Override
        public void serialize(SMinutes obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("SMinutes must not be null");
        }
    }
}
