const cds = require('@sap/cds');

class CatalogService extends cds.ApplicationService{
    init(){
        const { Books } = this.entities;
        this.after('READ', Books , this.grantDiscount);


        this.on('submitOrder',this.reduceStock)
        return super.init();
    }


grantDiscount(req) {
     for(let b of req){
        if(b.stock > 200) {
            b.title += '--58% İndirim'
        }
     }
}

reduceStock(req){
    const { Books } = this.entities;
    const { book , quantity} = req.data;

    if(quantity < 1){
        return req.error('en az 1 miktar olmalı');
    }
    let stock = 10;
    return { stock };
}
}

module.exports = CatalogService;