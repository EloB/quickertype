package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionMutable.Deserializer.class)
@JsonSerialize(using = UnionMutable.Serializer.class)
public class UnionMutable {
    public Double doubleValue;
    public Mutable mutableValue;

    static class Deserializer extends JsonDeserializer<UnionMutable> {
        @Override
        public UnionMutable deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionMutable value = new UnionMutable();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.mutableValue = jsonParser.readValueAs(Mutable.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionMutable");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionMutable> {
        @Override
        public void serialize(UnionMutable obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.mutableValue != null) {
                jsonGenerator.writeObject(obj.mutableValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
