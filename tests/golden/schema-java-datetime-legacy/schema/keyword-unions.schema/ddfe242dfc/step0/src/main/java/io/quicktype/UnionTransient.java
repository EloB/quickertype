package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionTransient.Deserializer.class)
@JsonSerialize(using = UnionTransient.Serializer.class)
public class UnionTransient {
    public Double doubleValue;
    public Transient transientValue;

    static class Deserializer extends JsonDeserializer<UnionTransient> {
        @Override
        public UnionTransient deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionTransient value = new UnionTransient();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.transientValue = jsonParser.readValueAs(Transient.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionTransient");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionTransient> {
        @Override
        public void serialize(UnionTransient obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.transientValue != null) {
                jsonGenerator.writeObject(obj.transientValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
