package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJpipe.Deserializer.class)
@JsonSerialize(using = UnionJpipe.Serializer.class)
public class UnionJpipe {
    public Double doubleValue;
    public Jpipe jpipeValue;

    static class Deserializer extends JsonDeserializer<UnionJpipe> {
        @Override
        public UnionJpipe deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJpipe value = new UnionJpipe();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jpipeValue = jsonParser.readValueAs(Jpipe.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJpipe");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJpipe> {
        @Override
        public void serialize(UnionJpipe obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jpipeValue != null) {
                jsonGenerator.writeObject(obj.jpipeValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
