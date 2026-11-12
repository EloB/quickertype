package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = SortUnion.Deserializer.class)
@JsonSerialize(using = SortUnion.Serializer.class)
public class SortUnion {
    public SortField sortFieldValue;
    public SortEnum enumValue;

    static class Deserializer extends JsonDeserializer<SortUnion> {
        @Override
        public SortUnion deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            SortUnion value = new SortUnion();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_STRING:
                    String string = jsonParser.readValueAs(String.class);
                    try {
                        value.enumValue = SortEnum.forValue(string);
                    } catch (Exception ex) {
                        // Ignored
                    }
                    break;
                case START_OBJECT:
                    value.sortFieldValue = jsonParser.readValueAs(SortField.class);
                    break;
                default: throw new IOException("Cannot deserialize SortUnion");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<SortUnion> {
        @Override
        public void serialize(SortUnion obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.sortFieldValue != null) {
                jsonGenerator.writeObject(obj.sortFieldValue);
                return;
            }
            if (obj.enumValue != null) {
                jsonGenerator.writeObject(obj.enumValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
