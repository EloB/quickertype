package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.List;

@JsonDeserialize(using = RangeConfigValue.Deserializer.class)
@JsonSerialize(using = RangeConfigValue.Serializer.class)
public class RangeConfigValue {
    public List<PrecisionValue> unionArrayValue;
    public VGScheme vgSchemeValue;

    static class Deserializer extends JsonDeserializer<RangeConfigValue> {
        @Override
        public RangeConfigValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            RangeConfigValue value = new RangeConfigValue();
            switch (jsonParser.currentToken()) {
                case START_ARRAY:
                    value.unionArrayValue = jsonParser.readValueAs(new TypeReference<List<PrecisionValue>>() {});
                    break;
                case START_OBJECT:
                    value.vgSchemeValue = jsonParser.readValueAs(VGScheme.class);
                    break;
                default: throw new IOException("Cannot deserialize RangeConfigValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<RangeConfigValue> {
        @Override
        public void serialize(RangeConfigValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.unionArrayValue != null) {
                jsonGenerator.writeObject(obj.unionArrayValue);
                return;
            }
            if (obj.vgSchemeValue != null) {
                jsonGenerator.writeObject(obj.vgSchemeValue);
                return;
            }
            throw new IOException("RangeConfigValue must not be null");
        }
    }
}
