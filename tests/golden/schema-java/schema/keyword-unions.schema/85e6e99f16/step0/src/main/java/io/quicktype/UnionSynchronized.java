package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionSynchronized.Deserializer.class)
@JsonSerialize(using = UnionSynchronized.Serializer.class)
public class UnionSynchronized {
    public Double doubleValue;
    public Synchronized synchronizedValue;

    static class Deserializer extends JsonDeserializer<UnionSynchronized> {
        @Override
        public UnionSynchronized deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionSynchronized value = new UnionSynchronized();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.synchronizedValue = jsonParser.readValueAs(Synchronized.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionSynchronized");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionSynchronized> {
        @Override
        public void serialize(UnionSynchronized obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.synchronizedValue != null) {
                jsonGenerator.writeObject(obj.synchronizedValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
