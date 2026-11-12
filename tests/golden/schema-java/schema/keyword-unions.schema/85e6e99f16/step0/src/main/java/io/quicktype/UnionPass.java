package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPass.Deserializer.class)
@JsonSerialize(using = UnionPass.Serializer.class)
public class UnionPass {
    public Double doubleValue;
    public Pass passValue;

    static class Deserializer extends JsonDeserializer<UnionPass> {
        @Override
        public UnionPass deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPass value = new UnionPass();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.passValue = jsonParser.readValueAs(Pass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPass");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPass> {
        @Override
        public void serialize(UnionPass obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.passValue != null) {
                jsonGenerator.writeObject(obj.passValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
