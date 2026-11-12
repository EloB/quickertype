package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionRight.Deserializer.class)
@JsonSerialize(using = UnionRight.Serializer.class)
public class UnionRight {
    public Double doubleValue;
    public Right rightValue;

    static class Deserializer extends JsonDeserializer<UnionRight> {
        @Override
        public UnionRight deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionRight value = new UnionRight();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.rightValue = jsonParser.readValueAs(Right.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionRight");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionRight> {
        @Override
        public void serialize(UnionRight obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.rightValue != null) {
                jsonGenerator.writeObject(obj.rightValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
