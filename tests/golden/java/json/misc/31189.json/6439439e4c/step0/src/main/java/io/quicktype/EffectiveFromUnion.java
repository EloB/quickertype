package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.time.LocalDate;

@JsonDeserialize(using = EffectiveFromUnion.Deserializer.class)
@JsonSerialize(using = EffectiveFromUnion.Serializer.class)
public class EffectiveFromUnion {
    public LocalDate dateValue;
    public EffectiveFromEnum enumValue;

    static class Deserializer extends JsonDeserializer<EffectiveFromUnion> {
        @Override
        public EffectiveFromUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            EffectiveFromUnion value = new EffectiveFromUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.dateValue = LocalDate.parse(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.enumValue = EffectiveFromEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize EffectiveFromUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<EffectiveFromUnion> {
        @Override
        public void serialize(EffectiveFromUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.dateValue != null) {
                jsonGenerator.writeObject(obj.dateValue.format(java.time.format.DateTimeFormatter.ISO_DATE));
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            throw new IOException("EffectiveFromUnion must not be null");
        }
    }
}
