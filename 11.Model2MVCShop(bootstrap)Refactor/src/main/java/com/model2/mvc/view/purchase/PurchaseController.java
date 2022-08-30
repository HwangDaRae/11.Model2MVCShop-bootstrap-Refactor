package com.model2.mvc.view.purchase;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.upload.UploadService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseServiceImpl;
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productServiceImpl;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	CartService cartServiceImpl;
	
	@Autowired
	@Qualifier("uploadServiceImpl")
	UploadService uploadServiceImpl;

	public PurchaseController() {
		System.out.println(getClass() + " default Constructor()]");
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@RequestMapping(value = "listPurchase", method = RequestMethod.GET )
	public ModelAndView listPurchase(HttpSession session, Model model ) throws Exception {
		System.out.println("/purchase/listPurchase : GET");
		Search searchVO = new Search();
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		
		int currentPage = 1;
		if(searchVO.getCurrentPage() != 0) {
			currentPage = searchVO.getCurrentPage();
		}
		searchVO.setCurrentPage(currentPage);
		searchVO.setPageSize(pageSize);
		
		List<Purchase> purchaseList = purchaseServiceImpl.getPurchaseList(searchVO, userId);
		int count = purchaseServiceImpl.totalCountPurchaseList(userId);
		
		Page resultPage = new Page(currentPage, count, pageUnit, pageSize);
		
		model.addAttribute("list", purchaseList);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("searVO", searchVO);
		model.addAttribute("userId", userId);

		return new ModelAndView("/purchase/listPurchase.jsp", "model", model);
	}
	
	@RequestMapping(value = "listPurchase", method = RequestMethod.POST )
	public ModelAndView listPurchase(Search searchVO, HttpSession session, Model model ) throws Exception {
		System.out.println("/purchase/listPurchase : GET");
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		
		int currentPage = 1;
		if(searchVO.getCurrentPage() != 0) {
			currentPage = searchVO.getCurrentPage();
		}
		searchVO.setCurrentPage(currentPage);
		searchVO.setPageSize(pageSize);
		
		List<Purchase> purchaseList = purchaseServiceImpl.getPurchaseList(searchVO, userId);
		int count = purchaseServiceImpl.totalCountPurchaseList(userId);
		
		Page resultPage = new Page(currentPage, count, pageUnit, pageSize);
		
		model.addAttribute("list", purchaseList);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("searVO", searchVO);
		model.addAttribute("userId", userId);

		return new ModelAndView("/purchase/listPurchase.jsp", "model", model);
	}
	
	@RequestMapping( value = "addPurchaseView", method = RequestMethod.POST )
	public ModelAndView addPurchaseView(@RequestParam("prod_no") int prod_no, @RequestParam("amount") int amount, Model model) throws Exception {
		System.out.println("/purchase/addPurchaseView : POST");
		
		model.addAttribute("productVO", productServiceImpl.getProduct(prod_no));
		model.addAttribute("amount", amount);
		
		return new ModelAndView("/purchase/addPurchaseView.jsp", "model", model);
	}
	
	@RequestMapping( value = "addPurchase", method = RequestMethod.POST )
	public ModelAndView addPurchase(@ModelAttribute("purchaseVO") Purchase purchaseVO, @RequestParam("amount") int[] amount, @RequestParam("prodNo") int prodNo, HttpSession session, Model model) throws Exception {
		System.out.println("/purchase/addPurchase : POST");

		List<Purchase> list = new ArrayList<Purchase>();
		List<Product> prodList = new ArrayList<Product>();
		Product productVO = new Product();
		
		//�ֹ���ȣ�� ���� �ĺ����ִ� ��
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		String tranId = sdf1.format( Calendar.getInstance().getTime() ) + "";
		System.out.println("purchaseVO.toString() defore : " + purchaseVO.toString());
		
    	// ���������⿡�� ����
		// �ֹ���ȣ �ֱ�
		purchaseVO.setTranId(tranId);
    	//���������� ��ǰ����
    	productVO = productServiceImpl.getProduct(prodNo);
    	purchaseVO.setPurchaseProd(productVO);        	
    	// ���������� ��������
		purchaseVO.setBuyer((User)session.getAttribute("user"));
		// ������ ��ǰ�� ��������
		purchaseVO.setAmount(amount[0]);			
		// ������ ��ǰ�� totalPrice
		purchaseVO.setTotalPrice(amount[0] * productVO.getPrice());

		// ��ǰ ���� -= ������ ����
		productVO.setAmount(productVO.getAmount() - amount[0]);
		productServiceImpl.updateProduct(productVO);

		// ����ǰ������ ���������� PurchaseVO�� �ִ´�
		purchaseServiceImpl.addPurchase(purchaseVO, productVO);
		list = purchaseServiceImpl.getPurchaseFromTranId(tranId);
		
		for (int i = 0; i < list.size(); i++) {
			Product product = new Product();
			System.out.println(list.get(i).getPurchaseProd().getProdNo());
			product = productServiceImpl.getProduct(list.get(i).getPurchaseProd().getProdNo());
			System.out.println(prodNo);
			prodList.add(product);
		}
		
		List<Upload> uploadList = uploadServiceImpl.getUploadFile(prodList.get(0).getFileName());

		model.addAttribute("list", list);
		model.addAttribute("prodList", prodList);
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("count", uploadList.size());
		
		return new ModelAndView("/purchase/addPurchase.jsp", "model", model);
	}
	
	@RequestMapping(value = "addCartPurchase", method = RequestMethod.POST )
	public ModelAndView addCartPurchase(@ModelAttribute("purchaseVO") Purchase purchaseVO, @RequestParam("amountArr") int[] amountArr, @RequestParam("productNo") int productNo[], HttpSession session, HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
		System.out.println("/purchase/addCartPurchase : POST");

		List<Purchase> list = new ArrayList<Purchase>();
		List<Product> prodList = new ArrayList<Product>();
		Product productVO = new Product();
		List<String> uploadList = new ArrayList<String>();
		
		//�ֹ���ȣ�� ���� �ĺ����ִ� ��
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		String tranId = sdf1.format( Calendar.getInstance().getTime() ) + "";
		// 2022-08-03 16:32:16
        String charsToRemove = "- :";
        for (char c : charsToRemove.toCharArray()) {
        	tranId = tranId.replace(String.valueOf(c), "");
        }
        //20220803163216
		System.out.println("purchaseVO.toString() defore : " + purchaseVO.toString());
		
		
		int totalPrice = 0;
		// ��ٱ��Ͽ��� ����
    	// �迭�� �� ��ǰ��ȣ�� ��ǰ���� ���
		for (int i = 0; i < productNo.length; i++) {
			System.out.println("��ǰ��ȣ : " + productNo[i] + ", ��ǰ���� : " + amountArr[i]);
			System.out.println("�������� : " + purchaseVO);
			
			// �ֹ���ȣ �ֱ�
			purchaseVO.setTranId(tranId);
			// ��ǰ���� ��������
			productVO = productServiceImpl.getProduct(productNo[i]);
			purchaseVO.setPurchaseProd(productVO);
			// �������� ��������
			User user = new User();
			user.setUserId( ((User)session.getAttribute("user")).getUserId() );
			purchaseVO.setBuyer(user);
			// ������ ��ǰ�� ��������
			purchaseVO.setAmount(amountArr[i]);
			
			// ��ǰ���� = ��ǰ���� - ���ż���
			productVO.setAmount(productVO.getAmount() - amountArr[i]);
			productServiceImpl.updateProduct(productVO);	

			// ����ǰ������ ���������� PurchaseVO�� �ִ´�
			purchaseServiceImpl.addPurchase(purchaseVO, productVO);

			Map<String, Object> map = new HashMap<String, Object>();
			// ��ٱ��Ͽ��� ����
			map.put("user_id", ((User)session.getAttribute("user")).getUserId());
			map.put("deleteArray", productNo);
			
			if( !((User)session.getAttribute("user")).getUserId().equals("non-member") ) {
				cartServiceImpl.deleteCart(map);
			}else {
				// ��Ű���� ����
				for (int j = 0; j < productNo.length; j++) {
					System.out.println("productNo : " + productNo[j]);
				}
				
				String cookieValue = "";
				Cookie[] cookies = request.getCookies();
				if(cookies != null && cookies.length > 0) {
					for (int j = 0; j < cookies.length; j++) {
						if(cookies[j].getName().equals("prodInfoCookie")) {
							cookieValue = URLDecoder.decode(cookies[i].getValue());
						}
					}
				}
				
				System.out.println("cookieValue : " + cookieValue);
				
				for (int k = 0; k < productNo.length; k++) {
					int returnIndexStart = cookieValue.indexOf(productNo[k]+"");
					System.out.println("return�� index : " + returnIndexStart);
					int returnIndexEnd = cookieValue.substring(returnIndexStart).indexOf(",");
					System.out.println("returnIndexEnd : " + returnIndexEnd);
					if(returnIndexEnd == -1) {
						cookieValue = cookieValue.substring(0, returnIndexStart-1);
					}else {
						if(returnIndexStart == 0) {
							cookieValue = cookieValue.substring(returnIndexStart + returnIndexEnd + 1);
						}else {
							cookieValue = cookieValue.substring(0, returnIndexStart-1) + cookieValue.substring(returnIndexStart + returnIndexEnd);
						}
					}
					System.out.println("cookieValue : " + cookieValue);
				}
				
				Cookie c = new Cookie("prodInfoCookie", URLEncoder.encode(cookieValue));
				c.setMaxAge(24*60*60);
				response.addCookie(c);
			}

			totalPrice += productVO.getPrice() * purchaseVO.getAmount();
        }

		list = purchaseServiceImpl.getPurchaseFromTranId(tranId);
		System.out.println(list.size());
		
		for (int i = 0; i < list.size(); i++) {
			Product p = new Product();
			list.get(i).setTotalPrice(totalPrice);
			int prodPurchaseNo = list.get(i).getPurchaseProd().getProdNo();
			System.out.println("tranId�� ������ ��ǰ��ȣ : " + prodPurchaseNo);
			p = productServiceImpl.getProduct(prodPurchaseNo);
			prodList.add(p);
		}
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).toString());
			System.out.println(prodList.get(i).toString());
		}

		for (int i = 0; i < prodList.size() ; i++) {
			uploadList.add(uploadServiceImpl.getUploadFile(prodList.get(i).getFileName()).get(0).getFileName());
		}
		
		for (int i = 0; i < uploadList.size(); i++) {
			System.out.println("��� ������ " + uploadList.get(i));
		}
		
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("count", uploadList.size());
		model.addAttribute("list", list);
		model.addAttribute("prodList", prodList);
		
		return new ModelAndView("/purchase/addPurchase.jsp", "model", model);
	}
	
	@RequestMapping(value = "getPurchaseFromTranId", method = RequestMethod.GET )
	public ModelAndView getPurchaseFromTranId(@RequestParam String tranId, Model model) throws Exception {
		System.out.println("/purchase/getPurchaseFromTranId : GET");
		
		List<Purchase> purList = (List<Purchase>)purchaseServiceImpl.getPurchaseFromTranId(tranId);
		List<String> uploadList = new ArrayList<String>();

		List<Product> proList = new ArrayList<Product>();
		for (int i = 0; i < purList.size(); i++) {
			purList.get(i).setTranCode(purList.get(i).getTranCode().trim());
			Product product = new Product();
			product = productServiceImpl.getProduct(purList.get(i).getPurchaseProd().getProdNo());
			proList.add(product);
		}
		
		for (int i = 0; i < proList.size(); i++) {
			uploadList.add(uploadServiceImpl.getUploadFile(proList.get(i).getFileName()).get(0).getFileName());
		}
		
		for (int i = 0; i < uploadList.size(); i++) {
			System.out.println(uploadList);
		}
				
		model.addAttribute("purList", purList);
		model.addAttribute("proList", proList);
		model.addAttribute("uploadList", uploadList);
		
		return new ModelAndView("/purchase/getPurchase.jsp", "model", model);
	}
	
	@RequestMapping(value = "updatePurchaseView", method = RequestMethod.GET )
	public ModelAndView updatePurchaseView(@RequestParam int tranNo, Model model) throws Exception {
		System.out.println("/purchase/updatePurchaseView : POST");
		
		Purchase purchaseVO = purchaseServiceImpl.getPurchase(tranNo);
		Product productVO = productServiceImpl.getProduct(purchaseVO.getPurchaseProd().getProdNo());
		
		model.addAttribute("purchaseVO", purchaseVO);
		model.addAttribute("productVO", productVO);
		
		return new ModelAndView("/purchase/updatePurchaseView.jsp", "model", model);
	}
	
	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST )
	public ModelAndView updatePurchase(@ModelAttribute("purchaseVO") Purchase purchaseVO, Model model) throws Exception {
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseVO = purchaseServiceImpl.updatePurchase(purchaseVO);
		purchaseVO.setTotalPrice(purchaseVO.getAmount() * purchaseVO.getPurchaseProd().getPrice());
		
		model.addAttribute("purchaseVO", purchaseVO);
		
		return new ModelAndView("/purchase/updatePurchase.jsp", "model", model);
	}
	
	@RequestMapping(value = "updateTranCode", method = RequestMethod.GET )
	public ModelAndView updateTranCode(@RequestParam int tranNo, @RequestParam String tranCode, @RequestParam("currentPage") int currentP, HttpSession session, Model model, Search searchVO) throws Exception {
		System.out.println("/purchase/updateTranCode : GET");
		//user���� : ����� => ��ۿϷ�
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tranNo", tranNo);
		map.put("prodNo", 0);
		map.put("tranCode", tranCode);
		
		purchaseServiceImpl.updateTranCode(map);

		//list�� ���ؼ�
		int currentPage = 1;
		if(currentP != 0) {
			currentPage = currentP;
		}
		searchVO.setCurrentPage(currentPage);
		searchVO.setPageSize(pageSize);
		
		String userId = ( (User)session.getAttribute("user") ).getUserId();
		List<Purchase> purchaseList = purchaseServiceImpl.getPurchaseList(searchVO, userId);		
		Page resultPage = new Page(currentPage, purchaseServiceImpl.totalCountPurchaseList(userId), pageUnit, pageSize);
		
		model.addAttribute("list", purchaseList);
		model.addAttribute("searVO", searchVO);
		model.addAttribute("resultPage", resultPage);
		
		return new ModelAndView("/purchase/listPurchase.jsp", "model", model);
	}
	
	@RequestMapping(value = "updateTranCodeByProd", method = RequestMethod.GET )
	public ModelAndView updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("currentPage") int currentP, @RequestParam("tranCode") int tranCode,
			@RequestParam("menu") String menu, Search searchVO, Model model) throws Exception {
		System.out.println("/purchase/updateTranCodeByProd : GET");
		// admin���� : ���ſϷ� => �����
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tranNo", 0);
		map.put("prodNo", prodNo);
		map.put("tranCode", tranCode);
		
		purchaseServiceImpl.updateTranCode(map);
		
		//list�� ���ؼ�		
		int currentPage = 1;
		if(currentP != 0) {
			currentPage = currentP;
		}
		searchVO.setCurrentPage(currentPage);
		searchVO.setPageSize(pageSize);

		List<Product> prodList = productServiceImpl.getProductList(searchVO);		
		Page resultPage = new Page(currentPage, productServiceImpl.getProductTotalCount(searchVO), pageUnit, pageSize);
		
		model.addAttribute("list", prodList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("menu", menu);
		
		return new ModelAndView("/product/listProduct.jsp", "model", model);
	}
	
	@RequestMapping( value = "nonMemberPurchase", method = RequestMethod.GET )
	public ModelAndView noMemPurchase() throws Exception {
		return new ModelAndView("/purchase/nonMemberPurchase.jsp");
	}
	
	@RequestMapping( value = "getNonMemPurchase", method = RequestMethod.POST )
	public ModelAndView getNonMemPurchase(@RequestParam("tranId") String tranId, Model model) throws Exception {
		System.out.println("/purchase/getNonMemPurchase : POST");
		System.out.println(tranId);
		List<String> uploadList = new ArrayList<String>();
		
		//��ȸ�� �ֹ���ȸ
		List<Purchase> purList = purchaseServiceImpl.getPurchaseFromTranId(tranId);
		List<Product> proList = new ArrayList<Product>();
		for (int i = 0; i < purList.size(); i++) {
			purList.get(i).setTranCode(purList.get(i).getTranCode().trim());
			Product productVO = new Product();
			productVO = productServiceImpl.getNonMemberPurchase(purList.get(i).getTranNo());
			proList.add(productVO);
		}

		for (int i = 0; i < proList.size() ; i++) {
			uploadList.add(uploadServiceImpl.getUploadFile(proList.get(i).getFileName()).get(0).getFileName());
		}

		model.addAttribute("uploadList", uploadList);
		model.addAttribute("purList", purList);
		model.addAttribute("proList", proList);
		
		return new ModelAndView("/purchase/getPurchase.jsp", "model", model);
	}

}
