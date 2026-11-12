package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWith.Deserializer.class)
@JsonSerialize(using = UnionWith.Serializer.class)
public class UnionWith {
    public Double doubleValue;
    public With withValue;

    static class Deserializer extends JsonDeserializer<UnionWith> {
        @Override
        public UnionWith deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWith value = new UnionWith();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.withValue = jsonParser.readValueAs(With.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionWith");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWith> {
        @Override
        public void serialize(UnionWith obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.withValue != null) {
                jsonGenerator.writeObject(obj.withValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
