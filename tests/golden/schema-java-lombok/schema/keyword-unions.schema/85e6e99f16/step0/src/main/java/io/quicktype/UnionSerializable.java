package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSerializable.Deserializer.class)
@JsonSerialize(using = UnionSerializable.Serializer.class)
public class UnionSerializable {
    public Double doubleValue;
    public Serializable serializableValue;

    static class Deserializer extends JsonDeserializer<UnionSerializable> {
        @Override
        public UnionSerializable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSerializable value = new UnionSerializable();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.serializableValue = jsonParser.readValueAs(Serializable.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSerializable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSerializable> {
        @Override
        public void serialize(UnionSerializable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.serializableValue != null) {
                jsonGenerator.writeObject(obj.serializableValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
