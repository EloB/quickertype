package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = WrothyElement.Deserializer.class)
@JsonSerialize(using = WrothyElement.Serializer.class)
public class WrothyElement {
    public Object[] nullArrayValue;
    public WrothyClass wrothyClassValue;

    static class Deserializer extends JsonDeserializer<WrothyElement> {
        @Override
        public WrothyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            WrothyElement value = new WrothyElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(Object[].class);
                    break;
                case START_OBJECT:
                    value.wrothyClassValue = jsonParser.readValueAs(WrothyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize WrothyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<WrothyElement> {
        @Override
        public void serialize(WrothyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.wrothyClassValue != null) {
                jsonGenerator.writeObject(obj.wrothyClassValue);
                return;
            }
            throw new IOException("WrothyElement must not be null");
        }
    }
}
