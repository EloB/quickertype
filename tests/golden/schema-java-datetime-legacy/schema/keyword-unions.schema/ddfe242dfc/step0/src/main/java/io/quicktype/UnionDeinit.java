package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDeinit.Deserializer.class)
@JsonSerialize(using = UnionDeinit.Serializer.class)
public class UnionDeinit {
    public Double doubleValue;
    public Deinit deinitValue;

    static class Deserializer extends JsonDeserializer<UnionDeinit> {
        @Override
        public UnionDeinit deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDeinit value = new UnionDeinit();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.deinitValue = jsonParser.readValueAs(Deinit.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDeinit");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDeinit> {
        @Override
        public void serialize(UnionDeinit obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.deinitValue != null) {
                jsonGenerator.writeObject(obj.deinitValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
