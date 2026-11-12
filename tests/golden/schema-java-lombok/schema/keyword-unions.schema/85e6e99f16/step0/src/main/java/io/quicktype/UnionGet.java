package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionGet.Deserializer.class)
@JsonSerialize(using = UnionGet.Serializer.class)
public class UnionGet {
    public Double doubleValue;
    public Get getValue;

    static class Deserializer extends JsonDeserializer<UnionGet> {
        @Override
        public UnionGet deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionGet value = new UnionGet();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.getValue = jsonParser.readValueAs(Get.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionGet");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionGet> {
        @Override
        public void serialize(UnionGet obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.getValue != null) {
                jsonGenerator.writeObject(obj.getValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
