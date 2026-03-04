namespace my.bookshop;

entity Books {
    key ID : Integer;
    title  : String ;
    stock  : Integer;
}

//Books" adında, içinde ID, başlık ve stok bilgisi barındıran bir tablo taslağı oluşturur.
//CAP, bu tanımlamalara dayanarak veritabanı şemalarını otomatik olarak üreterek (automatically generate) 
//geliştirme sürecini önemli ölçüde hızlandırır (significantly speeds up).