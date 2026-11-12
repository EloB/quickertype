package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSimpleModule.Deserializer.class)
@JsonSerialize(using = UnionSimpleModule.Serializer.class)
public class UnionSimpleModule {
    public Double doubleValue;
    public SimpleModule simpleModuleValue;

    static class Deserializer extends JsonDeserializer<UnionSimpleModule> {
        @Override
        public UnionSimpleModule deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSimpleModule value = new UnionSimpleModule();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.simpleModuleValue = jsonParser.readValueAs(SimpleModule.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSimpleModule");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSimpleModule> {
        @Override
        public void serialize(UnionSimpleModule obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.simpleModuleValue != null) {
                jsonGenerator.writeObject(obj.simpleModuleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
