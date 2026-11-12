package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = Protrusive.Deserializer.class)
@JsonSerialize(using = Protrusive.Serializer.class)
public class Protrusive {
    public Long[] unionArrayValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Protrusive> {
        @Override
        public Protrusive deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Protrusive value = new Protrusive();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(Long[].class);
                    break;
                default: throw new IOException("Cannot deserialize Protrusive");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Protrusive> {
        @Override
        public void serialize(Protrusive obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Protrusive must not be null");
        }
    }
}
