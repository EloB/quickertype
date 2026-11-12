package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrefix.Deserializer.class)
@JsonSerialize(using = UnionPrefix.Serializer.class)
public class UnionPrefix {
    public Double doubleValue;
    public Prefix prefixValue;

    static class Deserializer extends JsonDeserializer<UnionPrefix> {
        @Override
        public UnionPrefix deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrefix value = new UnionPrefix();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.prefixValue = jsonParser.readValueAs(Prefix.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrefix");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrefix> {
        @Override
        public void serialize(UnionPrefix obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.prefixValue != null) {
                jsonGenerator.writeObject(obj.prefixValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
