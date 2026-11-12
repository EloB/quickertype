package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionObjectNode.Deserializer.class)
@JsonSerialize(using = UnionObjectNode.Serializer.class)
public class UnionObjectNode {
    public Double doubleValue;
    public ObjectNode objectNodeValue;

    static class Deserializer extends JsonDeserializer<UnionObjectNode> {
        @Override
        public UnionObjectNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionObjectNode value = new UnionObjectNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.objectNodeValue = jsonParser.readValueAs(ObjectNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionObjectNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionObjectNode> {
        @Override
        public void serialize(UnionObjectNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.objectNodeValue != null) {
                jsonGenerator.writeObject(obj.objectNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
