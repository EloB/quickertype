package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Aerometry.Deserializer.class)
@JsonSerialize(using = Aerometry.Serializer.class)
public class Aerometry {
    public Boolean boolValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Aerometry> {
        @Override
        public Aerometry deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Aerometry value = new Aerometry();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                default: throw new IOException("Cannot deserialize Aerometry");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Aerometry> {
        @Override
        public void serialize(Aerometry obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Aerometry must not be null");
        }
    }
}
