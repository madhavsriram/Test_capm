namespace ms.db;
using { cuid , managed, Currency, temporal  } from '@sap/cds/common';
using { ms.common1 } from './common1';



// const Guid = String(32);
type Guid : String(32);
type Curr : Decimal(15,2);
context master {
    entity ad  {
      key  NODE_KEY	: Guid;
        CITY	: String(64);
        POSTAL_CODE	: String(10);
        STREET	: String(128);
        BUILDING : String(12);	
        COUNTRY	 : String(4);
        ADDRESS_TYPE : Integer;
        TOBPA: Association to many master.bpa on TOBPA.ADDRESS_GUID = $self;
    };
    entity bpa{
      key  NODE_KEY	: Guid;
        BP_ROLE	: Integer;
        PHONE_NUMBER : common1.PhoneNumber;	
        ADDRESS_GUID : Association to master.ad;	
        BP_ID	:Int16;
        COMPANY_NAME : String(128);
         APPROVAL_STATUS: String(12);
        CURRENCY_CODE :String(4);
    
    };
    entity pd{
       key NODE_KEY	: Guid;
        PRODUCT_ID	:String(16);
        TYPE_CODE	: String(4);
        CATEGORY	: String(256);
        NAME_GUID	: Guid;
        DESC_GUID	: Guid;
        SUPPLIER_GUID	: Association to master.bpa;
        CURRENCY_CODE	: String(4);
        PRICE   : common1.AmountT;
        
    };
    
    entity businesspartner {
        key NODE_KEY : Guid;
            BP_ROLE : String(2);
            EMAIL_ADDRESS: common1.Email;
            PHONE_NUMBER : common1.PhoneNumber;
            FAX_NUMBER : common1.PhoneNumber;
            WEB_ADDRESS : String(120);
            ADDRESS_GUID : Association to adress;
            BP_ID : String(18);
            COMPANY_NAME : String(120);


    };

    entity adress {
        key NODE_KEY: Guid;
        CITY : String(64);
        POSTAL_CODE: String(14);
        COUNTRY: String(14);
        businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self; 
    };

    entity employee : cuid , managed {
            UserId: Int16;	
            FirstName : String(32);	
            LastName   : String(32); 
            Salary	: common1.AmountT;
            Active   : Boolean
    };

    entity prodtext {
    key    NODE_KEY	: Guid;
        PARENT_KEY	: Guid;
        LANGUAGE	: String(1);
        TEXT        :String(256);
        // product : Association to many master.product on product.DESC_GUID = $self; 
    };

    entity product :managed{
       key  NODE_KEY : Guid;
            PRODUCT_ID : String(16);	
            CATEGORY	: String(256);
            CREATED_BY	: Guid;
            CREATED_AT	: String(128);
            CHANGED_BY	: Guid;
            CHANGED_AT	: String(128);
            NAME_GUID	: Guid;
            DESC_GUID	: Guid;
            SUPPLIER_GUID	: Guid ;
        
            CURRENCY_CODE	: String(4);
            PRICE           : common1.AmountT
    }


}

context transaction {

    entity po{
        
    key    NODE_KEY	: Guid;
        PO_ID	:String(16);
        NOTE_GUID	: Guid;
        PARTNER_GUID	: Association to master.bpa;
        CURRENCY_CODE	: String(4);
        GROSS_AMOUNT	: common1.AmountT;
        NET_AMOUNT	    : common1.AmountT;
        TAX_AMOUNT      : common1.AmountT;
        LIFECYCLE_STATUS : String(1);
        ORDERING_STATUS : String(1);
        INVOICING_STATUS : String(1);
        toitems : Composition of   many transaction.poi on toitems.PARENT_KEY = $self;
        NOTE : String(256);


    };
    entity poi{
      key  NODE_KEY : Guid;	
        PARENT_KEY	: Association to po;
        PO_ITEM_POS	: Integer;
        PRODUCT_GUID	: Association to master.pd;
        NOTE_GUID	: Guid;
        CURRENCY_CODE	: String(4);
        GROSS_AMOUNT	: common1.AmountT;
        NET_AMOUNT	    : common1.AmountT;
        TAX_AMOUNT      : common1.AmountT;
    };

    entity purchaseorder : common1.Amount1 ,managed {
     KEY  NODE_KEY	: Guid;
        SO_GUID	    : Guid;
        DLY_NOTE_NUMBER	: Int16;
        CREATED_BY	: Guid;
        CREATED_AT	: String(32);
        CHANGED_BY	: String(32);
        CHANGED_AT	: String(32);
        
        BUYER_GUID	    : Guid;
        PAYMENT_STATUS  : String(1);
        items : Association to many transaction.poitems on items.PARENT_KEY =$self  ;
        // poitems : Association to many transaction.poitems on poitems.PARENT_KEY ;
    }  ;
    annotate purchaseorder with{
        NODE_KEY @title : '{i18n>n_key}';
        SO_GUID @title : '{i18n>so_key}';
        BUYER_GUID @title : '{i18n>b_guid}';
    } ;
    annotate poitems with{
        PARENT_KEY @title : '{i18n>p_key}';
        SO_ITEM_GUID @title : '{i18n>so_item_guid}';
    } ;
    
    entity poitems : common1.Amount1 , managed {
    key NODE_KEY	: Guid;
        PARENT_KEY	: Association to transaction.purchaseorder;
        SO_ITEM_GUID : Guid;	
        QUANTITY	: Int16;
        QUANTITY_UNIT	: String(4);
       
        PRODUCT_GUID	: Guid;
        INV_ITEM_POS  : Integer;
          toPO : Association to one purchaseorder on toPO.NODE_KEY;

      };
}