package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLongNode.Deserializer.class)
@JsonSerialize(using = UnionLongNode.Serializer.class)
public class UnionLongNode {
    public Double doubleValue;
    public LongNode longNodeValue;

    static class Deserializer extends JsonDeserializer<UnionLongNode> {
        @Override
        public UnionLongNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLongNode value = new UnionLongNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.longNodeValue = jsonParser.readValueAs(LongNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLongNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLongNode> {
        @Override
        public void serialize(UnionLongNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.longNodeValue != null) {
                jsonGenerator.writeObject(obj.longNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
