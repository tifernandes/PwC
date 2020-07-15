trigger Filmes_tgr on Filme__c (after insert) {
	MovieCallout.movieGet(trigger.newmap.keyset());
}