


using { ms.db.master, ms.db.transaction  } from '../db/datamodel';

service CatalogService@(path:'/CatalogService') {
    entity EmployeeSet as projection on master.employee;
    entity AdressSet as projection on master.adress;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity ProdTestSet as projection on master.prodtext;
    entity ProductSet as projection on master.product;
     entity adSet as projection on master.ad;
      entity bpaSet as projection on master.bpa;
       entity pdSet as projection on master.pd;
        // entity poSet as projection on transaction.po;
        //  entity poiSet as projection on transaction.poi;

    entity PurchaseOrderSet as projection on transaction.purchaseorder;

    
    entity PoItemsSet as projection on transaction.poitems;
      
    entity POs @(
      title : 'Po Header',
      
    ) as projection on transaction.po {
                         *,
                         round(GROSS_AMOUNT,2) as GROSS_AMOUNT : Decimal(15,2),
                         case LIFECYCLE_STATUS
                            when 'P' then 'Paid'
                            when 'N' then 'New'
                            when 'D' then 'Delivered'
                            when ' ' then 'Pending'
                            end as LIFECYCLE_STATUS: String(20),
                          case LIFECYCLE_STATUS
                            when 'P' then 2
                            when 'N' then 1
                            when  'D' then 3
                            when ' ' then 4 
                            end as Criticality: Integer,
                         toitems: redirected to POitems
                         }actions{
                           function largestOrder() returns array of POs;
                           action boost();
                           
                         };

                   
    entity POitems as projection on transaction.poi{
        *,
      PARENT_KEY: redirected to POs,
      PRODUCT_GUID: redirected to pdSet
    };
    // annotate POs with {
    //   GROSS_AMOUNT @title : '{i18n>g_Amount}'
    // };
    annotate POs with{
        NODE_KEY @title : '{i18n>NODE_KEY}';
        PO_ID  @title : '{i18n>PO_ID}';
        NOTE_GUID  @title : '{i18n>NOTE_GUID}';
        PARTNER_GUID  @title : '{i18n>PARTNER_GUID}';
        CURRENCY_CODE  @title : '{i18n>CURRENCY_CODE}';
        GROSS_AMOUNT  @title : '{i18n>GROSS_AMOUNT}';
        NET_AMOUNT  @title : '{i18n>NET_AMOUNT}';
        TAX_AMOUNT  @title : '{i18n>TAX_AMOUNT}'

        
};

}