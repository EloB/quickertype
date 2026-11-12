package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionArrayNode.Deserializer.class)
@JsonSerialize(using = UnionArrayNode.Serializer.class)
public class UnionArrayNode {
    public Double doubleValue;
    public ArrayNode arrayNodeValue;

    static class Deserializer extends JsonDeserializer<UnionArrayNode> {
        @Override
        public UnionArrayNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionArrayNode value = new UnionArrayNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.arrayNodeValue = jsonParser.readValueAs(ArrayNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionArrayNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionArrayNode> {
        @Override
        public void serialize(UnionArrayNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.arrayNodeValue != null) {
                jsonGenerator.writeObject(obj.arrayNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
