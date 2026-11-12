package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionPackage.Deserializer.class)
@JsonSerialize(using = UnionPackage.Serializer.class)
public class UnionPackage {
    public Double doubleValue;
    public Package packageValue;

    static class Deserializer extends JsonDeserializer<UnionPackage> {
        @Override
        public UnionPackage deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionPackage value = new UnionPackage();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.packageValue = jsonParser.readValueAs(Package.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionPackage");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionPackage> {
        @Override
        public void serialize(UnionPackage obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.packageValue != null) {
                jsonGenerator.writeObject(obj.packageValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
