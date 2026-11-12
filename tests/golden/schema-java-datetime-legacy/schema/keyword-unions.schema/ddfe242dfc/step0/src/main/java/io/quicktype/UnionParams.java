package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionParams.Deserializer.class)
@JsonSerialize(using = UnionParams.Serializer.class)
public class UnionParams {
    public Double doubleValue;
    public Params paramsValue;

    static class Deserializer extends JsonDeserializer<UnionParams> {
        @Override
        public UnionParams deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionParams value = new UnionParams();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.paramsValue = jsonParser.readValueAs(Params.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionParams");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionParams> {
        @Override
        public void serialize(UnionParams obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.paramsValue != null) {
                jsonGenerator.writeObject(obj.paramsValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
