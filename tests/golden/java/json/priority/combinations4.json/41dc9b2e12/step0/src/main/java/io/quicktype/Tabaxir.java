package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Tabaxir.Deserializer.class)
@JsonSerialize(using = Tabaxir.Serializer.class)
public class Tabaxir {
    public Boolean boolValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Tabaxir> {
        @Override
        public Tabaxir deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Tabaxir value = new Tabaxir();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Tabaxir");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Tabaxir> {
        @Override
        public void serialize(Tabaxir obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Tabaxir must not be null");
        }
    }
}
