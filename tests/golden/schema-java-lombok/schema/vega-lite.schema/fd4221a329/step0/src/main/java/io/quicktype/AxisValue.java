package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = AxisValue.Deserializer.class)
@JsonSerialize(using = AxisValue.Serializer.class)
public class AxisValue {
    public Double doubleValue;
    public DateTime dateTimeValue;

    static class Deserializer extends JsonDeserializer<AxisValue> {
        @Override
        public AxisValue deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            AxisValue value = new AxisValue();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.dateTimeValue = jsonParser.readValueAs(DateTime.class);
                    break;
                default: throw new IOException("Cannot deserialize AxisValue");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<AxisValue> {
        @Override
        public void serialize(AxisValue obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue);
                return;
            }
            throw new IOException("AxisValue must not be null");
        }
    }
}
