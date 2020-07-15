({
	getPoster : function(component, event, helper) {
        var recId = component.get('v.recordId');
		var action = component.get('c.retrievePoster')
        action.setParams({ recordId: recId});
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log(state);
            
            if(state === 'SUCCESS'){
                var callReturn = response.getReturnValue();
                component.set('v.posterId', callReturn)
            }
        });
        $A.enqueueAction(action);
	}
})