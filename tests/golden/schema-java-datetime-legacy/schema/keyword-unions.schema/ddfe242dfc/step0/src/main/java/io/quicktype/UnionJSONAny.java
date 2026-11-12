package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONAny.Deserializer.class)
@JsonSerialize(using = UnionJSONAny.Serializer.class)
public class UnionJSONAny {
    public Double doubleValue;
    public JSONAny jsonAnyValue;

    static class Deserializer extends JsonDeserializer<UnionJSONAny> {
        @Override
        public UnionJSONAny deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONAny value = new UnionJSONAny();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonAnyValue = jsonParser.readValueAs(JSONAny.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONAny");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONAny> {
        @Override
        public void serialize(UnionJSONAny obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonAnyValue != null) {
                jsonGenerator.writeObject(obj.jsonAnyValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
