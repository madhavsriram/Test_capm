const cds = require("@sap/cds");
const { employee } = cds.entities("ms.db.master");
const mysrvdemo =  function(srv){
    srv.on("msfunction", (req,res) => {
        return "Hey  " + req.data.msg;
    });
    srv.on("READ","GetEmployee", async (req,res) =>{
            var oEmp = [];
                // oEmp.push({
                //     "ID": "00014b17-b846-4484-884e-fa62481b4d37",
                //     "UserId": 1082,
                //     "FirstName": "Andris",
                //     "LastName": "Kloss",cd
                //     "Salary": 3433.43
                    
                // });
            //  oEmp =   await cds.tx(req).run(SELECT.from(employee).limit(3))
            // oEmp = await cds.tx(req).run(SELECT.from`employee`.where`ID=003568e0-26cb-4994-99f1-3cd993d25680`)
            oEmp = await cds.tx(req).run(SELECT.from(employee).where({"FirstName":"Willi"}))
            console.log("iam at getemployee");
            return oEmp;
    });
    srv.on("CreateEmployee", async (req,res) => {
                var oEmp = [];

                     oEmp.push({
                    "ID": "00014b17-b846-4484-884e-fa62481b4d37",
                    "UserId": 1082,
                    "FirstName": "Andris",
                    "LastName": "Kloss",
                    "Salary": 3433.43
                    
                });  
                return oEmp;
    });
    srv.on("UPDATE","UpdateEmployee", async (req,res) =>{

    });
    srv.on("DELETE","DeleteEmployee", async (req,res) =>{

    })

}
const mstestsrv = function(srv1){
    srv1.on("mstextfn",(req,res) => {
        return 1234566;
    })
        
}
module.exports = mysrvdemo ;
module.exports = mstestsrv ;