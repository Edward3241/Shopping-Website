package spring.mvc.group_buy.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Arrays;
import java.util.Base64;
import java.util.Enumeration;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.opencsv.CSVWriter;

//import com.opencsv.CSVWriter;

import spring.mvc.group_buy.model.dao.GroupBuyDao;
import spring.mvc.group_buy.model.entity.Cart;
import spring.mvc.group_buy.model.entity.CartItem;
import spring.mvc.group_buy.model.entity.Product;
import spring.mvc.group_buy.model.entity.User;
import spring.mvc.group_buy.util.KeyUtil;
import spring.mvc.group_buy.util.OAuth2Util;

@Controller
@RequestMapping("/group_buy")
public class GroupBuyController {
	
	@Autowired
	private GroupBuyDao dao;
	
	@Value("${units}")
	private String[] units;
	
	
	
	
//	@GetMapping("/util/OAuth2Util")
//	public String githubLogin() {
//	    // 向 Github 驗證授權
//	    String auth = OAuth2Util.AUTH_URL;
//
//	    // 從資料庫或其他來源獲取使用者名稱
//	    String username = getUsernameFromDao();  // 使用 DAO 獲取使用者名稱
//	    if (username == null) {
//	        // 在這裡處理錯誤，例如拋出異常或返回錯誤信息
//	        throw new IllegalArgumentException("Username cannot be null");
//	    }
//
//	    // 進行重定向
//	    return "redirect:" + auth;
//	}
//
//	// 使用 DAO 獲取使用者名稱的方法
//	private String getUsernameFromDao() {
//	    // 使用你的 DAO 方法來獲取使用者名稱
//	    // 這裡僅僅是一個示例，實際上要根據你的 DAO 接口進行調整
//	    Optional<User> user = dao.findUserById(userId).get(); // 假設你有一個 findUserById 方法
//
//	    return user.map(User::getUsername).orElse(null);
//	}


	@GetMapping("/getcode")
	private void getCodeImage(HttpSession session, HttpServletResponse response) throws IOException {
		// 產生一個驗證碼 code
		Random random = new Random();
		String code1 = String.format("%c", (char)(random.nextInt(122-65+1) + 65));
		String code2 = String.format("%c", (char)(random.nextInt(122-65+1) + 65));
		String code3 = String.format("%c", (char)(random.nextInt(122-65+1) + 65));
		String code4 = String.format("%c", (char)(random.nextInt(122-65+1) + 65));
		
		String code  = code1+code2+code3+code4;
		session.setAttribute("code", code);
		
		// Java 2D 產生圖檔
		// 1. 建立圖像暫存區
		BufferedImage img = new BufferedImage(80, 30, BufferedImage.TYPE_INT_BGR);
		// 2. 建立畫布
		Graphics g = img.getGraphics();
		// 3. 設定顏色
		g.setColor(Color.GREEN);
		// 4. 塗滿背景
		g.fillRect(0, 0, 80, 30);
		// 5. 設定顏色
		g.setColor(Color.BLACK);
		// 6. 設定自型
		g.setFont(new Font("新細明體", Font.PLAIN, 30));
		// 7. 繪字串
		g.drawString(code, 10, 23); // code, x, y
		// 8. 干擾線
		g.setColor(Color.BLUE);
		for(int i=0;i<10;i++) {
			int x1 = random.nextInt(80);
			int y1 = random.nextInt(30);
			int x2 = random.nextInt(80);
			int y2 = random.nextInt(30);
			g.drawLine(x1, y1, x2, y2);
		}
		
		// 設定回應類型
		response.setContentType("image/png");
		
		// 將影像串流回寫給 client
		ImageIO.write(img, "PNG", response.getOutputStream());
	}
	
	// 登入首頁
	@GetMapping(value = {"/login", "/", "/login/"})
	public String loginPage(HttpSession session) {
		return "group_buy/login";
	}
	
	// % search search % %=任意資源
	
