package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLet.Deserializer.class)
@JsonSerialize(using = UnionLet.Serializer.class)
public class UnionLet {
    public Double doubleValue;
    public Let letValue;

    static class Deserializer extends JsonDeserializer<UnionLet> {
        @Override
        public UnionLet deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLet value = new UnionLet();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.letValue = jsonParser.readValueAs(Let.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLet");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLet> {
        @Override
        public void serialize(UnionLet obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.letValue != null) {
                jsonGenerator.writeObject(obj.letValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
