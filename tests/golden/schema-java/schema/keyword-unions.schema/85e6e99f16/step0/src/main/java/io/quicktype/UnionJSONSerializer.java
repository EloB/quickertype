package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONSerializer.Deserializer.class)
@JsonSerialize(using = UnionJSONSerializer.Serializer.class)
public class UnionJSONSerializer {
    public Double doubleValue;
    public JSONSerializer jsonSerializerValue;

    static class Deserializer extends JsonDeserializer<UnionJSONSerializer> {
        @Override
        public UnionJSONSerializer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONSerializer value = new UnionJSONSerializer();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonSerializerValue = jsonParser.readValueAs(JSONSerializer.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONSerializer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONSerializer> {
        @Override
        public void serialize(UnionJSONSerializer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonSerializerValue != null) {
                jsonGenerator.writeObject(obj.jsonSerializerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