	// 前台登入處理
	@PostMapping("/login") //我會導到login頁面
	public String login(@RequestParam("username") String username,  //接收jsp login中的3個參數 帶了username這個參數
						 @RequestParam("password") String password,
						 @RequestParam("code") String code,
						HttpSession session, Model model) throws Exception { //session存储和获取与用户会话相关的信息 , model傳遞資料 給jsp 
		// 比對驗證碼
//		if(!code.equals(session.getAttribute("code")+"")) {
//			session.invalidate(); // session 過期失效
//			model.addAttribute("loginMessage", "驗證碼錯誤");
//			return "group_buy/login";
//		}
		// 根據 username 查找 user 物件
		Optional<User> userOpt = dao.findUserByUsername(username);
		if(userOpt.isPresent()) {
			User user = userOpt.get();
			// 將 password 進行 AES 加密 -------------------------------------------------------------------
			final String KEY = KeyUtil.getSecretKey(); 														// 1. 獲取密鑰
			SecretKeySpec aesKeySpec = new SecretKeySpec(KEY.getBytes(), "AES"); 							// 2. 創建 SecretKeySpec
			byte[] encryptedPasswordECB = KeyUtil.encryptWithAESKey(aesKeySpec, password); 					// 3. 進行 AES 加密
			String encryptedPasswordECBBase64 = Base64.getEncoder().encodeToString(encryptedPasswordECB);   // 4. Base64 編碼
			//-------------------------------------------------------------------------------------------
			if(user.getPassword().equals(encryptedPasswordECBBase64)) { // 比對加密過後的 password 是否相同
				session.setAttribute("user", user); // 將 user 物件放入到 session 變數中
				return "redirect:/mvc/group_buy/frontend/main"; // OK, 導向前台首頁
			} else {
				session.invalidate(); // session 過期失效
				model.addAttribute("loginMessage", "密碼錯誤");
				return "group_buy/login"; //導向 login頁面
			}
		} else {
			session.invalidate(); // session 過期失效
			model.addAttribute("loginMessage", "無此使用者");
			return "group_buy/login"; //導向 login頁面
		}
	}
	
	// 後台登入處理
	@PostMapping("/login_backend")
	public String loginBackend(@RequestParam("username") String username, 
						 @RequestParam("password") String password,
						 @RequestParam("code") String code,
						HttpSession session, Model model) throws Exception {
//		// 比對驗證碼
//		if(!code.equals(session.getAttribute("code")+"")) {
//			session.invalidate(); // session 過期失效
//			model.addAttribute("loginMessage", "驗證碼錯誤");
//			return "group_buy/login";
//		}
		// 根據 username 查找 user 物件
		Optional<User> userOpt = dao.findUserByUsername(username);
		if(userOpt.isPresent()) {
			User user = userOpt.get();
			// 將 password 進行 AES 加密 -------------------------------------------------------------------
			final String KEY = KeyUtil.getSecretKey();
			SecretKeySpec aesKeySpec = new SecretKeySpec(KEY.getBytes(), "AES");
			byte[] encryptedPasswordECB = KeyUtil.encryptWithAESKey(aesKeySpec, password);
			String encryptedPasswordECBBase64 = Base64.getEncoder().encodeToString(encryptedPasswordECB);
			//-------------------------------------------------------------------------------------------
			if(user.getPassword().equals(encryptedPasswordECBBase64)) {
				// 比對 level = 2 才可以登入後台
				if(user.getLevel() == 2) {
					session.setAttribute("user", user); // 將 user 物件放入到 session 變數中
					return "redirect:/mvc/group_buy/backend/main"; // OK, 導向後台首頁
				}
				session.invalidate(); // session 過期失效
				model.addAttribute("loginMessage", "無權限登入後台");
				return "group_buy/login";
			} else {
				session.invalidate(); // session 過期失效
				model.addAttribute("loginMessage", "密碼錯誤");
				return "group_buy/login";
			}
		} else {
			session.invalidate(); // session 過期失效
			model.addAttribute("loginMessage", "無此使用者");
			return "group_buy/login";
		}
	}
	
