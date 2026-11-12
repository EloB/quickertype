package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCalendar.Deserializer.class)
@JsonSerialize(using = UnionCalendar.Serializer.class)
public class UnionCalendar {
    public Double doubleValue;
    public Calendar calendarValue;

    static class Deserializer extends JsonDeserializer<UnionCalendar> {
        @Override
        public UnionCalendar deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCalendar value = new UnionCalendar();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.calendarValue = jsonParser.readValueAs(Calendar.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCalendar");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCalendar> {
        @Override
        public void serialize(UnionCalendar obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.calendarValue != null) {
                jsonGenerator.writeObject(obj.calendarValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
