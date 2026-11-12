package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInstanceof.Deserializer.class)
@JsonSerialize(using = UnionInstanceof.Serializer.class)
public class UnionInstanceof {
    public Double doubleValue;
    public Instanceof instanceofValue;

    static class Deserializer extends JsonDeserializer<UnionInstanceof> {
        @Override
        public UnionInstanceof deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInstanceof value = new UnionInstanceof();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.instanceofValue = jsonParser.readValueAs(Instanceof.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInstanceof");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInstanceof> {
        @Override
        public void serialize(UnionInstanceof obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.instanceofValue != null) {
                jsonGenerator.writeObject(obj.instanceofValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
