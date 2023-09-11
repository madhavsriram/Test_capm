namespace ms.db;


using { ms.db.transaction , ms.db.master  } from './datamodel';

context CDSView {
    define view![POworklist] as 
    select from transaction.po{
        key NODE_KEY as ![nodeKey],
            PO_ID as ![PurchaseOrderId],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            PARTNER_GUID.BP_ID as ![PartnerId],
            GROSS_AMOUNT as ![POGrossAmount],
            CURRENCY_CODE as ![POCurrency],
             LIFECYCLE_STATUS as ![LIFECYCLE_STATUS],
           ORDERING_STATUS  as ![ORDERING_STATUS],
            INVOICING_STATUS as ![INVOICING_STATUS],
            
        key toitems.PO_ITEM_POS as ![Itemsposition],
            toitems.PRODUCT_GUID.PRODUCT_ID as ![ProductId],
            toitems.PRODUCT_GUID.DESC_GUID as ![DesGuid],
            PARTNER_GUID.BP_ROLE as ![BpRole],
            PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
            PARTNER_GUID.ADDRESS_GUID as ![addGuid],
            // PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![COUNTRY],
            PARTNER_GUID.ADDRESS_GUID.STREET as ![Street],
            toitems.NET_AMOUNT as ![ItemsNetAmount],
            toitems.GROSS_AMOUNT as ![ItemsGrossAmount],
            toitems.CURRENCY_CODE as ![ItemsCurrency]
    };

    define view ProductValueHelp as 
    select from master.pd{
        @EndUserText.label:[
            {
                language:'EN',
                text: 'Product ID'
            },
            {
                language:'DE',
                text: 'Produkt Id'
            }
        ]
        PRODUCT_ID as ![ProductId],
        @EndUserText.label:[
            {
                language:'EN',
                text: 'ProductGuid'
            },
            {
                language:'DE',
                text: 'Produkt guid'
            }
        ]
        DESC_GUID as ![DesGuid]
    };

    define view ![ItemView] as 
    select from transaction.poi{
        PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Partner],
        PRODUCT_GUID.NODE_KEY AS ![ProductId],
        CURRENCY_CODE as ![CurrencyCode],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        PARENT_KEY.PO_ID as ![PurchaseOrderId]

    };

    define view![ProductViewSub] as 
    select from master.pd as prod{
        PRODUCT_ID as ![ProductId],
        CATEGORY as ![Category],
        (
            select from transaction.poi as a{
                SUM(a.GROSS_AMOUNT) as sum
            }
            where a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
        )as PO_SUM :Decimal(15,2)
    };

    define view ProductView as select from master.pd
     mixin{
        PO_ORDERS: Association to ItemView on
                            PO_ORDERS.ProductId = $projection.ProductId
     }
     into{
        NODE_KEY as ![ProductId],
        DESC_GUID ,
        CATEGORY as ![Category],
        PRICE as ![Price],
        TYPE_CODE as ![TypeCode],
        SUPPLIER_GUID.BP_ID as ![BpId],
        SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
        SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
        SUPPLIER_GUID.ADDRESS_GUID.STREET as ![Street],
        PO_ORDERS

     };

     define view CProductValuesView as 
        select from ProductView{
            ProductId,
            Category,
            CompanyName,
            City,
            Country,
            PO_ORDERS.CurrencyCode as ![CurrencyCode],
            sum(PO_ORDERS.GrossAmount) as ![POGrossAmount] : Decimal(15,2)
        }group by ProductId,Category,CompanyName,City,Country,PO_ORDERS.CurrencyCode
}
