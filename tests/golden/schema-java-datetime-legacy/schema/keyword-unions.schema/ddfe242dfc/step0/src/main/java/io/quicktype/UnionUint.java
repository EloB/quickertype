package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUint.Deserializer.class)
@JsonSerialize(using = UnionUint.Serializer.class)
public class UnionUint {
    public Double doubleValue;
    public Uint uintValue;

    static class Deserializer extends JsonDeserializer<UnionUint> {
        @Override
        public UnionUint deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUint value = new UnionUint();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.uintValue = jsonParser.readValueAs(Uint.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUint");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUint> {
        @Override
        public void serialize(UnionUint obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.uintValue != null) {
                jsonGenerator.writeObject(obj.uintValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
