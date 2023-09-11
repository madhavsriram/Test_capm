using { ms.db.master  } from '../db/datamodel';

service mysrvdemo {
    function msfunction(msg:String) returns String ;
    
   @readonly
    entity GetEmployee as projection on master.employee;
    @insertonly
    entity CreateEmployee as projection on master.employee;
    @updateonly
    entity UpdateEmployee as projection on master.employee;
    @deleteonly
    entity DeleteEmployee as projection on master.employee;
}

service mstestsrv {

function mstextfn() returns Int16;

}