-- Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.

SELECT 
    *
FROM
    nhan_vien
WHERE
    (ho_ten LIKE 'H%' OR ho_ten LIKE 'T%'
        OR ho_ten LIKE 'K%')
        AND is_delete = 0;
    
-- Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

SELECT 
    *
FROM
    khach_hang
WHERE
    YEAR(CURDATE()) - YEAR(ngay_sinh) >= 18
        AND YEAR(CURDATE()) - YEAR(ngay_sinh) <= 50
        AND (dia_chi LIKE '% Da Nang'
			OR dia_chi LIKE '% Quang Tri')
        AND is_delete = 0;
        
-- Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

SELECT 
    kh.ma_khach_hang,
    kh.ho_ten,
    COUNT(kh.ma_khach_hang) so_lan_dat_phong
FROM
    (khach_hang kh
		JOIN hop_dong hd 
        ON kh.ma_khach_hang = hd.ma_khach_hang)
			JOIN
    loai_khach lk 
    ON kh.ma_loai_khach = lk.ma_loai_khach
WHERE
    lk.ten_loai_khach = 'diamond'
    AND lk.is_delete = 0
    AND hd.is_delete = 0
    AND kh.is_delete = 0
GROUP BY kh.ma_khach_hang
ORDER BY so_lan_dat_phong ASC;

-- Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

SELECT 
    kh.ma_khach_hang,
    kh.ho_ten,
    lk.ten_loai_khach,
    hd.ma_hop_dong,
    sub_table.ten_dich_vu,
    sub_table.ngay_lam_hop_dong,
    sub_table.ngay_ket_thuc,
    sub_table.tong_tien,
    kh.is_delete,
    lk.is_delete,
    hd.is_delete
FROM
    khach_hang kh
        JOIN
    loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
        LEFT JOIN
    hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
        LEFT JOIN
    (SELECT 
        hd.ma_hop_dong,
            dv.ten_dich_vu,
            hd.ngay_lam_hop_dong,
            hd.ngay_ket_thuc,
            dv.chi_phi_thue + IFNULL(SUM(hdct.so_luong * dvdk.gia), 0) tong_tien
    FROM
        hop_dong hd
    LEFT JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
    LEFT JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
    LEFT JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
    WHERE
        dv.is_delete = 0 AND hd.is_delete = 0
            AND (hdct.is_delete = 0
				OR hdct.is_delete IS NULL)
            AND (dvdk.is_delete = 0
				OR dvdk.is_delete IS NULL)
    GROUP BY hd.ma_hop_dong) AS sub_table ON hd.ma_hop_dong = sub_table.ma_hop_dong
    WHERE
		kh.is_delete = 0
        AND lk.is_delete = 0
        AND (hd.is_delete = 0 OR hd.is_delete is null);

