package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionImaginery.Deserializer.class)
@JsonSerialize(using = UnionImaginery.Serializer.class)
public class UnionImaginery {
    public Double doubleValue;
    public Imaginery imagineryValue;

    static class Deserializer extends JsonDeserializer<UnionImaginery> {
        @Override
        public UnionImaginery deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionImaginery value = new UnionImaginery();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.imagineryValue = jsonParser.readValueAs(Imaginery.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionImaginery");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionImaginery> {
        @Override
        public void serialize(UnionImaginery obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.imagineryValue != null) {
                jsonGenerator.writeObject(obj.imagineryValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
