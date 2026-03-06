using com.sap.learning as db from '../db/schema';

service CatalogService @(path:'/cat') { // Boşluğu sildik
    entity Authors as projection on db.Authors {
        *,
        epoch.name as period
    } excluding {
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    };

    entity Books as projection on db.Books {
        ID,
        title,
        author.name as writer,
        publCountry,
        isHardcover,
        price.amount,
        price.currency.code, // Currency bir association olduğu için .code ekledik
        stock,
        author
    };
}