package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionBreak.Deserializer.class)
@JsonSerialize(using = UnionBreak.Serializer.class)
public class UnionBreak {
    public Double doubleValue;
    public Break breakValue;

    static class Deserializer extends JsonDeserializer<UnionBreak> {
        @Override
        public UnionBreak deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionBreak value = new UnionBreak();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.breakValue = jsonParser.readValueAs(Break.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionBreak");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionBreak> {
        @Override
        public void serialize(UnionBreak obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.breakValue != null) {
                jsonGenerator.writeObject(obj.breakValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
