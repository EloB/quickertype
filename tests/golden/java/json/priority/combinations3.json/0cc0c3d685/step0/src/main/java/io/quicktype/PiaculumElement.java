package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = PiaculumElement.Deserializer.class)
@JsonSerialize(using = PiaculumElement.Serializer.class)
public class PiaculumElement {
    public PiaculumClass piaculumClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<PiaculumElement> {
        @Override
        public PiaculumElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            PiaculumElement value = new PiaculumElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.piaculumClassValue = jsonParser.readValueAs(PiaculumClass.class);
                    break;
                default: throw new IOException("Cannot deserialize PiaculumElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<PiaculumElement> {
        @Override
        public void serialize(PiaculumElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.piaculumClassValue != null) {
                jsonGenerator.writeObject(obj.piaculumClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("PiaculumElement must not be null");
        }
    }
}
