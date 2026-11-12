package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAnd.Deserializer.class)
@JsonSerialize(using = UnionAnd.Serializer.class)
public class UnionAnd {
    public Double doubleValue;
    public And andValue;

    static class Deserializer extends JsonDeserializer<UnionAnd> {
        @Override
        public UnionAnd deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAnd value = new UnionAnd();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.andValue = jsonParser.readValueAs(And.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAnd");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAnd> {
        @Override
        public void serialize(UnionAnd obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.andValue != null) {
                jsonGenerator.writeObject(obj.andValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
