package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = SantirElement.Deserializer.class)
@JsonSerialize(using = SantirElement.Serializer.class)
public class SantirElement {
    public SantirClass santirClassValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<SantirElement> {
        @Override
        public SantirElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            SantirElement value = new SantirElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.santirClassValue = jsonParser.readValueAs(SantirClass.class);
                    break;
                default: throw new IOException("Cannot deserialize SantirElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<SantirElement> {
        @Override
        public void serialize(SantirElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.santirClassValue != null) {
                jsonGenerator.writeObject(obj.santirClassValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("SantirElement must not be null");
        }
    }
}
