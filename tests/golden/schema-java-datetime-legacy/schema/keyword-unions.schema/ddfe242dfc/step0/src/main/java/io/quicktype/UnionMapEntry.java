package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionMapEntry.Deserializer.class)
@JsonSerialize(using = UnionMapEntry.Serializer.class)
public class UnionMapEntry {
    public Double doubleValue;
    public MapEntry mapEntryValue;

    static class Deserializer extends JsonDeserializer<UnionMapEntry> {
        @Override
        public UnionMapEntry deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionMapEntry value = new UnionMapEntry();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.mapEntryValue = jsonParser.readValueAs(MapEntry.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionMapEntry");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionMapEntry> {
        @Override
        public void serialize(UnionMapEntry obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.mapEntryValue != null) {
                jsonGenerator.writeObject(obj.mapEntryValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
