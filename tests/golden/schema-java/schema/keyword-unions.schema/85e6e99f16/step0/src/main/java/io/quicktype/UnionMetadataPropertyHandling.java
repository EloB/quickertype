package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionMetadataPropertyHandling.Deserializer.class)
@JsonSerialize(using = UnionMetadataPropertyHandling.Serializer.class)
public class UnionMetadataPropertyHandling {
    public Double doubleValue;
    public MetadataPropertyHandling metadataPropertyHandlingValue;

    static class Deserializer extends JsonDeserializer<UnionMetadataPropertyHandling> {
        @Override
        public UnionMetadataPropertyHandling deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionMetadataPropertyHandling value = new UnionMetadataPropertyHandling();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.metadataPropertyHandlingValue = jsonParser.readValueAs(MetadataPropertyHandling.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionMetadataPropertyHandling");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionMetadataPropertyHandling> {
        @Override
        public void serialize(UnionMetadataPropertyHandling obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.metadataPropertyHandlingValue != null) {
                jsonGenerator.writeObject(obj.metadataPropertyHandlingValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
