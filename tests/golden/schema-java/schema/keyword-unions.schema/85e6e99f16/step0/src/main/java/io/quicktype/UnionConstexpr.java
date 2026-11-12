package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionConstexpr.Deserializer.class)
@JsonSerialize(using = UnionConstexpr.Serializer.class)
public class UnionConstexpr {
    public Double doubleValue;
    public Constexpr constexprValue;

    static class Deserializer extends JsonDeserializer<UnionConstexpr> {
        @Override
        public UnionConstexpr deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionConstexpr value = new UnionConstexpr();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.constexprValue = jsonParser.readValueAs(Constexpr.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionConstexpr");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionConstexpr> {
        @Override
        public void serialize(UnionConstexpr obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.constexprValue != null) {
                jsonGenerator.writeObject(obj.constexprValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
