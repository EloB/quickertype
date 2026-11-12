package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUshort.Deserializer.class)
@JsonSerialize(using = UnionUshort.Serializer.class)
public class UnionUshort {
    public Double doubleValue;
    public Ushort ushortValue;

    static class Deserializer extends JsonDeserializer<UnionUshort> {
        @Override
        public UnionUshort deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUshort value = new UnionUshort();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.ushortValue = jsonParser.readValueAs(Ushort.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUshort");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUshort> {
        @Override
        public void serialize(UnionUshort obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.ushortValue != null) {
                jsonGenerator.writeObject(obj.ushortValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
