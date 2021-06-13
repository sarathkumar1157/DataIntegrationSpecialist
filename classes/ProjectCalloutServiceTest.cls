@isTest
private class ProjectCalloutServiceTest {
    //Implement mock callout tests here
    @testSetup static void oppTestData()
    {
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Opportunity opp = new Opportunity(Name='Test Opp',StageName='Closed Won',AccountId=acc.Id,CloseDate=System.today(),Amount=100);
        insert opp;
        
        ServiceTokens__c st = new ServiceTokens__c();
        st.Name = 'ProjectServiceToken';
        st.Token__c = '2345';
        insert st;
    }
    @isTest static void postOpportunityToPMSSuccessTest()
    {
        List<Id> oppIds = new List<Id>();
        for(Opportunity opp : [Select Id from Opportunity limit 1])
            oppIds.add(opp.Id);
        
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(oppIds);
        Test.stopTest();
        Opportunity opp = [select StageName from Opportunity where id =: oppIds[0]];
      	System.assertEquals('Closed Won',opp.StageName);
    }
    @isTest static void postOpportunityToPMSFailureTest()
    {
        List<Id> oppIds = new List<Id>();
        for(Opportunity opp : [Select Id from Opportunity limit 1])
            oppIds.add(opp.Id);
        
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(oppIds);
        Test.stopTest();
        Opportunity opp = [select StageName from Opportunity where id =: oppIds[0]];
      	System.assertEquals('Closed Won',opp.StageName);
    }
}