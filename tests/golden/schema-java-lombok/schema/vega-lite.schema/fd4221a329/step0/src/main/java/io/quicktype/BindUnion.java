package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Map;

@JsonDeserialize(using = BindUnion.Deserializer.class)
@JsonSerialize(using = BindUnion.Serializer.class)
public class BindUnion {
    public Map<String, VGBinding> vgBindingMapValue;
    public BindEnum enumValue;

    static class Deserializer extends JsonDeserializer<BindUnion> {
        @Override
        public BindUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            BindUnion value = new BindUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = BindEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                case START_OBJECT:
                    value.vgBindingMapValue = jsonParser.readValueAs(Map.class);
                    break;
                default: throw new IOException("Cannot deserialize BindUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<BindUnion> {
        @Override
        public void serialize(BindUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.vgBindingMapValue != null) {
                jsonGenerator.writeObject(obj.vgBindingMapValue);
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
