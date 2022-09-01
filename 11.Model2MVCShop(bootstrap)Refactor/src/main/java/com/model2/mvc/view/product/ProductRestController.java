package com.model2.mvc.view.product;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.upload.UploadService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productServiceImpl;
	
	@Autowired
	@Qualifier("uploadServiceImpl")
	UploadService uploadServiceImpl;

	public ProductRestController() {
		System.out.println(getClass() + " default Constructor()]");
		System.out.println("pageSize : " + pageSize);
		System.out.println("pageUnit : " + pageUnit);
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value = "json/getProduct/{prodNo}/{menu}", method = RequestMethod.GET )
	public Map<String, Object> getProduct(@PathVariable int prodNo, @PathVariable String menu) throws Exception {
		System.out.println("json/getProduct : GET");
		List<Upload> uploadList = uploadServiceImpl.getUploadFile(productServiceImpl.getProduct(prodNo).getFileName());		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productVO", productServiceImpl.getProduct(prodNo));
		map.put("uploadList", uploadServiceImpl.getUploadFile(productServiceImpl.getProduct(prodNo).getFileName()));
		map.put("count", uploadList.get(0).getFileCount());
		return map;
	}
	
	@RequestMapping( value = "autocompleteProduct", method = RequestMethod.POST )
	public List<String> autocompleteProduct( @RequestBody Search search) throws Exception {
		System.out.println("/autocompleteProduct : POST");
		System.out.println(search);
		return productServiceImpl.autocompleteProduct(search);
	}
	
	@RequestMapping( value = "/json/listProduct", method = RequestMethod.POST )
	//public List<Map<String, Object>> listProduct( @RequestBody Search search, String menu) throws Exception {
	public List<Product> listProduct( @RequestBody Search search) throws Exception {
		System.out.println("/product/json/listProduct : POST");
		System.out.println(search);

		search = new Search(search.getCurrentPage(), search.getSearchCondition(), search.getSearchKeyword(), pageSize, search.getPriceSort());
		
		// 검색정보를 넣어서 현재 페이지의 list를 가져온다
		List<Product> prodList = productServiceImpl.getProductList(search);		
		
		for (int i = 0; i < prodList.size(); i++) {
			System.out.println(getClass() + " : " + prodList.get(i).toString());
		}
		
		for (int i = 0; i < prodList.size(); i++) {
			prodList.get(i).setFileName(uploadServiceImpl.getUploadFile(prodList.get(i).getFileName()).get(0).getFileName());
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchVO", search);
		map.put("list", prodList);
		List resultValue = new ArrayList();
		resultValue.add(search);
		resultValue.add(prodList);
		
		for (int i = 0; i < resultValue.size(); i++) {
			System.out.println(resultValue.get(i));
		}
		
		return prodList;
	}

}


