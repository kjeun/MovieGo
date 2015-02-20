package com.mvg.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvg.entity.Movie;
import com.mvg.entity.NowMovie;

@Repository
public class NowMovieDaoImpl implements NowMovieDao {

	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(NowMovieDaoImpl.class);
	}
	
	private final String namespace = "com.mvg.mappers.nowmovieMapper.";
	private final String namespace2 = "com.mvg.mappers.movieMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getAllNowMovieCnt() {
		String stmt = namespace + "getAllNowMovieCnt";
		int result = sqlSession.selectOne(stmt);
		return result;
	}

	@Override
	public List<NowMovie> getAllNowMovies() {
		String stmt = namespace + "getAllNowMovies";
		List<NowMovie> nmovies = sqlSession.selectList(stmt);
		return nmovies;
	}

	@Override
	public List<NowMovie> getNowMovieByMovieCode(String movieCode) {
		String stmt = namespace + "getNowMovieByMovieCode";
		List<NowMovie> nmovies = sqlSession.selectList(stmt, movieCode);
		return nmovies;
	}

	@Override
	public int insertNowMovie(Movie movie) {
		String stmt = namespace + "insertNowMovie";
		int result = sqlSession.insert(stmt, movie);
		return result;
	}

	@Override
	public int updateNowMovie(Movie movie) {
		String stmt = namespace + "updateNowMovie";
		int result = sqlSession.update(stmt, movie);
		return result;
	}

	@Override
	public int deleteNowMovie(String movieCode) {
		String stmt = namespace + "deleteNowMovie";
		int result = sqlSession.delete(stmt, movieCode);
		return result;
	}

	@Override
	public Map<String, String> getAllNowMovieNames(int theaterId) {
		String stmt = namespace + "getAllNowMovieCodes";
		String stmt2 = namespace2 + "getMovieByMovieCode";
		List<String> movieCodes = sqlSession.selectList(stmt, theaterId);
		HashMap<String, String> codesAndNames = new HashMap<String, String>();
		for (int i=0;i<movieCodes.size();i++) {
			String code = movieCodes.get(i);
			Movie movie = sqlSession.selectOne(stmt2, code);
			codesAndNames.put(code, movie.getMovieTitleKr());
		}
		return codesAndNames;
	}
	
	@Override
	public List<NowMovie> getNowMovieByTheaterId(int theaterId) {
		String stmt = namespace + "getNowMovieByTheaterId";
		List<NowMovie> nowmovies = sqlSession.selectList(stmt, theaterId);
		return nowmovies;
	}

	@Override
	public Map<String, String> getNMovieTimeByThAndMovie(int theaterId, String movieCode) {
		NowMovie n = new NowMovie();
		n.setTheaterId(theaterId);
		n.setMovieCode(movieCode);
		String stmt2 = namespace + "getNMovieTimeByThAndMovie2";
		List<String> tlist = sqlSession.selectList(stmt2, n);
		HashMap<String, String> mtimes = new HashMap<String, String>();
		for (int i=0;i<tlist.size();i++) {
			String value = tlist.get(i);
			int strlen = value.length();
			if ((value.substring(strlen-2)).equals("06")) {
				value = value.replace("06", "오전");
			}
			else if ((value.substring(strlen-2)).equals("18")) {
				value = value.replace("18", "오후");
			}
			mtimes.put(tlist.get(i), value);	
		}
		logger.trace("수업: 영화시간맵: "+mtimes);
		return mtimes;
	}

	@Override
	public int getNMovieIdByNMovie(int theaterId, String movieCode, String movieTime) {
		String stmt = namespace + "getNMovieIdByNMovie";
		NowMovie n = new NowMovie();
		n.setMovieCode(movieCode);
		n.setMovieTime(movieTime);
		n.setTheaterId(theaterId);
		int nid = sqlSession.selectOne(stmt, n);
		logger.trace("수업: nowmovieid="+nid);
		return nid;

	}

	
}
