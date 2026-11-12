package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTimeZone.Deserializer.class)
@JsonSerialize(using = UnionTimeZone.Serializer.class)
public class UnionTimeZone {
    public Double doubleValue;
    public TimeZone timeZoneValue;

    static class Deserializer extends JsonDeserializer<UnionTimeZone> {
        @Override
        public UnionTimeZone deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTimeZone value = new UnionTimeZone();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.timeZoneValue = jsonParser.readValueAs(TimeZone.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTimeZone");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTimeZone> {
        @Override
        public void serialize(UnionTimeZone obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.timeZoneValue != null) {
                jsonGenerator.writeObject(obj.timeZoneValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
