package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUtf8JSONWriter.Deserializer.class)
@JsonSerialize(using = UnionUtf8JSONWriter.Serializer.class)
public class UnionUtf8JSONWriter {
    public Double doubleValue;
    public Utf8JSONWriter utf8JSONWriterValue;

    static class Deserializer extends JsonDeserializer<UnionUtf8JSONWriter> {
        @Override
        public UnionUtf8JSONWriter deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUtf8JSONWriter value = new UnionUtf8JSONWriter();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.utf8JSONWriterValue = jsonParser.readValueAs(Utf8JSONWriter.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUtf8JSONWriter");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUtf8JSONWriter> {
        @Override
        public void serialize(UnionUtf8JSONWriter obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.utf8JSONWriterValue != null) {
                jsonGenerator.writeObject(obj.utf8JSONWriterValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
