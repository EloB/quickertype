package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTextNode.Deserializer.class)
@JsonSerialize(using = UnionTextNode.Serializer.class)
public class UnionTextNode {
    public Double doubleValue;
    public TextNode textNodeValue;

    static class Deserializer extends JsonDeserializer<UnionTextNode> {
        @Override
        public UnionTextNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTextNode value = new UnionTextNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.textNodeValue = jsonParser.readValueAs(TextNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTextNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTextNode> {
        @Override
        public void serialize(UnionTextNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.textNodeValue != null) {
                jsonGenerator.writeObject(obj.textNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
