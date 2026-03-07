using {
    cuid,
    managed
} from '@sap/cds/common';

namespace tutorial.db;

/**
 * Books Entity: Kitap ana verilerini tutar.
 * : cuid -> Sistemin her kitaba otomatik benzersiz bir ID (UUID) atamasını sağlar.
 * : managed -> Kaydın ne zaman oluşturulduğu ve kimin değiştirdiği bilgilerini (createdAt, createdBy vb.) otomatik tutar.
 */
entity Books : cuid, managed {
    Title       : String; // Kitabın başlığı

    /** * Association (İlişkilendirme):
     * Yazar ile kitap arasında "gevşek" bir bağ kurar.
     * Bir kitap silindiğinde yazar silinmez. Sadece yazara bir referans (link) tutar.
     */
    author      : Association to Authors;

    /** * Composition of many (Bileşim - Çoklu):
     * Kitap ile bölümler arasında "sıkı" bir bağ kurar.
     * 'of many' ifadesi, bir kitabın BİRDEN FAZLA bölümü olabileceğini belirtir.
     * Kitap silindiğinde ona bağlı tüm bölümler de sistemden otomatik silinir (Cascade Delete).
     */
    genre       : String;
    publishedAt : Date;
    pages       : Integer;
    price       : Decimal(9, 2);
    Chapters    : Composition of many Chapters
                      on Chapters.book = $self; // Bu bölümün 'bu kitaba' ait olduğunu doğrular.
}

/**
 * Authors Entity: Yazarların ana verilerini tutar.
 */
entity Authors : cuid, managed {
    name  : String;

    /** * Association to many:
     * Bir yazarın birden fazla kitabı olabilir.
     * 'to many' burada bir koleksiyon (dizi) yapısı oluşturur.
     */
    books : Association to many Books
                on books.author = $self; // Kitap tablosundaki 'author'  alanı ile eşleşir.
}

/**
 * Chapters Entity: Kitaplara ait bölümleri tutar.
 */
entity Chapters : cuid, managed {
    key book   : Association to Books;

        /** * Back-link Association:
         * Bu bölümün hangi kitaba ait olduğunu belirten anahtar alan.
         * 'key' olarak tanımlanması, veri tabanı seviyesinde bu ilişkinin
         * bu tablonun kimliği için kritik olduğunu gösterir.
         */
        number : Integer; // Bölüm numarası (Örn: 1, 2, 3...)
        pages  : Integer;

}
