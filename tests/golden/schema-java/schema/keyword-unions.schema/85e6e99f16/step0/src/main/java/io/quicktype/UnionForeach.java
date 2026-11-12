package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionForeach.Deserializer.class)
@JsonSerialize(using = UnionForeach.Serializer.class)
public class UnionForeach {
    public Double doubleValue;
    public Foreach foreachValue;

    static class Deserializer extends JsonDeserializer<UnionForeach> {
        @Override
        public UnionForeach deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionForeach value = new UnionForeach();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.foreachValue = jsonParser.readValueAs(Foreach.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionForeach");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionForeach> {
        @Override
        public void serialize(UnionForeach obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.foreachValue != null) {
                jsonGenerator.writeObject(obj.foreachValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
