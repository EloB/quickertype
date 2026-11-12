package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = RangeElement.Deserializer.class)
@JsonSerialize(using = RangeElement.Serializer.class)
public class RangeElement {
    public Double doubleValue;
    public DateTime dateTimeValue;

    static class Deserializer extends JsonDeserializer<RangeElement> {
        @Override
        public RangeElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            RangeElement value = new RangeElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateTimeValue = jsonParser.readValueAs(DateTime.class);
                    break;
                default: throw new IOException("Cannot deserialize RangeElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<RangeElement> {
        @Override
        public void serialize(RangeElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
