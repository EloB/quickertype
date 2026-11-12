package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = PotwhiskyElement.Deserializer.class)
@JsonSerialize(using = PotwhiskyElement.Serializer.class)
public class PotwhiskyElement {
    public PotwhiskyClass potwhiskyClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<PotwhiskyElement> {
        @Override
        public PotwhiskyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            PotwhiskyElement value = new PotwhiskyElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.potwhiskyClassValue = jsonParser.readValueAs(PotwhiskyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize PotwhiskyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<PotwhiskyElement> {
        @Override
        public void serialize(PotwhiskyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.potwhiskyClassValue != null) {
                jsonGenerator.writeObject(obj.potwhiskyClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
