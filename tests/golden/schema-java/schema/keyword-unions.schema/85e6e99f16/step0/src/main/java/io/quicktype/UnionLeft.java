package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionLeft.Deserializer.class)
@JsonSerialize(using = UnionLeft.Serializer.class)
public class UnionLeft {
    public Double doubleValue;
    public Left leftValue;

    static class Deserializer extends JsonDeserializer<UnionLeft> {
        @Override
        public UnionLeft deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionLeft value = new UnionLeft();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.leftValue = jsonParser.readValueAs(Left.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionLeft");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionLeft> {
        @Override
        public void serialize(UnionLeft obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.leftValue != null) {
                jsonGenerator.writeObject(obj.leftValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
