codeunit 50109 GetAIAnalysis
{
    internal procedure GetSentiment(ReviewText: Text): Text
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        HttpHeader: HttpHeaders;
        JsonResponse: Text;
        JsonBody: Text;
        JObject: JsonObject;
        JArray: JsonArray;
        JToken: JsonToken;
        SentimentToken: JsonToken;
        Sentiment: Text;
        DocToken: JsonToken;
        DocObject: JsonObject;
    begin
        JsonBody := '{ "documents": [ { "language": "en", "id": "1", "text": "' + ReviewText + '" } ] }';

        RequestMessage.SetRequestUri('--- your API Endpoint here--- + text/analytics/v3.1/sentiment');
        RequestMessage.Method := 'POST';
        RequestMessage.Content().WriteFrom(JsonBody);
        RequestMessage.Content().GetHeaders(HttpHeader);
        HttpHeader.Remove('Content-Type'); // Ensure it's not duplicated
        HttpHeader.Add('Content-Type', 'application/json');
        HttpHeader.Add('Ocp-Apim-Subscription-Key', '---your API key here---');

        if Client.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content().ReadAs(JsonResponse);
            JObject.ReadFrom(JsonResponse);

            if JObject.Get('documents', JToken) then begin
                JArray := JToken.AsArray(); // JArray is properly initialized

                foreach DocToken in JArray do begin
                    DocObject := DocToken.AsObject();
                    if DocObject.Get('sentiment', SentimentToken) then begin
                        Sentiment := SentimentToken.AsValue().AsText();
                        break; // Exit after processing the first item
                    end;
                end;
            end;

            exit(Sentiment); // e.g. "positive", "neutral", "negative"
        end;

        exit('unknown');
    end;

    internal procedure GetKeyInformation(ReviewText: Text): Text
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        HttpHeader: HttpHeaders;
        JsonResponse: Text;
        JsonBody: Text;
        JObject: JsonObject;
        JArray: JsonArray;
        JToken: JsonToken;
        EntityToken: JsonToken;
        EntityObject: JsonObject;
        EntityNameToken: JsonToken;
        EntityList: Text;
    begin
        JsonBody := '{ "documents": [ { "language": "en", "id": "1", "text": "' + ReviewText + '" } ] }';

        RequestMessage.SetRequestUri('--- your API Endpoint here--- + text/analytics/v3.1/entities/recognition/general');
        RequestMessage.Method := 'POST';
        RequestMessage.Content().WriteFrom(JsonBody);
        RequestMessage.Content().GetHeaders(HttpHeader);
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/json');
        HttpHeader.Add('Ocp-Apim-Subscription-Key', '---your API key here---');

        if Client.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content().ReadAs(JsonResponse);
            JObject.ReadFrom(JsonResponse);

            if JObject.Get('documents', JToken) then begin
                JArray := JToken.AsArray();

                foreach JToken in JArray do begin
                    if JToken.AsObject().Get('entities', JToken) then begin
                        foreach EntityToken in JToken.AsArray() do begin
                            EntityObject := EntityToken.AsObject();
                            if EntityObject.Get('text', EntityNameToken) then begin
                                EntityList += EntityNameToken.AsValue().AsText() + '; ';
                            end;
                        end;
                    end;
                end;
                exit(EntityList);
            end else
                Error(Format(JsonResponse));
        end;

        exit('No key information was found.');
    end;
}