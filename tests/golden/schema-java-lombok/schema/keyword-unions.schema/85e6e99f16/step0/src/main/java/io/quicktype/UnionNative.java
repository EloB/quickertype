package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNative.Deserializer.class)
@JsonSerialize(using = UnionNative.Serializer.class)
public class UnionNative {
    public Double doubleValue;
    public Native nativeValue;

    static class Deserializer extends JsonDeserializer<UnionNative> {
        @Override
        public UnionNative deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNative value = new UnionNative();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nativeValue = jsonParser.readValueAs(Native.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNative");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNative> {
        @Override
        public void serialize(UnionNative obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nativeValue != null) {
                jsonGenerator.writeObject(obj.nativeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
