namespace ms.common1;
using { cuid,Currency,managed,temporal,sap  } from '@sap/cds/common';



type Gender : String(1) enum {
    male = 'M';
    female = 'F';
    noDescribe = 'N';
    transGender = 'T';
    selDescribe = 'S';
   
};

 type AmountT : Decimal(15,2)@(
    Semantic.amount.currencyCode :'CURRENCY_CODE'
    
 );
 
 abstract entity Amount1 {
        GROSS_AMOUNT    : AmountT;	
        NET_AMOUNT	    : AmountT;
        TAX_AMOUNT	    : AmountT;
        CURRENCY_CODE	: String(4);
};



type PhoneNumber : String(20)@assert.format : '/^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}/' ;
type Email : String(128)@assert.format : '[a-z0-9]+@[a-z]+\.[a-z]{2,3}';


