package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStruct.Deserializer.class)
@JsonSerialize(using = UnionStruct.Serializer.class)
public class UnionStruct {
    public Double doubleValue;
    public Struct structValue;

    static class Deserializer extends JsonDeserializer<UnionStruct> {
        @Override
        public UnionStruct deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStruct value = new UnionStruct();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.structValue = jsonParser.readValueAs(Struct.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStruct");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStruct> {
        @Override
        public void serialize(UnionStruct obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.structValue != null) {
                jsonGenerator.writeObject(obj.structValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
