package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDeserializationFeature.Deserializer.class)
@JsonSerialize(using = UnionDeserializationFeature.Serializer.class)
public class UnionDeserializationFeature {
    public Double doubleValue;
    public DeserializationFeatureClass deserializationFeatureClassValue;

    static class Deserializer extends JsonDeserializer<UnionDeserializationFeature> {
        @Override
        public UnionDeserializationFeature deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDeserializationFeature value = new UnionDeserializationFeature();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.deserializationFeatureClassValue = jsonParser.readValueAs(DeserializationFeatureClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDeserializationFeature");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDeserializationFeature> {
        @Override
        public void serialize(UnionDeserializationFeature obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.deserializationFeatureClassValue != null) {
                jsonGenerator.writeObject(obj.deserializationFeatureClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
