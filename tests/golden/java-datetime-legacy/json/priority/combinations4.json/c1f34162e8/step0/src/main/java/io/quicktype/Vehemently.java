package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = Vehemently.Deserializer.class)
@JsonSerialize(using = Vehemently.Serializer.class)
public class Vehemently {
    public List<Object> nullArrayValue;
    public Boolean boolValue;

    static class Deserializer extends JsonDeserializer<Vehemently> {
        @Override
        public Vehemently deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            Vehemently value = new Vehemently();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case START_ARRAY:
                    value.nullArrayValue = jsonParser.readValueAs(new TypeReference<List<Object>>() {});
                    break;
                default: throw new IOException("Cannot deserialize Vehemently");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<Vehemently> {
        @Override
        public void serialize(Vehemently obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.nullArrayValue != null) {
                jsonGenerator.writeObject(obj.nullArrayValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
