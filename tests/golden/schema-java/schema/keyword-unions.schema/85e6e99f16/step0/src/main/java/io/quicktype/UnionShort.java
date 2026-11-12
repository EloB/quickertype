package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionShort.Deserializer.class)
@JsonSerialize(using = UnionShort.Serializer.class)
public class UnionShort {
    public Double doubleValue;
    public Short shortValue;

    static class Deserializer extends JsonDeserializer<UnionShort> {
        @Override
        public UnionShort deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionShort value = new UnionShort();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.shortValue = jsonParser.readValueAs(Short.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionShort");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionShort> {
        @Override
        public void serialize(UnionShort obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.shortValue != null) {
                jsonGenerator.writeObject(obj.shortValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
