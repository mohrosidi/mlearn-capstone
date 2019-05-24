# Machine Learning with R - Capstone Project

## Petunjuk Umum

* Buatlah repositori GitHub pada akun Anda
* *Clone* repositori tersebut sebagai Project ke RStudio Anda (**File - New Project - Version Control - Git**)
* Buat atau sunting berkas README.md serta tambahkan direktori 'data-raw' dan 'vignettes'
* Unduh dataset dalam direktori 'data-raw' pada repositori ini dan kemudian simpanlah ke direktori 'data-raw' pada RStudio Project Anda
* Lakukanlah analisis pada dataset tersebut dengan menggunakan dokumen R Markdown. Anda diminta untuk menggunakan *output document* berupa 'github_document'. Simpan berkas dokumen tersebut pada direktori 'vignettes'
* Setelah selesai melakukan analisis, silakan lakukan *knitting* dokumen R Markdown
* Lakukan prosedur git add, git commit, dan git push agar hasil pekerjaan Anda terunggah di repositori GitHub milik Anda

## Studi Kasus

### Kasus 1: OK-CLEAN

OK-CLEAN merupakan layanan kebersihan profesional berbasis aplikasi yang tersedia di berbagai kota di Indonesia. Layanan yang diberikan meliputi membersihkan taman rumah, ruang tamu, dapur, toilet, dan lain – lain. Layanan tersebut dikerjakan oleh Mitra OK-CLEAN.

Kota Bandung merupakan salah satu wilayah cakupan layanan OK-CLEAN. Di Kota Kembang ini, layanan kebersihan telah dirilis sejak 6 bulan belakangan. Ribuan konsumen telah menggunakan layanan tersebut. Namun, Manajer Umum OK-CLEAN menilai bahwa pasar tersebut belum memuaskan dan masih terdapat peluang yang sangat besar untuk dieksploitasi.

Manajer Umum memerintahkan Manajer Pemasaran untuk melakukan promosi besar – besaran selama 120 hari penuh. Manajer Pemasaran mulai melakukan perencanaan strategi pemasaran dengan berkolaborasi bersama Manajer Layanan Konsumen dan Manajer Keuangan. Upaya pemasaran direncanakan dengan memberikan potongan harga yang semakin besar di akhir periode promosi. Namun, keputusan tersebut memiliki risiko yaitu Mitra OK-CLEAN sering melakukan pelayanan yang tidak sesuai dengan standar ketika konsumen memesan layanan dengan menggunakan potongan harga yang besar.

