package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = ChemotherapeuticElement.Deserializer.class)
@JsonSerialize(using = ChemotherapeuticElement.Serializer.class)
public class ChemotherapeuticElement {
    public ChemotherapeuticClass chemotherapeuticClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<ChemotherapeuticElement> {
        @Override
        public ChemotherapeuticElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ChemotherapeuticElement value = new ChemotherapeuticElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.chemotherapeuticClassValue = jsonParser.readValueAs(ChemotherapeuticClass.class);
                    break;
                default: throw new IOException("Cannot deserialize ChemotherapeuticElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ChemotherapeuticElement> {
        @Override
        public void serialize(ChemotherapeuticElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.chemotherapeuticClassValue != null) {
                jsonGenerator.writeObject(obj.chemotherapeuticClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("ChemotherapeuticElement must not be null");
        }
    }
}
