package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionStdSerializer.Deserializer.class)
@JsonSerialize(using = UnionStdSerializer.Serializer.class)
public class UnionStdSerializer {
    public Double doubleValue;
    public StdSerializer stdSerializerValue;

    static class Deserializer extends JsonDeserializer<UnionStdSerializer> {
        @Override
        public UnionStdSerializer deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionStdSerializer value = new UnionStdSerializer();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.stdSerializerValue = jsonParser.readValueAs(StdSerializer.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionStdSerializer");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionStdSerializer> {
        @Override
        public void serialize(UnionStdSerializer obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.stdSerializerValue != null) {
                jsonGenerator.writeObject(obj.stdSerializerValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
