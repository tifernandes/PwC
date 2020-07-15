public class MovieCallout {
    @AuraEnabled
    public static String retrievePoster(Id recordId){
        Filme__c getPoster = [Select Poster__c FROM Filme__c WHERE id = :recordId];
        return getPoster.Poster__c;
    }
    
    @future (callout=true)
    public static void movieGet(Set<id> setFilme) {
        Tmdb__mdt controller = [SELECT Token__c FROM Tmdb__mdt Limit 1];
        
        List<Filme__c> lstFilme = [SELECT id, Name, Nome_Filme__c, Filme_Desc__c FROM Filme__c WHERE Id IN :setFilme];
        
        for(Filme__c filme : lstFilme){
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.themoviedb.org/3/movie/'+filme.Name+'?api_key='+controller.Token__c+'&language=pt-BR&append_to_response=videos');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            
            if(response.getStatusCode() == 200){
                System.debug('teste '+response.getBody());
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                filme.Nome_Filme__c = String.valueOf(result.get('title'));
                filme.Filme_Desc__c = String.valueOf(result.get('overview')); 
                filme.Poster__c = String.valueOf(result.get('poster_path'));
                
                //percorre map até chave id do trailer
				map<String,Object> mapObjVideo = (map<String,Object>) result.get('videos');
                List<Object> lstVideo = (List<Object>) mapObjVideo.get('results');
                map<String,Object> ObjVideo = (map<String,Object>) lstVideo[0];
                String keyTrailer = (String) ObjVideo.get('key');
                
                filme.Trailer__c = keyTrailer;
                
                update filme;
            }
        }
    }
}