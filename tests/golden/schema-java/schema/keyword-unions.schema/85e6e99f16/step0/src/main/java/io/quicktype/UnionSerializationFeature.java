package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSerializationFeature.Deserializer.class)
@JsonSerialize(using = UnionSerializationFeature.Serializer.class)
public class UnionSerializationFeature {
    public Double doubleValue;
    public SerializationFeatureClass serializationFeatureClassValue;

    static class Deserializer extends JsonDeserializer<UnionSerializationFeature> {
        @Override
        public UnionSerializationFeature deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSerializationFeature value = new UnionSerializationFeature();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.serializationFeatureClassValue = jsonParser.readValueAs(SerializationFeatureClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSerializationFeature");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSerializationFeature> {
        @Override
        public void serialize(UnionSerializationFeature obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.serializationFeatureClassValue != null) {
                jsonGenerator.writeObject(obj.serializationFeatureClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
