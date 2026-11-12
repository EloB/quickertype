package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionJdec.Deserializer.class)
@JsonSerialize(using = UnionJdec.Serializer.class)
public class UnionJdec {
    public Double doubleValue;
    public Jdec jdecValue;

    static class Deserializer extends JsonDeserializer<UnionJdec> {
        @Override
        public UnionJdec deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionJdec value = new UnionJdec();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.jdecValue = jsonParser.readValueAs(Jdec.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionJdec");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionJdec> {
        @Override
        public void serialize(UnionJdec obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.jdecValue != null) {
                jsonGenerator.writeObject(obj.jdecValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
