package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Neuromastic.Deserializer.class)
@JsonSerialize(using = Neuromastic.Serializer.class)
public class Neuromastic {
    public List<Object> nullArrayValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Neuromastic> {
        @Override
        public Neuromastic deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Neuromastic value = new Neuromastic();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Neuromastic");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Neuromastic> {
        @Override
        public void serialize(Neuromastic obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Neuromastic must not be null");
        }
    }
}
