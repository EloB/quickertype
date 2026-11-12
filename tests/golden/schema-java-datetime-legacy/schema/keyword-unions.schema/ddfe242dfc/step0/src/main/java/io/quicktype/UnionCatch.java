package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionCatch.Deserializer.class)
@JsonSerialize(using = UnionCatch.Serializer.class)
public class UnionCatch {
    public Double doubleValue;
    public Catch catchValue;

    static class Deserializer extends JsonDeserializer<UnionCatch> {
        @Override
        public UnionCatch deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionCatch value = new UnionCatch();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.catchValue = jsonParser.readValueAs(Catch.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionCatch");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionCatch> {
        @Override
        public void serialize(UnionCatch obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.catchValue != null) {
                jsonGenerator.writeObject(obj.catchValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
