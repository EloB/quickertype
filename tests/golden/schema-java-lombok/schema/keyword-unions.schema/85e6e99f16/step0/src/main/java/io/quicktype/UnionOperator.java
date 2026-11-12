package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionOperator.Deserializer.class)
@JsonSerialize(using = UnionOperator.Serializer.class)
public class UnionOperator {
    public Double doubleValue;
    public Operator operatorValue;

    static class Deserializer extends JsonDeserializer<UnionOperator> {
        @Override
        public UnionOperator deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionOperator value = new UnionOperator();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.operatorValue = jsonParser.readValueAs(Operator.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionOperator");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionOperator> {
        @Override
        public void serialize(UnionOperator obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.operatorValue != null) {
                jsonGenerator.writeObject(obj.operatorValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
