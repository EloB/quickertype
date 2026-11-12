package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionClone.Deserializer.class)
@JsonSerialize(using = UnionClone.Serializer.class)
public class UnionClone {
    public Double doubleValue;
    public Clone cloneValue;

    static class Deserializer extends JsonDeserializer<UnionClone> {
        @Override
        public UnionClone deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionClone value = new UnionClone();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.cloneValue = jsonParser.readValueAs(Clone.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionClone");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionClone> {
        @Override
        public void serialize(UnionClone obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.cloneValue != null) {
                jsonGenerator.writeObject(obj.cloneValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
