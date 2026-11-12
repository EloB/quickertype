package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionAlignof.Deserializer.class)
@JsonSerialize(using = UnionAlignof.Serializer.class)
public class UnionAlignof {
    public Double doubleValue;
    public Alignof alignofValue;

    static class Deserializer extends JsonDeserializer<UnionAlignof> {
        @Override
        public UnionAlignof deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionAlignof value = new UnionAlignof();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.alignofValue = jsonParser.readValueAs(Alignof.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionAlignof");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionAlignof> {
        @Override
        public void serialize(UnionAlignof obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.alignofValue != null) {
                jsonGenerator.writeObject(obj.alignofValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
