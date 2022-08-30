package com.model2.mvc.view.cart;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.CookieInfo;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.upload.UploadService;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Autowired
	@Qualifier("cartServiceImpl")
	CartService cartServiceImpl;
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productServiceImpl;
	
	@Autowired
	@Qualifier("uploadServiceImpl")
	UploadService uploadServiceImpl;
	
	public CartController() {
		System.out.println(getClass() + " default Constructor()]");
	}

	@RequestMapping(value = "addCart", method = RequestMethod.POST )
	public ModelAndView addCart(HttpServletRequest request,
								HttpServletResponse response,
								@RequestParam("prod_no") int prod_no,
								@RequestParam("amount") int amount,
								HttpSession session,
								Model model) throws Exception {
		System.out.println("/cart/addCart : POST");
		
		Product product = productServiceImpl.getProduct(prod_no);
		// getProduct.jsp���� ��ٱ��� ��ư Ŭ���� ��ٱ��Ͽ� �߰��ȴ�.
		Cart cart = new Cart(prod_no, ((User)session.getAttribute("user")).getUserId(), product.getFileName(), product.getProdName(), product.getProdDetail(), amount, product.getPrice(), product.getAmount());		
		System.out.println("AddCartAction cart : " + cart.toString());
		
		String cookieValue = "";

		//��ȸ�� : ��Ű�� ���� ��ǰ��ȣ, ���� �����´�
		if(((User)session.getAttribute("user")).getUserId().equals("non-member")) {
			System.out.println("��ȸ��");

			List<Cart> cartList = new ArrayList<Cart>();
			List<CookieInfo> returnList = new ArrayList<CookieInfo>();
			
			Cookie[] cookies = request.getCookies();
			
			if(cookies != null && cookies.length > 0) {
				for (int i = 0; i < cookies.length; i++) {
					if(cookies[i].getName().equals("prodInfoCookie")) {
						// ex) 10001:12,10007:5,10013:31
						cookieValue = URLDecoder.decode(cookies[i].getValue());
						System.out.println("������ prodInfoCookie ��Ű�� �ִ� cookieValue : " + cookieValue);
						
						if(cookieValue.trim().length() == 0) {
							//��ٱ��� ��� �װ��� ��ü���� �� ����� �´�
							System.out.println("1.��ٱ��Ͽ� ��ǰ�� �ϳ��� ���� ��");
							CookieInfo c = new CookieInfo(prod_no, amount);
							returnList.add(c);
							cookieValue = prod_no + ":" + amount;
							break;
						}

						// �ι�° ���� ��ٱ��� ��� ������ => list�� �Ľ��ؼ� �ִ´�
						System.out.println("2.��ٱ��Ͽ� �����Ͱ� �ϳ��� ���� �� List�� ���");
						int secondCheck = cookieValue.indexOf(",");

						// list�� ������ ��Ű�� �Ľ��� �ִ´�
						if(secondCheck == -1) {
							//��ٱ��Ͽ� ��ǰ�� �ϳ��� ���� ��
							String[] arr = cookieValue.split(":");
							CookieInfo c = new CookieInfo(Integer.parseInt(arr[0]), Integer.parseInt(arr[1]));
							returnList.add(c);
						}else {
							String[] arr = cookieValue.split(",");
							for (int j = 0; j < arr.length; j++) {
								String[] subArr = arr[j].split(":");
								CookieInfo c = new CookieInfo(Integer.parseInt(subArr[0]), Integer.parseInt(subArr[1]));
								returnList.add(c);
							}
						}												
						System.out.println("�Ľ��ؼ� ���� list : " + returnList);
						
						// ���� ���� ��ǰ�� ��ȣ�� list�� �ִ� ��ǰ��ȣ�� ���ٸ� ������ �߰�
						boolean isSameProdNo = false;
						for (int j = 0; j < returnList.size(); j++) {
							if(returnList.get(j).getProd_no() == prod_no) {
								isSameProdNo = true;
								returnList.get(j).setAmount(returnList.get(j).getAmount() + amount);
							}
						}
						
						if(!isSameProdNo) {
							returnList.add(new CookieInfo(prod_no, amount));
						}

						// ���� ������ list�� �ٽ� String���� ��ȯ
						cookieValue = "";
						for (int j = 0; j < returnList.size(); j++) {
							cookieValue += returnList.get(j).getProd_no() + ":" + returnList.get(j).getAmount() + ",";
							if(j==returnList.size()-1) {
								cookieValue = cookieValue.substring(0, cookieValue.length()-1);
								System.out.println(cookieValue);
							}
						}
						
					}else{
						// ù��° ��ٱ��� ��� ������ : ���� �����Ͱ� ������ �ٷ� �߰�
						if(cookieValue.trim().length() == 0) {
							System.out.println("1.��ٱ��Ͽ� ��ǰ�� �ϳ��� ���� ��");
							CookieInfo c = new CookieInfo(prod_no, amount);
							returnList.add(c);
							cookieValue = prod_no + ":" + amount;
							break;
						}
					}
				}// end of cookie�� ���� �� for��
				
				// ��Ű�� ��ǰ���� �߰�
				System.out.println("response�� ��Ű ������ cookieValue : " + cookieValue);
				Cookie cookie = new Cookie("prodInfoCookie", URLEncoder.encode(cookieValue));
				cookie.setMaxAge(24*60*60);
				response.addCookie(cookie);

				// ��Ű�� ����� �����͸� list �Ѹ���				
				for (int y = 0; y < returnList.size(); y++) {
					Product productVO = new Product();					
					productVO = productServiceImpl.getProduct(returnList.get(y).getProd_no());
					Cart c = new Cart(productVO.getProdNo(), "", productVO.getFileName(), productVO.getProdName(),
							productVO.getProdDetail(), returnList.get(y).getAmount(), productVO.getPrice(), productVO.getAmount());
					cartList.add(c);
				}//end of cookieValueArr ��ٱ��Ͽ��� �ѷ��� list ��������
				
			}
			
			for (int j = 0; j < cartList.size(); j++) {
				System.out.println("===========> " + cartList.get(j).toString());
			}
			
			model.addAttribute("list", cartList);
			model.addAttribute("count", cartList.size());
		}else {
			// ȸ�� : ���� ��ǰ�� �ִ��� ���� ����Ʈ
			List<Cart> cartList = cartServiceImpl.getCartList( ((User)session.getAttribute("user")).getUserId() );
			List<String> uploadList = new ArrayList<String>();
			
			//��ٱ��� ���θ� �����ͼ� ��ǰ��ȣ�� ���ٸ� �����߰�
			boolean isProdNo = false;
			for (int i = 0; i < cartList.size(); i++) {
				if(cartList.get(i).getProd_no() == prod_no){
					isProdNo = true;
					//��ٱ��Ͽ� ��ǰ�� �ִٸ� => ���� ������Ʈ
					cart.setAmount(cartList.get(i).getAmount() + amount);
					cartServiceImpl.updateAmount(cart);
				}
			}
			
			if(!isProdNo) {
				//��ٱ��Ͽ� ��ǰ�� ���ٸ� => insert
				cartServiceImpl.insertCart(cart);
			}
			//jsp���� ����� list ��ٱ��� list �����´�
			cartList = cartServiceImpl.getCartList( ((User)session.getAttribute("user")).getUserId() );

			for (int i = 0; i < cartList.size() ; i++) {
				uploadList.add(uploadServiceImpl.getUploadFile(cartList.get(i).getImage()).get(0).getFileName());
			}
			
			model.addAttribute("uploadList", uploadList);
			
			model.addAttribute("list", cartList);
			model.addAttribute("count", cartList.size());
		}
		
		return new ModelAndView("/cart/listCart.jsp", "model", model);
	}

	/*
	@RequestMapping(value = "deliveryCart", method = RequestMethod.POST)
	public ModelAndView deliveryCart(@RequestParam("deleteCheckBox") int[] checkProdNo,
									@RequestParam("amount") int[] amount,
			HttpSession session, User user, Model model) throws Exception {
		System.out.println("/cart/deliveryCart : POST");
		List<Purchase> purList = new ArrayList<Purchase>();
		
		for (int i = 0; i < checkProdNo.length; i++) {
			System.out.println(checkProdNo[i]);
			System.out.println(amount[i]);
		}
		
		for (int i = 0; i < checkProdNo.length; i++) {
			Purchase purchaseVO = new Purchase();
			System.out.println("��ǰ��ȣ : " + checkProdNo[i]);
			System.out.println("���� : " + amount[i]);
			
			//������ ��ǰ����
			purchaseVO.setPurchaseProd(productServiceImpl.getProduct(checkProdNo[i]));
			
			//������ ��������
			user.setUserId( ((User)session.getAttribute("user")).getUserId() );
			purchaseVO.setBuyer(user);
			
			//������ ��ǰ�� ��������
			purchaseVO.setAmount(amount[i]);
			
			purList.add(purchaseVO);
		}
		
		for (int i = 0; i < purList.size(); i++) {
			System.out.println("purList : " + purList.get(i));
		}
		
		model.addAttribute("purList", purList);
		model.addAttribute("count", purList.size());
		
		return new ModelAndView("/cart/deliveryCart.jsp", "model", model);
	}
	*/

	///*
	@RequestMapping(value = "deliveryCart", method = RequestMethod.POST)
	public ModelAndView deliveryCart(@RequestParam("addPurchaseCheckBox") int[] allProdNo,
									@RequestParam("deleteCheckBox") int[] checkProdNo,
									@RequestParam("amount") int[] allAmount,
			HttpSession session, User user, Model model) throws Exception {
		System.out.println("/cart/deliveryCart : POST");
		//allAmount => ��� ����, allCheckProdNo => ��� ��ǰ��ȣ, checkedProdNo => üũ�� ��ǰ��ȣ
		//���� ���������� ���� ��� üũ�ڽ��� üũ�� üũ�ڽ��� ���ؼ� index�� �˾Ƴ��� �� index�� �´� ��ǰ��ȣ, ������ ������
		List<Purchase> purList = new ArrayList<Purchase>();
		Product productVO = new Product();
		List<String> uploadList = new ArrayList<String>();

		for (int i = 0; i < allProdNo.length; i++) {
			System.out.println("for��1 : allProdNo[" + i + "] : " + allProdNo[i]);
			for (int j = 0; j < checkProdNo.length; j++) {
				System.out.println("for��2 : checkProdNo[" + j + "] : " + checkProdNo[j]);
				if(allProdNo[i] == checkProdNo[j]) {
					System.out.println("üũ");
					Purchase purchaseVO = new Purchase();
					System.out.println("��ǰ��ȣ : " + checkProdNo[j]);
					System.out.println("���� : " + allAmount[i]);
					
					//������ ��ǰ����
					productVO = productServiceImpl.getProduct(checkProdNo[j]);
					purchaseVO.setPurchaseProd(productVO);
					
					//������ ��������
					System.out.println(user);
					String userId = ((User)session.getAttribute("user")).getUserId();
					System.out.println(userId);
					user.setUserId( userId );
					purchaseVO.setBuyer(user);
					
					//������ ��ǰ�� ��������
					purchaseVO.setAmount(allAmount[i]);
					System.out.println("purchaseVO : " + purchaseVO);
					
					purList.add(purchaseVO);
					System.out.println("purList.toString() : " + purList.toString());
				}
			}
		}
		
		System.out.println("����");
		
		for (int i = 0; i < purList.size(); i++) {
			System.out.println("purList : " + purList.get(i));
		}

		for (int i = 0; i < purList.size() ; i++) {
			uploadList.add(uploadServiceImpl.getUploadFile(purList.get(i).getPurchaseProd().getFileName()).get(0).getFileName());
		}
		
		model.addAttribute("uploadList", uploadList);
		
		model.addAttribute("purList", purList);
		model.addAttribute("count", purList.size());
		
		return new ModelAndView("/cart/deliveryCart.jsp", "model", model);
	}
	//*/

	@RequestMapping(value = "deleteCart", method = RequestMethod.POST)
	public ModelAndView deleteCart( @RequestParam("deleteCheckBox") int[] deleteArr, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		System.out.println("/cart/deleteCart : POST");

		ModelAndView modelAndView = new ModelAndView();
		User user = (User)session.getAttribute("user");
		
		if(user == null || user.getUserId().equals("non-member")) {
			System.out.println("��ȸ��");
			String cookieValue = "";
			
			Cookie[] cookies = request.getCookies();
			if(cookies != null && cookies.length > 0) {
				for (int i = 0; i < cookies.length; i++) {
					if(cookies[i].getName().equals("prodInfoCookie")) {
						cookieValue = URLDecoder.decode(cookies[i].getValue());
						System.out.println("prodInfoCookie���� ã�� value : " + cookieValue);
					}
				}
			}

			List<CookieInfo> cookieList = new ArrayList<CookieInfo>();
			if(cookieValue.length() > 1) {
				String[] prodNoAndAmount = cookieValue.split(",");
				for (int i = 0; i < prodNoAndAmount.length; i++) {
					String[] arr = prodNoAndAmount[i].split(":");
					CookieInfo c = new CookieInfo(Integer.parseInt(arr[0]), Integer.parseInt(arr[1]));
					cookieList.add(c);
				}

				Iterator<CookieInfo> it = cookieList.iterator();
				while (it.hasNext()) {
					CookieInfo tmp = (CookieInfo)it.next();

					for (int i = 0; i < deleteArr.length; i++) {
						if(tmp.getProd_no() == deleteArr[i]) {
							it.remove();
						}
					}		
				}
			}
			
			for (int i = 0; i < cookieList.size(); i++) {
				System.out.println(cookieList.get(i).toString());
			}
			
			System.out.println("======================================================");
			
			cookieValue = "";
			for (int i = 0; i < cookieList.size(); i++) {
				cookieValue = cookieList.get(i).getProd_no() +":"+cookieList.get(i).getAmount()+",";
				if(i == cookieList.size()-1) {
					cookieValue = cookieValue.substring(0, cookieValue.length()-1);
				}
			}
			System.out.println("response �� cookie : " + cookieValue);
			
			Cookie cookie = new Cookie("prodInfoCookie", URLEncoder.encode(cookieValue));
			cookie.setMaxAge(24*60*60);
			response.addCookie(cookie);
			
			//if(cookieValue.trim().length() == 0) {
			//	cookie.getName().setMaxAge(-1);
			//}

			List<Cart> cartList = new ArrayList<Cart>();
			int count = 0;

			// prodInfoCookie ��Ű�� �������� �Ľ��ؼ� list �Ѹ���
			if(cookieValue.length() > 1) {
				String[] prodNoAndAmount = cookieValue.split(",");
				for (int i = 0; i < prodNoAndAmount.length; i++) {
					String cookieInfo[] = prodNoAndAmount[i].split(":");
					Product productVO = productServiceImpl.getProduct(Integer.parseInt(cookieInfo[0]));
					Cart cart = new Cart(productVO.getProdNo(), "", productVO.getFileName(), productVO.getProdName(),
							productVO.getProdDetail(), Integer.parseInt(cookieInfo[1]), productVO.getPrice(), productVO.getAmount());
					cartList.add(cart);
				}
				count = cartList.size();
			}
			
			model.addAttribute("list", cartList);
			model.addAttribute("count", count);
			modelAndView.setViewName("/cart/listCart.jsp");
			
		}else {
			//ȸ���̶��
			Map<String, Object> map = new HashMap<String, Object>();
			List<String> uploadList = new ArrayList<String>();
			
			//������ ��ǰ��ȣ�� user_id�� map�� �ִ´�
			map.put("deleteArray", deleteArr);
			map.put("user_id", ( (User)session.getAttribute("user") ).getUserId() );

			//��ٱ��Ͽ��� ��ǰ�� �����ϰ� ������ list�� �����´�
			cartServiceImpl.deleteCart(map);
			List<Cart> list = cartServiceImpl.getCartList( ( (User)session.getAttribute("user") ).getUserId() );

			for (int i = 0; i < list.size() ; i++) {
				uploadList.add(uploadServiceImpl.getUploadFile(list.get(i).getImage()).get(0).getFileName());
			}
			
			model.addAttribute("uploadList", uploadList);
			model.addAttribute("list", list);
			//count : �Խù� ��, listCart.jsp���� count>0�϶� for������ list���
			model.addAttribute("count", list.size());

			modelAndView.setViewName("/cart/listCart.jsp");
		}
		
		modelAndView.addObject("model", model);
		
		return modelAndView;
	}
	
	@RequestMapping(value = "listCart", method = RequestMethod.GET)
	public ModelAndView listCart(HttpServletRequest request,
								HttpServletResponse response,
								HttpSession session,
								Model model) throws Exception {
		System.out.println("/cart/listCart : GET");
		
		//left.jsp ���̾ �ִ� ��ٱ��� <a href Ŭ���� ������ �´� ��ٱ��� ����Ʈ�� �̵�
		User user = (User)session.getAttribute("user");
		List<String> uploadList = new ArrayList<String>();
		
		if(user.getUserId().equals("non-member")) {
			System.out.println("����� ��ȸ��");
			
			Cookie[] cookies = request.getCookies();
			List<Cart> cartList = new ArrayList<Cart>();
			int count = 0;
			String cookieValue = "";
			
			if(cookies != null && cookies.length > 0) {
				for (int i = 0; i < cookies.length; i++) {
					System.out.println(cookies[i].getName());
					if(cookies[i].getName().equals("prodInfoCookie")) {
						cookieValue = URLDecoder.decode(cookies[i].getValue());
					}
				}

				// prodInfoCookie ��Ű�� �������� �Ľ��ؼ� list �Ѹ���
				if(cookieValue.length() > 1) {
					String[] prodNoAndAmount = cookieValue.split(",");
					for (int i = 0; i < prodNoAndAmount.length; i++) {
						String cookieInfo[] = prodNoAndAmount[i].split(":");
						Product productVO = productServiceImpl.getProduct(Integer.parseInt(cookieInfo[0]));
						Cart cart = new Cart(productVO.getProdNo(), "", productVO.getFileName(), productVO.getProdName(),
								productVO.getProdDetail(), Integer.parseInt(cookieInfo[1]), productVO.getPrice(), productVO.getAmount());
						cartList.add(cart);
					}
					count = cartList.size();
				}
				
			}//end of if cookies

			for (int i = 0; i < cartList.size() ; i++) {
				uploadList.add(uploadServiceImpl.getUploadFile(cartList.get(i).getImage()).get(0).getFileName());
			}
			
			model.addAttribute("list", cartList);
			model.addAttribute("uploadList", uploadList);
			model.addAttribute("count", count);
		}else {
			System.out.println("����� ȸ�� ��ٱ��� ����Ʈ");
			List<Cart> list = new ArrayList<Cart>();
			list = cartServiceImpl.getCartList(user.getUserId());
			
			for (int i = 0; i < list.size() ; i++) {
				uploadList.add(uploadServiceImpl.getUploadFile(list.get(i).getImage()).get(0).getFileName());
			}
			
			for (int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i).toString());
				System.out.println(uploadList.get(i).toString());
			}
			
			model.addAttribute("list", list);
			//count : �Խù� ��, listCart.jsp���� count>0�϶� for������ list���
			model.addAttribute("count", list.size());
			model.addAttribute("uploadList", uploadList);
		}
		
		return new ModelAndView("/cart/listCart.jsp", "model", model);
	}
	
}
