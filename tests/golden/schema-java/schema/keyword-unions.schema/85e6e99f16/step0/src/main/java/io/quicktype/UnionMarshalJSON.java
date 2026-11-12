package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionMarshalJSON.Deserializer.class)
@JsonSerialize(using = UnionMarshalJSON.Serializer.class)
public class UnionMarshalJSON {
    public Double doubleValue;
    public MarshalJSON marshalJSONValue;

    static class Deserializer extends JsonDeserializer<UnionMarshalJSON> {
        @Override
        public UnionMarshalJSON deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionMarshalJSON value = new UnionMarshalJSON();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.marshalJSONValue = jsonParser.readValueAs(MarshalJSON.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionMarshalJSON");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionMarshalJSON> {
        @Override
        public void serialize(UnionMarshalJSON obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.marshalJSONValue != null) {
                jsonGenerator.writeObject(obj.marshalJSONValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
