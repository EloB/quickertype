package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPrecedence.Deserializer.class)
@JsonSerialize(using = UnionPrecedence.Serializer.class)
public class UnionPrecedence {
    public Double doubleValue;
    public Precedence precedenceValue;

    static class Deserializer extends JsonDeserializer<UnionPrecedence> {
        @Override
        public UnionPrecedence deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPrecedence value = new UnionPrecedence();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.precedenceValue = jsonParser.readValueAs(Precedence.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPrecedence");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPrecedence> {
        @Override
        public void serialize(UnionPrecedence obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.precedenceValue != null) {
                jsonGenerator.writeObject(obj.precedenceValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
