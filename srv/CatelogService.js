module.exports = cds.service.impl(async function () {
    const {
        POs 
    }= this.entities;

    this.on('largestOrder', async req => {
        try {
           const ID = req.params[0];
           console.log("requested data id is --> " + ID);
           const tx = cds.tx(req);
          const reply = await tx.read(POs).orderBy({
            GROSS_AMOUNT: 'desc'
           }).limit(1) ;

           return reply;
        } catch (error) {
            return "Error" + error.toString();
        }
    });
    this.on('boost', async req => {
        try {
            const ID = req.params[0];
            console.log("requested data id is " + ID + "will be boosted");
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT : { '+=' : 20000 }, NOTE : 'Boosted By User!'
            }).where(ID);
            return{};
        } catch (error) {
            return  "Error" + error.toString();
        }
    });
});