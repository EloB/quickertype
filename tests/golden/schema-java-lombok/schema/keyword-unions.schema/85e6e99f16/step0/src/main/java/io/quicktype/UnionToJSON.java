package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionToJSON.Deserializer.class)
@JsonSerialize(using = UnionToJSON.Serializer.class)
public class UnionToJSON {
    public Double doubleValue;
    public ToJSON toJSONValue;

    static class Deserializer extends JsonDeserializer<UnionToJSON> {
        @Override
        public UnionToJSON deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionToJSON value = new UnionToJSON();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.toJSONValue = jsonParser.readValueAs(ToJSON.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionToJSON");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionToJSON> {
        @Override
        public void serialize(UnionToJSON obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.toJSONValue != null) {
                jsonGenerator.writeObject(obj.toJSONValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
