package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStackalloc.Deserializer.class)
@JsonSerialize(using = UnionStackalloc.Serializer.class)
public class UnionStackalloc {
    public Double doubleValue;
    public Stackalloc stackallocValue;

    static class Deserializer extends JsonDeserializer<UnionStackalloc> {
        @Override
        public UnionStackalloc deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStackalloc value = new UnionStackalloc();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.stackallocValue = jsonParser.readValueAs(Stackalloc.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStackalloc");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStackalloc> {
        @Override
        public void serialize(UnionStackalloc obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stackallocValue != null) {
                jsonGenerator.writeObject(obj.stackallocValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
