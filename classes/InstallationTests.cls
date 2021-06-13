/* 
 * This class can be safely deleted from your org. 
 * It was only used to ensure 100% test coverage
 * for the managed package installation.
 */

@IsTest
private class InstallationTests {

    @testSetup
    static void setupData() {

		Account testAcct = new Account();
        testAcct.name = 'Test Account';
        testAcct.type = 'Customer - Direct';
        insert testAcct;
        
        Opportunity testOpp = new Opportunity(); 
        testOpp.name = 'Test Opportunity';
        testOpp.AccountId = testAcct.id;
        testOpp.type = 'New Project';
        testOpp.CloseDate = system.today();
        testOpp.StageName = 'Negotiation/Review';
        testOpp.Amount = 500000;
        insert testOpp;
        
        ServiceTokens__c st = new ServiceTokens__c();
        st.Name = 'ProjectServiceToken';
        st.Token__c = '2345';
        insert st;
    }

    //Test empty trigger stub
    static testmethod void testProjectTrigger() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Project__c p = new Project__c();
        p.Opportunity__c = opp.Id;
        insert p;
    }
    
    //Test empty service stub
	static testmethod void testProjectCalloutServiceForInstall() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        List<Id> oppIds = new List<Id>();
        oppIds.add(opp.Id);
	    ProjectCalloutService.postOpportunityToPMS(oppIds);
	}

}