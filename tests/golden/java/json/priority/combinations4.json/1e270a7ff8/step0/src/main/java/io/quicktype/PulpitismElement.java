package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = PulpitismElement.Deserializer.class)
@JsonSerialize(using = PulpitismElement.Serializer.class)
public class PulpitismElement {
    public List<Long> integerArrayValue;
    public PulpitismClass pulpitismClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<PulpitismElement> {
        @Override
        public PulpitismElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            PulpitismElement value = new PulpitismElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                case START_OBJECT:
                    value.pulpitismClassValue = jsonParser.readValueAs(PulpitismClass.class);
                    break;
                default: throw new IOException("Cannot deserialize PulpitismElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<PulpitismElement> {
        @Override
        public void serialize(PulpitismElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.pulpitismClassValue != null) {
                jsonGenerator.writeObject(obj.pulpitismClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("PulpitismElement must not be null");
        }
    }
}
