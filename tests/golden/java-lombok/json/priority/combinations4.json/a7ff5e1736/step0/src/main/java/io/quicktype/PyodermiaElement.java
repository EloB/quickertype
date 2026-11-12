package io.quicktype;

import java.io.IOException;
import java.io.IOException;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;

@JsonDeserialize(using = PyodermiaElement.Deserializer.class)
@JsonSerialize(using = PyodermiaElement.Serializer.class)
public class PyodermiaElement {
    public PyodermiaClass pyodermiaClassValue;
    public Long integerValue;

    static class Deserializer extends JsonDeserializer<PyodermiaElement> {
        @Override
        public PyodermiaElement deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
            PyodermiaElement value = new PyodermiaElement();
            switch (jsonParser.currentToken()) {
                case VALUE_NUMBER_INT:
                    value.integerValue = jsonParser.readValueAs(Long.class);
                    break;
                case START_OBJECT:
                    value.pyodermiaClassValue = jsonParser.readValueAs(PyodermiaClass.class);
                    break;
                default: throw new IOException("Cannot deserialize PyodermiaElement");
            }
            return value;
        }
    }

    static class Serializer extends JsonSerializer<PyodermiaElement> {
        @Override
        public void serialize(PyodermiaElement obj, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
            if (obj.pyodermiaClassValue != null) {
                jsonGenerator.writeObject(obj.pyodermiaClassValue);
                return;
            }
            if (obj.integerValue != null) {
                jsonGenerator.writeObject(obj.integerValue);
                return;
            }
            throw new IOException("PyodermiaElement must not be null");
        }
    }
}
