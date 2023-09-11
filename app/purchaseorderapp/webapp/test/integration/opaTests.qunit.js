sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ms/app/purchaseorderapp/test/integration/FirstJourney',
		'ms/app/purchaseorderapp/test/integration/pages/POsList',
		'ms/app/purchaseorderapp/test/integration/pages/POsObjectPage',
		'ms/app/purchaseorderapp/test/integration/pages/POitemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POitemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ms/app/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOitemsObjectPage: POitemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);