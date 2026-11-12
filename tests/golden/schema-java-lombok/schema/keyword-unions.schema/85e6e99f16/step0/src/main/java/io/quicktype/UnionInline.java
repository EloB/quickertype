package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.core.type.*;

@JsonDeserialize(using = UnionInline.Deserializer.class)
@JsonSerialize(using = UnionInline.Serializer.class)
public class UnionInline {
    public Double doubleValue;
    public Inline inlineValue;

    static class Deserializer extends JsonDeserializer<UnionInline> {
        @Override
        public UnionInline deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            UnionInline value = new UnionInline();
            switch (jsonParser.currentToken()) {
                case VALUE_NULL:
                    break;
                case VALUE_NUMBER_INT:
                case VALUE_NUMBER_FLOAT:
                    value.doubleValue = jsonParser.readValueAs(Double.class);
                    break;
                case START_OBJECT:
                    value.inlineValue = jsonParser.readValueAs(Inline.class);
                    break;
                default: throw new IOException("Cannot deserialize UnionInline");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<UnionInline> {
        @Override
        public void serialize(UnionInline obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.doubleValue != null) {
                jsonGenerator.writeObject(obj.doubleValue);
                return;
            }
            if (obj.inlineValue != null) {
                jsonGenerator.writeObject(obj.inlineValue);
                return;
            }
            jsonGenerator.writeNull();
        }
    }
}
