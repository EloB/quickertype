package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionXorEq.Deserializer.class)
@JsonSerialize(using = UnionXorEq.Serializer.class)
public class UnionXorEq {
    public Double doubleValue;
    public XorEq xorEqValue;

    static class Deserializer extends JsonDeserializer<UnionXorEq> {
        @Override
        public UnionXorEq deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionXorEq value = new UnionXorEq();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.xorEqValue = jsonParser.readValueAs(XorEq.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionXorEq");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionXorEq> {
        @Override
        public void serialize(UnionXorEq obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.xorEqValue != null) {
                jsonGenerator.writeObject(obj.xorEqValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
