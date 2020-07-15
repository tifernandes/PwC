@isTest
global class MovieCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{  "adult": false,  "backdrop_path": "/y1cYrSJdVm7TOWRKeW4oQrmnFz1.jpg",  "belongs_to_collection": {    "id": 10,    "name": "Coleção Star Wars",    "poster_path": "/fI9R8fkW21fv0HDrwNnM3PZhgN.jpg",    "backdrop_path": "/d8duYyyC9J5T825Hg7grmaabfxQ.jpg"  },  "budget": 250000000,  "genres": [    {      "id": 28,      "name": "Ação"    },    {      "id": 12,      "name": "Aventura"    },    {      "id": 878,      "name": "Ficção científica"    }  ],  "homepage": "https://www.starwars.com/films/star-wars-episode-ix-the-rise-of-skywalker",  "id": 181812,  "imdb_id": "tt2527338",  "original_language": "en",  "original_title": "Star Wars: The Rise of Skywalker",  "overview": "Com o retorno do Imperador Palpatine, todos voltam a temer seu poder e, com isso, a Resistência toma a frente da batalha que ditará os rumos da galáxia. Treinando para ser uma completa Jedi, Rey (Daisy Ridley) ainda se encontra em conflito com seu passado e futuro, mas teme pelas respostas que pode conseguir a partir de sua complexa ligação com Kylo Ren (Adam Driver), que também se encontra em conflito pela Força.",  "popularity": 242.722,  "poster_path": "/lFx2i2pg1BoaD7grcpGDyHM1eML.jpg",  "production_companies": [    {      "id": 1,      "logo_path": "/o86DbpburjxrqAzEDhXZcyE8pDb.png",      "name": "Lucasfilm",      "origin_country": "US"    },    {      "id": 11461,      "logo_path": "/p9FoEt5shEKRWRKVIlvFaEmRnun.png",      "name": "Bad Robot",      "origin_country": "US"    },    {      "id": 2,      "logo_path": "/wdrCwmRnLFJhEoH8GSfymY85KHT.png",      "name": "Walt Disney Pictures",      "origin_country": "US"    }  ],  "production_countries": [    {      "iso_3166_1": "US",      "name": "United States of America"    }  ],  "release_date": "2019-12-18",  "revenue": 1073604458,  "runtime": 141,  "spoken_languages": [    {      "iso_639_1": "en",      "name": "English"    }  ],  "status": "Released",  "tagline": "Toda geração tem uma lenda",  "title": "Star Wars - A Ascensão Skywalker",  "video": false,  "vote_average": 6.5,  "vote_count": 3935}');
        response.setStatusCode(200);
        return response; 
    }
    
    @isTest static void testCallout() {
        Set<Id> setId = new Set<Id>();
        Filme__c filme = new Filme__c();
        	filme.Name = '181812';
        	insert filme;
        setId.add(filme.Id);
        
        Test.setMock(HttpCalloutMock.class, new MovieCalloutMock()); 
        Test.startTest();
        	MovieCallout.movieGet(setId);
        Test.stopTest();
        
        List<Filme__c> lstFilme = [SELECT Id from Filme__c WHERE id=: filme.id];
        System.assertEquals(1, lstFilme.size());
    }
}