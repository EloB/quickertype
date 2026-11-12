package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAndEq.Deserializer.class)
@JsonSerialize(using = UnionAndEq.Serializer.class)
public class UnionAndEq {
    public Double doubleValue;
    public AndEq andEqValue;

    static class Deserializer extends JsonDeserializer<UnionAndEq> {
        @Override
        public UnionAndEq deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAndEq value = new UnionAndEq();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.andEqValue = jsonParser.readValueAs(AndEq.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAndEq");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAndEq> {
        @Override
        public void serialize(UnionAndEq obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.andEqValue != null) {
                jsonGenerator.writeObject(obj.andEqValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
