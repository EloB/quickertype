package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNonlocal.Deserializer.class)
@JsonSerialize(using = UnionNonlocal.Serializer.class)
public class UnionNonlocal {
    public Double doubleValue;
    public Nonlocal nonlocalValue;

    static class Deserializer extends JsonDeserializer<UnionNonlocal> {
        @Override
        public UnionNonlocal deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNonlocal value = new UnionNonlocal();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nonlocalValue = jsonParser.readValueAs(Nonlocal.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNonlocal");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNonlocal> {
        @Override
        public void serialize(UnionNonlocal obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nonlocalValue != null) {
                jsonGenerator.writeObject(obj.nonlocalValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
