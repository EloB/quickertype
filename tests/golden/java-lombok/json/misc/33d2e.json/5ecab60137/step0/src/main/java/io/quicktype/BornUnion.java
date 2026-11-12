package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;
import java.time.LocalDate;

@JsonDeserialize(using = BornUnion.Deserializer.class)
@JsonSerialize(using = BornUnion.Serializer.class)
public class BornUnion {
    public LocalDate dateValue;
    public BornEnum enumValue;

    static class Deserializer extends JsonDeserializer<BornUnion> {
        @Override
        public BornUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            BornUnion value = new BornUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.dateValue = LocalDate.parse(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    try {
                        value.enumValue = BornEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                default: throw new IOException("Cannot deserialize BornUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<BornUnion> {
        @Override
        public void serialize(BornUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.dateValue != null) {
                jsonGenerator.writeObject(obj.dateValue.format(java.time.format.DateTimeFormatter.ISO_DATE));
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            throw new IOException("BornUnion must not be null");
        }
    }
}
