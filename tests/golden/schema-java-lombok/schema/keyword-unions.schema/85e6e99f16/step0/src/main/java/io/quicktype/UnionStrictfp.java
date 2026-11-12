package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStrictfp.Deserializer.class)
@JsonSerialize(using = UnionStrictfp.Serializer.class)
public class UnionStrictfp {
    public Double doubleValue;
    public Strictfp strictfpValue;

    static class Deserializer extends JsonDeserializer<UnionStrictfp> {
        @Override
        public UnionStrictfp deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStrictfp value = new UnionStrictfp();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.strictfpValue = jsonParser.readValueAs(Strictfp.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStrictfp");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStrictfp> {
        @Override
        public void serialize(UnionStrictfp obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.strictfpValue != null) {
                jsonGenerator.writeObject(obj.strictfpValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
