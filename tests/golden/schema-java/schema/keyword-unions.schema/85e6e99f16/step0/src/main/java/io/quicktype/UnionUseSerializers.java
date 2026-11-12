package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUseSerializers.Deserializer.class)
@JsonSerialize(using = UnionUseSerializers.Serializer.class)
public class UnionUseSerializers {
    public Double doubleValue;
    public UseSerializers useSerializersValue;

    static class Deserializer extends JsonDeserializer<UnionUseSerializers> {
        @Override
        public UnionUseSerializers deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUseSerializers value = new UnionUseSerializers();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.useSerializersValue = jsonParser.readValueAs(UseSerializers.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUseSerializers");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUseSerializers> {
        @Override
        public void serialize(UnionUseSerializers obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.useSerializersValue != null) {
                jsonGenerator.writeObject(obj.useSerializersValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
