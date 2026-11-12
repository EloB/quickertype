package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionUnmarshalJSON.Deserializer.class)
@JsonSerialize(using = UnionUnmarshalJSON.Serializer.class)
public class UnionUnmarshalJSON {
    public Double doubleValue;
    public UnmarshalJSON unmarshalJSONValue;

    static class Deserializer extends JsonDeserializer<UnionUnmarshalJSON> {
        @Override
        public UnionUnmarshalJSON deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionUnmarshalJSON value = new UnionUnmarshalJSON();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.unmarshalJSONValue = jsonParser.readValueAs(UnmarshalJSON.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionUnmarshalJSON");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionUnmarshalJSON> {
        @Override
        public void serialize(UnionUnmarshalJSON obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.unmarshalJSONValue != null) {
                jsonGenerator.writeObject(obj.unmarshalJSONValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
