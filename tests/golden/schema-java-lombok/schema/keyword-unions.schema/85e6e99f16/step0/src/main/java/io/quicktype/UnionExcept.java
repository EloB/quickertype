package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionExcept.Deserializer.class)
@JsonSerialize(using = UnionExcept.Serializer.class)
public class UnionExcept {
    public Double doubleValue;
    public Except exceptValue;

    static class Deserializer extends JsonDeserializer<UnionExcept> {
        @Override
        public UnionExcept deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionExcept value = new UnionExcept();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.exceptValue = jsonParser.readValueAs(Except.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionExcept");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionExcept> {
        @Override
        public void serialize(UnionExcept obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.exceptValue != null) {
                jsonGenerator.writeObject(obj.exceptValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