Bagian Layanan Konsumen dan Bagian Keuangan selalu erat kaitannya dengan perilaku Mitra OK-CLEAN. Ketika Mitra OK-CLEAN dinilai memiliki kinerja yang buruk atau merugikan konsumen, maka komplain yang diterima oleh Bagian Layanan Konsumen OK-CLEAN akan meningkat dan ganti rugi yang harus diproses oleh Bagian Keuangan juga semakin besar nilainya.
Strategi promosi selama 120 hari telah dieksekusi sesuai dengan yang direncakan. Pergerakan jumlah konsumen diarsipkan oleh Manajer Pemasaran pada dataset [**"001_ok-clean_pengguna.csv"**](https://github.com/r-academy/mlearn-capstone/raw/master/data-raw/001_ok-clean_penggunaan.csv), pergerakan jumlah komplain diarsipkan oleh Manajer Layanan Konsumen pada dataset [**"001_ok-clean_komplain.csv"**](https://github.com/r-academy/mlearn-capstone/raw/master/data-raw/001_ok-clean_komplain.csv), dan pergerakan  keuntungan perusahaan diarsipkan oleh Manajer Keuangan pada dataset [**"001_ok-clean_keuntungan.csv"**](https://github.com/r-academy/mlearn-capstone/raw/master/data-raw/001_ok-clean_keuntungan.csv).

Manajer Umum OK-CLEAN mengadakan pertemuan bersama Manajer Pemasaran, Manajer Layanan Konsumen, dan Manajer Keuangan segera setelah periode promosi berakhir. Pertemuan tersebut membahas tentang proyeksi pergerakan jumlah konsumen, komplain, dan keuntungan di masa yang akan datang berdasarkan data yang diperoleh selama 120 hari promosi.

Untuk itu, Manajer Umum meminta masing – masing manajer untuk menyediakan data sebagai berikut:

**Bagi Manajer Pemasaran**

+ Pola yang terbentuk dari data arsip jumlah pengguna dengan menggunakan grafik yang menarik.
+ Prediksi jumlah pengguna diakhir periode ketika upaya pemasaran dilanjutkan menjadi 130 hari.
+ Prediksi jumlah pengguna diakhir periode ketika upaya pemasaran dilanjutkan menjadi 150 hari.
+ Prediksi jumlah pengguna diakhir periode ketika upaya pemasaran dilanjutkan menjadi 200 hari.

**Bagi Manajer Layanan Konsumen**

+ Pola yang terbentuk dari data arsip jumlah komplain dengan menggunakan grafik yang menarik.
+ Prediksi jumlah komplain diakhir periode ketika upaya pemasaran dilanjutkan menjadi 130 hari.
+ Prediksi jumlah komplain diakhir periode ketika upaya pemasaran dilanjutkan menjadi 150 hari.
+ Prediksi jumlah komplain diakhir periode ketika upaya pemasaran dilanjutkan menjadi 200 hari.

**Bagi Manajer Keuangan:**

+ Pola yang terbentuk dari data arsip jumlah keuntungan dengan menggunakan grafik yang menarik.
+ Prediksi jumlah keuntungan diakhir periode ketika upaya pemasaran dilanjutkan menjadi 130 hari.
+ Prediksi jumlah keuntungan diakhir periode ketika upaya pemasaran dilanjutkan menjadi 150 hari.
+ Prediksi jumlah keuntungan diakhir periode ketika upaya pemasaran dilanjutkan menjadi 200 hari.

**Bagi Ketiga Manajer**

+ Adakah pola mencurigakan yang terjadi dalam data pada masing – masing arsip?
+ Kapan pola tersebut tersebut mulai terjadi?
+ Mengapa hal tersebut dapat terjadi?
+ Akankah temuan tersebut jika berlangsung secara terus – menerus dapat merugikan perusahaan?
+ Keputusan apa yang sebaiknya diambil oleh perusahaan?

### Kasus 2: Pemilihan Umum Presiden 2019

Indonesia merupakan negara kesatuan dengan bentuk pemerintahan republik. Pemilihan Dewan Perwakilan Rakyat, Dewan Perwakilan Daerah, dan Presiden dilakukan secara langsung. Pemilihan ini pada umumnya disebut dengan istilah “pemilihan umum” atau "pemilu" yang diadakan setiap 5 tahun sekali.
            
Tahun 2019 merupakan tahun demokrasi bagi seluruh rakyat Indonesia. Pada tahun tersebut, terdapat dua pasangan yang mendaftarkan diri sebagai calon presiden dan wakil presiden Indonesia periode 2019 – 2024. Kedua belah pihak melakukan kampanye melalui berbagai media, baik media offline maupun media online.

Media sosial menjadi wadah yang baik untuk dimanfaatkan sebagai lokasi penyebaran informasi, interaksi, dan upaya – upaya kampanye lainnya. Tak hanya keduabelah pihak, masing – masing pendukung juga terus menyuarakan pendapatnya melalui media ini. Aktivitas penyebaran informasi melalui media sosial ini telah diarsipkan pada dokumen [**"002_twitter-bot.csv"**](https://github.com/r-academy/mlearn-capstone/raw/master/data-raw/002_twitter-bot.csv).

Diantara sekian banyak pelaku penyebaran informasi, ditemukan bahwasannya tidak semua informasi yang dibagikan bersumber dari manusia. Bot sering ditemukan menjadi pelaku penyebaran informasi secara massal untuk meramaikan interaksi yang terjadi. Hal ini dilakukan untuk memperluas cakupan sebaran informasi dan menimbulkan persepsi bagi pengguna media sosial bahwa calon yang dibicarakan memiliki lebih banyak pendukung.

Sebagai pengamat media sosial, saya harus lebih berhati – hati dalam mengambil kesimpulan dari seluruh interaksi yang terjadi. Saya harus dapat memilah informasi menjadi beberapa kategori, yaitu informasi disebarkan oleh manusia, bot, atau yang dicurigai sebagai bot. Alasan dibalik pentingnya melakukan pemilahan ini yaitu mengingat bahwasannya informasi yang disampaikan oleh bot tidak dapat disamakan kualitasnya dengan yang disampaikan oleh manusia secara langsung. Bot biasanya mengirimkan informasi yang sama secara berulang – ulang, berbeda dengan manusia yang cenderung menyampaikan informasi yang berbeda – beda untuk setiap kiriman.

Saya bertanggungjawab untuk menyediakan informasi yang akurat dan kredibel. Dengan demikian, pemilahan harus saya lakukan dengan cermat untuk memperoleh kesimpulan yang tepat.

1. Bagaimana saya dapat melakukan pemilahan tersebut?
2. Hasil apa yang dapat saya simpulkan?

### Kasus 3: Lamudi

Anda adalah seorang data analyst di perusahaan properti yang berlokasi di Kota Bandung. Pada suatu hari, anda diberikan tugas oleh atasan Anda untuk membuat sebuah model yang dapat menentukan lokasi wilayah dari suatu rumah berdasarkan nilai jual, jumlah kamar, luas tanah (LT), dan luas bangunan (LB). Anda dapat menggunakan dataset [**"003_lamudi.csv"**](https://github.com/r-academy/mlearn-capstone/raw/master/data-raw/003_lamudi.csv).

Untuk itu, 

1. Model apa yang cocok terhadap kasus diatas? Buatlah model tersebut
2. Apa kesimpulan yang bisa diperoleh dari model yang telah dibuat?

### Kasus 4: HDI

Anda adalah seorang yang bekerja di Kementerian Sosial RI. Salah satu tugas dari Kementerian ini adalah menjamin kesejahteraan sosial bagi masyarakat. Dalam prosesnya, anda diminta untuk menganalisis Kota dan Kabupaten yang ada di seluruh Indonesia berdasarkan nilai HDI dan Revenue nya agar bisa melihat Kota dan Kabupaten mana saja yang memiliki kesamaan karakteristik terkait 2 nilai tersebut. Anda dapat menggunakan dataset [**"004_hdi.csv"**](https://github.com/r-academy/mlearn-capstone/raw/master/data-raw/004_hdi.csv).

Untuk itu,

1. Model apa yang cocok untuk kasus diatas?
2. Apakah terdapat suatu Gap yang cukup besar antara Kota dan Kabupaten di Indonesia? Jika ada, sebutkan contoh Kota dan Kabupaten tersebut?

