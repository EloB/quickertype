package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFallthrough.Deserializer.class)
@JsonSerialize(using = UnionFallthrough.Serializer.class)
public class UnionFallthrough {
    public Double doubleValue;
    public Fallthrough fallthroughValue;

    static class Deserializer extends JsonDeserializer<UnionFallthrough> {
        @Override
        public UnionFallthrough deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFallthrough value = new UnionFallthrough();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fallthroughValue = jsonParser.readValueAs(Fallthrough.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFallthrough");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFallthrough> {
        @Override
        public void serialize(UnionFallthrough obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.fallthroughValue != null) {
                jsonGenerator.writeObject(obj.fallthroughValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
