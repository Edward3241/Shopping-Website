package spring.mvc.group_buy.controller;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import spring.mvc.group_buy.model.dao.GroupBuyDao;
import spring.mvc.group_buy.model.entity.User;
import spring.mvc.group_buy.util.OAuth2Util;

@Controller
@RequestMapping("/secure/oauth2")
public class SecureCallbackOauth2Controller {
	
	@Autowired
	private GroupBuyDao dao;
	
	@RequestMapping("/login/github")
	public String loginGithub() {
		// 向 Github 驗證授權
		System.out.println("/login/github");
		String auth = OAuth2Util.AUTH_URL;
		return "redirect:" + auth;
	}
	
	@RequestMapping("/callback/github")
	public String callbackGithub(@RequestParam("code") String code, HttpSession session) throws IOException {
		// 已有授權碼(code)之後，可以跟 Github 來得到 token (訪問令牌)
		// 有了 token 就可以得到客戶的公開資訊例如: userInfo
		System.out.println("/callback/github");
		// 1. 根據 code 得到 token
		String token = OAuth2Util.getGitHubAccessToken(code);
		System.out.println("1");
		
		// 2. 透過 token 裡面的 access_token 來取的用戶資訊
		String accessToken = OAuth2Util.parseAccessToken(token);
		System.out.println("2");
		
		// 3. 得到用戶在 Github 上的公開資料
		String userInfo = OAuth2Util.getUserInfoFromGitHub(accessToken);
		System.out.println("3"+userInfo);
		
		// 4. 利用 Gson 來分析資料
		GithubUser githubUser = new Gson().fromJson(userInfo, GithubUser.class);
		System.out.println("4");
		
		// 5. 檢查會員資料表中是否有此人, 若無則將該會員資料自動新增到資料表
		Optional<User> userOpt = dao.findAllUsers().stream()
				.filter(user -> user.getAuthType() != null && user.getAuthId() != null && user.getAuthType().equalsIgnoreCase("github") && user.getAuthId().equalsIgnoreCase(githubUser.id))
				.findFirst();
		System.out.println("5");
		
		User user = null;
		if(userOpt.isEmpty()) {
			System.out.println("6");
			System.out.println(githubUser.login);
			user = new User(0, githubUser.login, "None", 1, "github", githubUser.id);
			System.out.println(user);
			System.out.println("6-1");

			dao.addUser(user);
			System.out.println("6-2");
			
		}
		System.out.println(githubUser.login);
		user = dao.findUserByUsername(githubUser.login).get();
		System.out.println("7");
		
		// 6. 新增成功就自行自動登入 (例如: 建立 user 物件並存放到 session 中)
		session.setAttribute("user", user);
		System.out.println("8");
		
		// 7. 重導到登入成功頁面(前台首頁)
		//return session.getAttribute("user").toString();
		return "redirect:/mvc/group_buy/frontend/main";
	}
	
	@RequestMapping("/callback/google")
	@ResponseBody
	public String callbackGoogle(@RequestParam("code") String code) {
		return code;
	}
	
	class GithubUser {
		public String login;
		public String id;
		public String name;
		public String email;
//		public String service;
		
		@Override
		public String toString() {
			return "GithubUser [login=" + login + ", id=" + id + ", name=" + name + ", email=" + email + "]";
		}
	}
}
