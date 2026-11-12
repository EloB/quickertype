package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionModule.Deserializer.class)
@JsonSerialize(using = UnionModule.Serializer.class)
public class UnionModule {
    public Double doubleValue;
    public Module moduleValue;

    static class Deserializer extends JsonDeserializer<UnionModule> {
        @Override
        public UnionModule deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionModule value = new UnionModule();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.moduleValue = jsonParser.readValueAs(Module.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionModule");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionModule> {
        @Override
        public void serialize(UnionModule obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.moduleValue != null) {
                jsonGenerator.writeObject(obj.moduleValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