	// 登出
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/mvc/group_buy/login";
	}
	
	// 前台團購首頁
	@GetMapping("/frontend/main")
	public String frontendMain(Model model) {
		// 過濾出只有上架的商品
		List<Product> products = dao.findAllProducts(false);
		for ( Product product :  products ) {
			System.out.println(product);
			}
		model.addAttribute("products", products);
		return "group_buy/frontend/main";
	}
	
	// 商品頁面
	@GetMapping("/frontend/product")
	public String frontendProduct(Model model) {
		// 過濾出只有上架的商品
		List<Product> products = dao.findAllProducts(false);
		for ( Product product :  products ) {
			System.out.println(product);
			}
		model.addAttribute("products", products);
		return "group_buy/frontend/product";
	}
	
	
	// 前台購物完成頁
	@PostMapping("/frontend/addToCart")
	public String addToCart(@RequestParam("productId") Integer productId,
							@RequestParam("quantity") Integer quantity,
							HttpSession session, Model model) {
		// 1. 先找到 user 登入者
		User user = (User)session.getAttribute("user");
		// 2. 找到 user 的尚未結帳的購物車
		Cart cart = null;
		Optional<Cart> cartOpt = dao.findNoneCheckoutCartByUserId(user.getUserId());
		if(cartOpt.isPresent()) {
			cart = cartOpt.get(); // 取得該 user 的購物車
		} else { 
			cart = new Cart(); // 建立新的購物車
			cart.setUserId(user.getUserId());
			dao.addCart(cart); // 將購物車存放到資料表
			
			// 新增之後馬上又要查詢, 建議可以下達一個 delay
			try {
				Thread.sleep(10);
			} catch (Exception e) {
				
			}
			
			// 再抓一次該使用者的購物車(目的是要得到剛才新增 cart 的 cartId)
			cart = dao.findNoneCheckoutCartByUserId(user.getUserId()).get();
		}
		
		// 建立購物項目
		CartItem cartItem = new CartItem();
		cartItem.setCartId(cart.getCartId());
		cartItem.setProductId(productId);
		cartItem.setQuantity(quantity);
		// 新增購物車項目
		dao.addCartItem(cartItem);
		
		model.addAttribute("product", dao.findProductById(productId).get()); // 商品物件
		model.addAttribute("quantity", quantity);
		return "group_buy/frontend/result";
	}
	
	// 商品刪除
	@PostMapping("/backend/deleteToCart")
	public String deleteToCart(@RequestParam("productId") Integer productId,
							
							HttpSession session, Model model) {

		dao.deleteProduct(productId);
		
		return "group_buy/backend/delete";
	}
	
	@GetMapping("/backend/delete")
	public String delete(Model model) {
		// 過濾出只有上架的商品
		List<Product> products = dao.findAllProducts(false);
		for ( Product product :  products ) {
			System.out.println(product);
			}
		model.addAttribute("products", products);
		return "group_buy/backend/delete";
	}
	
	// 購物車頁面
	@GetMapping("/frontend/cart")
	public String cartPage(HttpSession session, Model model) {
		// 1. 先找到 user 登入者
		User user = (User)session.getAttribute("user");
		// 2. 找到 user 的尚未結帳的購物車
		Optional<Cart> cartOpt = dao.findNoneCheckoutCartByUserId(user.getUserId());
		cartOpt.ifPresent(cart -> {
			// 3. 計算購物車總金額
			int total = cart.getCartItems().stream()
							.mapToInt(item -> item.getQuantity() * item.getProduct().getPrice())
							.sum();
			model.addAttribute("cart", cart);
			model.addAttribute("total", total);
		});
		
		return "group_buy/frontend/cart";
	}
	
	// 購物車結帳
	@GetMapping("/frontend/checkout")
	public String checkout(HttpSession session, Model model) {
		// 1. 先找到 user 登入者
		User user = (User)session.getAttribute("user");
		// 2. 找到 user 的尚未結帳的購物車
		Optional<Cart> cartOpt = dao.findNoneCheckoutCartByUserId(user.getUserId());
		cartOpt.ifPresent(cart -> {
			// 3. 計算購物車總金額
			int total = cart.getCartItems().stream()
							.mapToInt(item -> item.getQuantity() * item.getProduct().getPrice())
							.sum();
			dao.checkoutCartByUserId(cart.getUserId()); // 結帳
			model.addAttribute("cart", cart);
			model.addAttribute("total", total);
		});
		return "group_buy/frontend/finish";
	}
	
	// 修改購物車商品項目數量
	@GetMapping("/frontend/cart/update")
	public String updateCartItem(@RequestParam("itemId") Integer itemId,
								 @RequestParam("quantity") Integer quantity,
								 HttpSession session) {
		User user = (User)session.getAttribute("user");
		// 如何得知 itemId 是屬於該使用者的 ?
		dao.findCartItemById(itemId).ifPresent(cartItem -> {
			if(cartItem.getCart().getUserId().equals(user.getUserId())) {
				if(quantity > 0) {
					dao.updateCartItemQuantity(itemId, quantity);
				} else {
					dao.removeCartItemById(itemId);
				}
			}
		});
		return "redirect:/mvc/group_buy/frontend/cart";
	}
	
	// 刪除購物車項目
	@GetMapping("/frontend/cart/delete")
	public String updateCartItem(@RequestParam("itemId") Integer itemId,
								 HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		// 如何得知 itemId 是屬於該使用者的 ?
		dao.findCartItemById(itemId).ifPresent(cartItem -> {
			if(cartItem.getCart().getUserId().equals(user.getUserId())) {
				dao.removeCartItemById(itemId);
			}
		});
		
		return "redirect:/mvc/group_buy/frontend/cart";
		
	}
	
	// 使用者 Profile
