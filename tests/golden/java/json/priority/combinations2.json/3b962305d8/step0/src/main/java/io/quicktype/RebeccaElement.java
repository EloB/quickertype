package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = RebeccaElement.Deserializer.class)
@JsonSerialize(using = RebeccaElement.Serializer.class)
public class RebeccaElement {
    public Rebecca rebeccaValue;
    public Long integerValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<RebeccaElement> {
        @Override
        public RebeccaElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            RebeccaElement value = new RebeccaElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.rebeccaValue = jsonParser.readValueAs(Rebecca.class);
                    break;
                default: throw new IOException("Cannot deserialize RebeccaElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<RebeccaElement> {
        @Override
        public void serialize(RebeccaElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.rebeccaValue != null) {
                jsonGenerator.writeObject(obj.rebeccaValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("RebeccaElement must not be null");
        }
    }
}
