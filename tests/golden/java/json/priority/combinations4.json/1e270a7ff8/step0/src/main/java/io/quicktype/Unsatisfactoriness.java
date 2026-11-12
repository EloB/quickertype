package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Unsatisfactoriness.Deserializer.class)
@JsonSerialize(using = Unsatisfactoriness.Serializer.class)
public class Unsatisfactoriness {
    public List<Long> integerArrayValue;
    public Boolean boolValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<Unsatisfactoriness> {
        @Override
        public Unsatisfactoriness deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Unsatisfactoriness value = new Unsatisfactoriness();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Unsatisfactoriness");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Unsatisfactoriness> {
        @Override
        public void serialize(Unsatisfactoriness obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("Unsatisfactoriness must not be null");
        }
    }
}
