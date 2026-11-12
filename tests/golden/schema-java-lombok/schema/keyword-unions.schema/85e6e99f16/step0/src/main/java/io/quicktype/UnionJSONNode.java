package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJSONNode.Deserializer.class)
@JsonSerialize(using = UnionJSONNode.Serializer.class)
public class UnionJSONNode {
    public Double doubleValue;
    public JSONNode jsonNodeValue;

    static class Deserializer extends JsonDeserializer<UnionJSONNode> {
        @Override
        public UnionJSONNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJSONNode value = new UnionJSONNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jsonNodeValue = jsonParser.readValueAs(JSONNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJSONNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJSONNode> {
        @Override
        public void serialize(UnionJSONNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jsonNodeValue != null) {
                jsonGenerator.writeObject(obj.jsonNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
