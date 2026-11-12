package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEnum.Deserializer.class)
@JsonSerialize(using = UnionEnum.Serializer.class)
public class UnionEnum {
    public Double doubleValue;
    public Enum enumValue;

    static class Deserializer extends JsonDeserializer<UnionEnum> {
        @Override
        public UnionEnum deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEnum value = new UnionEnum();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.enumValue = jsonParser.readValueAs(Enum.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEnum");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEnum> {
        @Override
        public void serialize(UnionEnum obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
