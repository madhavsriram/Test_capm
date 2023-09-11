using { ms.db.CDSView } from '../db/CDSView';

service CDSService@(path:'/CDSService') {

    entity POworklist as projection on CDSView.POworklist ;
    entity ProductOrders as projection on CDSView.ProductViewSub;
    entity ProductAggregation as projection on CDSView.CProductValuesView;

}
