package sk.main.service;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import sk.main.dao.MainDAO;

@Service("mainService")
public class MainServiceImpl implements MainService{
	
	@Resource(name="mainDAO")
	private MainDAO mainDAO;

	@Override
	public List<Map<String, Object>> BrandSearch(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return mainDAO.BrandSearch(map);
	}

	@Override
	public List<Map<String, Object>> ShopSearch(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		return mainDAO.ShopSearch(map);
	}

	@Override
	public int selectShopCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return mainDAO.selectShopCount(map);
	}

	@Override
	public List<Map<String, Object>> GoodsSearch(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		return mainDAO.GoodsSearch(map);

	}

}
