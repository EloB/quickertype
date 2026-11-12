package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNSError.Deserializer.class)
@JsonSerialize(using = UnionNSError.Serializer.class)
public class UnionNSError {
    public Double doubleValue;
    public NSError nsErrorValue;

    static class Deserializer extends JsonDeserializer<UnionNSError> {
        @Override
        public UnionNSError deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNSError value = new UnionNSError();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nsErrorValue = jsonParser.readValueAs(NSError.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNSError");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNSError> {
        @Override
        public void serialize(UnionNSError obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nsErrorValue != null) {
                jsonGenerator.writeObject(obj.nsErrorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
