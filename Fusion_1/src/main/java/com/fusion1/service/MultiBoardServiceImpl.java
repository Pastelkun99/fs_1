package com.fusion1.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fusion1.dao.ArticleVO;
import com.fusion1.dao.MenuVO;
import com.fusion1.dao.MultiBoardVO;
import com.fusion1.dao.PagenationVO;
import com.fusion1.dao.ReadNoticeVO;

@Service
public class MultiBoardServiceImpl implements MultiBoardService {
	
	@Resource(name="sqlSession")
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<ArticleVO> getArticleListByBoardNo(MultiBoardVO multiVO) {
		return sqlSession.selectList("multiBoardMapper.getArticleListByBoardNo", multiVO);
	}
	
	@Override
	public List<ArticleVO> getArticleListByBoardNo2(PagenationVO page) {
		return sqlSession.selectList("multiBoardMapper.getArticleListByBoardNo2", page);
	}

	@Override
	public ArticleVO getArticleCountByBoardNo(MultiBoardVO multiVO) {
		return sqlSession.selectOne("multiBoardMapper.getArticleCountByBoardNo", multiVO);
	}

	@Override
	public List<ArticleVO> getArticleSearchList(PagenationVO page) {
		return sqlSession.selectList("multiBoardMapper.getArticleSearchList", page);
	}

	@Override
	public ArticleVO getArticleSearchCount(PagenationVO page) {
		return sqlSession.selectOne("multiBoardMapper.getArticleSearchCount", page);
	}

	@Override
	public ArticleVO getArticleOne(int article_no) {
		return sqlSession.selectOne("multiBoardMapper.getArticleOne", article_no);
	}

	@Override
	public int articleHitUpdate(int article_no) {
		return sqlSession.update("multiBoardMapper.articleHitUpdate", article_no);
	}

	@Override
	public int articleDelete(ArticleVO articleVO) {
		return sqlSession.update("multiBoardMapper.articleDelete", articleVO);
	}

	@Override
	public int articleUpdate(ArticleVO articleVO) {
		return sqlSession.update("multiBoardMapper.articleUpdate", articleVO);
	}

	@Override
	public int articleInsert(ArticleVO articleVO) {
		return sqlSession.insert("multiBoardMapper.articleInsert", articleVO);
	}

	@Override
	public ArticleVO getPreventInsertedArticle() {
		return sqlSession.selectOne("multiBoardMapper.getPreventInsertedArticle");
	}
	
	@Override
	public int articleParentsnoUpdate(int article_no) {
		return sqlSession.update("multiBoardMapper.articleParentsnoUpdate", article_no);
	}

	@Override
	public int reWriteGroupOrder(ArticleVO articleVO) {
		return sqlSession.update("multiBoardMapper.reWriteGroupOrder", articleVO);
	}

	@Override
	public int reArticleInsert(ArticleVO articleVO) {
		return sqlSession.insert("multiBoardMapper.reArticleInsert", articleVO);
	}

	@Override
	public ArticleVO nonReadNoticeArticle(ReadNoticeVO read) {
		return sqlSession.selectOne("multiBoardMapper.nonReadNoticeArticle", read);
	}

	@Override
	public ArticleVO nonReadNoticeArticleThisBoard(MultiBoardVO multiVO) {
		return sqlSession.selectOne("multiBoardMapper.nonReadNoticeArticleThisBoard", multiVO);
	}

	@Override
	public int writeNoticeInfo(ReadNoticeVO read) {
		return sqlSession.insert("multiBoardMapper.writeNoticeInfo", read);
	}

	@Override
	public List<ArticleVO> getNonReadNoticeList(MultiBoardVO multiVO) {
		return sqlSession.selectList("multiBoardMapper.getNonReadNoticeList", multiVO);
	}
	
}