//	@GetMapping("/frontend/profile")
//	public String profile() {
//		return "group_buy/frontend/profile";
//	}
	
	// 密碼變更
//	@PostMapping("/frontend/change_password")
//	@RequestMapping(value = "/frontend/change_password", method = RequestMethod.POST)
//	public String changePassword(@RequestParam("oldPassword") String oldPassword, 
//								 @RequestParam("newPassword") List<String> newPasswords,
//								 HttpSession session,
//								 Model model) throws Exception {
//		System.out.println("/frontend/change_password");
//		
//		User user = (User)session.getAttribute("user");
//		
//		// 將 password 進行 AES 加密 -------------------------------------------------------------------
//		final String KEY = KeyUtil.getSecretKey();
//		SecretKeySpec aesKeySpec = new SecretKeySpec(KEY.getBytes(), "AES");
//		byte[] encryptedOldPasswordECB = KeyUtil.encryptWithAESKey(aesKeySpec, oldPassword);
//		String encryptedOldPasswordECBBase64 = Base64.getEncoder().encodeToString(encryptedOldPasswordECB);
//		//-------------------------------------------------------------------------------------------
//		
//		if(!user.getPassword().equals(encryptedOldPasswordECBBase64)) {
//			model.addAttribute("errorMessage", "原密碼錯誤");
//			return "group_buy/frontend/profile";
//		}
//		if(!newPasswords.get(0).equals(newPasswords.get(1))) {
//			model.addAttribute("errorMessage", "二次新密碼不一致");
//			return "group_buy/frontend/profile";
//		}
//		// 將新密碼加密
//		byte[] encryptedNewPasswordECB = KeyUtil.encryptWithAESKey(aesKeySpec, newPasswords.get(0));
//		String encryptedNewPasswordECBBase64 = Base64.getEncoder().encodeToString(encryptedNewPasswordECB);
//		// 進行密碼變更
//		dao.updateUserPassword(user.getUserId(), encryptedNewPasswordECBBase64);
//		return "redirect:/mvc/group_buy/logout";
//	}
	
	@RequestMapping(value = "/frontend/change_password", method = RequestMethod.POST)
	public String changePassword(@RequestParam("oldPassword") String oldPassword, 
								 @RequestParam("newPassword") String newPasswords,
								 @RequestParam("newPassword") String confirmNewPassword,
								 HttpSession session,
								 Model model) throws Exception {
		System.out.println("/frontend/change_password");
		
		User user = (User)session.getAttribute("user");
		
		// 將 password 進行 AES 加密 -------------------------------------------------------------------
		final String KEY = KeyUtil.getSecretKey();
		SecretKeySpec aesKeySpec = new SecretKeySpec(KEY.getBytes(), "AES");
		byte[] encryptedOldPasswordECB = KeyUtil.encryptWithAESKey(aesKeySpec, oldPassword);
		String encryptedOldPasswordECBBase64 = Base64.getEncoder().encodeToString(encryptedOldPasswordECB);
		//-------------------------------------------------------------------------------------------
		
		if(!user.getPassword().equals(encryptedOldPasswordECBBase64)) {
			model.addAttribute("errorMessage", "原密碼錯誤");
			return "group_buy/frontend/profile";
		}
//		if(!newPasswords.get(0).equals(newPasswords.get(1))) {
//			model.addAttribute("errorMessage", "二次新密碼不一致");
//			return "group_buy/frontend/profile";
//		}
		if(!newPasswords.equals(confirmNewPassword)) {
			model.addAttribute("errorMessage", "二次新密碼不一致");
			return "group_buy/frontend/profile";
		}
		// 將新密碼加密
		byte[] encryptedNewPasswordECB = KeyUtil.encryptWithAESKey(aesKeySpec, newPasswords);
		String encryptedNewPasswordECBBase64 = Base64.getEncoder().encodeToString(encryptedNewPasswordECB);
		// 進行密碼變更
		dao.updateUserPassword(user.getUserId(), encryptedNewPasswordECBBase64);
		return "redirect:/mvc/group_buy/logout";
	}
	
	// 得到目前所有 session attribute names
	@GetMapping("/findAllSessionNames")
	@ResponseBody
	public String findAllSessionNames(HttpSession session) {
		StringBuilder names = new StringBuilder();
		// 目前系統中在使用的
		Enumeration<String> sessionAttrNames = session.getAttributeNames();
		while (sessionAttrNames.hasMoreElements()) {
			String name = (String) sessionAttrNames.nextElement();
			names.append(name + "\n");
		}
		return names.toString();
	}
	
	//------------------------------------------------------------------------------
	
	// 後臺首頁
	@GetMapping("/backend/main")
	public String backendMain(@ModelAttribute Product product, Model model, HttpSession session) {
		// 建立一個 csrf_token 防止 csrf 攻擊
		String csrf_token = UUID.randomUUID().toString(); // 得到一個隨機的唯一識別碼
		// 將 csrf_token 存放到 session 物件中
		session.setAttribute("csrf_token", csrf_token);
		
		model.addAttribute("products", dao.findAllProducts());
		model.addAttribute("units", units);
		model.addAttribute("csrf_token", csrf_token);
		return "group_buy/backend/main";
	}
	
	// 商品新增
	@PostMapping("/backend/addProduct")
	public String addProduct(@ModelAttribute Product product, 
							 @RequestParam("csrf_token") String csrf_token, 
							 HttpSession session) {
		// 比對 csrf_token 與 session 中的 csrf_token
		if(csrf_token.equals(session.getAttribute("csrf_token").toString())) {
			// 比對成功進行新增程序
			dao.addProduct(product); 
			return "group_buy/backend/result";
		} else {
			return "redirect:/mvc/group_buy/logout"; // 強制登出
		}
	}
	
	// 商品上下架處理
	@GetMapping("/backend/update_product_launch")
	public String updateProductLaunch(@RequestParam("productId") Integer productId, 
									  @RequestParam("isLaunch") Boolean isLaunch) {
		
		dao.updateProductLaunch(productId, isLaunch);
		
		return "redirect:/mvc/group_buy/backend/main";
	}	
	
	// 後臺報表
	@GetMapping("/backend/report")
	public String report(Model model, @RequestParam(name = "userId", defaultValue = "0") Integer userId) {
		model.addAttribute("reports", dao.calculateTotalAmountPerUser());
		if(userId != 0) {
			model.addAttribute("reportUser", dao.findUserById(userId).get());
			// 該使用者已結帳的購物車紀錄
			model.addAttribute("carts", dao.findCartsbyUserIdAndCheckoutStatus(userId, true));
		}
		return "/group_buy/backend/report";
		
	}
	
	@GetMapping("/frontend/profile")
	public String getOrder(HttpSession session, Model model) {
		// 1. 先找到 user 登入者
		User user = (User)session.getAttribute("user");
//		List<Cart> allCarts=dao.findAllCart();
//        List<Cart> checkoutCarts = allCarts.stream()
//                .filter(cart -> cart.getIsCheckout() != null && cart.getIsCheckout())
//                .collect(Collectors.toList());
//        for (Cart cart : checkoutCarts) {
//			dao.enrichCartWithDetails(cart);
//			System.out.println(cart.getCartItems());
//		}
//        findCartsbyUserIdAndCheckoutStatus(Integer userId, Boolean isCheckout)
//        findCartsbyUserIdAndCheckoutStatus
		List<Cart> checkoutCarts =dao.findCartsbyUserIdAndCheckoutStatus(user.getUserId(), true);
       
        model.addAttribute("checkoutCarts",checkoutCarts);	
        return "group_buy/frontend/profile";
	}


