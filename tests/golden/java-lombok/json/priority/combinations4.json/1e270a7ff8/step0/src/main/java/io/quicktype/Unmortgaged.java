package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = Unmortgaged.Deserializer.class)
@JsonSerialize(using = Unmortgaged.Serializer.class)
public class Unmortgaged {
    public Double doubleValue;
    public Map<String, Long> integerMapValue;

    static class Deserializer extends JsonDeserializer<Unmortgaged> {
        @Override
        public Unmortgaged deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Unmortgaged value = new Unmortgaged();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.integerMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize Unmortgaged");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Unmortgaged> {
        @Override
        public void serialize(Unmortgaged obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.integerMapValue != null) {
                jsonGenerator.writeObject(obj.integerMapValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
