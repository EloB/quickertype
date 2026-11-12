package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFromJSON.Deserializer.class)
@JsonSerialize(using = UnionFromJSON.Serializer.class)
public class UnionFromJSON {
    public Double doubleValue;
    public FromJSON fromJSONValue;

    static class Deserializer extends JsonDeserializer<UnionFromJSON> {
        @Override
        public UnionFromJSON deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFromJSON value = new UnionFromJSON();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fromJSONValue = jsonParser.readValueAs(FromJSON.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFromJSON");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFromJSON> {
        @Override
        public void serialize(UnionFromJSON obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.fromJSONValue != null) {
                jsonGenerator.writeObject(obj.fromJSONValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
