package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.OffsetTime;

@JsonDeserialize(using = UnionArray.Deserializer.class)
@JsonSerialize(using = UnionArray.Serializer.class)
public class UnionArray {
    public LocalDate dateValue;
    public OffsetTime timeValue;
    public OffsetDateTime dateTimeValue;

    static class Deserializer extends JsonDeserializer<UnionArray> {
        @Override
        public UnionArray deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionArray value = new UnionArray();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.timeValue = Converter.parseTimeString(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.dateValue = LocalDate.parse(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.dateTimeValue = Converter.parseDateTimeString(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize UnionArray");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionArray> {
        @Override
        public void serialize(UnionArray obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.dateValue != null) {
                jsonGenerator.writeObject(obj.dateValue.format(java.time.format.DateTimeFormatter.ISO_DATE));
                return;
            }
            if (obj.timeValue != null) {
                jsonGenerator.writeObject(obj.timeValue.format(java.time.format.DateTimeFormatter.ISO_OFFSET_TIME));
                return;
            }
            if (obj.dateTimeValue != null) {
                jsonGenerator.writeObject(obj.dateTimeValue.format(java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME));
                return;
            }
            throw new IOException("UnionArray must not be null");
        }
    }
}
