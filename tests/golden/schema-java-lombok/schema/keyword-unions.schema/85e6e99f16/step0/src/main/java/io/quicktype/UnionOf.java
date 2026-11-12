package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOf.Deserializer.class)
@JsonSerialize(using = UnionOf.Serializer.class)
public class UnionOf {
    public Double doubleValue;
    public Of ofValue;

    static class Deserializer extends JsonDeserializer<UnionOf> {
        @Override
        public UnionOf deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOf value = new UnionOf();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.ofValue = jsonParser.readValueAs(Of.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOf");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOf> {
        @Override
        public void serialize(UnionOf obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.ofValue != null) {
                jsonGenerator.writeObject(obj.ofValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
