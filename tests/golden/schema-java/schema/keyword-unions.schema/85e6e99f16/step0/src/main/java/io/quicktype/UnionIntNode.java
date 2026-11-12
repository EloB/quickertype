package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionIntNode.Deserializer.class)
@JsonSerialize(using = UnionIntNode.Serializer.class)
public class UnionIntNode {
    public Double doubleValue;
    public IntNode intNodeValue;

    static class Deserializer extends JsonDeserializer<UnionIntNode> {
        @Override
        public UnionIntNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionIntNode value = new UnionIntNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.intNodeValue = jsonParser.readValueAs(IntNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionIntNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionIntNode> {
        @Override
        public void serialize(UnionIntNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.intNodeValue != null) {
                jsonGenerator.writeObject(obj.intNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
