package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Moralness.Deserializer.class)
@JsonSerialize(using = Moralness.Serializer.class)
public class Moralness {
    public List<Object> nullArrayValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Moralness> {
        @Override
        public Moralness deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Moralness value = new Moralness();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Moralness");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Moralness> {
        @Override
        public void serialize(Moralness obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
