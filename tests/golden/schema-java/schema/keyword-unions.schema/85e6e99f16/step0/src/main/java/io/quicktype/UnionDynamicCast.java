package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDynamicCast.Deserializer.class)
@JsonSerialize(using = UnionDynamicCast.Serializer.class)
public class UnionDynamicCast {
    public Double doubleValue;
    public DynamicCast dynamicCastValue;

    static class Deserializer extends JsonDeserializer<UnionDynamicCast> {
        @Override
        public UnionDynamicCast deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDynamicCast value = new UnionDynamicCast();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dynamicCastValue = jsonParser.readValueAs(DynamicCast.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDynamicCast");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDynamicCast> {
        @Override
        public void serialize(UnionDynamicCast obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dynamicCastValue != null) {
                jsonGenerator.writeObject(obj.dynamicCastValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
