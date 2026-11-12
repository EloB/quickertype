package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Rebarbative.Deserializer.class)
@JsonSerialize(using = Rebarbative.Serializer.class)
public class Rebarbative {
    public List<Long> integerArrayValue;
    public Boolean boolValue;
    public Double doubleValue;

    static class Deserializer extends JsonDeserializer<Rebarbative> {
        @Override
        public Rebarbative deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Rebarbative value = new Rebarbative();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.integerArrayValue = jsonParser.readValueAs(new TypeReference<List<Long>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Rebarbative");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Rebarbative> {
        @Override
        public void serialize(Rebarbative obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerArrayValue != null) {
                jsonGenerator.writeObject(obj.integerArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            throw new IOException("Rebarbative must not be null");
        }
    }
}
