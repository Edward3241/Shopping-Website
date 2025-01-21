# Shopping Website

System structure
1. 使用Spring MVC框架構建的購物網站的專案
2. Controller去分派網址, dao去資料庫做增刪查改 傳回來的資料返回到Controller 
3. Controller把資料用model的方式送到jsp, jsp 美化之後再送回使用者端
   
Other Tools
1. Aop: 追蹤應用程序的執行流程
2. 使用第三方登入Github login
3. 前端工具 HTML,CSS,JS
4. 資訊安全:
   Aes 對稱式加密 – 提高用戶資料安全,
   csrf – 建立csrf token 以防範csrf攻擊,
   SSL 使用https對http數據進行加密

Site Map

前台登入 
1. 購物網首頁
2. 商品頁面 - 新增商品 - 新增商品結果
3. 購物車 - 商品數量調整 - 結帳成功
4. Profile - 密碼變更 - 訂單另存新檔

後台登入
1. 後台報告 - 結帳明細
2. 商品新增 - 商品新增結果
3. 商品刪除 
