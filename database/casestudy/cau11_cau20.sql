-- Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

SELECT 
    dvdk.*
FROM
    dich_vu_di_kem dvdk
        JOIN hop_dong_chi_tiet hdct 
        ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
        JOIN hop_dong hd 
        ON hdct.ma_hop_dong = hd.ma_hop_dong
        JOIN khach_hang kh 
        ON hd.ma_khach_hang = kh.ma_khach_hang
        JOIN loai_khach lk 
        ON kh.ma_loai_khach = lk.ma_loai_khach
WHERE
    lk.ten_loai_khach = 'Diamond'
        AND (
        kh.dia_chi LIKE '% Vinh'
        OR kh.dia_chi LIKE '% Quang Ngai'
        );
        
-- Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem 
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
-- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT 
    hd.ma_hop_dong, 
    nv.ho_ten ho_ten_nhan_vien, 
    kh.ho_ten ho_ten_khach_hang, 
    kh.so_dien_thoai so_dien_thoai_khach_hang, 
    dv.ten_dich_vu, 
    count(dvdk.ten_dich_vu_di_kem) so_luong_dich_vu_di_kem, 
    hd.tien_dat_coc
FROM
      hop_dong hd 
        JOIN khach_hang kh 
        ON hd.ma_khach_hang = kh.ma_khach_hang
        JOIN nhan_vien nv
        ON hd.ma_nhan_vien = nv.ma_nhan_vien
        JOIN dich_vu dv
        ON hd.ma_dich_vu = dv.ma_dich_vu
        LEFT JOIN hop_dong_chi_tiet hdct 
        ON hdct.ma_hop_dong = hd.ma_hop_dong
        LEFT JOIN dich_vu_di_kem dvdk
        ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
WHERE 
dv.ma_dich_vu IN (SELECT DISTINCT
		ma_dich_vu
	FROM
		hop_dong
	WHERE
		ngay_lam_hop_dong >= DATE '2020-10-01'
			AND ngay_lam_hop_dong <= DATE '2021-12-30')
AND
	dv.ma_dich_vu NOT IN (SELECT DISTINCT
		ma_dich_vu
	FROM
		hop_dong
	WHERE
		ngay_lam_hop_dong >= DATE '2021-01-01'
			AND ngay_lam_hop_dong <= DATE '2021-06-30')
GROUP BY ma_hop_dong, ho_ten_nhan_vien, ho_ten_khach_hang, so_dien_thoai_khach_hang, ten_dich_vu, tien_dat_coc;
