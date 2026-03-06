const cds = require('@sap/cds');

class AdminService extends cds.ApplicationService{
    init(){
        const { Authors } = this.entities;
        this.before(['CREATE','UPDATE'], Authors,this.validateLifeData);
        return super.init();
    }


validateLifeData(req) {
    const { dateOfBirth , dateofDeath } = req.data;
    if(!dateOfBirth || dateofDeath){
        return;
    }

    const birth = new Date(dateOfBirth);
    const dead = new Date(dateofDeath);

    if(dead < birth){
        req.error('Ölüm tarihi daoğum tarihinden önce olamaz');
    }
}
}

module.exports = AdminService;