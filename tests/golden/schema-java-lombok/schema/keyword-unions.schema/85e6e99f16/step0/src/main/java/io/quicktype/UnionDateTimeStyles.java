package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDateTimeStyles.Deserializer.class)
@JsonSerialize(using = UnionDateTimeStyles.Serializer.class)
public class UnionDateTimeStyles {
    public Double doubleValue;
    public DateTimeStyles dateTimeStylesValue;

    static class Deserializer extends JsonDeserializer<UnionDateTimeStyles> {
        @Override
        public UnionDateTimeStyles deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDateTimeStyles value = new UnionDateTimeStyles();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateTimeStylesValue = jsonParser.readValueAs(DateTimeStyles.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDateTimeStyles");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDateTimeStyles> {
        @Override
        public void serialize(UnionDateTimeStyles obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateTimeStylesValue != null) {
                jsonGenerator.writeObject(obj.dateTimeStylesValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
