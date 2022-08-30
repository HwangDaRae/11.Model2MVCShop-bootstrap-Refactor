package com.model2.mvc.view.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{		
		System.out.println("/user/json/getUser : GET");
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login( @RequestBody User user, HttpSession session ) throws Exception{
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping( value="json/checkDuplication", method=RequestMethod.POST )
	public Map<String, Object> checkDuplication( @RequestBody User user ) throws Exception{

		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(user.getUserId());
		// Model �� View ����
		// true => ��� �����ϴ�, false => ��� �Ұ����ϴ�
		String comment = "��밡���� ���̵��Դϴ�";
		Map<String, Object> map = new HashMap<String, Object>();
		if(!result) {
			comment = "�̹� ����ϰ� �ִ� ���̵��Դϴ�";
		}
		map.put("result", comment);

		return map;
	}
	
	@RequestMapping( value="json/listUser", method = RequestMethod.POST )
	public List<User> listUser( @RequestBody Search search , Model model ) throws Exception{
		
		System.out.println("/user/json/listUser : POST ");
		System.out.println("search : " + search);
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map = userService.getUserList(search);
		List<User> list = (List<User>)map.get("list");
		
		for (int i = 0; i < list.size() ; i++) {
			System.out.println(list.get(i));
		}
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return list;
	}
	
}