const cds = require('@sap/cds');

class CatalogService extends cds.ApplicationService{
    init(){
        const { Books } = this.entities;
        this.after('READ', Books , this.grantDiscount);
        return super.init();
    }


grantDiscount(req) {
     for(let b of req){
        if(b.stock > 200) {
            b.title += '--58% İndirim'
        }
     }
}
}

module.exports = CatalogService;