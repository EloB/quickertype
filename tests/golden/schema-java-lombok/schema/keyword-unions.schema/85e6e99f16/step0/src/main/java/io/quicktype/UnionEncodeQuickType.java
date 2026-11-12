package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEncodeQuickType.Deserializer.class)
@JsonSerialize(using = UnionEncodeQuickType.Serializer.class)
public class UnionEncodeQuickType {
    public Double doubleValue;
    public EncodeQuickType encodeQuickTypeValue;

    static class Deserializer extends JsonDeserializer<UnionEncodeQuickType> {
        @Override
        public UnionEncodeQuickType deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEncodeQuickType value = new UnionEncodeQuickType();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.encodeQuickTypeValue = jsonParser.readValueAs(EncodeQuickType.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEncodeQuickType");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEncodeQuickType> {
        @Override
        public void serialize(UnionEncodeQuickType obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.encodeQuickTypeValue != null) {
                jsonGenerator.writeObject(obj.encodeQuickTypeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
