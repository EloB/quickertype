package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInfix.Deserializer.class)
@JsonSerialize(using = UnionInfix.Serializer.class)
public class UnionInfix {
    public Double doubleValue;
    public Infix infixValue;

    static class Deserializer extends JsonDeserializer<UnionInfix> {
        @Override
        public UnionInfix deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInfix value = new UnionInfix();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.infixValue = jsonParser.readValueAs(Infix.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInfix");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInfix> {
        @Override
        public void serialize(UnionInfix obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.infixValue != null) {
                jsonGenerator.writeObject(obj.infixValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
