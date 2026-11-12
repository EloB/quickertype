package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionType.Deserializer.class)
@JsonSerialize(using = UnionType.Serializer.class)
public class UnionType {
    public Double doubleValue;
    public Type typeValue;

    static class Deserializer extends JsonDeserializer<UnionType> {
        @Override
        public UnionType deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionType value = new UnionType();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.typeValue = jsonParser.readValueAs(Type.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionType");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionType> {
        @Override
        public void serialize(UnionType obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.typeValue != null) {
                jsonGenerator.writeObject(obj.typeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
