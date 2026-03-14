# Gallery Integration (Laravel → Frontend)

Dokumentasi ini menjelaskan cara menampilkan **image gallery secara dinamis dari Laravel** ke **frontend Javascript**.

Gallery akan:

* mengambil gambar dari folder server
* mengirim data ke Blade
* diparsing ke Javascript
* dirender ke grid gallery di frontend

---

# 1. Controller Setup

Controller akan membaca semua file gambar dari folder:

```
public/images/gallery
```

Lalu mengubahnya menjadi URL yang bisa digunakan di frontend.

```php
use Illuminate\Support\Facades\File;

public function gallery()
{
    $images = collect(File::files(public_path('images/gallery')))
        ->map(fn($file) => asset('images/gallery/'.$file->getFilename()))
        ->values();

    return view('gallery', [
        'images' => $images
    ]);
}
```

### Penjelasan

| Method          | Fungsi                          |
| --------------- | ------------------------------- |
| `File::files()` | membaca semua file dalam folder |
| `collect()`     | membuat collection Laravel      |
| `map()`         | mengubah file menjadi URL       |
| `asset()`       | menghasilkan URL publik         |
| `values()`      | reset index array               |

---

# 2. Struktur Folder

Pastikan struktur folder seperti berikut:

```
public
 └ images
    └ gallery
        ├ 1.jpg
        ├ 2.jpg
        ├ 3.jpg
        └ 4.jpg
```

Semua gambar dalam folder tersebut akan otomatis dimasukkan ke gallery.

---

# 3. Kirim Data ke Frontend (Blade)

Di file blade (`gallery.blade.php`), parse data dari Laravel ke Javascript.

```html
<script>
    const galleryData = @json($images);
</script>
```

Contoh output di browser:

```javascript
const galleryData = [
  "http://localhost/images/gallery/1.jpg",
  "http://localhost/images/gallery/2.jpg",
  "http://localhost/images/gallery/3.jpg"
];
```

---

# 4. Digunakan oleh Javascript Gallery

Variabel `galleryData` akan digunakan oleh script gallery untuk membuat grid image.

Contoh:

```javascript
const images = galleryData;
const TOTAL = images.length;
```

Kemudian data tersebut digunakan untuk generate card gallery.

---

# 5. Flow Data

Alur data gallery:

```
images folder
      ↓
Laravel Controller
      ↓
$images array
      ↓
Blade @json
      ↓
Javascript galleryData
      ↓
buildGrid()
      ↓
Gallery render
```

---

# 6. Keuntungan Sistem Ini

✔ ringan dan cepat
✔ cocok untuk static gallery
