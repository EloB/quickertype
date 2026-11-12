package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.util.Date;

@JsonDeserialize(using = BarUnion.Deserializer.class)
@JsonSerialize(using = BarUnion.Serializer.class)
public class BarUnion {
    public BarEnum enumValue;
    public Date dateTimeValue;

    static class Deserializer extends JsonDeserializer<BarUnion> {
        @Override
        public BarUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            BarUnion value = new BarUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.dateTimeValue = Converter.parseAllDateTimeString(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.enumValue = BarEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize BarUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<BarUnion> {
        @Override
        public void serialize(BarUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(Converter.serializeDateTime(obj.dateTimeValue));
                return;
            }
            throw new IOException("BarUnion must not be null");
        }
    }
}
