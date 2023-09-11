using CatalogService as service from '../../srv/CatelogService';
annotate service.POs with @(
    UI:{
        SelectionFields  : [
        
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        CURRENCY_CODE,
        LIFECYCLE_STATUS
    
        ],
        
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'NODE_KEY',
            Value : NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Label : 'PO_ID',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Country',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Company Name',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type:'UI.DataField',
            Label : 'Gross Amount',
            Value: GROSS_AMOUNT
        },
        {
           $Type: 'UI.DataFieldForAction' ,
           Label : 'Booster',
           Action: 'CatalogService.boost',
           Inline:true
        },
        {
            $Type : 'UI.DataField',
            Label : 'Note',
            Value : NOTE
        },
        {
            $Type : 'UI.DataField',
            Label : 'CURRENCY_CODE',
            Value : CURRENCY_CODE,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Life Cycle Status',
            Value : LIFECYCLE_STATUS,
            Criticality: Criticality
        },
        {
            $Type : 'UI.DataField',
            Label : 'Invoice Status',
            Value : INVOICING_STATUS
        },
        {
            $Type  : 'UI.DataField',
            Label  : 'Order Status',
            Value : ORDERING_STATUS 

        }
    ]
);
annotate service.POs with @(
     UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type: 'UI.ReferenceFacet',
           
            Label : 'Purchase Order Items',
            Target  : 'toitems/@UI.LineItem'
        }
    ],
    UI.HeaderInfo:{
        $Type : 'UI.HeaderInfoType',
        TypeName: 'PURCHASE ORDER',
        TypeNamePlural: 'PURCHASE ORDERS',
        Title:{
            Label: 'POID',
            Value: PO_ID
        },
        Description:{
            Label: 'DESCRIPTION',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        ImageUrl: 'https://drive.google.com/file/d/1Z4qT1ALg-lJN_IS5pfptW4gqk_VRw0xt/view?usp=drive_link',
    },
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'NODE_KEY',
                Value : NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PO_ID',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NOTE_GUID',
                Value : NOTE_GUID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'COMPANY NAME',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CURRENCY_CODE',
                Value : CURRENCY_CODE,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NET_AMOUNT',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'TAX_AMOUNT',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NOTE',
                Value : NOTE,
            },
             {
            $Type : 'UI.DataField',
            Label : 'Life Cycle Status',
            Value : LIFECYCLE_STATUS
        },
        {
            $Type : 'UI.DataField',
            Label : 'Invoice Status',
            Value : INVOICING_STATUS
        },
        {
            $Type  : 'UI.DataField',
            Label  : 'Order Status',
            Value : ORDERING_STATUS 

        }
        ],
    },
   
);
annotate service.POitems with @(
    UI:{
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_IDcd,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_CODE,
            },
            {
                $Type : 'UI.DataField',
                Value : PARENT_KEY.PARTNER_GUID.COMPANY_NAME,
            },{
                $Type : 'UI.DataField',
                Value : PARENT_KEY.PARTNER_GUID.ADDRESS_GUID.CITY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.BP_ROLE,
            },{
                $Type : 'UI.DataField',
                Value : PARENT_KEY.ORDERING_STATUS,
                Criticality: PARENT_KEY.Criticality
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PoItem_LineItem',
            TypeNamePlural : 'PoItem_LineItems',
            Title:{
                $Type: 'UI.DataField',
                Value: PARENT_KEY.PO_ID
            },
            Description:{
                   $Type : 'UI.DataField',
                   Value: PARENT_KEY.PARTNER_GUID.COMPANY_NAME 
            }
        },
        Facets  : [
            {
                Label:'PoI LineItem',
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#LineItemHead'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Target : ''
            }
        ],
        FieldGroup#LineItemHead  : {
            $Type : 'UI.FieldGroupType',
            Data :[
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID_NODE_KEY ,
                    Label : 'ProductGuid'
                },{
                    $Type : 'UI.DataField',
                    Value : PO_ITEM_POS,
                    Label : 'Po_Item'
                },{
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                    Label  : 'GrossAmount' 
                },{
                    $Type : 'UI.DataField',
                    Value :CURRENCY_CODE,
                    Label : 'CurrencyCode'
                },
            ]
            
        },
    }
);
annotate service.ProductSet with @(
        UI:{
            FieldGroup  : {
                $Type : 'UI.FieldGroupType',
                Data: [
                    {
                        $Type : 'UI.DataField',
                        Value : PRODUCT_ID,
                        Label : 'ProductId'
                    },{
                        $Type : 'UI.DataField',
                        Value : CATEGORY,
                    },{
                        $Type : 'UI.DataField',
                        Value : PRICE,
                    },{
                        $Type : 'UI.DataField',
                        Value : CURRENCY_CODE,
                    },{
                        $Type : 'UI.DataField',
                        Value : SUPPLIER_GUID,
                    },{
                        $Type : 'UI.DataField',
                        Value : CREATED_BY,
                    },
                ]
            },
        }
) ;
