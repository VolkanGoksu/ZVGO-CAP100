using {
    AdminService.Authors,
    AdminService.Books
} from './admin-service';


annotate Books with @(restritc:[
    {
        grant:['DELETE'],
        to : 'admin',
        where : 'stock = 0'
    },
//Sadece 'admin' olmak yetmiyor. Sistemi öyle kurguluyoruz ki; admin bile olsa sadece stoğu 0 olan kitapları silebilir.
// Kullanıcı bir DELETE isteği gönderdiğinde, CAP arka planda SQL sorgusuna otomatik olarak AND stock = 0 ekler. 
//Eğer kullanıcı stoğu 5 olan bir kitabı silmeye çalışırsa, sistem "böyle bir kayıt bulunamadı" veya "yetkin yok" diyerek işlemi reddeder.
    {
        grant :[
            'READ',
            'CREATE',
            'UPDATE'
        ],
        TO : 'admin'
    }
]);

//@restrict annotasyonu, @requires'tan çok daha güçlüdür çünkü aksiyon bazlı ve koşul bazlı kısıtlamalar yapmanı sağlar.
//grant: Hangi işlemlere izin verildiğini belirtir. Burada Okuma, Oluşturma ve Güncelleme paketlenmiş.
//to: Bu izinlerin kimin için olduğunu söyler. 'admin' rolüne sahip olanlar bu üç işlemi özgürce yapabilir.

annotate Authors with @(requires:'admin');
//Authors entity'sine ulaşmak isteyen herkesin 
//cebinde 'admin' rolü (scope) olmak zorundadır.
