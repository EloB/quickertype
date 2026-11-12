package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionDecoder.Deserializer.class)
@JsonSerialize(using = UnionDecoder.Serializer.class)
public class UnionDecoder {
    public Double doubleValue;
    public Decoder decoderValue;

    static class Deserializer extends JsonDeserializer<UnionDecoder> {
        @Override
        public UnionDecoder deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionDecoder value = new UnionDecoder();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.decoderValue = jsonParser.readValueAs(Decoder.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionDecoder");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionDecoder> {
        @Override
        public void serialize(UnionDecoder obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.decoderValue != null) {
                jsonGenerator.writeObject(obj.decoderValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
