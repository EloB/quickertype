package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = LandlubberlyElement.Deserializer.class)
@JsonSerialize(using = LandlubberlyElement.Serializer.class)
public class LandlubberlyElement {
    public Boolean boolValue;
    public LandlubberlyClass landlubberlyClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<LandlubberlyElement> {
        @Override
        public LandlubberlyElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LandlubberlyElement value = new LandlubberlyElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_OBJECT:
                    value.landlubberlyClassValue = jsonParser.readValueAs(LandlubberlyClass.class);
                    break;
                default: throw new IOException("Cannot deserialize LandlubberlyElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LandlubberlyElement> {
        @Override
        public void serialize(LandlubberlyElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.landlubberlyClassValue != null) {
                jsonGenerator.writeObject(obj.landlubberlyClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("LandlubberlyElement must not be null");
        }
    }
}
