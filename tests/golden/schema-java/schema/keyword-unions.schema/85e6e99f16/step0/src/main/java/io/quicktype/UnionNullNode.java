package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNullNode.Deserializer.class)
@JsonSerialize(using = UnionNullNode.Serializer.class)
public class UnionNullNode {
    public Double doubleValue;
    public NullNode nullNodeValue;

    static class Deserializer extends JsonDeserializer<UnionNullNode> {
        @Override
        public UnionNullNode deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNullNode value = new UnionNullNode();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nullNodeValue = jsonParser.readValueAs(NullNode.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNullNode");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNullNode> {
        @Override
        public void serialize(UnionNullNode obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nullNodeValue != null) {
                jsonGenerator.writeObject(obj.nullNodeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
