package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = LabelOverlapUnion.Deserializer.class)
@JsonSerialize(using = LabelOverlapUnion.Serializer.class)
public class LabelOverlapUnion {
    public Boolean boolValue;
    public LabelOverlapEnum enumValue;

    static class Deserializer extends JsonDeserializer<LabelOverlapUnion> {
        @Override
        public LabelOverlapUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LabelOverlapUnion value = new LabelOverlapUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = LabelOverlapEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize LabelOverlapUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LabelOverlapUnion> {
        @Override
        public void serialize(LabelOverlapUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
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
