package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCoAwait.Deserializer.class)
@JsonSerialize(using = UnionCoAwait.Serializer.class)
public class UnionCoAwait {
    public Double doubleValue;
    public CoAwait coAwaitValue;

    static class Deserializer extends JsonDeserializer<UnionCoAwait> {
        @Override
        public UnionCoAwait deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCoAwait value = new UnionCoAwait();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.coAwaitValue = jsonParser.readValueAs(CoAwait.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCoAwait");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCoAwait> {
        @Override
        public void serialize(UnionCoAwait obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.coAwaitValue != null) {
                jsonGenerator.writeObject(obj.coAwaitValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
