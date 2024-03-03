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
VIX Big Data Analytics Kimia Farma merupakan virtual internship experience yang difasilitasi oleh [Rakamin Academy](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program). Pada project ini saya berperan sebagai Data Analyst Intern yang diminta untuk menganalisis dan membuat laporan penjualan perusahaan menggunakan data-data yang telah disediakan. <br>
<br>

**Objectives**
- Membuat Objectives tabel aggregat
- Membuat visualisasi/dashboard laporan penjualan perusahaan
- Belajar memahami kode syntax 


### Tabel Aggregat
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

---

## 📂 **Data Visualization**

[Lihat pada halaman Looker Data Studio]([https://lookerstudio.google.com/reporting/3c67b292-3be2-484d-bc29-27bd0b4015fd](https://lookerstudio.google.com/reporting/d8854498-5f76-4eab-b5a8-9ac692905f10))).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://user-images.githubusercontent.com/115857221/222877035-53371a89-081d-4ec5-9e72-65b0176a96fd.jpg"> </kbd> <br>
    Gambar 3 — Sales Report Dashboard PT. Kimia Farma
</p>
<br>
