const cds = require('@sap/cds');
const { UPDATE, SELECT } = require('@sap/cds/lib/ql/cds-ql');

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

async reduceStock(req){
    const { Books } = this.entities;
    const { book , quantity} = req.data;

    if(quantity < 1){
        return req.error('en az 1 miktar olmalı');
    }
    
    const b = await SELECT.one.from(Books).where({ID:book}).columns(b=> {b.stock});
    if(!b){
        return req.error(`${book}idli kitap mevcut değil`);
    }
    let { stock } = b;
    if(quantity > stock){
        return req.error(`${quantity} miktar stoğu aşıyor`)
    }
    await UPDATE(Books).where({ID:book}).with({stock: { '-=':quantity}});
    return {stock:stock - quantity};
}
}

module.exports = CatalogService;