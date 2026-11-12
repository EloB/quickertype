package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = LeaddatumElement.Deserializer.class)
@JsonSerialize(using = LeaddatumElement.Serializer.class)
public class LeaddatumElement {
    public LeaddatumEnum enumValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<LeaddatumElement> {
        @Override
        public LeaddatumElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LeaddatumElement value = new LeaddatumElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = LeaddatumEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize LeaddatumElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LeaddatumElement> {
        @Override
        public void serialize(LeaddatumElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("LeaddatumElement must not be null");
        }
    }
}
