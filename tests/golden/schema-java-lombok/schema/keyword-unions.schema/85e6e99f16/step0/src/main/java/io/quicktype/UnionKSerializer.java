package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionKSerializer.Deserializer.class)
@JsonSerialize(using = UnionKSerializer.Serializer.class)
public class UnionKSerializer {
    public Double doubleValue;
    public KSerializer kSerializerValue;

    static class Deserializer extends JsonDeserializer<UnionKSerializer> {
        @Override
        public UnionKSerializer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionKSerializer value = new UnionKSerializer();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.kSerializerValue = jsonParser.readValueAs(KSerializer.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionKSerializer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionKSerializer> {
        @Override
        public void serialize(UnionKSerializer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.kSerializerValue != null) {
                jsonGenerator.writeObject(obj.kSerializerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
