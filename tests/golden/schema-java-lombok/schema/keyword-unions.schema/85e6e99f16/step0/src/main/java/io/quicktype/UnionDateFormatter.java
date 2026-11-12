package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDateFormatter.Deserializer.class)
@JsonSerialize(using = UnionDateFormatter.Serializer.class)
public class UnionDateFormatter {
    public Double doubleValue;
    public DateFormatter dateFormatterValue;

    static class Deserializer extends JsonDeserializer<UnionDateFormatter> {
        @Override
        public UnionDateFormatter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDateFormatter value = new UnionDateFormatter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateFormatterValue = jsonParser.readValueAs(DateFormatter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDateFormatter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDateFormatter> {
        @Override
        public void serialize(UnionDateFormatter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateFormatterValue != null) {
                jsonGenerator.writeObject(obj.dateFormatterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