//	 導出功能
	@GetMapping("/getOrderHistoryCsv")
	public ResponseEntity<byte[]> getOrderHistoryCsv(HttpSession session) {
	    User sessionUser = (User) session.getAttribute("user");
	User user = dao.findUserById(sessionUser.getUserId()).get();
//	List<Cart> carts = dao.findCartsByUserId(user.getUserId());
//	List<Cart> orderHistorys = carts.stream()
//	        .filter(cart -> cart.getIsCheckout() != null && cart.getIsCheckout())
//	        .collect(Collectors.toList());
	List<Cart> checkoutCarts =dao.findCartsbyUserIdAndCheckoutStatus(user.getUserId(), true);

	try {
	    ByteArrayOutputStream stream = new ByteArrayOutputStream();
	    CSVWriter writer = new CSVWriter(new OutputStreamWriter(stream));
	    String[] header = { "Item"," Product Name" ," Price","Unit" ,"Quantity" , "Total Price" };
	    writer.writeNext(header);
//	    for (Cart cart : checkoutCarts) {
//	        String[] data = { String.valueOf(cart.getCartId()),cart.getUserId().toString(),cart.getCartItems().toString(), cart.getCheckoutTime().toString() };
//	        writer.writeNext(data);
//	    }
        for (Cart cart : checkoutCarts) { //使用 checkoutCarts 遍歷了每個 Cart對象
        	for(CartItem item:cart.getCartItems()) { //再使用第二個 c:forEach 遍歷了其中的 cartItems
        		String[] data = {
        			    Integer.toString(item.getItemId()),
        			    item.getProduct().getProductName(),
        			    Double.toString(item.getProduct().getPrice()),  // Assuming price is of type double
        			    item.getProduct().getUnit(),
        			    Integer.toString(item.getQuantity()),
        			    Double.toString(item.getProduct().getPrice() * item.getQuantity())
        			};

                writer.writeNext(data);
        	}
        }
	    writer.close();
	    byte[] bytes = stream.toByteArray();
	
	    HttpHeaders headers = new HttpHeaders();
	    headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename = order_history.csv");
	
	        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
	    } catch (IOException e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
}