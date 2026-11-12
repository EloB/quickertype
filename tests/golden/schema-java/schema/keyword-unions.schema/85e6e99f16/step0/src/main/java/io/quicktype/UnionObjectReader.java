package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionObjectReader.Deserializer.class)
@JsonSerialize(using = UnionObjectReader.Serializer.class)
public class UnionObjectReader {
    public Double doubleValue;
    public ObjectReaderClass objectReaderClassValue;

    static class Deserializer extends JsonDeserializer<UnionObjectReader> {
        @Override
        public UnionObjectReader deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionObjectReader value = new UnionObjectReader();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.objectReaderClassValue = jsonParser.readValueAs(ObjectReaderClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionObjectReader");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionObjectReader> {
        @Override
        public void serialize(UnionObjectReader obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.objectReaderClassValue != null) {
                jsonGenerator.writeObject(obj.objectReaderClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
