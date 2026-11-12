package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = LupusElement.Deserializer.class)
@JsonSerialize(using = LupusElement.Serializer.class)
public class LupusElement {
    public LupusClass lupusClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<LupusElement> {
        @Override
        public LupusElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LupusElement value = new LupusElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.lupusClassValue = jsonParser.readValueAs(LupusClass.class);
                    break;
                default: throw new IOException("Cannot deserialize LupusElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LupusElement> {
        @Override
        public void serialize(LupusElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.lupusClassValue != null) {
                jsonGenerator.writeObject(obj.lupusClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("LupusElement must not be null");
        }
    }
}
