package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDefault.Deserializer.class)
@JsonSerialize(using = UnionDefault.Serializer.class)
public class UnionDefault {
    public Double doubleValue;
    public Default defaultValue;

    static class Deserializer extends JsonDeserializer<UnionDefault> {
        @Override
        public UnionDefault deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDefault value = new UnionDefault();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.defaultValue = jsonParser.readValueAs(Default.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDefault");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDefault> {
        @Override
        public void serialize(UnionDefault obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.defaultValue != null) {
                jsonGenerator.writeObject(obj.defaultValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
