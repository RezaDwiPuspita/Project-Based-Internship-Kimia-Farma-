# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : Google Cloud 
Visualization : Looker Data Studio - [Lihat dashboard](https://lookerstudio.google.com/reporting/d8854498-5f76-4eab-b5a8-9ac692905f10) <br>
Dataset : 
- Kf_final_transaction.csv
- kf_inventory.csv
- kf_kantor_cabang.csv
- kf_product.csv

<br>

---

## 📂 **Introduction**
Big Data Analytics Kimia Farma merupakan virtual internship experience yang difasilitasi oleh [Rakamin Academy](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program). Pada project ini saya berperan sebagai Data Analyst Intern yang diminta untuk menganalisis dan membuat laporan bisnis perusahaan Kimia Farma dengan menggunakan data-data yang telah disediakan. <br>
<br>

**Objectives**
- Membuat Objectives tabel aggregat
- Membuat visualisasi/dashboard laporan penjualan perusahaan
- Belajar memahami kode syntax 


## 📂 **Tabel Agregat**
Tabel agregat adalah tabel yang dibuat dengan mengumpulkan dan menghitung data dari tabel basis. Tabel aggregat ini berisi informasi yang lebih ringkas dan digunakan untuk menganalisis data lebih cepat dan efisien. Hasil tabel ini akan digunakan untuk sumber pembuatan dashboard laporan penjualan.

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql

    SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    SUM((p.price - (p.price * t.discount_percentage / 100))) AS total_profit,
    SUM(p.price) AS total_sales,
    SUM((p.price - (p.price * t.discount_percentage / 100))) AS nett_sales,
    b.rating
FROM
    kimia_farma.transaction t
JOIN
    kimia_farma.kantorcabang b ON t.branch_id = b.branch_id
JOIN
    kimia_farma.product p ON t.product_id = p.product_id
GROUP BY
    t.transaction_id,
    t.date,
    t.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating;
```   
<br>
</details>
<br>

<p align="center">
    <kbd> <img width="750" alt="sample aggregat" src="https://github.com/RezaDwiPuspita/Project-Based-Internship-Kimia-Farma-/blob/main/Kimia%20Farma/Tabel%20Agregat.png"> </kbd> <br>
    Gambar 1 — Hasil Pembuatan Tabel Aggregat
</p>
<br>

---

## 📂 **BigData Syntax**
Big data syntax merujuk pada aturan dan struktur yang digunakan untuk mengatur dan memanipulasi data besar (big data). Ini termasuk cara data disusun, diakses, dan diproses dalam lingkungan yang berukuran besar. Contohnya, dalam pemrograman menggunakan bahasa seperti Python, Java, atau SQL, menggunakan sintaks khusus untuk melakukan tugas seperti pengambilan data, pengolahan, dan analisis.

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql

    /*
Author: Reza Dwi Puspita
Tool used: Google CLoud Platform 
*/

/*
--------------------------
CREATE BIG QUERY
--------------------------
*/
-- 1. memasukkan data seperti Kf_final_transaction.csv, kf_inventory.csv, kf_kantor_cabang.csv, Kf_product.csv ke dalam dataset kimia_farma 

-- Membuat big Query 
SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    t.customer_name,
    t.product_id,
    t.price,
    t.discount_percentage,
    t.rating,
    k.branch_category,
    k.branch_name,
    k.kota,
    k.provinsi,
    p.product_name,
    p.product_category,
    p.price AS product_price,
    i.opname_stock
FROM
    kimia_farma.transaction AS t
JOIN
    kimia_farma.kantorcabang AS k ON t.branch_id = k.branch_id
JOIN
    kimia_farma.product AS p ON t.product_id = p.product_id
JOIN
    kimia_farma.inventory AS i ON t.branch_id = i.branch_id AND t.product_id = i.product_id;


-- Melakukan analisis 
/*rating_cabang : penilaian konsumen terhadap cabang Kimia
Farma */
SELECT 
  branch_id, 
  branch_name, 
  rating AS rating_cabang
FROM kimia_farma.analisis;

/*customer_name : Nama customer yang melakukan transaksi, */
SELECT customer_name
FROM kimia_farma.analisis;


-- Penilaian Produk dan Laba: 
/*product_id : kode product obat, ● product_name : nama obat, ● actual_price : harga obat, ● discount_percentage : Persentase diskon yang diberikan pada obat, ● persentase_gross_laba : Persentase laba yang seharusnya diterima dari obat dengan ketentuan berikut:
 */
  
SELECT
    product_id,
    product_name,
    price,
    discount_percentage,
    CASE
        WHEN price <= 50000 THEN 0.1
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.2
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.3
    END AS grosslaba,
    price * (1 - discount_percentage) AS nett_sales,
    price * (1 - discount_percentage) * 
    CASE
        WHEN price <= 50000 THEN 0.1
        WHEN price > 50000 AND price <= 100000 THEN 0.15
        WHEN price > 100000 AND price <= 300000 THEN 0.2
        WHEN price > 300000 AND price <= 500000 THEN 0.25
        ELSE 0.3
    END AS nett_profit
FROM
    kimia_farma.analisis;


-- Penilaian Transaksi:
/*rating_transaksi : penilaian konsumen terhadap transaksi
yang dilakukan.
 */

SELECT
    transaction_id,
    customer_name,
    branch_id,
    product_id,
    price,
    discount_percentage,
    rating AS ratingtransaksi,
    CASE
        WHEN rating >= 4.5 THEN 'Sangat Baik'
        WHEN rating >= 4.0 THEN 'Baik'
        WHEN rating >= 3.0 THEN 'Cukup'
        ELSE 'Kurang'
    END AS ratingdescription
FROM
   kimia_farma.analisis;

```   
<br>
</details>

<br>

<p align="center">
    <kbd> <img width="750" alt="sample aggregat" src="https://github.com/RezaDwiPuspita/Project-Based-Internship-Kimia-Farma-/blob/main/Kimia%20Farma/Analisis%20Kimia%20Farma.png"> </kbd> <br>
    Gambar 2 — Pembuatan Tabel BigData Syntax
</p>
<br>

---

## 📂 **Data Visualization**

[Lihat pada halaman Looker Data Studio]([https://lookerstudio.google.com/reporting/3c67b292-3be2-484d-bc29-27bd0b4015fd](https://lookerstudio.google.com/reporting/d8854498-5f76-4eab-b5a8-9ac692905f10))).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://github.com/RezaDwiPuspita/Project-Based-Internship-Kimia-Farma-/blob/main/Kimia%20Farma/Kimia_Farma%20Dashboard.jpg "> </kbd> <br>
    Gambar 3 —  Dashboard Analisis Bisnis Dashboard PT. Kimia Farma
</p>
<br>
