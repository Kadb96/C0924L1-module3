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
	AND (kh.dia_chi LIKE '% Vinh'
        OR kh.dia_chi LIKE '% Quang Ngai'
	) AND dvdk.is_delete = 0
    AND hd.is_delete = 0
    AND kh.is_delete = 0
    AND lk.is_delete = 0;
        
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
			ngay_lam_hop_dong >= '2020-10-01'
				AND ngay_lam_hop_dong <= '2020-12-30'
				AND is_delete = 0)
	AND
		dv.ma_dich_vu NOT IN (SELECT DISTINCT
			ma_dich_vu
		FROM
			hop_dong
		WHERE
			ngay_lam_hop_dong >= '2021-01-01'
				AND ngay_lam_hop_dong <= '2021-06-30'
				AND is_delete = 0)
	AND hd.is_delete = 0
	AND kh.is_delete = 0
	AND nv.is_delete = 0
	AND dv.is_delete = 0
	AND (hdct.is_delete = 0
		OR hdct.is_delete IS NULL)
	AND (dvdk.is_delete = 0
		OR hdct.is_delete IS NULL)
GROUP BY ma_hop_dong, ho_ten_nhan_vien, ho_ten_khach_hang, so_dien_thoai_khach_hang, ten_dich_vu, tien_dat_coc;

-- Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

SELECT dvdk.*
FROM dich_vu_di_kem dvdk
	JOIN hop_dong_chi_tiet hdct
    ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
WHERE dvdk.is_delete = 0
	AND hdct.is_delete = 0
GROUP BY dvdk.ma_dich_vu_di_kem
HAVING 
	sum(hdct.so_luong) = (
		SELECT sum(so_luong)
        FROM hop_dong_chi_tiet
        WHERE is_delete = 0
        GROUP BY ma_dich_vu_di_kem
        ORDER BY sum(so_luong) DESC
        LIMIT 1
        );
        
-- Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).

SELECT hdct.ma_hop_dong,
	ldv.ten_loai_dich_vu,
    dvdk.ten_dich_vu_di_kem,
    sub_table.so_lan_su_dung
FROM hop_dong_chi_tiet hdct
	JOIN hop_dong hd
    ON hdct.ma_hop_dong = hd.ma_hop_dong
    JOIN dich_vu dv
    ON hd.ma_dich_vu = dv.ma_dich_vu
    JOIN loai_dich_vu ldv
    ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
    JOIN dich_vu_di_kem dvdk
    ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
    JOIN (
		SELECT  
			ma_dich_vu_di_kem,
            count(ma_dich_vu_di_kem) so_lan_su_dung
		FROM hop_dong_chi_tiet
		WHERE is_delete = 0
		GROUP BY ma_dich_vu_di_kem
		HAVING count(ma_dich_vu_di_kem) = 1
        ) as sub_table
	ON hdct.ma_dich_vu_di_kem = sub_table.ma_dich_vu_di_kem
WHERE 
	hdct.is_delete = 0
	AND dv.is_delete = 0
    AND hd.is_delete = 0
    AND ldv.is_delete = 0
    AND dvdk.is_delete = 0;

-- Hiển thi thông tin của tất cả nhân viên 
-- bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

SELECT 
	nv.ma_nhan_vien, 
	nv.ho_ten, 
    td.ten_trinh_do, 
    bp.ten_bo_phan, 
    nv.so_dien_thoai, 
    nv.dia_chi
FROM 
	nhan_vien nv
	JOIN trinh_do td
    ON nv.ma_trinh_do = td.ma_trinh_do
    JOIN bo_phan bp
    ON nv.ma_bo_phan = bp.ma_bo_phan
    JOIN hop_dong hd
    on nv.ma_nhan_vien = hd.ma_nhan_vien
WHERE
	nv.is_delete = 0
    AND td.is_delete = 0
    AND bp.is_delete = 0
    AND hd.is_delete = 0
GROUP BY nv.ma_nhan_vien
HAVING count(nv.ma_nhan_vien) <= 3;

-- Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
UPDATE nhan_vien
SET is_delete = 1
WHERE ma_nhan_vien NOT IN (
	SELECT distinct ma_nhan_Vien
    FROM 
		hop_dong 
	WHERE
		is_delete = 0
        AND year(ngay_lam_hop_dong) BETWEEN 2019 AND 2021
	);

SELECT * FROM nhan_vien;
    
-- Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, 
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

UPDATE khach_hang
SET ma_loai_khach = (SELECT ma_loai_khach FROM loai_khach WHERE ten_loai_khach = 'Diamond')
WHERE 
	is_delete = 0
    AND ma_loai_khach = (SELECT ma_loai_khach FROM loai_khach WHERE ten_loai_khach = 'Platinum')
	AND ma_khach_hang IN (
		SELECT 
			hd.ma_khach_hang
		FROM 
			hop_dong hd
			JOIN dich_vu dv
			ON hd.ma_dich_vu = dv.ma_dich_vu
			LEFT JOIN hop_dong_chi_tiet hdct
			ON hd.ma_hop_dong = hdct.ma_hop_dong
			LEFT JOIN dich_vu_di_kem dvdk
			ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
		WHERE 
			hd.is_delete = 0
			AND dv.is_delete = 0
			AND (
				hdct.is_delete = 0
				OR hdct.is_delete IS NULL
			) AND (
				dvdk.is_delete = 0
				OR dvdk.is_delete IS NULL
			)
			AND YEAR(hd.ngay_lam_hop_dong) = 2021
		GROUP BY hd.ma_khach_hang
			HAVING sum(dv.chi_phi_thue + ifnull(hdct.so_luong * dvdk.gia, 0)) > 10000000);

SELECT * FROM khach_hang;

-- Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).

UPDATE khach_hang
SET is_delete = 1
WHERE ma_khach_hang IN (
	SELECT distinct ma_khach_hang
    FROM hop_dong
	WHERE 
		YEAR(ngay_lam_hop_dong) < 2021
        AND hop_dong.is_delete = 0
);

SELECT * FROM khach_hang;

-- Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

UPDATE dich_vu_di_kem
SET gia = gia * 2
WHERE 
	is_delete = 0
    AND ma_dich_vu_di_kem IN (
	SELECT hdct.ma_dich_vu_di_kem
    FROM 
		hop_dong_chi_tiet hdct
		JOIN hop_dong hd
        ON hdct.ma_hop_dong = hd.ma_hop_dong
	WHERE
		hdct.is_delete = 0
        AND hd.is_delete = 0
        AND YEAR(hd.ngay_lam_hop_dong) = 2020
	GROUP BY hdct.ma_dich_vu_di_kem
    HAVING sum(hdct.so_luong) > 10);
    
    SELECT * FROM dich_vu_di_kem;

-- Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, 
-- thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.

SELECT ma_nhan_vien id, ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi
FROM nhan_vien
WHERE is_delete = 0
UNION ALL
	SELECT ma_khach_hang id, ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi
    FROM khach_hang
    WHERE is_delete = 0;