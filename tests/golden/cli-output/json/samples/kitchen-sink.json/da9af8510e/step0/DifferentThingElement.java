package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = DifferentThingElement.Deserializer.class)
@JsonSerialize(using = DifferentThingElement.Serializer.class)
public class DifferentThingElement {
    public Long integerValue;
    public DifferentThingClass differentThingClassValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<DifferentThingElement> {
        @Override
        public DifferentThingElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            DifferentThingElement value = new DifferentThingElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.differentThingClassValue = jsonParser.readValueAs(DifferentThingClass.class);
                    break;
                default: throw new IOException("Cannot deserialize DifferentThingElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<DifferentThingElement> {
        @Override
        public void serialize(DifferentThingElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.differentThingClassValue != null) {
                jsonGenerator.writeObject(obj.differentThingClassValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("DifferentThingElement must not be null");
        }
    }
}
