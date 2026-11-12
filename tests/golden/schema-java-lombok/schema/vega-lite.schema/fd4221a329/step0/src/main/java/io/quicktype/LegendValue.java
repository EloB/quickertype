package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = LegendValue.Deserializer.class)
@JsonSerialize(using = LegendValue.Serializer.class)
public class LegendValue {
    public Double doubleValue;
    public DateTime dateTimeValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<LegendValue> {
        @Override
        public LegendValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            LegendValue value = new LegendValue();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.dateTimeValue = jsonParser.readValueAs(DateTime.class);
                    break;
                default: throw new IOException("Cannot deserialize LegendValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<LegendValue> {
        @Override
        public void serialize(LegendValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue);
                return;
            }
            if (obj.stringValue != null) {
                jsonGenerator.writeObject(obj.stringValue);
                return;
            }
            throw new IOException("LegendValue must not be null");
        }
    }
}
