package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJenc.Deserializer.class)
@JsonSerialize(using = UnionJenc.Serializer.class)
public class UnionJenc {
    public Double doubleValue;
    public Jenc jencValue;

    static class Deserializer extends JsonDeserializer<UnionJenc> {
        @Override
        public UnionJenc deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJenc value = new UnionJenc();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jencValue = jsonParser.readValueAs(Jenc.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJenc");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJenc> {
        @Override
        public void serialize(UnionJenc obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jencValue != null) {
                jsonGenerator.writeObject(obj.jencValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
