package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionFileprivate.Deserializer.class)
@JsonSerialize(using = UnionFileprivate.Serializer.class)
public class UnionFileprivate {
    public Double doubleValue;
    public Fileprivate fileprivateValue;

    static class Deserializer extends JsonDeserializer<UnionFileprivate> {
        @Override
        public UnionFileprivate deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionFileprivate value = new UnionFileprivate();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.fileprivateValue = jsonParser.readValueAs(Fileprivate.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionFileprivate");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionFileprivate> {
        @Override
        public void serialize(UnionFileprivate obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.fileprivateValue != null) {
                jsonGenerator.writeObject(obj.fileprivateValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
