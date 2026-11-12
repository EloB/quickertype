package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionMap.Deserializer.class)
@JsonSerialize(using = UnionMap.Serializer.class)
public class UnionMap {
    public Double doubleValue;
    public MapClass mapClassValue;

    static class Deserializer extends JsonDeserializer<UnionMap> {
        @Override
        public UnionMap deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionMap value = new UnionMap();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.mapClassValue = jsonParser.readValueAs(MapClass.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionMap");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionMap> {
        @Override
        public void serialize(UnionMap obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.mapClassValue != null) {
                jsonGenerator.writeObject(obj.mapClassValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
