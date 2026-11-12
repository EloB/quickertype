package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionXor.Deserializer.class)
@JsonSerialize(using = UnionXor.Serializer.class)
public class UnionXor {
    public Double doubleValue;
    public Xor xorValue;

    static class Deserializer extends JsonDeserializer<UnionXor> {
        @Override
        public UnionXor deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionXor value = new UnionXor();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.xorValue = jsonParser.readValueAs(Xor.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionXor");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionXor> {
        @Override
        public void serialize(UnionXor obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.xorValue != null) {
                jsonGenerator.writeObject(obj.xorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
