package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionWcharT.Deserializer.class)
@JsonSerialize(using = UnionWcharT.Serializer.class)
public class UnionWcharT {
    public Double doubleValue;
    public WcharT wcharTValue;

    static class Deserializer extends JsonDeserializer<UnionWcharT> {
        @Override
        public UnionWcharT deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionWcharT value = new UnionWcharT();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.wcharTValue = jsonParser.readValueAs(WcharT.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionWcharT");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionWcharT> {
        @Override
        public void serialize(UnionWcharT obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.wcharTValue != null) {
                jsonGenerator.writeObject(obj.wcharTValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
