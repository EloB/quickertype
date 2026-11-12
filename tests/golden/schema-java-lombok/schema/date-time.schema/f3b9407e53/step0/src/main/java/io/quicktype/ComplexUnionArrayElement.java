package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.time.OffsetDateTime;

@JsonDeserialize(using = ComplexUnionArrayElement.Deserializer.class)
@JsonSerialize(using = ComplexUnionArrayElement.Serializer.class)
public class ComplexUnionArrayElement {
    public Long integerValue;
    public ComplexUnionArrayEnum enumValue;
    public OffsetDateTime dateTimeValue;

    static class Deserializer extends JsonDeserializer<ComplexUnionArrayElement> {
        @Override
        public ComplexUnionArrayElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            ComplexUnionArrayElement value = new ComplexUnionArrayElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.dateTimeValue = Converter.parseDateTimeString(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.enumValue = ComplexUnionArrayEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize ComplexUnionArrayElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<ComplexUnionArrayElement> {
        @Override
        public void serialize(ComplexUnionArrayElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue.format(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME));
                return;
            }
            throw new IOException("ComplexUnionArrayElement must not be null");
        }
    }
}
