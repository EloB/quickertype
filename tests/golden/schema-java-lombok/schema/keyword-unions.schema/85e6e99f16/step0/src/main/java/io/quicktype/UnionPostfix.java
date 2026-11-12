package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPostfix.Deserializer.class)
@JsonSerialize(using = UnionPostfix.Serializer.class)
public class UnionPostfix {
    public Double doubleValue;
    public Postfix postfixValue;

    static class Deserializer extends JsonDeserializer<UnionPostfix> {
        @Override
        public UnionPostfix deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPostfix value = new UnionPostfix();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.postfixValue = jsonParser.readValueAs(Postfix.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPostfix");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPostfix> {
        @Override
        public void serialize(UnionPostfix obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.postfixValue != null) {
                jsonGenerator.writeObject(obj.postfixValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
