package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNoexcept.Deserializer.class)
@JsonSerialize(using = UnionNoexcept.Serializer.class)
public class UnionNoexcept {
    public Double doubleValue;
    public Noexcept noexceptValue;

    static class Deserializer extends JsonDeserializer<UnionNoexcept> {
        @Override
        public UnionNoexcept deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNoexcept value = new UnionNoexcept();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.noexceptValue = jsonParser.readValueAs(Noexcept.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNoexcept");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNoexcept> {
        @Override
        public void serialize(UnionNoexcept obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.noexceptValue != null) {
                jsonGenerator.writeObject(obj.noexceptValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
