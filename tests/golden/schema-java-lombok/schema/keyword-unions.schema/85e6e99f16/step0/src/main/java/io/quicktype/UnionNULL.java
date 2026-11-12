package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionNULL.Deserializer.class)
@JsonSerialize(using = UnionNULL.Serializer.class)
public class UnionNULL {
    public Double doubleValue;
    public Null nullValue;

    static class Deserializer extends JsonDeserializer<UnionNULL> {
        @Override
        public UnionNULL deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionNULL value = new UnionNULL();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.nullValue = jsonParser.readValueAs(Null.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionNULL");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionNULL> {
        @Override
        public void serialize(UnionNULL obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.nullValue != null) {
                jsonGenerator.writeObject(obj.nullValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
