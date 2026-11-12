package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUtf8JSONReader.Deserializer.class)
@JsonSerialize(using = UnionUtf8JSONReader.Serializer.class)
public class UnionUtf8JSONReader {
    public Double doubleValue;
    public Utf8JSONReader utf8JSONReaderValue;

    static class Deserializer extends JsonDeserializer<UnionUtf8JSONReader> {
        @Override
        public UnionUtf8JSONReader deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUtf8JSONReader value = new UnionUtf8JSONReader();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.utf8JSONReaderValue = jsonParser.readValueAs(Utf8JSONReader.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUtf8JSONReader");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUtf8JSONReader> {
        @Override
        public void serialize(UnionUtf8JSONReader obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.utf8JSONReaderValue != null) {
                jsonGenerator.writeObject(obj.utf8JSONReaderValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
