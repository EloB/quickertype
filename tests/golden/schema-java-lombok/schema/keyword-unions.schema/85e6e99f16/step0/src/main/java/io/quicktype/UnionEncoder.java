package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionEncoder.Deserializer.class)
@JsonSerialize(using = UnionEncoder.Serializer.class)
public class UnionEncoder {
    public Double doubleValue;
    public Encoder encoderValue;

    static class Deserializer extends JsonDeserializer<UnionEncoder> {
        @Override
        public UnionEncoder deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionEncoder value = new UnionEncoder();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.encoderValue = jsonParser.readValueAs(Encoder.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionEncoder");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionEncoder> {
        @Override
        public void serialize(UnionEncoder obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.encoderValue != null) {
                jsonGenerator.writeObject(obj.encoderValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
