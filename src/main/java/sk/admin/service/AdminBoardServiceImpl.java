package sk.admin.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sk.admin.dao.AdminBoardDAO;

@Service("adminBoardService")
public class AdminBoardServiceImpl implements AdminBoardService {

	@Resource(name = "adminBoardDAO")
	private AdminBoardDAO adminBoardDAO;

	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectNoticeList(map);
	}

	@Override
	public int selectNoticeCount(Map<String, Object> map) throws Exception {
		return adminBoardDAO.selectNoticeCount(map);
	}

	@Override
	public int insertNotice(Map<String, Object> map) throws Exception {
		return adminBoardDAO.insertNotice(map);

	}

	@Override
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {

		return adminBoardDAO.selectNoticeDetail(map);
	}

	@Override
	public int updateNoticeModify(Map<String, Object> map) throws Exception {

		return adminBoardDAO.updateNoticeModify(map);
	}

	@Override
	public int adminDeleteNotice(Map<String, Object> map) throws Exception {

		return adminBoardDAO.deleteNotice(map);
	}

	@Override
	public List<Map<String, Object>> selectTotalGoodsList(Map<String, Object> map) throws Exception {
		return adminBoardDAO.selectTotalGoodsList(map);
	}

	@Override
	public int selectTotalGoodsListCount(Map<String, Object> map) throws Exception {
		return adminBoardDAO.selectTotalGoodsListCount(map);
	}

	@Transactional
	@Override
	public int adminDeleteGoods(Map<String, Object> map) throws Exception {

		adminBoardDAO.adminDeleteGoods(map);
		adminBoardDAO.adminDeleteGoodsImage(map);

		return 1;
	}

	@Override
	public void adminDeleteGoodsImage(Map<String, Object> map) throws Exception {

		adminBoardDAO.adminDeleteGoodsImage(map);
	}
}
