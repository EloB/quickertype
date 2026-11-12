package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = AlleviateElement.Deserializer.class)
@JsonSerialize(using = AlleviateElement.Serializer.class)
public class AlleviateElement {
    public Long[] unionArrayValue;
    public AlleviateClass alleviateClassValue;

    static class Deserializer extends JsonDeserializer<AlleviateElement> {
        @Override
        public AlleviateElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            AlleviateElement value = new AlleviateElement();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(Long[].class);
                    break;
                case START_OBJECT:
                    value.alleviateClassValue = jsonParser.readValueAs(AlleviateClass.class);
                    break;
                default: throw new IOException("Cannot deserialize AlleviateElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<AlleviateElement> {
        @Override
        public void serialize(AlleviateElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.alleviateClassValue != null) {
                jsonGenerator.writeObject(obj.alleviateClassValue);
                return;
            }
            throw new IOException("AlleviateElement must not be null");
        }
    }
}
