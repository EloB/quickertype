package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionComplex.Deserializer.class)
@JsonSerialize(using = UnionComplex.Serializer.class)
public class UnionComplex {
    public Double doubleValue;
    public Complex complexValue;

    static class Deserializer extends JsonDeserializer<UnionComplex> {
        @Override
        public UnionComplex deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionComplex value = new UnionComplex();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.complexValue = jsonParser.readValueAs(Complex.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionComplex");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionComplex> {
        @Override
        public void serialize(UnionComplex obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.complexValue != null) {
                jsonGenerator.writeObject(obj.complexValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
