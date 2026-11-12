package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

/**
 * The value that the field should be equal to.
 */
@JsonDeserialize(using = EqualUnion.Deserializer.class)
@JsonSerialize(using = EqualUnion.Serializer.class)
public class EqualUnion {
    public Double doubleValue;
    public Boolean boolValue;
    public DateTime dateTimeValue;
    public String stringValue;

    static class Deserializer extends JsonDeserializer<EqualUnion> {
        @Override
        public EqualUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            EqualUnion value = new EqualUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case VALUE_TRUE:
                case VALUE_FALSE:
                    value.boolValue = jsonParser.readValueAs(Boolean.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    value.stringValue = string;
                    break;
                case START_OBJECT:
                    value.dateTimeValue = jsonParser.readValueAs(DateTime.class);
                    break;
                default: throw new IOException("Cannot deserialize EqualUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<EqualUnion> {
        @Override
        public void serialize(EqualUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.boolValue != null) {
                jsonGenerator.writeObject(obj.boolValue);
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
            jsonGenerator.writeNull();
        }
    }
}
