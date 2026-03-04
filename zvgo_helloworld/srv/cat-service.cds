using my.bookshop as my from '../data/data-model';
//sing my.bookshop as my from '../data/data-model';
//Bu satır, ../data/data-model dosyasında tanımlanmış olan veri yapılarını (örneğin kitaplar, yazarlar)
// bu dosyada kullanmak üzere içeri aktarır.
// as my ifadesi, bu içeriğe kısa bir takma ad (alias) verir.

service MyService {
//Burada MyService adında bir OData servisi oluşturuluyor. CAP, bu tanıma dayanarak otomatik olarak bir uygulama katmanı oluşturur
    entity Books as projection on my.Books;
    //servisler veriye nasıl erişileceğini belirler. 
    //Bu ifade, veritabanındaki asıl Books tablosunun bir "yansımasını" veya "izdüşümünü" servis katmanında oluşturur.

}