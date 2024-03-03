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
