package com.mvg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvg.dao.CustomerBoardDao;
import com.mvg.entity.CustomerBoard;

@Service
public class CustomerBoardServiceImpl implements CustomerBoardService {

	@Autowired
	CustomerBoardDao dao;
	
	@Override
	public List<CustomerBoard> getAllBoardList() {
		List<CustomerBoard> results = dao.getAllBoard();
		return results;
	}

	@Override
	public int addBoard(CustomerBoard board) {
		int result = dao.insertCustomerBoard(board);
		return result;
	}

}
